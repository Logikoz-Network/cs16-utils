using System;

namespace Amx.Cod
{
	using System.Collections;
	using System.Collections.Specialized;
	using System.Text;
	using System.IO;

	using Amx.Core;
	using Amx.Ops;
	using Amx.Dat;
	using Amx.Logic.Jumps;
	using Amx.Logic.Labels;
	using Amx.Logic.Debug;

	using Files;

	public delegate void DisassemblyInstructionUpdateHandler(object sender, DisassemblyInstructionUpdateEventArgs e);
	public delegate void DisassemblyResourceUpdateHandler(object sender, DisassemblyResourceUpdateEventArgs e);
	public delegate void DisassemblyStatusMessageHandler(object sender, DisassemblyStatusMessageEventArgs e);
	public class DisassemblyInstructionUpdateEventArgs : EventArgs
	{
		private int count;
		private bool finished;

		public DisassemblyInstructionUpdateEventArgs(int count,bool finished)
		{
			this.count=count;
			this.finished=finished;
		}


		public int Count
		{
			get
			{
				return count;
			}
		}

		public bool Finished
		{
			get
			{
				return finished;
			}
		}
	}

	public class DisassemblyResourceUpdateEventArgs : EventArgs
	{
		private int loopcount;
		private int maxloops;
		private bool finished;

		public DisassemblyResourceUpdateEventArgs(int loopcount, int maxloops, bool finished)
		{
			this.loopcount=loopcount;
			this.maxloops=maxloops;
			this.finished=finished;
		}


		public int LoopCount
		{
			get
			{
				return loopcount;
			}
		}

		public int Loops
		{
			get
			{
				return maxloops;
			}
		}
		public bool Finished
		{
			get
			{
				return finished;
			}
		}
	}

	public class DisassemblyStatusMessageEventArgs : EventArgs
	{
		private string message;

		public DisassemblyStatusMessageEventArgs(string msg)
		{
			this.message=msg;
		}

		public string Message
		{
			get
			{
				return message;
			}
		}
	}


	public class Disassembly : IDisposable
	{	
		public event DisassemblyInstructionUpdateHandler InstructionUpdate;
		public event DisassemblyResourceUpdateHandler ResourceUpdate;
		public event DisassemblyStatusMessageHandler StatusUpdate;

		private bool error;
		private IAmxInstance amx;
		private Ops ops;
		private Counters counters;
		private JumpTable jumps;
	
		private ResourceList l_dat;
		private InstructionList l_cod;
		private StringCollection l_src;
	
		private Hashtable tags;
		private Hashtable publics;
		private Hashtable privates;
		private Hashtable natives;
		private Hashtable datsegments;
		private SymbolTable symbols;

		private Hashtable datrefs;
		private SortedList localcalls;
		private SortedList systemcalls;
		
			
	
		public Disassembly(IAmxInstance amx, Ops ops)
		{
			error=false;
			this.ops=ops;
			this.amx = amx;
		}
		~Disassembly()
		{
			if (ops!=null)
			{
				this.Dispose();
			}
		}
	
	
		public void Disassemble()
		{
			if (amx.Valid)
			{
				l_cod = DisassembleCod(amx,ops);
				if (!error)
				{
					DigestCod();
				}
				if (!error)
				{
					l_dat = DisassembleDat(amx,l_cod);
				}
				if (!error)
				{
					Correlate();
				}
				//IndexLines();
			}
		}
	
	
		public void DigestCod()
		{
			bool debug = amx.Header.GetFlag(AMX_FLAGS.DEBUG);
	
			counters = new Counters();
	
			symbols = new SymbolTable();
			jumps = new JumpTable();
	
			publics = new Hashtable();
			privates = new Hashtable();
			datsegments = new Hashtable();
			datrefs = new Hashtable();
	
			localcalls = new SortedList();
			systemcalls = new SortedList();
			natives = new Hashtable();
			tags = new Hashtable();

			#region tags setup
			for (int i=0;i<amx.Header.Tags.Length;i++)
			{
				if (!tags.Contains((int)amx.Header.Tags[i].Address))
				{
					tags.Add(
						//(int)amx.Header.Tags[i].Address,
						i,
						amx.Header.Tags[i].Data
						);
				}						 
			}
			#endregion
	
			#region publics setup
			for (int i=0;i<amx.Header.Publics.Length;i++)
			{
				if (!publics.Contains((int)amx.Header.Publics[i].Address))
				{
					publics.Add(
						(int)amx.Header.Publics[i].Address,
						amx.Header.Publics[i].Data
						);
				}						 
			}
			#endregion
	
			#region native setup
			for (int i=0;i<amx.Header.Natives.Length;i++)
			{
				natives.Add(
					i,
					amx.Header.Natives[i].Data
					);						 
			}
			#endregion
	
			#region dat setup
			if (l_dat!=null)
			{
				for (int i=0;i<l_dat.Count;i++) 
				{
					if (!datsegments.Contains( ((IDatEntry)l_dat[i]).Start ))
					{
						datsegments.Add(
							new ValInt(((IDatEntry)l_dat[i]).Start),
							l_dat[i]
							);
					}
				}
			}
			#endregion
		
			Symbol lastsymbol = null;
			foreach (Instruction line in l_cod)
			{	
				//int index;
				switch (line.Op.Code)
				{
					#region SYSREQ_C
					case OPCODES.OP_SYSREQ_C:
						if ( (line.Param >=0) && (line.Param<amx.Header.Natives.Length) )
						{
							systemcalls.Add(line.Offset,line.Param);
						}
						else
						{
							systemcalls.Add(line.Offset,-1);							
						}
						break;
					#endregion
					#region PROC   
					case OPCODES.OP_PROC:
						if (!publics.ContainsKey(line.Offset))
						{
							privates.Add(line.Offset,"func_" + privates.Count.ToString("D2"));
						}
						break;
					#endregion  
					#region CALL   
					case OPCODES.OP_CALL:
						localcalls.Add(line.Offset,line.Param);
						break;
					#endregion
					#region CASETBL
					case OPCODES.OP_CASETBL:
						Casetbl table =	 new Casetbl(line.Offset,line.GetParam(1),line.GetParam(0),counters.Casetbl);
						jumps.Add(table);
						CaseTriplet[] cases = (CaseTriplet[])line.Extra;
						for (int i=0;i<cases.Length;i++)
						{
							jumps.Add(new Case(cases[i],table.TableNumber,i));
						}
						break;
					#endregion
					#region SWITCH 
					case OPCODES.OP_SWITCH:
						jumps.Add(new Switch(line.Offset,line.Param,counters.Switch));
						break;
					#endregion
					#region JREL   
					case OPCODES.OP_JREL:
						jumps.Add(new JumpRelative(line.Offset,line.Param,counters.Jump));
						break;
					#endregion
					#region J*     
					case OPCODES.OP_JEQ:
					case OPCODES.OP_JGEQ:
					case OPCODES.OP_JGRTR:
					case OPCODES.OP_JLEQ:
					case OPCODES.OP_JLESS:
					case OPCODES.OP_JNEQ:
					case OPCODES.OP_JNZ:
					case OPCODES.OP_JSGEQ:
					case OPCODES.OP_JSGRTR:
					case OPCODES.OP_JSLEQ:
					case OPCODES.OP_JSLESS:
					case OPCODES.OP_JUMP:
					case OPCODES.OP_JUMP_PRI:
					case OPCODES.OP_JZER:
						jumps.Add(new Jump(line.Offset,line.Param,counters.Jump));
						break;
					#endregion
					#region PUSH [|PRI|ALT|C] 
					case OPCODES.OP_PUSH:
					case OPCODES.OP_PUSH_PRI:
					case OPCODES.OP_PUSH_ALT:
					case OPCODES.OP_PUSH_C:
						if (!debug && line.Param !=0)
						{
							if (datsegments.Contains(line.Param))
							{
								datrefs.Add(line.Offset,line.Param);
							}
						}
						break;
					#endregion
					#region CONST [ALT|PRI]   
					case OPCODES.OP_CONST_ALT:
					case OPCODES.OP_CONST_PRI:
						if (line.Param!=0)
						{
							if (datsegments.Contains(line.Param))
							{
								datrefs.Add(line.Offset,line.Param);
							}
						}
						break;
					#endregion
					#region SYMBOL 
					case OPCODES.OP_SYMBOL:
						lastsymbol = new Symbol(line.Offset,line.GetParam(1), line.GetParam(2) ,(byte[])line.Extra);
						symbols.Add(line.Offset,lastsymbol);
						break;
					#endregion
					#region SRANGE 
					case OPCODES.OP_SRANGE:
						SymbolRange range = new SymbolRange(line.Offset,line.GetParam(0),line.GetParam(1));
						if (lastsymbol!=null)
						{
							lastsymbol.AddExtension(range);
						}
						else
						{
							throw new Exception("srange opcode with no preceeding symbol");
						}
						symbols.Add(line.Offset,range);
						break;
					#endregion
					#region SYMTAG 
					case OPCODES.OP_SYMTAG:
						SymbolTag tag = new SymbolTag(line.Offset,line.Param);
						if (lastsymbol!=null)
						{
							lastsymbol.AddExtension(tag);
						}
						symbols.Add(line.Offset,tag);
						break;
					#endregion
					#region FILE   
					case OPCODES.OP_FILE:
						symbols.Add(line.Offset,new Amx.Logic.Debug.File(line.Offset,line.Param,(byte[])line.Extra));
						break;
					#endregion
					#region LINE   
					case OPCODES.OP_LINE:
						symbols.Add(line.Offset, new Line(line.Offset,line.GetParam(1),line.GetParam(0)));
						break;
					#endregion
				}	
				//index=-1;
			}	
		}
	
		private void Correlate()
		{
			DatCounters counters = new DatCounters();
			SortedList entries = new SortedList(l_dat.Count);
			DatEntryOffsetComparer datcmp = new DatEntryOffsetComparer();
			SortedList names = new SortedList(symbols.Count);

			foreach (ASymbol sym in symbols.Values)
			{
				Symbol symbol = sym as Symbol;
				if (
					symbol!=null &&
					symbol.Relative==SymbolRelativeTo.DAT					
					)
				{
					switch (symbol.Type)
					{
						case SymbolFlagType.array:
						case SymbolFlagType.array_ptr:
						case SymbolFlagType.variable:
						case SymbolFlagType.variable_ptr:
							names.Add(symbol.Position,symbol);
							break;
					}
					
				}
			}
	
			foreach (IDatEntry dat in l_dat)
			{
				Symbol symbol = names[dat.Start] as Symbol;
				if (symbol!=null)
				{
					dat.Name=symbol.Name;
					dat.NameType=DatNameStrength.Symbol;
				}
				else
				{
					dat.Name=counters.GetName(dat.Type);
					dat.NameType=DatNameStrength.Runtime;
				}
			}
		}
		
	
		public IAmxInstance Amx
		{
			get
			{
				return amx;
			}
		}
	
		public Ops Ops
		{
			get
			{
				return ops;
			}
		}
	
	
		public InstructionList Instructions
		{
			get
			{
				return l_cod;
			}
		}
		public ResourceList Resources
		{
			get
			{
				return l_dat;
			}
		}
	
	
		public StringCollection Source
		{
			get
			{
				return l_src;
			}
		}
	
	
		public Hashtable PublicsFunctions
		{
			get
			{
				return publics;
			}
		}
		public Hashtable PrivateFunctions
		{
			get
			{
				return privates;
			}
		}
		public Hashtable NativeFunctions
		{
			get
			{
				return natives;
			}
		}
	
			
		public Hashtable Tags
		{
			get
			{
				return tags;
			}
		}
		public SymbolTable Symbols
		{
			get
			{
				return symbols;
			}
		}
	
		public JumpTable Jumps
		{
			get
			{
				return jumps;
			}
		}
		public LabelTable Labels
		{
			get
			{
				return (jumps!=null? jumps.labels: null);
			}
		}
	
	
		public Hashtable ResourceReferences
		{
			get
			{
				return datrefs;
			}
		}
	
		public SortedList PrivateReferences
		{
			get
			{
				return localcalls;
			}
		}
		public SortedList NativeReferences
		{
			get
			{
				return systemcalls;
			}
		}
			
	
		public void LoadSource()
		{
			l_src = new StringCollection();
			string source = Path.GetDirectoryName(amx.Path) + Path.DirectorySeparatorChar + Path.GetFileNameWithoutExtension(amx.Path) + ".sma";
			string str = amx.Path.Substring(0,amx.Path.LastIndexOf('.')) +".sma";
			if (System.IO.File.Exists(source)/*System.IO.File.Exists(amx.Path.Substring(0,amx.Path.LastIndexOf('.')) +".sma")*/)
			{
				StreamReader sr=null;
				try
				{
					sr = new StreamReader(source/*amx.Path.Substring(0,amx.Path.LastIndexOf('.')) +".sma"*/);
					l_src.AddRange(sr.ReadToEnd().Split( new char[]{'\n'}));
					for (int i=0;i<l_src.Count;i++)
					{
						l_src[i]=l_src[i].TrimEnd();
					}
				}
				catch (Exception)
				{
				}
				finally
				{
					if (sr!=null)
					{
						sr.Close();
						sr=null;
					}
				}
			}
			else
			{
				l_src=null;
			}
		}
	
		
		private InstructionList DisassembleCod(IAmxInstance file,Ops ops)
		{
			int sizeof_cell = (int)file.Bits;
			Bits bits = file.Bits;
			//ArrayList lines = new ArrayList();
			InstructionList lines = new InstructionList();

			AmxStream bin = file.GetStream();
			
			Op curop=null;
			int opnum=0, header_len=0;//,op_len=0;
			Instruction line=null;
	
			bin.Seek((long)file.Header.Cod,SeekOrigin.Begin);
			header_len = file.Header.Dat;
				
			while (bin.Position<file.Header.Dat)
			{
				line = new Instruction();
				try
				{
					opnum = bin.ReadValInt(bits);
				}
				catch (InvalidOpException)
				{
					error=true;
					break;
				}
				curop = ops[opnum];
				//op_len = curop.ParamCount;
				line.Op=curop;
				line.Offset=(int)bin.Position-(file.Header.Cod+sizeof_cell);
					
				if (curop.VariableLength)
				{
					#region variable length opcodes
					switch (line.Op.Code)
					{
						case OPCODES.OP_CASETBL: // casetbl num default num*[case jump]
							line.SetParam(0,bin.ReadValInt(bits));
							line.SetParam(1,bin.ReadValInt(bits));
							int numcases = line.GetParam(0);
							lines.Add(line);
							CaseTriplet[] cases = new CaseTriplet[numcases];
							line.Extra=cases;
							for (int i=0;i<numcases;i++)
							{
								cases[i]=new CaseTriplet(
									(int)bin.Position-(file.Header.Cod+sizeof_cell),
									bin.ReadValInt(bits),
									bin.ReadValInt(bits)
									);
								Instruction caseline = new Instruction();
								caseline.Op=ops["NONE"];
								caseline.Offset=cases[i].Position;
								caseline.SetParam(0,cases[i].Value);
								caseline.SetParam(1,cases[i].Target);
								lines.Add(caseline);
							}
							line=null;
							break;
						case OPCODES.OP_FILE: // 124, FILE, size ord name...
							line.SetParam(0,bin.ReadValInt(bits));
							line.SetParam(1,bin.ReadValInt(bits));
							line.Extra = bin.ReadBytes(line.GetParam(0) - ( (line.Op.ParamCount -2 ) * sizeof_cell));
							break;
						case OPCODES.OP_SYMBOL: // 126, SYMBOL, sze off flg name...
							line.SetParam(0,bin.ReadValInt(bits));
							line.SetParam(1,bin.ReadValInt(bits));
							line.SetParam(2,bin.ReadValInt(bits));
							line.Extra = bin.ReadBytes(line.GetParam(0) - ( (line.Op.ParamCount -2 ) * sizeof_cell));
							break;
						default:
							throw new Exception("found op: " + curop.Name + " which has a variable opcount field and is unhandled");
								
					}
					#endregion	
				}
				else
				{
					//switch (line.OPCODE)
					//{
							//case OPCODES.OP_SRANGE:
							//	line.SetParam(0,bin.ReadValInt(bits));
							//	line.SetParam(1,bin.ReadValInt(bits));
							//	break;
					//	default:
							for (int i=0;i<curop.ParamCount;i++) 
								line.SetParam(i,bin.ReadValInt(bits));
					//		break;
					//}
				}
	
				if (line!=null)
				{
					lines.Add(line);
				}
				if ((lines.Count % 100) ==0 )
				{
					OnInstructionUpdate(lines.Count,false);
				}
			}
			OnInstructionUpdate(lines.Count,true);
	
			bin.Close();
			bin=null;

			return lines;
		}
	
		private ResourceList DisassembleDat(IAmxInstance file,InstructionList lines)
		{
			ResourceList entries = new ResourceList();
			ArrayList strings = new ArrayList();
			ArrayList arrays = new ArrayList();

			int sizeof_cell=(int)file.Bits;
			Bits bits = file.Bits;
	
			bool debug = file.Header.GetFlag(AMX_FLAGS.DEBUG);
			bool found =false;
	
			AmxStream bin = file.GetStream();
			byte[] data;
			bin.Seek((long)file.Header.Dat,SeekOrigin.Current);
			data=bin.ReadBytes((int)file.Length-file.Header.Dat);
	
			bin.Close();
			bin=null;

			if (symbols!=null)
			{
				foreach (ASymbol sym in symbols.Values)
				{
					Symbol symbol = sym as Symbol;
					if (symbol!=null && symbol.Relative==SymbolRelativeTo.DAT)
					{
						DatArrayDescription newentry = new DatArrayDescription(symbol.Position/*.Offset*/);
						foreach (ASymbol ext in symbol.Extensions)
						{
							SymbolRange srange = ext as SymbolRange;
							if (srange!=null)
							{
								newentry.Add(srange.Rank,srange.Value);
							}
						}
						if (newentry.Valid)
						{
							IDatEntry newdatentry = new BadEntry();
							switch (symbol.Type)
							{
								case SymbolFlagType.array:
								case SymbolFlagType.array_ptr:
								switch (newentry.Count)
								{
									case 0:
										throw new Exception("array symbol declared with no bounds");
									case 1: // array or string
										if (newentry[0]==0)  // string
										{
											newdatentry = DatHelpers.CreateDatEntry(
												data,
												sizeof_cell,
												newentry.Start,
												false,
												true,
												true,
												false
												);
										}
										else // array
										{
											newdatentry = DatHelpers.CreateDatEntry(
												data,
												sizeof_cell,
												newentry.Start,
												(newentry[0] * sizeof_cell),
												false,
												true,
												true,
												false
												);
										}
										break;
									default:
										newdatentry = DatHelpers.CreateDatEntry(
											data,
											sizeof_cell,
											newentry.Start,
											true,
											true,
											true,
											false
											);
										break;
								}

									switch(newdatentry.Type)
									{
										case DatEntryType.MultiArray:
											MultiEntry mul = newdatentry as MultiEntry;
											for (int index=0;index<newentry.Count;index++)
											{
												if (mul.Bounds == newentry.Count)
												{
													if ( mul.GetBound(index) != newentry[index] )
													{
														newdatentry = BadEntry.Empty;
														break;
													}
												}
												else
												{
													newdatentry = BadEntry.Empty;
												}
											}
											break;
										case DatEntryType.Array:
											if( (newdatentry as ArrayEntry).Length != newentry[0])
											{
												newdatentry = BadEntry.Empty;
											}
											break;
										default:
											newdatentry = BadEntry.Empty;
											break;
									}
									break;
								case SymbolFlagType.variable:
								case SymbolFlagType.variable_ptr:
									newdatentry = DatHelpers.CreateDatEntry(
											data,
											sizeof_cell,
											newentry.Start,
											false,
											false,
											false,
											true
										);
									break;
							}
							if (newdatentry.Type!=DatEntryType.Bad)
							{
								newdatentry.Name=symbol.Name;
								newdatentry.NameType=DatNameStrength.Symbol;
								entries.Add(newdatentry);
							}

						}
					}
				}
			}
	
			#region find all possible dat region references
			// always add 0 as a possible, it can't be detected with this method 
			// because rather than pushing a zero with CONST.pri the compiler will
			// merely ZERO.pri because its less work
			strings.Add( new ValInt(0,bits) );
			//DatEntryMultiarrayDescription dem=null;

		/* In the standard sc compiler the const.* opcodes are used to push 
		* string onto the stack for arguments in function calls. If the 
		* optimizer is enabled this can be replaces with the use of a push.*
		* opcode instead. The use of the optimisation function was prohibited
		* the debug level setting meaning that if (debug) const.* else push*
		* could be used to cut down on the possible string.
		* 
		* In the amxxmod compiler BAILOPAN and PMOnoTo have changed the compiler
		* and remove the prohibition of optimisation with debugging ops included.
		* this requires that unless compiler version detection is possible all
		* push.* and const.* opcodes must be considered as possible argument
		* specification instructions. This may make the code look cleaner but it
		* results in a larger number of dat references to parse and possibly discard
		*/
			foreach (Instruction dl in lines)
			{
				switch (dl.Op.Code)
				{
					case OPCODES.OP_CONST_ALT:
					case OPCODES.OP_CONST_PRI:
					//case OPCODES.OP_PUSH_PRI:
					//case OPCODES.OP_PUSH_ALT:
					case OPCODES.OP_PUSH_C:
						if ( dl.Param>0 && (dl.Param%sizeof_cell)==0 && dl.Param<=data.Length )  // aligned with the cell size
						{
							if (!strings.Contains(dl.Param))
							{
								strings.Add(dl.Param);
							}
						}
						break;	
				}
			}
			/*
			 foreach (Instruction dl in lines)
			{
				if(debug)
				{
					if (dl.OPCODE==OPCODES.OP_CONST_PRI || dl.OPCODE==OPCODES.OP_CONST_ALT)
					{
						if ( (dl.Param%sizeof_cell)==0 )  // aligned with the cell size
						{
							dem=new DatEntryMultiarrayDescription();
							dem.offset=dl.Offset;
							dem.value=dl.Param;
							if (dl.Param>=0 && dl.Param<=data.Length)
							{
								if (!strings.Contains(dl.Param))
									strings.Add(dl.Param);
							}
						}
					}
				}
				else
				{
					if ( 
						(dl.OPCODE==OPCODES.OP_PUSH_C ) ||
						(dl.OPCODE==OPCODES.OP_PUSH_PRI ) || 
						(dl.OPCODE==OPCODES.OP_PUSH_ALT )
						)
					{
						// strings
						//if (dl.Param>=0 && dl.Param<=(long)data.Length && (dl.Param%sizeof_cell)==0)
						//{
						//	if (!strings.Contains(dl.Param))
						//		strings.Add(dl.Param);
						//}
						if (dl.Param>=0)
						{
							if (dl.Param<=data.Length)
							{
								if ( (dl.Param%sizeof_cell)==0)
								{
									if (!strings.Contains(dl.Param))
										strings.Add(dl.Param);
								}
							}
						}
					}
					else if 
						(
						(dl.OPCODE==OPCODES.OP_CONST_PRI ) ||
						(dl.OPCODE==OPCODES.OP_CONST_ALT)
						)
					{
						if ((dl.Param%sizeof_cell)==0)
						{
							dem=new DatEntryMultiarrayDescription();
							dem.offset=dl.Offset;
							dem.value=dl.Param;
							if (dl.Param>=0 && dl.Param<=data.Length)
							{
								if (!strings.Contains(dl.Param))
									strings.Add(dl.Param);
							}
						}
					}
				}
				if (dl.OPCODE==OPCODES.OP_BOUNDS)
				{
					if (dem!=null)
					{
						if (dem.bound_value!=0)
						{
							dem.bound_offset_2=dem.bound_offset;
							dem.bound_value_2=dem.bound_value;
						}
						dem.bound_value=dl.Param;
						dem.bound_offset= dl.Offset;
						//arrays.Add(dem);
					}
				}
				//if (dl.OPCODE==OPCODES.OP_SYMBOL)
				//{
				//	int flg_type = (int)((dl.GetParam(2) & 0xff));
				//	int flg_class = ((dl.GetParam(2) & 0xff00) >>8);
				//	if (flg_class==0||flg_class==2||flg_class==9||flg_type==10)
				//	{
				//		if (!symbols.Contains(dl.GetParam(1))) symbols.Add(dl.GetParam(1),dl);
				//	}
				//}
			}
			*/
			#endregion
				
			#region remove multiple references to the same multiarrays
				
			ArrayList temparrays = new ArrayList();
			for (int i=0;i<arrays.Count;i++)
			{
				found=false;
				for (int k=0;k<temparrays.Count;k++)
				{
					DatEntryMultiarrayDescription kd = temparrays[k] as DatEntryMultiarrayDescription;
					DatEntryMultiarrayDescription id = arrays[i] as DatEntryMultiarrayDescription;
					if (kd.value==id.value && kd.bound_value==id.bound_value	)
					{
						found=true;
						break;
					}
				}
				if (!found)
				{
					temparrays.Add(arrays[i]);
				}
			}
			arrays=temparrays;
			arrays.Sort();
			#endregion
				
			#region identify and create all bounds checked arrays and multiarrays
				
			foreach (DatEntryMultiarrayDescription ded in arrays)
			{
				IDatEntry entry = DatHelpers.CreateDatEntry(data,sizeof_cell,ded,true,false,true,true);
				if (entry.Type!=DatEntryType.Bad)
				{
					if ((entry.Start%sizeof_cell)!=0 || (entry.Length%sizeof_cell)!=0)
					{
						break;
					}
					ded.found=true;
					entries.Add(entry);
					//MultiEntry mentry = entry as MultiEntry;
					//if (mentry!=null)
					//{
					//	foreach (IDatEntry sub in mentry.Data)
					//	{
					//		entries.Add(sub);
					//	}
					//}
				}
			}
				
			#endregion
	
			#region parse out all possible address loads
			foreach (ValInt offset in strings)
			{
				IDatEntry entry = DatHelpers.CreateDatEntry(data,sizeof_cell,offset,true,true,false,false);
				if ( entry!=null &&	entry.Type!=DatEntryType.Bad )
				{
					if (!entries.ContainsEntryAt(entry.Start))
					{
						entries.Add(entry);
					}
				}
			}
			#endregion
		
				
			//entries.Sort();
	
			foreach (IDatEntry e in entries)
			{
				if ( (e.Start%sizeof_cell)!=0 || ((e.End+1)%sizeof_cell)!=0 )
				{
					return null;
				}
			}
	
			bool changed=true;
			int count=0;
			int max = 4;
			while (changed && count<max)
			{
				OnResourceUpdate(count,max,false);
				changed = DatHelpers.ResolveOcclusion(entries,data,sizeof_cell);
				changed = DatHelpers.ResolveGaps(entries,data,sizeof_cell);
				if (!changed)
				{
					changed = !DatHelpers.Contiguous(entries,sizeof_cell, data.Length);
				}
				count++;
			}
			OnResourceUpdate(count,max,true);
			if (!DatHelpers.Contiguous(entries,sizeof_cell, data.Length))
			{
				OnStatusMessage("non contiguous dat region, there may be missing entries");
			}
			
				
			return entries;
	
		}
	

		protected virtual void OnStatusMessage(string message)
		{
			if (StatusUpdate!=null)
			{
				StatusUpdate(this, new DisassemblyStatusMessageEventArgs(message)); 
			}
		}
		protected virtual void OnInstructionUpdate(int count,bool finished)
		{
			if (InstructionUpdate!=null)
			{
				InstructionUpdate(this,new DisassemblyInstructionUpdateEventArgs(count,finished));
			}
		}
		protected virtual void OnResourceUpdate(int loop, int max, bool finished)
		{
			if (ResourceUpdate!=null)
			{
				ResourceUpdate(this,new DisassemblyResourceUpdateEventArgs(loop,max,finished));
			}
		}
	

		#region IDisposable Members
	
		public void Dispose()
		{
			lock(this)
			{
	
				if (jumps!=null)
				{
					jumps.Clear();
				}
	
				if (l_dat!=null)
				{
					l_dat.Clear();					
				}
				if (l_cod!=null)
				{
					l_cod.Clear();					
				}
				if (l_src!=null)
				{
					l_src.Clear();					
				}
				//if (lineindex!=null)
				//{
				//	lineindex.Clear();					
				//}
				if (publics!=null)
				{
					publics.Clear();					
				}
				if (privates!=null)
				{
					privates.Clear();
					
				}
				if (datsegments!=null)
				{
					datsegments.Clear();					
				}
				if (datrefs!=null)
				{
					datrefs.Clear();					
				}
				if (symbols!=null)
				{
					symbols.Clear();					
				}
				if (localcalls!=null)
				{
					localcalls.Clear();					
				}
				if (systemcalls!=null)
				{
					systemcalls.Clear();					
				}
				if (natives!=null)
				{
					natives.Clear();					
				}
				publics=null;
				privates=null;
				datsegments=null;
				datrefs=null;
				symbols=null;
				localcalls=null;
				systemcalls=null;
				natives=null;
				amx=null;
				ops=null;
				counters=null;
				jumps=null;
				l_dat=null;
				l_cod=null;
				l_src=null;
				//lineindex=null;
				InstructionUpdate=null;
				ResourceUpdate=null;
				StatusUpdate=null;
			}
			GC.SuppressFinalize(this);
		}
	
		#endregion
	}
	

}


namespace Amx.Cod
{
	using System.Collections;
	using System.Text;

	using Amx.Core;
	using Amx.Ops;


	public class Instruction : IDisposable
	{
		private Op l_op;
		private int l_offset;
		private ValInt[] l_params;
		private object l_extra;
		private int l_numparams;

		public Instruction() : this(0,null)
		{
		}

		public Instruction(bool b, int offset,Op op,ValInt param)
		{
			l_params= new ValInt[1];
			l_op = op;
			l_params[0] = param;
			l_offset = offset;
			l_extra=null;
		}

		public Instruction(int offset,Op op)
		{
			l_params= new ValInt[1];
			l_op = op;
			l_offset = offset;
			l_extra=null;
		}
		~Instruction()
		{
			if (l_op!=null)
			{
				this.Dispose();
			}
		}


		public int NumParams
		{
			get
			{
				return l_numparams+1;
			}
		}


		public ValInt Param
		{
			get
			{
				return this.GetParam(0);//l_params[0];
			}
			//set
			//{
				//l_params[0] = value;
				//if (l_numparams<1)
				//{
				//	l_numparams=1;
				//}
				//this.SetParam(0,value);
			//}
		}
			
		public ValInt GetParam()
		{
			return GetParam(0);
		}
		public ValInt GetParam(int index)
		{
			if (index<l_params.Length)
			{
				return l_params[index];
			}
			else
				throw new IndexOutOfRangeException();
		}

		public void SetParam(ValInt value)
		{
			SetParam(0,value);
		}
		public void SetParam(int index, ValInt value)
		{
			if (index+1 > l_params.Length)
			{
				ValInt[] arr = new ValInt[index+1];
				l_params.CopyTo(arr,0);
				l_params = arr;
			}
			//if (index<l_params.Length)
			//{
				l_params[index]=value;
			//}
			if (index>0 && index>l_numparams)
				l_numparams = index;
		}


		public int Offset
		{
			get
			{
				return l_offset;
			}
			set
			{
				l_offset=value;
			}
		}

		public Op Op
		{
			get
			{
				return l_op;
			}
			set
			{
				l_op = value;
			}
		}

		//public OPCODES OPCODE
		//{
		//	get
		//	{
		//		return (OPCODES)l_op.Code;
		//	}
		//}

		/*
		public bool IsdatReference
		{
			get
			{
				return l_isdatreference;
			}
			set 
			{
				l_isdatreference = value;
			}
		}
		*/

		public object Extra
		{
			get
			{
				return l_extra;
			}
			set
			{
				if (l_extra==null && value !=null)
				{
					l_numparams+=1;
					l_numparams=~l_numparams;
				}
				l_extra=value;
				if (l_extra==null)
				{
					l_numparams=~l_numparams;
					l_numparams-=1;
				}
			}
		}


		public string FormatValue(int value, NumberOptions options)
		{
			string retval="";
			string formatter="";

			switch (options.Format)
			{
				case NumberFormat.SignedHex:
				case NumberFormat.Hex:
					formatter = "X";
					break;
				case NumberFormat.Dec:
					formatter = "D";
					break;
			}

			if (options.NumWidth!=0)
			{
				formatter+=options.NumWidth.ToString();
			}

			switch (options.Format)
			{
				case NumberFormat.SignedHex:
					if (value<0)
					{
						retval = ("-0x" + ((~value)+1).ToString(formatter));
					}
					else
					{
						retval = ("0x" + value.ToString(formatter));
					}
					break;
				case NumberFormat.Hex:
					retval = ("0x" + value.ToString(formatter));
					break;
				case NumberFormat.Dec:
					retval = (value.ToString(formatter));
					break;
			}

			switch (options.Alignment)
			{
				case Align.Left:
					retval=retval.PadRight(options.MaxWidth,options.PadChar);
					break;
				case Align.Right:
					retval=retval.PadLeft(options.MaxWidth,options.PadChar);
					break;
			}

			return retval;
		}
		public string FormatValue(ValInt value, NumberOptions options)
		{
			return FormatValue(value,options,null,null);
			/*
			string retval="";
			string formatter="";

			switch (options.Format)
			{
				case NumberFormat.SignedHex:
				case NumberFormat.Hex:
					formatter = "X";
					break;
				case NumberFormat.Dec:
					formatter = "D";
					break;
			}

			if (options.NumWidth!=0)
			{
				formatter+=options.NumWidth.ToString();
			}

			switch (options.Format)
			{
				case NumberFormat.SignedHex:
					if (value<0)
					{
						retval = ("-0x" + ((~value)+1).ToString(formatter));
					}
					else
					{
						retval = ("0x" + value.ToString(formatter));
					}
					break;
				case NumberFormat.Hex:
					retval = ("0x" + value.ToString(formatter));
					break;
				case NumberFormat.Dec:
					retval = (value.ToString(formatter));
					break;
			}

			switch (options.Alignment)
			{
				case Align.Left:
					retval=retval.PadRight(options.MaxWidth,options.PadChar);
					break;
				case Align.Right:
					retval=retval.PadLeft(options.MaxWidth,options.PadChar);
					break;
			}

			return retval;
			*/
		}

		public string FormatValue(ValInt value, NumberOptions options,string prefix, string postfix)
		{
			StringBuilder str = new StringBuilder(options.MaxWidth);
			string formatter="";
			bool writeprefix =  (prefix!=null && prefix.Length>0);
			bool writepostfix = (postfix!=null && postfix.Length>0);

			if (writeprefix)
			{
				str.Append(prefix);
			}

			switch (options.Format)
			{
				case NumberFormat.SignedHex:
					if (value<0)
					{
						value=( (~(value)) + 1 );
						str.Append("-");
					}
					goto case NumberFormat.Hex;
				case NumberFormat.Hex:
					str.Append("0x");
					formatter = "X";
					break;
				case NumberFormat.Dec:
					formatter = "D";
					break;
			}

			if (options.NumWidth!=0)
			{
				formatter+=options.NumWidth.ToString();
			}

			str.Append(value.ToString(formatter));

			if (writepostfix)
			{
				str.Append(postfix);
			}

			int pad = Math.Max(options.MinWidth,(options.MaxWidth - str.Length) );

			switch (options.Alignment)
			{
				case Align.Left:
					str.Append(options.PadChar,pad);
					break;
				case Align.Right:
					str.Insert(0,new string(options.PadChar,pad));
					break;
			}

			return str.ToString();
		}


		public string FormatString(string value, StringOptions options)
		{
			return FormatString(value,options,null,null);			
		}
		public string FormatString(string value, StringOptions options, string prefix, string postfix)
		{
			if (value!=null)
			{
				StringBuilder str = new StringBuilder(options.MaxWidth);

				bool useprefix = (prefix!=null && prefix.Length>0);
				bool usepostfix = (postfix!=null && postfix.Length>0);
				bool delaypad = (options.Alignment == Align.Left);

				int strlen = value.Length;
				if (useprefix)
				{
					strlen +=prefix.Length;
				}
				if (usepostfix)
				{
					strlen +=postfix.Length;
				}
				int pad = Math.Max(options.MinWidth, (options.MaxWidth - strlen)); 
				if (!delaypad)
				{
					str.Append(options.PadChar,pad);
				}
				if (useprefix)
				{
					str.Append(prefix);
				}
				str.Append(value);
				if (usepostfix)
				{
					str.Append(prefix);
				}
				if (delaypad)
				{
					str.Append(options.PadChar,pad);
				}
				return str.ToString();
			}
			else
			{
				return "";
			}
		}


		#region IDisposable Members

		public void Dispose()
		{
			lock(this)
			{
				l_op=null;
				l_offset=-1;
				l_params=null;
				l_extra=null;
				l_numparams=-1;
			}
			GC.SuppressFinalize(this);
		}

		#endregion
	}


	public class InstructionOffsetComparer : IComparer
	{
		#region IComparer Members

		public int Compare(object x, object y)
		{
			int retval = 0;
			Instruction dx = x as Instruction;
			int iy = (int)y;
			if (dx!=null)
			{
				retval = dx.Offset.CompareTo(iy);
			}
			else
			{
				retval = -1;
			}
			return retval;
		}

		#endregion
	}

	public class InstructionList : IEnumerable,IDictionary
	{
		private SortedList list;

		public InstructionList():this(10){}
		public InstructionList(int capacity)
		{
			list = new SortedList(capacity);
		}

		~InstructionList()
		{
			lock (this)
			{
				if (list!=null)
				{
					list.Clear();
				}
			}
		}


		public void Add(Instruction inst)
		{
			if( inst==null)
			{
				throw new ArgumentNullException();
			}
			if (list.Contains(inst.Offset))
			{
				throw new ArgumentException();
			}
			list.Add(inst.Offset,inst);
		}

		public Instruction this[int offset]
		{
			get
			{
				return list[offset] as Instruction;
			}
		}
		public Instruction this[ValInt offset]
		{
			get
			{
				return list[offset.Value] as Instruction;
			}
		}


		#region IEnumerable Members

		public IEnumerator GetEnumerator()
		{
			return new InstructionListEnumerator(this);
		}

		#endregion

		#region IDictionary Members

		public bool IsReadOnly
		{
			get
			{
				return false;
			}
		}

		IDictionaryEnumerator System.Collections.IDictionary.GetEnumerator()
		{
			return list.GetEnumerator();
		}

		public object this[object key]
		{
			get
			{
				if (key is ValInt || key is Int32 || key is Int64 || key is byte || key is Int16)
				{
					return this[ (ValInt)key ];
				}
				else
				{
					throw new Exception("the InstructionTable cannot be indexed by objects of type " + key.GetType().ToString() );
				}
			}
			set
			{
				
			}
		}

		public void Remove(object key)
		{
			list.Remove(key);
		}

		public bool Contains(object key)
		{
			return list.Contains(key);
		}

		public void Clear()
		{
			list.Clear();
		}

		public ICollection Values
		{
			get
			{
				return list.Values;
			}
		}

		public void Add(object key, object value)
		{
			throw new Exception("the default dictionary add member of this type is not implemnted. Use Add(Instruction) instead");
		
		}

		public ICollection Keys
		{
			get
			{
				return list.Keys;
			}
		}

		public bool IsFixedSize
		{
			get
			{
				return false;
			}
		}

		#endregion

		#region ICollection Members

		public bool IsSynchronized
		{
			get
			{
				return list.IsSynchronized;
			}
		}

		public int Count
		{
			get
			{
				return list.Count;
			}
		}

		public void CopyTo(Array array, int index)
		{
			list.CopyTo(array,index);
		}

		public object SyncRoot
		{
			get
			{
				return list.SyncRoot;
			}
		}

		#endregion

	}

	public class InstructionListEnumerator : IEnumerator
	{
		private ArrayList items;
		private int position;

		public InstructionListEnumerator(IDictionary dict)
		{
			items = new ArrayList(dict.Values);
			this.Reset();
		}


		#region IEnumerator Members

		public void Reset()
		{
			position=-1;
		}

		public object Current
		{
			get
			{
				if (position>=0 && position<items.Count)
				{
					return items[position];
				}
				else
				{
					throw new InvalidOperationException();
				}
			}
		}

		public bool MoveNext()
		{
			position+=1;
			return (position>=0 && position<items.Count);
		}

		#endregion
	}

}
