using System;

namespace View
{
	using Amx.Cod;
	using Amx.Dat;
	using Amx.Strings;
	using Amx.Ops;
	using Amx.Logic.Jumps;
	using Amx.Logic.Debug;  // class name clash with system.IO.File and Debug.File
	using Amx.Logic.Labels;
	using Amx.Core;
	//using File.Structures;

	using View;

	using IO = System.IO;
	using System.Text;
	using System.Collections;
	using System.Collections.Specialized;

	public class ScasmDisassemblyView : IDisassemblyView
	{
		private bool inited;
		private FormatOptions format;

		public ScasmDisassemblyView()
		{
			inited=false;
		}

		
		private void InitFormat()
		{
			format = new FormatOptions();

			format.Offset=new NumberOptions(
					12,
					0,
					Align.Left,
					NumberFormat.Hex,
					0,
					' '
				);

			format.Opcode = new StringOptions(
					10,
					0,
					Align.Left,
					' ',
					false
				);

			format.NumberParams = new NumberOptions(
					12,
					2,
					Align.Right,
					NumberFormat.SignedHex,
					0,
					' '
				);

			format.StringParams = new StringOptions(
					12,
					1,
					Align.Right,
					' ',
					false
				);


			format.Indent = new StringOptions(
					4,
					1,
					Align.Left,
					' ',
					false
				);

			format.Spacer = new StringOptions(
				1,
				2,
				Align.Left,
				' ',
				false
				);

			format.Comment = new StringOptions(
				1,
				1,
				Align.Left,
				';',
				false
				);

			format.NewLine=Environment.NewLine;

		}



		#region IDisassemblyView Members

		public bool WriteToFile(string filename, Disassembly disassembly, Options options)
		{
			bool retval = false;

			if (IO.File.Exists(filename))
			{
				IO.File.Delete(filename);
			}
			if (!IO.File.Exists(filename))
			{
				IO.StreamWriter writer = new IO.StreamWriter(filename,false);
				try
				{
					if (writer!=null)
					{
						WriteFunctions(writer,disassembly,options);
						WriteResources(writer,disassembly,options);
						WriteInstructions(writer,disassembly,options);
					}
					retval = true;
				}
				finally
				{
					writer.Flush();
					writer.Close();
					writer=null;
				}
				
			}

			return retval;
		}


		public bool ShowResourceTree
		{
			get
			{

				return false;
			}
		}

		public bool ShowInstructionTextBox
		{
			get
			{
				
				return true;
			}
		}

		public bool ShowInfoTextBox
		{
			get
			{
				return false;
			}
		}


		public string Name
		{
			get
			{
				return "ScasmView";
			}
		}

		public string Description
		{
			get
			{
				return "provides a small-assembly syntax view of a disassembly";
			}
		}


		public FormatOptions Format
		{
			get
			{
				if (!inited)
				{
					InitFormat();
					inited=true;
				}
				return format;
			}
			set
			{
				format=value;
				inited|=true;
			}
		}

		public void ResetFormat()
		{
			InitFormat();
		}


		public bool CanWriteToFile
		{
			get
			{
				return true;
			}
		}
		public bool CanWriteResourceToTree
		{
			get
			{
				return false;
			}
		}
		public bool CanWriteResourceToText
		{
			get
			{
				return true;
			}
		}

		public bool CanWriteInstructionToText
		{
			get
			{
				return true;
			}
		}

		public bool CanGetLineInfo
		{
			get
			{
				// TODO:  Add ScasmDisassemblyView.CanGetLineInfo getter implementation
				return false;
			}
		}

		public LineParts GetLineInfo(string line)
		{
			return LineParts.Empty;
		}
		#endregion

		public void WriteInstructions(object output, Disassembly disassembly, Options options)
		{
			if (output is IO.TextWriter)
			{
				this.WriteInstructions( (output as IO.TextWriter), disassembly,options);
			}
		}

		private void WriteInstructions(IO.TextWriter writer, Disassembly dis, Options options)
		{
			int index = -1;
			object val;
			bool inproc = false;
			bool ininfo = false;
			bool infile = false;
			bool returned = false;
			 
			StringBuilder builder;
			Label lbl = null;
			AJump jmp = null;
			ASymbol sym = null;
			string name = null;
			writer.Write(options.format.NewLine);
			writer.WriteLine(".CODE");

			if (dis!=null)
			{
				/*ArrayList*/ InstructionList instlist =  dis.Instructions;
				/*ArrayList*/ ResourceList reslist = dis.Resources;
				LabelTable labels = dis.Labels;
				JumpTable  jumps = dis.Jumps;

				foreach (Instruction inst in instlist)
				{
					builder = new StringBuilder(50);
					lbl = labels[inst.Offset];
					jmp = jumps[inst.Offset];
					sym = dis.Symbols[inst.Offset] as ASymbol;

					#region label target
					if (lbl!=null)
					{
						builder.Append(options.format.Indent.PadChar,options.format.Indent.MinWidth);
						builder.Append(lbl.Name);
						builder.Append(":");
						builder.Append(options.format.NewLine);
						lbl=null;
					}
					#endregion
					
					switch (inst.Op.Code)
					{
						#region PUSH | CONST
						case OPCODES.OP_PUSH:
						case OPCODES.OP_PUSH_PRI:
						case OPCODES.OP_PUSH_ALT:
						case OPCODES.OP_PUSH_C:
						case OPCODES.OP_CONST_ALT:
						case OPCODES.OP_CONST_PRI:
							val=null;
							val = dis.ResourceReferences[inst.Offset];
							if (val!=null && val is ValInt)
							{
								//builder.Append(options.format.Indent.PadChar,options.format.Indent.Width);
								//builder.Append(inst.Op.Name.ToLower());
								//builder.Append(options.format.StringParams.PadChar, Math.Max(options.format.Opcode.MinWidth,(options.format.Opcode.MaxWidth - inst.Op.Name.Length)) );

								WriteOpcodeAndOffset(builder,inst,options,options.format.Indent.MaxWidth);

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								IDatEntry datentry = dis.Resources.FromStart( (ValInt) val );
								//IDatEntry datentry = dis.ResourcesAddresses[(ValInt)val] as IDatEntry ;

								if (datentry!=null)
								{
									builder.Append(	inst.FormatString(datentry.Name,options.format.StringParams));
											
//									int len = options.format.StringParams.Width - datentry.Name.Length;
//									if (len<0) 
//									{
//										len=0;
//									}
//									switch (options.format.StringParams.Alignment)
//									{
//										case Align.Left:
//											builder.Append(datentry.Name);
//											builder.Append(options.format.StringParams.PadChar,len);
//											break;
//										case Align.Right:
//											builder.Append(options.format.StringParams.PadChar,len);
//											builder.Append(datentry.Name);
//											break;
//									}
									builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MaxWidth);
									builder.Append(options.format.Comment.PadChar,options.format.Comment.MaxWidth);
									builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MaxWidth);
									builder.Append("ref to ");
									builder.Append(datentry.Type.ToString());
									builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MaxWidth);
								}
								else
								{
									builder.Append("[BAD DAT]");
								}
							}
							else
							{
								goto default;
							}
							break;
							#endregion
						#region CALL
						case OPCODES.OP_CALL:
							//builder.Append(options.format.Indent.PadChar,options.format.Indent.Width);
							//builder.Append(inst.Op.Name.ToLower());
							//builder.Append(options.format.StringParams.PadChar, Math.Max(options.format.Opcode.MinWidth,(options.format.Opcode.MaxWidth - inst.Op.Name.Length)) );
							//builder.Append(options.format.Spacer.PadChar,options.format.Spacer.Width);

							WriteOpcodeAndOffset(builder,inst,options,options.format.Indent.MaxWidth);

							builder.Append(
								options.format.Spacer.PadChar,
								options.format.Spacer.MaxWidth
								);

							
							index = (ValInt)dis.PrivateReferences[inst.Offset];
							name = dis.PrivateFunctions[index] as string ;
							if (name==null)
							{
								name=dis.PublicsFunctions[index] as string;
							}
							if (name!=null && name.Length>0)
							{
								builder.Append(inst.FormatString(name,options.format.StringParams));
							}
							else
							{
								builder.Append("[BADCALL]");
								//throw new Exception("call instructions can only call functions that are present in the amx file");
							}
							break;
						#endregion
						#region SYSREQ
						case OPCODES.OP_SYSREQ_C:
						case OPCODES.OP_SYSREQ_PRI:
//							builder.Append(options.format.Indent.PadChar,options.format.Indent.Width);
//							builder.Append(inst.Op.Name.ToLower());
//							builder.Append(options.format.StringParams.PadChar, Math.Max(options.format.Opcode.MinWidth,(options.format.Opcode.MaxWidth - inst.Op.Name.Length)) );
//							builder.Append(options.format.Spacer.PadChar,options.format.Spacer.Width);

							WriteOpcodeAndOffset(builder,inst,options,options.format.Indent.MaxWidth);

							builder.Append(
								options.format.Spacer.PadChar,
								options.format.Spacer.MaxWidth
								);

							name = dis.NativeFunctions[dis.NativeReferences[inst.Offset]] as string ;
							if (name!=null && name.Length>0)
							{
								builder.Append(inst.FormatString(name,options.format.StringParams));
							}
							else
							{
								builder.Append("[BAD SYSREQ]");
								//throw new Exception("sysreq instructions cannot call external functions unless they are registered in the natives table");
							}
							break;
						#endregion
						#region PROC
						case OPCODES.OP_PROC:
							if (ininfo)
							{
								builder.Append("ENDI");
								builder.Append(options.format.NewLine);
								ininfo=false;
							}
							if (inproc)
							{
								builder.Append("ENDP");
								builder.Append(options.format.NewLine);
								inproc=false;
							}
							inproc=true;
							returned=false;
							builder.Append(options.format.NewLine);
							builder.Append("PROC");
							builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MaxWidth);
							name = dis.PublicsFunctions[inst.Offset] as string;
							if (name==null)
							{
								name = dis.PrivateFunctions[inst.Offset] as string;
							}
							if (name!=null)
							{
								builder.Append(name);
							}
							break;
						#endregion
						#region NONE (case)
						case OPCODES.OP_NONE:

							builder.Append(
								options.format.Indent.PadChar,
								options.format.Indent.MaxWidth
								);

							if (jmp is Case)
							{
								builder.Append(
										inst.FormatString(
											"case",
											options.format.Opcode,
											new string(
												options.format.StringParams.PadChar,
												options.format.StringParams.MinWidth
												),
											null
										)
									);
								//builder.Append("case");
								//builder.Append(options.format.StringParams.PadChar,Math.Max(options.format.Opcode.MinWidth,options.format.Opcode.MaxWidth-(options.format.Indent.Width+2)));

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								builder.Append(inst.FormatValue(inst.GetParam(0),options.format.NumberParams));

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								//builder.Append(options.format.StringParams.PadChar,Math.Max(options.format.NumberParams.MinWidth,(options.format.NumberParams.MaxWidth - jmp.Name.Length)));
								//builder.Append(jmp.Name);

								builder.Append(inst.FormatString(jmp.Name,options.format.StringParams));
							}
							else
							{
								builder.Append(inst.Op.Name.ToLower());
							}
							break;
							#endregion
						#region CASETBL
						case OPCODES.OP_CASETBL:
							if (jmp!=null)
							{
								//builder.Append(options.format.Indent.PadChar,options.format.Indent.Width);
								//builder.Append(inst.Op.Name.ToLower());
								//builder.Append(options.format.StringParams.PadChar, Math.Max(options.format.Opcode.MinWidth,(options.format.Opcode.MaxWidth - inst.Op.Name.Length)) );
								//builder.Append(options.format.Spacer.PadChar,options.format.Spacer.Width);

								WriteOpcodeAndOffset(builder,inst,options,options.format.Indent.MaxWidth);

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								builder.Append(inst.FormatValue(inst.GetParam(0),options.format.NumberParams));

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								builder.Append(inst.FormatString(jmp.Name,options.format.StringParams));

								//builder.Append(options.format.StringParams.PadChar,Math.Max(options.format.NumberParams.MinWidth,(options.format.NumberParams.MaxWidth - jmp.Name.Length)));
								//builder.Append(jmp.Name);
							}
							else
							{
								throw new Exception("casetbl opcode must be the origin of a jump, this assembly is invalid");
							}
							break;
						#endregion
						#region RET | RETN
						case OPCODES.OP_RET:
						case OPCODES.OP_RETN:
							returned=true;
							goto default;
						#endregion

						#region LINE
						case OPCODES.OP_LINE:
							if (options.debugops.ShowLineOps)
							{
								goto default;
							}
							break;
						#endregion
						#region FILE
						case OPCODES.OP_FILE:
							if (options.debugops.ShowFileOps)
							{
								if (!infile /*&& !ininfo && !inproc*/)
								{
									if (ininfo)
									{
										builder.Append("ENDI");
										builder.Append(options.format.NewLine);
										ininfo=false;
									}
									if (inproc)
									{
										builder.Append("ENDP");
										builder.Append(options.format.NewLine);
										inproc=false;
									}
									builder.Append(options.format.NewLine);
									builder.Append("FILE");
									builder.Append(options.format.NewLine);
									infile=true;
								}

								//builder.Append(options.format.Indent.PadChar,options.format.Indent.Width);
								//builder.Append(inst.Op.Name.ToLower());
								//builder.Append(options.format.StringParams.PadChar,Math.Max(options.format.Opcode.MinWidth,options.format.Opcode.MaxWidth - inst.Op.Name.Length));

								WriteOpcodeAndOffset(builder,inst,options,options.format.Indent.MaxWidth);

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								builder.Append(inst.FormatValue(inst.GetParam(1),options.format.NumberParams));

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								File file = sym as File;
								if (file!=null)
								{
									builder.Append(
											inst.FormatString(
												file.Information,
												options.format.StringParams,
												"\"",
												"\""
											)
										);

//									int len = options.format.StringParams.Width - (file.Information.Length+2);
//									if (len<0)
//									{
//										len=0;
//									}
//									switch (options.format.StringParams.Alignment)
//									{
//										case Align.Left:
//											builder.Append('"');
//											builder.Append(file.Information);
//											builder.Append('"');
//											builder.Append(options.format.StringParams.PadChar,len);
//											break;
//										case Align.Right:
//											builder.Append(options.format.StringParams.PadChar,len);
//											builder.Append('"');
//											builder.Append(file.Information);
//											builder.Append('"');
//											break;
//									}

								}
								else
								{
									throw new Exception("file opcodes must have a corresponding file in the symbol table, this assembly is invalid.");
								}
							}
							break;
						#endregion
						#region SYMBOL
						case OPCODES.OP_SYMBOL:				
							if (inproc && returned)
							{
								builder.Append("ENDP");
								builder.Append(options.format.NewLine);
								inproc=false;								
							}
							if (infile)
							{
								builder.Append("ENDF");
								builder.Append(options.format.NewLine);
								infile=false;
							}
							if (options.debugops.ShowSymbolOps)
							{
								if (!ininfo && !inproc)
								{
									builder.Append(options.format.NewLine);
									builder.Append("INFO");
									builder.Append(options.format.NewLine);
									ininfo=true;
								}
								#region write it 
								Symbol symb = sym as Symbol;
								if (symb!=null)
								{
									//builder.Append(options.format.Indent.PadChar,options.format.Indent.Width);
									//builder.Append(inst.Op.Name.ToLower());
									//builder.Append(options.format.StringParams.PadChar,Math.Max(options.format.Opcode.MinWidth,options.format.Opcode.MaxWidth - inst.Op.Name.Length));
									//builder.Append(options.format.Spacer.PadChar,options.format.Spacer.Width);

									WriteOpcodeAndOffset(builder,inst,options,options.format.Indent.MaxWidth);

									builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MaxWidth
										);

									builder.Append(
											inst.FormatString(
												symb.Name,
												options.format.StringParams,
												"\"",
												"\""
											)
										);

//									int len = options.format.StringParams.Width - (symb.Name.Length+2);
//									if (len<0) 
//									{
//										len=0;
//									}
//
//									switch (options.format.StringParams.Alignment)
//									{
//										case Align.Left:
//											builder.Append('"');
//											builder.Append(symb.Name);
//											builder.Append('"');
//											builder.Append(options.format.StringParams.PadChar,len);
//											break;
//										case Align.Right:
//											builder.Append(options.format.StringParams.PadChar,len);
//											builder.Append('"');
//											builder.Append(symb.Name);
//											builder.Append('"');
//											break;
//									}

									builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MinWidth
										);

									builder.Append(symb.Class.ToString());

									
									builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MinWidth
										);

									//builder.Append(options.format.Spacer.PadChar);
									builder.Append(symb.Relative.ToString());

									
									builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MinWidth
										);

									//builder.Append(options.format.Spacer.PadChar);

									builder.Append(symb.Type.ToString());

									//builder.Append(options.format.Spacer.PadChar);
								}
								else
								{
									throw new Exception("symbol opcodes must have a corresponding symbol in the symbol table, this assembly is invalid.");
								}
							}
						#endregion
							break;
						#endregion
						#region SYMTAG
						case OPCODES.OP_SYMTAG:
							if (options.debugops.ShowSymtagOps)
							{
								if (!ininfo && !inproc)
								{
									throw new Exception("symtag opcodes may only occur when linked to symbol ops in an INFO or PROC region, this assembly is invalid");
								}
								if (sym!=null)
								{

									builder.Append(
										options.format.Indent.PadChar,
										options.format.Indent.MaxWidth
										);

									WriteOpcodeAndOffset(builder,inst,options);

									builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MaxWidth
										);

									SymbolTag tag = sym as SymbolTag; 
									if (tag!=null && tag.Owner!=null)
									{
										name = dis.Tags[tag.Value] as string;
										if (name!=null)
										{
											builder.Append(inst.FormatString(name,options.format.StringParams));
										}
										else
										{
											builder.Append(inst.FormatString("[ BAD TAG TABLE ] ",options.format.StringParams));
											builder.Append(inst.FormatValue(tag.Value,options.format.NumberParams));
										}
									}
									else
									{
										builder.Append(inst.FormatString("[ BAD TAG ]",options.format.StringParams));
										builder.Append(inst.FormatValue(inst.Offset,format.NumberParams));
										//throw new Exception("symtag opcodes must have a corresponding srange entry in the symbol table, this assembly is invalid.");
									}
									break;
								}
								else
								{
									throw new Exception("symbol srange or symtag opcode must correspond to an entry in the symbol table, this assembly is not valid");
								}
							}
							break;
						#endregion
						#region SRANGE
						case OPCODES.OP_SRANGE:
							if (options.debugops.ShowSrangeOps)
							{
								if (!ininfo && !inproc)
								{
									throw new Exception("srange opcodes may only occur when linked to symbol ops in an INFO or PROC region, this assembly is invalid");
								}
								if (sym!=null)
								{
									goto default;
								}
								else
								{
									throw new Exception("symbol srange or symtag opcode must correspond to an entry in the symbol table, this assembly is not valid");
								}
							}
							break;
						#endregion
						#region BOUNDS
						case OPCODES.OP_BOUNDS:
							if (options.debugops.ShowBoundsOps)
							{
								//builder.Append(indenter,indent);
								//WriteStandardOp(builder,inst,options,jmp);
								goto default;
							}
							break;
						#endregion

						default:
							if (inst.Op.VariableLength)
							{
								#region Variable length
								builder.Append(options.format.Indent.PadChar,options.format.Indent.MaxWidth);
								builder.Append(inst.Op.Name.ToLower());
								builder.Append(options.format.StringParams.PadChar, Math.Max(options.format.Opcode.MinWidth,(options.format.Opcode.MaxWidth - inst.Op.Name.Length)) );
								builder.Append("[VAR LEN OP]");
								#endregion
							}
							else
							{
								#region Standard length
								builder.Append(options.format.Indent.PadChar,options.format.Indent.MaxWidth);
								this.WriteStandardInstruction(builder,inst,options,jmp);
								#endregion
							}
							
							break;
					}
					if (builder.Length>0)
					{
						writer.WriteLine(builder.ToString().TrimEnd(options.format.NewLine.ToCharArray()));
					}
					builder=null;
					name=null;
					jmp=null;
					lbl=null;
				}
				#region close any open blocks
				if (inproc)
				{
					builder = new StringBuilder();
					builder.Append("ENDP");
					builder.Append(options.format.NewLine);
					writer.WriteLine(builder.ToString());
					builder=null;
				}
				if (ininfo)
				{
					builder = new StringBuilder();
					builder.Append("ENDI");
					builder.Append(options.format.NewLine);
					writer.WriteLine(builder.ToString());
					builder=null;
				}
				#endregion
			}
		}


		public void WriteResources(object output, Disassembly disassembly, Options options)
		{
			if (output is IO.TextWriter)
			{
				this.WriteResources( (output as IO.TextWriter), disassembly, options);
			}
		}
		private void WriteResources(IO.TextWriter writer, Disassembly dis, Options options)
		{
			StringBuilder str;

			if (dis.Resources!=null)
			{
				str = new StringBuilder();
				str.Append(options.format.NewLine);
				str.Append(".DATA");
				str.Append(options.format.NewLine);
				
				foreach (IDatEntry val in dis.Resources)
				{
					if (!val.InArray)
					{
						WriteStandardResource(str,val,options,0);
					}
				}
				writer.WriteLine(str.ToString());
			}
		}


		public void WriteFunctions(IO.TextWriter writer, Disassembly dis, Options options)
		{
			StringBuilder str;

			if (dis.PublicsFunctions!=null)
			{
				str = new StringBuilder();
				str.Append(options.format.NewLine);
				str.Append(".PUBLIC");
				str.Append(options.format.NewLine);
				foreach (string val in dis.PublicsFunctions.Values)
				{
					str.Append(options.format.Indent.PadChar,options.format.Indent.MaxWidth);
					str.Append(val);
					str.Append(options.format.NewLine);
				}
				writer.Write(str.ToString());
				str=null;
			}

			if (dis!=null)
			{
				str = new StringBuilder();
				str.Append(options.format.NewLine);
				str.Append(".NATIVE");
				str.Append(options.format.NewLine);
				foreach (string val in dis.NativeFunctions.Values)
				{
					str.Append(options.format.Indent.PadChar,options.format.Indent.MaxWidth);
					str.Append(val);
					str.Append(options.format.NewLine);
				}
				writer.Write(str.ToString());
				str=null;
			}
		}


		public void WriteStandardInstruction(StringBuilder builder, Instruction inst, Options options)
		{
			WriteStandardInstruction(builder,inst,options,null);
		}
		public void WriteStandardInstruction(StringBuilder builder, Instruction inst,Options options,AJump jmp)
		{
			if (inst.Op.ParamCount>=0)
			{
				WriteOpcodeAndOffset(builder,inst,options);

				bool writejump = (jmp!=null);
				ValInt param;

				if (!inst.Op.VariableLength && inst.Op.ParamCount>0)
				{
					for (int i=0;i<inst.Op.ParamCount;i++)
					{
						builder.Append(
							options.format.Spacer.PadChar,
							options.format.Spacer.MaxWidth
							);

						param = inst.GetParam(i);

						if ( writejump && (param == jmp.Target) )
						{
							builder.Append(inst.FormatString(jmp.Name,options.format.StringParams));
							writejump=false;
						}
						else
						{
							builder.Append(inst.FormatValue(param,options.format.NumberParams));
						}
						
					}
				}

//				if (inst.Op.OpCount>0)
//				{
//					if (jmp!=null)
//					{
//						for (int i=0;i<inst.Op.OpCount;i++)
//						{
//							builder.Append(
//								options.format.Spacer.PadChar,
//								options.format.Spacer.Width
//								);
//
//							ValInt param = inst.GetParam(i);
//							if (param == jmp.Target)
//							{
//								builder.Append(
//									inst.FormatString(
//									jmp.Name,
//									options.format.StringParams.MaxWidth,
//									options.format.StringParams.MinWidth,
//									options.format.StringParams.Alignment,
//									options.format.StringParams.PadChar
//									)
//									);
//							}
//							else
//							{
//								builder.Append(
//									inst.FormatValue(
//									param,
//									options.format.NumberParams.MaxWidth,
//									0,
//									options.format.NumberParams.Alignment,
//									options.format.NumberParams.Format,
//									options.format.StringParams.PadChar
//									)
//									);
//							}
//						}
//					}
//					else
//					{
//						for (int i=0;i<inst.Op.OpCount;i++)
//						{
//							builder.Append(
//								options.format.Spacer.PadChar,
//								options.format.Spacer.Width
//								);
//
//							builder.Append(
//								inst.FormatValue(
//								inst.GetParam(i),
//								options.format.NumberParams.MaxWidth,
//								0,
//								options.format.NumberParams.Alignment,
//								options.format.NumberParams.Format,
//								options.format.StringParams.PadChar
//								)
//								);
//						}
//					}
//				}
			}
		}


		public void WriteStandardResource(StringBuilder builder, IDatEntry entry, Options options)
		{
			WriteStandardResource(builder, entry, options,0);
		}
		public void WriteStandardResource(StringBuilder builder, IDatEntry entry, Options options,int preindent)
		{
			if (builder!=null)
			{
				int len=0;

				builder.Append(options.format.StringParams.PadChar,preindent);
				builder.Append(options.format.StringParams.PadChar,options.format.Indent.MaxWidth);
				switch (entry.Type)
				{
					case DatEntryType.Array:
						ArrayEntry a = entry as ArrayEntry;
						if (a.Name!=null && a.Name.Length>0)
						{
							len = Math.Max(options.format.Opcode.MinWidth,(options.format.Opcode.MaxWidth - a.Name.Length));
							builder.Append(a.Name);
							builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						}
						builder.Append("array");
						builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						builder.Append(a.Values.Length.ToString("D"));
						builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						if (a.IsHomegenous())
						{
							builder.Append("fill ");
							if (a.IsZeroed())
							{
								builder.Append("0x0");
							}
							else
							{
								builder.Append("0x");
								builder.Append(a.FillValue.ToString("X"));
							}
						}
						else
						{
							if (a.Values.Length<=10)
							{
								builder.Append("(");
								builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
								for (int j=0;j<a.Values.Length;j++)
								{
									builder.Append("0x");
									builder.Append( a.Values[j].ToString("X") );
									if (j!=a.Values.Length-1)
									{
										builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
										builder.Append( "," );
										builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
									}
								}
								builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
								builder.Append(")");
							}
							else
							{
								int k = 0;
								int l = 0;
								builder.Append(options.format.NewLine);
								builder.Append(options.format.Indent.PadChar,preindent);
								builder.Append(options.format.Indent.PadChar,options.format.Indent.MaxWidth);
								builder.Append(options.format.Indent.PadChar,options.format.Indent.MaxWidth);
								builder.Append("(");
								builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
								for (l=0;l<a.Values.Length;l++,k++)
								{
									if (k==10)
									{
										builder.Append(options.format.NewLine);
										builder.Append(options.format.Indent.PadChar,preindent);
										builder.Append(options.format.Indent.PadChar,options.format.Indent.MaxWidth);
										builder.Append(options.format.Indent.PadChar,options.format.Indent.MaxWidth);
										k=0;
									}
									builder.Append("0x");
									builder.Append( a.Values[l].ToString("X") );
									if (l!=a.Values.Length-1)
									{
										builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
										builder.Append( "," );
										builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
									}
								}
								builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
								builder.Append(")");
							}
						}
						break;
					case DatEntryType.MultiArray:
						MultiEntry m = entry as MultiEntry;
						if (m.Name!=null && m.Name.Length>0)
						{
							len = Math.Max(options.format.Opcode.MinWidth,(options.format.Opcode.MaxWidth - m.Name.Length));
							builder.Append(m.Name);
							builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						}
						builder.Append("multiarray");
						builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						builder.Append(m.FirstBound.ToString());
						builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						if (m.LastBound!=-1)
						{
							builder.Append(m.LastBound.ToString());
						}
						else
						{
							builder.Append("-");
						}
						builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						builder.Append(options.format.NewLine);
						for (int count=0;count<m.FirstBound;count++)
						{
							WriteStandardResource(builder,m.Data[count],options,preindent+options.format.Indent.MaxWidth);
						}
						break;
					case DatEntryType.String :
						StringEntry s = entry as StringEntry;
						if (s.Name!=null && s.Name.Length>0)
						{
							len = Math.Max(options.format.Opcode.MinWidth,(options.format.Opcode.MaxWidth - s.Name.Length));
							builder.Append(s.Name);
							builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						}
						builder.Append("string");
						builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						if(s.Packed)
						{
							builder.Append('!');
						}
						builder.Append('"');
						builder.Append(s.Data);
						builder.Append('"');						
						break;
					case DatEntryType.Variable:
						VariableEntry v = entry as VariableEntry;
						if (v.Name!=null && v.Name.Length>0)
						{
							len = Math.Max(options.format.Opcode.MinWidth,(options.format.Opcode.MaxWidth - v.Name.Length));
							builder.Append(v.Name);
							builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						}
						builder.Append("variable");
						builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						builder.Append("(");
						builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						builder.Append("0x");
						builder.Append(v.Value.ToString("X"));
						builder.Append(options.format.StringParams.PadChar,options.format.StringParams.MinWidth);
						builder.Append(")");
						break;
					default:
						throw new Exception();
				}
				builder.Append(options.format.NewLine);

			}
		}


		private void WriteOpcodeAndOffset(StringBuilder builder, Instruction inst, Options options)
		{
			WriteOpcodeAndOffset(builder, inst, options, 0);
		}
		private void WriteOpcodeAndOffset(StringBuilder builder, Instruction inst, Options options, int preindent)
		{
			builder.Append(
				options.format.Indent.PadChar,
				preindent
				);

			builder.Append(inst.FormatString(inst.Op.Name.ToLower(),options.format.Opcode));
		}

		#region IDisassemblyView Members



		#endregion
	}

}