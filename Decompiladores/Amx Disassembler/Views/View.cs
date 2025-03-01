namespace View
{
	using Amx.Cod;
	using Amx.Logic.Jumps;
	using Amx.Core;

	using System;
	using System.Text;


	public interface IDisassemblyView
	{
		bool WriteToFile(string filename, Disassembly disassembly, Options options);

		void WriteInstructions(object output, Disassembly disassembly, Options options);
		void WriteResources(object output, Disassembly disassembly, Options options);

		void WriteStandardInstruction(StringBuilder builder, Instruction inst,Options options);
		void WriteStandardInstruction(StringBuilder builder, Instruction inst,Options options,AJump jmp);



		bool ShowResourceTree 
		{
			get;
		}
		bool ShowInstructionTextBox
		{
			get;
		}
		bool ShowInfoTextBox
		{
			get;
		}


		bool CanWriteToFile
		{
			get;
		}

		bool CanWriteResourceToTree
		{
			get;
		}
		bool CanWriteResourceToText
		{
			get;
		}

		bool CanWriteInstructionToText
		{
			get;
		}

		bool CanGetLineInfo
		{
			get;
		}


		string Name
		{
			get;
		}
		string Description
		{
			get;
		}


		FormatOptions Format
		{
			get;
			set;
		}
		void ResetFormat();

		LineParts GetLineInfo(string line);
	}


	public class LineParts
	{
		private string offset;
		private string op;
		private string arguments;
		private string comment;

		public LineParts(string op):this (null,op,null,null){}
		public LineParts(string offset,string op) : this (offset,op,null,null){}
		public LineParts(string offset, string op, string args) : this(offset,op,args,null){}
		public LineParts(string offset,string op,string args, string comments)
		{
			if (offset!=null && offset.Length>0)
			{
				this.offset=offset;
			}
			else
			{
				this.offset=null;
			}

			if (op!=null && op.Length>0)
			{
				this.op=op;
			}
			else
			{
				this.op=null;
			}

			if (args!=null && args.Length>0)
			{
				this.arguments=args;
			}
			else
			{
				this.arguments=null;
			}

			if (comments!=null && comments.Length>0)
			{
				this.comment=comments;
			}
			else
			{
				this.comment=null;
			}
		}


		public string Offset
		{
			get
			{
				return this.offset;
			}
		}

		public string Op
		{
			get
			{
				return this.op;
			}
		}

		public string Arguments
		{
			get
			{
				return this.arguments;
			}
		}
		public string Comment
		{
			get
			{
				return this.comment;
			}
		}



		public static LineParts Empty
		{
			get
			{
				return new LineParts(null,null,null,null);
			}
		}
	}

}