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

	using System;
	using IO = System.IO;
	using System.Text;
	using System.Text.RegularExpressions;
	using System.Collections;
	using System.Collections.Specialized;

	using Win = System.Windows.Forms;


	public class WindowsFormsDisassemblyView : IDisassemblyView	
	{
		//private const string infopattern  = @"^[\s]*?(0x[A-Z0-9]+|[0-9]+|)[\s]*?([A-Z]+(?:[A-Za-z\.]+|)).*$";
		private const string infopattern = @"^\s*(0x[A-Z0-9]+|[0-9]+|)\s+?([A-Z]+(?:[A-Za-z\.]+|))\s*([^;]*?)\s*(?:\s*;\s(.*?)|)\s*$";
		private bool inited;
		private Regex regex;
		private FormatOptions format;

		public WindowsFormsDisassemblyView()
		{
			regex = new Regex(infopattern);
			inited=false;
		}

		
		private void InitFormat()
		{
			format = new FormatOptions();

			format.Offset = new NumberOptions(
					10,
					0,
					Align.Left,
					NumberFormat.Hex,
					0,
					' '
				);

			format.Opcode=new StringOptions(
					10,
					0,
					Align.Left,
					' ',
					false
				);


			format.NumberParams = new NumberOptions(
					15,
					2,
					Align.Right,
					NumberFormat.SignedHex,
					0,
					' '
				);

			format.StringParams=new StringOptions(
					15,
					2,
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
					2,
					1,
					Align.Left,
					' ',
					false
				);

			format.Comment = new StringOptions(
					1,
					1,
					Align.Right,
					';',
					false
				);

			format.NewLine=Environment.NewLine;

		}


		#region IDisassemblyView Members

		public bool WriteToFile(string filename, Disassembly disassembly, Options options)
		{
			return false;
		}


		public bool ShowResourceTree
		{
			get
			{
				return true;
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
				return true;
			}
		}


		public string Name
		{
			get
			{
				return "WinformsView";
			}
		}

		public string Description
		{
			get
			{
				return "provides a disassembly view optimised for windows forms viewing ease";
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
				return false;
			}
		}
		public bool CanWriteResourceToTree
		{
			get
			{
				return true;
			}
		}
		public bool CanWriteResourceToText
		{
			get
			{
				return false;
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
				return true;
			}
		}


		public LineParts GetLineInfo(string line)
		{
			LineParts retval = LineParts.Empty;
			Match match = regex.Match(line);
			if (match.Groups.Count>=3)
			{
				retval = new LineParts(match.Groups[1].ToString(),match.Groups[2].ToString());
			}
			return retval;
		}
		#endregion


		public  void WriteInstructions(object output, Disassembly disassembly, Options options)
		{
			if (output is IO.TextWriter)
			{
				this.WriteInstructions( (output as IO.TextWriter) , disassembly, options);
			}
		}
		private void WriteInstructions(IO.TextWriter writer, Disassembly dis, Options options)
		{
			StringBuilder builder;
			Label lbl = null;
			Line ln = null;
			AJump jmp = null;
			ASymbol sym = null;
			string name = null;
			bool returned= true;
			bool hascomment = false;
			bool blocknewline = false;

			if (dis!=null)
			{
				InstructionList instlist =  dis.Instructions;
				ResourceList reslist = dis.Resources;
				LabelTable labels = dis.Labels;
				JumpTable  jumps = dis.Jumps;
				SymbolTable symbols = dis.Symbols;

				builder = new StringBuilder(10000);
				foreach (Instruction inst in instlist)
				{
					ln = null;
					lbl = labels[inst.Offset];
					jmp = jumps[inst.Offset];
					sym = symbols[inst.Offset];

					switch (inst.Op.Code )
					{
						#region PUSH | CONST
						case OPCODES.OP_PUSH:
						case OPCODES.OP_PUSH_PRI:
						case OPCODES.OP_PUSH_ALT:
						case OPCODES.OP_PUSH_C:
						case OPCODES.OP_CONST_ALT:
						case OPCODES.OP_CONST_PRI:
							object val=null;
							val = dis.ResourceReferences[inst.Offset];
							if (val!=null && val is ValInt)
							{
								WriteOpcodeAndOffset(builder,inst,options);

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								//IDatEntry datentry = dis.ResourcesAddresses[(ValInt)val] as IDatEntry ;
								IDatEntry datentry = dis.Resources.FromStart((ValInt)val);

								if (datentry!=null)
								{
									if (datentry.Name!=null && datentry.Name.Length>0)
									{
										builder.Append(inst.FormatString(datentry.Name,options.format.StringParams));
									}
									builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MinWidth);
									builder.Append(options.format.Comment.PadChar,options.format.Comment.MaxWidth);
									builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MinWidth );
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

							WriteOpcodeAndOffset(builder,inst,options);
							builder.Append(
								options.format.Spacer.PadChar,
								options.format.Spacer.MaxWidth
								);

							ValInt index = (ValInt)dis.PrivateReferences[inst.Offset];
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
								builder.Append(inst.FormatString("[ BAD CALL ]",options.format.StringParams));
								builder.Append(inst.FormatValue(inst.GetParam(0),format.NumberParams));
								//throw new Exception("call instructions can only call functions that are present in the amx file");
							}
							break;
						#endregion
						#region SYSREQ
						case OPCODES.OP_SYSREQ_C:
						case OPCODES.OP_SYSREQ_PRI:

							WriteOpcodeAndOffset(builder,inst,options);

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
							}
							break;
						#endregion

						#region PROC
						case OPCODES.OP_PROC:
							returned=false;
							builder.Append(options.format.NewLine);
							WriteStandardInstruction(builder,inst,options,jmp);
							builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MaxWidth);
							builder.Append(options.format.StringParams.PadChar,options.format.NumberParams.MaxWidth);
							WriteCommentSeparator(builder,options,ref hascomment);
							string nm = dis.PublicsFunctions[inst.Offset] as string;
							if (nm==null)
							{
								nm = dis.PrivateFunctions[inst.Offset] as string;
							}
							if (nm!=null)
							{
								builder.Append(nm);
							}
							break;
						#endregion
						#region RET | RETN
						case OPCODES.OP_RET:
						case OPCODES.OP_RETN:
							returned=true;
							goto default;
							#endregion
						#region CASETBL
						case OPCODES.OP_CASETBL:
							if (jmp!=null)
							{
								//builder.Append(options.format.Indent.PadChar,options.format.Indent.MinWidth);
								//builder.Append(inst.FormatOffset(options.format.Offset.MaxWidth,options.format.Offset.Alignment,options.format.Offset.Format));
								//builder.Append(options.format.Spacer.PadChar,options.format.Spacer.Width);
								//builder.Append(inst.FormatOp(options.format.Opcode.MaxWidth,options.format.Opcode.Alignment));
								//builder.Append(options.format.Spacer.PadChar,options.format.Spacer.Width);

								WriteOpcodeAndOffset(builder, inst,options);

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								builder.Append(inst.FormatValue(inst.GetParam(0),options.format.NumberParams));

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								//builder.Append(options.format.StringParams.PadChar,Math.Max(options.format.NumberParams.MinWidth ,(options.format.NumberParams.MaxWidth - jmp.Name.Length)));
								//builder.Append(jmp.Name);
								builder.Append(inst.FormatString(jmp.Name,options.format.StringParams));
							}
							else
							{
								throw new Exception("casetbl opcode must be the origin of a jump, this assembly is invalid");
							}
							break;
						#endregion
						#region NONE (CASE)
						case OPCODES.OP_NONE:
							if (jmp is Case)
							{
								//builder.Append(options.format.Indent.PadChar,options.format.Indent.MinWidth);
								//builder.Append(options.format.Spacer.PadChar,options.format.Offset.MaxWidth);
								//builder.Append(options.format.Spacer.PadChar,options.format.Spacer.Width);
								//builder.Append("CASE");
								//builder.Append(options.format.Spacer.PadChar,Math.Max( (options.format.Opcode.MaxWidth-4),0));
								//builder.Append(options.format.StringParams.PadChar,options.format.Spacer.Width);


								builder.Append(
									options.format.Indent.PadChar,
									options.format.Indent.MinWidth
									);

								// write the offset
								builder.Append(
									options.format.Offset.PadChar,
									options.format.Offset.MaxWidth
									);

								// write the spacer
								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								builder.Append(inst.FormatString("CASE",options.format.Opcode));

								// write the spacer
								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								builder.Append(inst.FormatValue(inst.GetParam(0),options.format.NumberParams));

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								//builder.Append(options.format.StringParams.PadChar,(options.format.NumberParams.MaxWidth - jmp.Name.Length));
								//builder.Append(jmp.Name);

								builder.Append(inst.FormatString(jmp.Name,options.format.StringParams));

								break;
							}
							else
							{
								//builder.Append(inst.Op.Name.ToLower());
								goto default;
							}
							
							#endregion
							
						#region SYMBOL
						case OPCODES.OP_SYMBOL:
							if (options.debugops.ShowSymbolOps)
							{
								if (returned)
								{
									builder.Append(options.format.NewLine);
								}
								WriteOpcodeAndOffset(builder,inst,options);

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MaxWidth
									);

								#region write it 
								Symbol symb = sym as Symbol;
								if (symb!=null)
								{

									builder.Append(
										inst.FormatString(
										symb.Name,
										options.format.StringParams,
										"\"",
										"\""
										)
										);

									builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MinWidth
										);

									builder.Append(symb.Class.ToString());

									builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MinWidth
										);

									builder.Append(symb.Relative.ToString());

									builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MinWidth
										);

									builder.Append(symb.Type.ToString());

									if (
										symb.Relative==SymbolRelativeTo.COD &&
										symb.Class == SymbolFlagClass.global &&
										symb.Type == SymbolFlagType.function
										)
									{
										//blocknewline = true;
									}
								}
								else
								{
									throw new Exception("symbol opcodes must have a corresponding symbol in the symbol table, this assembly is invalid.");
								}
							}
							#endregion
							else
							{
								blocknewline=true;
							}
							break;
						#endregion
						#region SYMTAG
						case OPCODES.OP_SYMTAG:
							if (options.debugops.ShowSymtagOps)
							{
								//goto default;	
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
										builder.Append(inst.FormatString("[ BAD TAG ENTRY ] ",options.format.StringParams));
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
								blocknewline=true;
								break;
							}
						#endregion
						#region SRANGE
						case OPCODES.OP_SRANGE:
							if (options.debugops.ShowSrangeOps)
							{
								WriteOpcodeAndOffset(builder,inst,options);

								builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MaxWidth
									);

								builder.Append(
									inst.FormatValue(
										inst.GetParam(0),
										options.format.NumberParams
										,"rank ",
										","
										)
									);

								builder.Append(
									options.format.Spacer.PadChar,
									options.format.Spacer.MinWidth
									);

								builder.Append(
									inst.FormatValue(
										inst.GetParam(1),
										options.format.NumberParams.Modify(Align.Left),
										"len ",
										null
										)
									);

								SymbolRange range = sym as SymbolRange; 
								if (range!=null && range.Owner!=null)
								{
									WriteCommentSeparator(builder,options,ref hascomment);

								
									for (int i=0;i<range.Rank;i++)
									{
										builder.Append(" [   ]");
									}

									builder.Append(" [ ");
									builder.Append( range.Value.ToString("D") );
									builder.Append(" ]");
								}
								else
								{
									throw new Exception("srange opcodes must have a corresponding srange entry in the symbol table, this assembly is invalid.");
								}								
							}
							else
							{
								blocknewline=true;
							}
							break;
							#endregion
						#region BOUNDS
						case OPCODES.OP_BOUNDS:
							if (options.debugops.ShowBoundsOps)
							{
								goto default;								
							}
							else
							{
								blocknewline=true;
								break;
							}
							#endregion
						#region LINE
						case OPCODES.OP_LINE:
							ln = sym as Line;
							if (ln!=null)
							{
								if (options.debugops.ShowLineOps || (lbl!=null) )
								{
									WriteOpcodeAndOffset(builder,inst,options);

									builder.Append(
										options.format.Spacer.PadChar,
										options.format.Spacer.MaxWidth
										);

									if (ln.Ordinal!=0)
									{
										builder.Append(inst.FormatValue(inst.GetParam(0),options.format.NumberParams,"line ",","));
										builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MinWidth);
										builder.Append(inst.FormatValue(inst.GetParam(1),options.format.NumberParams.Modify(Align.Left),"file ",null));
									}
									else
									{
										builder.Append(inst.FormatValue(inst.GetParam(0),options.format.NumberParams,"line ",null));
									}
								}
								else
								{
									blocknewline=true;
								}

								/*
								if (options.ShowSource)
								{
									if (dis.Source!=null )
									{
										builder.Append( options.format.NewLine);
										if (ln.Ordinal==0)
										{
											if (ln.Number>=0 && ln.Number<dis.Source.Count)
											{
												builder.Append(dis.Source[ln.Number] );
											}
											else
											{
												builder.Append("[BAD LINE]");
											}
										}
										else
										{
											builder.Append("[EXTERNAL FILE]");
										}
									}
								}
								*/
							}
							else
							{
								throw new Exception("line opcode without corresponding source was found");
							}
							break;
							#endregion
						#region FILE
						case OPCODES.OP_FILE:
							if (options.debugops.ShowFileOps)
							{
								WriteOpcodeAndOffset(builder,inst,options);

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
								}
								else
								{
									throw new Exception("file opcodes must have a corresponding file in the symbol table, this assembly is invalid.");
								}
							}
							else
							{
								blocknewline=true;
							}
							break;
						#endregion

						default:
							WriteStandardInstruction(builder,inst,options,jmp);
							break;
					}

					#region label target
					if (lbl!=null)
					{
						WriteCommentSeparator(builder,options,ref hascomment);
						builder.Append(
								inst.FormatString(
									lbl.Name,
									new StringOptions(
										lbl.Name.Length,
										0,
										Align.Left,
										' ',false
										),
									"target:",
									null
								)
							);
						//builder.Append("target:");
						//builder.Append(lbl.Name);
						//builder.Append("->");
						//builder.Append(lbl.Name);
						//builder.Append(", ");
						//lbl=null;
					}
					#endregion

					#region source input
					if (ln!=null && options.ShowSource)
					{
						if (dis.Source!=null )
						{
							builder.Append( options.format.NewLine);
							if (ln.Ordinal==0)
							{
								if (ln.Number>=0 && ln.Number<dis.Source.Count)
								{
									builder.Append(dis.Source[ln.Number-1] );
								}
								else
								{
									builder.Append("[BAD LINE]");
								}
							}
							else
							{
								builder.Append("[EXTERNAL FILE]");
							}
						}
					}
					#endregion

					if (!blocknewline)
					{
						builder.Append(options.format.NewLine);
					}
					name=null;
					jmp=null;
					lbl=null;

					hascomment=false;
					blocknewline=false;
				}
				if (builder.Length>0)
				{
					writer.WriteLine(builder.ToString().TrimEnd(options.format.NewLine.ToCharArray()));
				}
			}
		}


		public  void WriteResources(object output, Disassembly disassembly, Options options)
		{
			if (output is Win.TreeView)
			{
				this.WriteResourcesTree( (output as Win.TreeView), disassembly, options);
			}
		}


		private void WriteResourcesTree(Win.TreeView tree, Disassembly disassembly, Options options)
		{
			foreach (IDatEntry entry in disassembly.Resources)
			{
				if (!entry.InArray)
				{
					WriteStandardResourceNode(tree.Nodes,entry,disassembly,options);
				}
			}
			Hashtable index = new Hashtable(tree.Nodes.Count);
			foreach (Win.TreeNode node in tree.Nodes)
			{
				if (node.Tag!=null && node.Tag is ValInt)
				{
					index.Add( (ValInt)node.Tag , node );
				}
			}
			tree.Tag=index;
		}

		private void WriteStandardResourceNode(Win.TreeNodeCollection nodes, IDatEntry entry, Disassembly dis, Options options)
		{
			StringEntry str = null;
			MultiEntry mae = null;
			ArrayEntry arr = null;
			VariableEntry var = null;
			Win.TreeNode node = new System.Windows.Forms.TreeNode(); 
			node = new Win.TreeNode(entry.Type.ToString());
			node.Tag=new ValInt(entry.Start);

			node.Text+=" " + entry.Name;
			if (entry.Name!=null)
			{
				if 	(entry.NameType!=DatNameStrength.Runtime)
				{
					node.ForeColor=System.Drawing.Color.Navy;
					node.Nodes.Add(new Win.TreeNode("Providence: " + entry.NameType.ToString() ));
				}
				node.Nodes.Add("Name: " +entry.Name);
			}

			switch (entry.Type)
			{
				case DatEntryType.Array:
					arr = entry as ArrayEntry;
					if (arr!=null)
					{
						if (arr.IsZeroed())
						{
							node.Nodes.Add(new Win.TreeNode("Empty"));
						}
						else if(arr.IsHomegenous())
						{
							node.Nodes.Add(	new Win.TreeNode("Homogenous"));
							node.Nodes.Add("Fill Value: " + arr.FillValue.ToString("X") );
						}
						else
						{
						}
						node.Text+=
							" [ " +
							 entry.Length.ToString("D") +
							" ]";
					}
					break;
				case DatEntryType.String:
					str = entry as StringEntry;
					if (str!=null)
					{
						if (entry.Name==null)
						{
							if (str.Data.Length>19)
							{
								node.Text+=
									" \"" + 
									str.Data.Substring(0,19) +
									"...\"";
							}
							else
							{
								node.Text+= 
									" \"" + 
									str.Data + 
									"\"";
							}
						}
						node.Nodes.Add(new Win.TreeNode("Data: \""+str.Data+"\""));
						if (str.Packed)
						{
							node.Nodes.Add(new Win.TreeNode("Packed"));
						}
					}
					break;
				case DatEntryType.Variable:
					var = entry as VariableEntry;
					if (var!=null)
					{
						node.Nodes.Add(new Win.TreeNode("Value: " + var.Value.ToString("x")));
					}
					break;
				case DatEntryType.MultiArray:
					mae = entry as MultiEntry;
					if (mae!=null)
					{
						int bounds = mae.Bounds;
						for (int i=0;i<bounds;i++)
						{
							int bound = mae.GetBound(i);
							node.Text+=	" [ ";
							if (bound>=0)
							{
								node.Text+=bound.ToString("D");
							}
							node.Text+=	" ]";							
						}
						foreach (IDatEntry sub in mae.Data)
						{
							WriteStandardResourceNode(node.Nodes,sub,dis,options);
						}
					}
					break;
			}
			node.Nodes.Add(new Win.TreeNode("Start: " + entry.Start.ToString("x")));
			node.Nodes.Add(new Win.TreeNode("Length: " + entry.Length.ToString("x")));
			nodes.Add(node);
		}


		public  void WriteStandardInstruction(StringBuilder builder, Instruction inst, Options options)
		{
			WriteStandardInstruction(builder,inst,options,null);
		}
		public  void WriteStandardInstruction(StringBuilder builder, Instruction inst, Options options,AJump jmp)
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

			/*
			if (builder!=null)
			{
				if (inst.Op.OpCount>=0)
				{
					WriteOffsetAndOpcode(builder,inst,options);

					//write the indent
//					builder.Append(
//						options.format.Indent.PadChar,
//						options.format.Indent.MinWidth
//					);
//
//					// write the offset
//					builder.Append(
//						inst.FormatValue(
//							inst.Offset,
//							options.format.Offset.MaxWidth,
//							0,						
//							options.format.Offset.Alignment,
//							options.format.Offset.Format,
//							options.format.Offset.PadChar
//							)
//						);
//
//					// write the spacer
//					builder.Append(
//						options.format.Spacer.PadChar,
//						options.format.Spacer.Width
//						);
//
//					builder.Append(
//							inst.FormatString(
//								inst.Op.Name,
//								options.format.Opcode.MaxWidth,
//								options.format.Opcode.MinWidth,
//								options.format.Opcode.Alignment,
//								options.format.Opcode.PadChar
//							)
//						);

					//builder.Append(
					//		inst.FormatOp(
					//			options.format.Opcode.MaxWidth,
					//			options.format.Opcode.Alignment
					//		)
					//	);

					if (jmp!=null)
					{
						for (int i=0;i<inst.Op.OpCount;i++)
						{
							builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MaxWidth);
							int param = inst.GetParam(i);
							if (param == jmp.Target)
							{
								int len = Math.Max (0,options.format.NumberParams.MaxWidth - jmp.Name.Length);
								switch (options.format.StringParams.Alignment)
								{
									case Align.Left:
										builder.Append(jmp.Name);
										builder.Append(options.format.StringParams.PadChar,len);
										break;
									case Align.Right:
										builder.Append(options.format.StringParams.PadChar,len);
										builder.Append(jmp.Name);
										break;
								}
							}
							else
							{
								builder.Append(
									inst.FormatValue(
									inst.GetParam(i),
									options.format.NumberParams.MaxWidth,
									0,
									options.format.NumberParams.Alignment,
									options.format.NumberParams.Format
									)
									);
							}
						}
					}
					else
					{
						for (int i=0;i<inst.Op.OpCount;i++)
						{
							builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MaxWidth);
							builder.Append(
								inst.FormatParam(
								i,
								options.format.NumberParams.MaxWidth,
								0,
								options.format.NumberParams.Alignment,
								options.format.NumberParams.Format
								)
								);
						}
					}
				}

			}
			*/
		}


		public  void WriteCommentSeparator(StringBuilder builder, Options options, ref bool written)
		{
			if (builder!=null)
			{
				if (written)
				{
					builder.Append(",");
					builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MinWidth);
				}
				else
				{
					builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MinWidth);
					builder.Append(options.format.Comment.PadChar,options.format.Comment.MaxWidth);
					builder.Append(options.format.Spacer.PadChar,options.format.Spacer.MinWidth );
					written=true;
				}
			}
		}

		public  void WriteOpcodeAndOffset(StringBuilder builder, Instruction inst, Options options)
		{
			builder.Append(
				options.format.Indent.PadChar,
				options.format.Indent.MinWidth
				);

			// write the offset
			builder.Append(inst.FormatValue(inst.Offset,options.format.Offset));

			// write the spacer
			builder.Append(
				options.format.Spacer.PadChar,
				options.format.Spacer.MaxWidth
				);

			builder.Append(inst.FormatString(inst.Op.Name,options.format.Opcode));

			// write the spacer
			//builder.Append(
			//	options.format.Spacer.PadChar,
			//	options.format.Spacer.MaxWidth
			//	);
		}
	}
}