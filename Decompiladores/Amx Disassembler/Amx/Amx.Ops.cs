using System;

namespace Amx.Ops
{
	using System.Collections;
	using System.Collections.Specialized;
	using System.IO;
	using System.Text.RegularExpressions;
	

	public class Op
	{
		private OPCODES l_code;
		private string[] l_params=null;
		private string l_name;
		private string l_description;
		private bool l_varargs;


		public Op(OPCODES code, string name, string param, string description)
		{
			l_code = code;
			l_name = name;
			if (param.IndexOf("...")==-1)
			{
				l_varargs=false;
			}
			else
			{
				l_varargs=true;
			}
			string[] t_params = param.Split(new char[]{' '});
			int count=0;
			foreach (string s in t_params)
			{
				if (s!="")
				{
					count+=1;
				}
			}
			l_params = new string[count];
			if (count>0)
			{
				//l_params = new string[count];
				count=0;
				foreach (string s in t_params)
				{
					if (s!="")
					{
						l_params[count]=s;
						count+=1;
					}
				}
			}
			l_description = description;
		}


		public string Name
		{
			get
			{
				return l_name;
			}
		}

		public string[] Params
		{
			get
			{
				return l_params;
			}
		}

		public int ParamCount
		{
			get
			{
				int retval = 0;

				if (l_params!=null)
				{
					if (l_params.Length == 1 && l_params[0]=="")
					{
						retval = 0;
					}
					else
					{
						retval=l_params.Length;
					}
				}


				return retval;
			}
		}
		public string Description
		{
			get
			{
				return l_description;
			}
		}

		public OPCODES Code
		{
			get
			{
				return l_code;
			}
		}

		public bool VariableLength
		{
			get
			{
				return l_varargs;
			}
		}

		/*
		public int ParamsCount
		{
			get
			{
				int retval = 0;
				if (!l_varargs)
				{
					if (l_params!=null)
					{
						if (l_params.Length == 1 && l_params[0]=="")
						{
							retval = 0;
						}
						else
						{
							retval=l_params.Length;
						}
					}
				}
				else
				{
					retval = -1;
				}

				return retval;
			}
		}
		*/

		/*public bool Print
		{
			get
			{
				return l_print;
			}
			set
			{
				l_print = value;
			}
		}*/
		/*public int ParamLength
		{
			get
			{
				if (l_params==null)
				{
					return 0;
				}
				else
				{
					return l_params.Length;
				}
			}
		}
		*/
	}

	public class Ops
	{
		private bool valid;
		private SortedList codes;
		private Hashtable names;
		private string l_file;
		private Regex regex;
		private Match match;

		public Ops(string path)
		{
			valid=false;
			l_file=path;
			regex = new System.Text.RegularExpressions.Regex("(.*?), (.*?), (.*?), (.*)$",System.Text.RegularExpressions.RegexOptions.Compiled);
			valid = loadfile();
		}


		private bool loadfile()
		{
			bool retval = true;
			codes = new SortedList(140);
			names = CollectionsUtil.CreateCaseInsensitiveHashtable(140);
			if (File.Exists(l_file))
			{
				StreamReader sr=null;
				try 
				{
					string line;
					sr = new StreamReader(l_file);

					while (sr.Peek()!=-1)
					{
						line = sr.ReadLine();
						match = regex.Match(line);
						if (match.Groups.Count==5)
						{
							int opnum=-1;
							Op newop = null;
							try
							{
								opnum = int.Parse(match.Groups[1].Value);
							}
							catch (FormatException)
							{
								opnum=-1;
								continue;
							}
							catch (OverflowException)
							{
								opnum=-1;
								continue;
							}
							if (opnum<0)
							{
								throw new ArgumentOutOfRangeException("opcode number cannot be less than 0");
							}
							if (!Enum.IsDefined(typeof(OPCODES),opnum))
							{
								throw new ArgumentOutOfRangeException("opcode number "+ opnum.ToString("D") + " is not present in the OPCODES enumeration");
							}
							if (codes.Contains(opnum))
							{
								throw new ArgumentException("the ops collection already contains the op number " + opnum.ToString("D"));
							}

							newop = new Op(
								(OPCODES)opnum,
								match.Groups[2].Value,
								match.Groups[3].Value,
								match.Groups[4].Value
								);

							codes.Add(opnum,newop);
							names.Add(newop.Name,newop);

						}
						else
						{
							continue;
						}
					}
				}
				finally
				{
					if (sr!=null)
					{
						sr.Close();
					}
					sr=null;
				}
			}
			else
			{
				retval = false;
			}
			return retval;
		}


		public Op this[int index]
		{
			get
			{
				Op retval = codes[index] as Op;
				if (retval!=null)
				{
					return retval;
				}
				else
				{
					throw new InvalidOpException("There is no opcode corresponding to the number " + index.ToString("D") );
				}
			}
		}

		public Op this[string name]
		{
			get
			{
				return names[name] as Op;
			}
		}

		public bool Valid
		{
			get
			{
				return valid;
			}
		}
	}

	public class OpListEnumerator : IEnumerator
	{
		private int position;
		private Op[] ops;

		public OpListEnumerator(SortedList oplist)
		{
			ops = null;
			oplist.Values.CopyTo(ops,0);
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
				if (position>=0 && position<ops.Length)
				{
					return ops[position];
				}
				else
				{
					throw new InvalidOperationException("enumerator position is not valid");
				}
			}
		}

		public bool MoveNext()
		{
			position+=1;
			return (position<ops.Length);
		}

		#endregion
	}


	public class OpComparer : IComparer
	{
		#region IComparer Members
		public int Compare(object x, object y)
		{
			int retval = 0;
			Op xo = x as Op;
			Op yo = y as Op;
			if (xo!=null&&yo!=null)
			{
				retval = xo.Code.CompareTo(yo.Code);
			}
			else if (xo==null)
			{
				retval =1;
			}
			else
			{
				retval = -1;
			}
			// TODO:  Add OpComparer.Compare implementation
			return retval;
		}
		#endregion
	}

	public class OpIntComparer : IComparer
	{
		#region IComparer Members

		public int Compare(object x, object y)
		{
			int retval = 0;
			if (y is Int32)
			{
				int yi = (int)y;
				Op xo = x as Op;
				if (xo!=null)
				{
					retval = xo.Code.CompareTo(yi);
				}
				else if (xo==null)
				{
					retval =1;
				}
				// TODO:  Add OpComparer.Compare implementation
			}
			return retval;
		}

		#endregion

	}

	public class InvalidOpException : Exception 
	{
		public InvalidOpException(string error) : base(error)
		{
		}

		public InvalidOpException()
		{
		}

	}


	public enum OPCODES : int
	{
		OP_NONE=0,              // invalid opcode //
		OP_LOAD_PRI,
		OP_LOAD_ALT,
		OP_LOAD_S_PRI,
		OP_LOAD_S_ALT,
		OP_LREF_PRI,
		OP_LREF_ALT,
		OP_LREF_S_PRI,
		OP_LREF_S_ALT,
		OP_LOAD_I,
		OP_LODB_I,
		OP_CONST_PRI,
		OP_CONST_ALT,
		OP_ADDR_PRI,
		OP_ADDR_ALT,
		OP_STOR_PRI,
		OP_STOR_ALT,
		OP_STOR_S_PRI,
		OP_STOR_S_ALT,
		OP_SREF_PRI,
		OP_SREF_ALT,
		OP_SREF_S_PRI,
		OP_SREF_S_ALT,
		OP_STOR_I,
		OP_STRB_I,
		OP_LIDX,
		OP_LIDX_B,
		OP_IDXADDR,
		OP_IDXADDR_B,
		OP_ALIGN_PRI,
		OP_ALIGN_ALT,
		OP_LCTRL,
		OP_SCTRL,
		OP_MOVE_PRI,
		OP_MOVE_ALT,
		OP_XCHG,
		OP_PUSH_PRI,
		OP_PUSH_ALT,
		OP_PUSH_R,
		OP_PUSH_C,
		OP_PUSH,
		OP_PUSH_S,
		OP_POP_PRI,
		OP_POP_ALT,
		OP_STACK,
		OP_HEAP,
		OP_PROC,
		OP_RET,
		OP_RETN,
		OP_CALL,
		OP_CALL_PRI,
		OP_JUMP,
		OP_JREL,
		OP_JZER,
		OP_JNZ,
		OP_JEQ,
		OP_JNEQ,
		OP_JLESS,
		OP_JLEQ,
		OP_JGRTR,
		OP_JGEQ,
		OP_JSLESS,
		OP_JSLEQ,
		OP_JSGRTR,
		OP_JSGEQ,
		OP_SHL,
		OP_SHR,
		OP_SSHR,
		OP_SHL_C_PRI,
		OP_SHL_C_ALT,
		OP_SHR_C_PRI,
		OP_SHR_C_ALT,
		OP_SMUL,
		OP_SDIV,
		OP_SDIV_ALT,
		OP_UMUL,
		OP_UDIV,
		OP_UDIV_ALT,
		OP_ADD,
		OP_SUB,
		OP_SUB_ALT,
		OP_AND,
		OP_OR,
		OP_XOR,
		OP_NOT,
		OP_NEG,
		OP_INVERT,
		OP_ADD_C,
		OP_SMUL_C,
		OP_ZERO_PRI,
		OP_ZERO_ALT,
		OP_ZERO,
		OP_ZERO_S,
		OP_SIGN_PRI,
		OP_SIGN_ALT,
		OP_EQ,
		OP_NEQ,
		OP_LESS,
		OP_LEQ,
		OP_GRTR,
		OP_GEQ,
		OP_SLESS,
		OP_SLEQ,
		OP_SGRTR,
		OP_SGEQ,
		OP_EQ_C_PRI,
		OP_EQ_C_ALT,
		OP_INC_PRI,
		OP_INC_ALT,
		OP_INC,
		OP_INC_S,
		OP_INC_I,
		OP_DEC_PRI,
		OP_DEC_ALT,
		OP_DEC,
		OP_DEC_S,
		OP_DEC_I,
		OP_MOVS,
		OP_CMPS,
		OP_FILL,
		OP_HALT,
		OP_BOUNDS,
		OP_SYSREQ_PRI,
		OP_SYSREQ_C,
		OP_FILE,
		OP_LINE,
		OP_SYMBOL,
		OP_SRANGE,
		OP_JUMP_PRI,
		OP_SWITCH,
		OP_CASETBL,
		OP_SWAP_PRI,
		OP_SWAP_ALT,
		OP_NOP,
		OP_PUSHADDR,
		OP_SYSREQ_D,
		OP_SYMTAG,
		OP_BREAK,
		// ----- //
		OP_NUM_OPCODES
	}

}
