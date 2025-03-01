using System;

using Amx.Core;
using Amx.Strings;

namespace Files
{
	using System.IO;
	using System.Collections;


	public interface IFiletype
	{
		string FriendyName
		{
			get;
		}
		string Description
		{
			get;
		}
		string Name
		{
			get;
		}
		string Extension
		{
			get;
		}

		string FilterText
		{
			get;
		}
		string FilterMask
		{
			get;
		}


		IAmxContainer GetContainer(string path);
		IAmxInstance  GetInstance (string path, Bits bits);
	}


	public interface IAmxContainer : IEnumerable
	{
		int Count
		{
			get;
		}
		string Path
		{
			get;
		}
		string Name
		{
			get;
		}
		AmxStream GetStream(IAmxDescription description);
		IAmxInstance GetFile(IAmxDescription description);
	}

	public interface IAmxDescription
	{
		/// <summary>
		/// Returns the bittedness of the entry
		/// </summary>
		Bits Bits
		{
			get;
		}
		bool Valid
		{
			get;
		}
		/// <summary>
		/// Returns the plugin name as an extensionless name
		/// </summary>
		string Name
		{
			get;
		}
		/// <summary>
		/// Returns the full path to the plugin
		/// </summary>
		string Path
		{
			get;
		}


		int Start
		{
			get;
		}
		int Length
		{
			get;
		}
	}

	public interface IAmxInstance : IAmxDescription
	{
		AmxHeader Header
		{
			get;
		}

		string InfoString
		{
			get;
		}
		AmxStream GetStream();
		IAmxContainer Container
		{
			get;
		}
		IAmxDescription Description
		{
			get;
		}
	}


	

	public sealed class AmxHelpers
	{
		private AmxHelpers()
		{
		}


		public static AmxHeader GetHeader(string path)
		{
			AmxHeader retval = null;
			AmxHeader basic = null;
			Stream file = null;
			if (File.Exists(path))
			{
				try
				{
					file = File.Open(path,FileMode.Open,FileAccess.Read,FileShare.Read);
				}
				catch
				{
					file=null;
				}
			}

			if(file!=null)
			{
				AmxStream reader = new AmxStream(file);

				basic = new AmxHeader(reader);

				switch (basic.FileVersion)
				{
					case 4:
						if ( reader.Peek() < Int16.MaxValue )
						{
							retval = new AmxHeader_4_lin(reader, basic);
						}
						else
						{
							retval = new AmxHeader_4_win(reader, basic);
						}
						break;
					case 5:
						if ( reader.Peek() < Int16.MaxValue )
						{
							retval = new AmxHeader_5_lin(reader, basic);
						}
						else
						{
							retval = new AmxHeader_5_win(reader, basic);
						}
						break;
					case 6:
						retval = new AmxHeader_6(reader, basic);
						break;
					case 7:
						retval = new AmxHeader_7(reader, basic);
						break;
					case 8:
						retval = new AmxHeader_8(reader, basic);
						break;
					default:
						throw new Exception("Unknown amx file version, " + basic.FileVersion.ToString("D") );
				}
				if (retval!=null)
				{
					retval.LoadTables(reader);
				}
				reader.Close();
				reader=null;
			}

			return retval;
		}
		public static AmxHeader GetHeader(AmxStream reader)
		{
			AmxHeader basic = new AmxHeader(reader);
			AmxHeader retval = null;

			switch (basic.FileVersion)
			{
				case 3:
				case 4:
					if ( reader.Peek() < Int16.MaxValue )
					{
						retval = new AmxHeader_4_lin(reader, basic);
					}
					else
					{
						retval = new AmxHeader_4_win(reader, basic);
					}
					break;
				case 5:
					if ( reader.Peek() < Int16.MaxValue  )
					{
						retval = new AmxHeader_5_lin(reader, basic);
					}
					else
					{
						retval = new AmxHeader_5_win(reader, basic);
					}
					break;
				case 6:
					retval = new AmxHeader_6(reader, basic);
					break;
				case 7:
					retval = new AmxHeader_7(reader, basic);
					break;
				case 8:
					retval = new AmxHeader_8(reader, basic);
					break;
				default:
					throw new Exception("Unknown amx file version, " + basic.FileVersion.ToString("D") );
			}
			if (retval!=null)
			{
				retval.LoadTables(reader);
			}
			return retval;
		}


		public static MemoryStream decompress(AmxHeader header,string from)
		{

			BinaryWriter output;
			BinaryReader input;
			MemoryStream mem;
			System.Collections.Stack stack;
			byte[] code;
			
			input = new BinaryReader(new FileStream(from,FileMode.Open));
			mem = new MemoryStream((int)input.BaseStream.Length);
			output = new BinaryWriter(mem);
			
			output.Write(input.ReadBytes(header.Cod));
			input.BaseStream.Seek(header.Cod, SeekOrigin.Begin);

			code = new byte[header.Hea-header.Cod];
			input.BaseStream.Seek((long)header.Cod,SeekOrigin.Begin); // seek to the beginning of the code section
			code = input.ReadBytes(code.Length);
			input.Close();

			stack = new System.Collections.Stack(code.Length);

			uint c;      // 32 bit unsigned
			short shift; // 16 bit signed
			uint codesize = (uint)code.Length;

			while (codesize  > 0)
			{
				c=0;
				shift=0;

				do 
				{
					codesize--;
					c = c | (uint)(code[codesize] & 0x7f) << shift;
					shift+=7;
				}while ( (codesize >0) && ( (code[codesize-1] & 0x80) !=0) );

				if ( (code[codesize] &0x40) != 0)
				{
					while (shift < (8 * 4 ) )  // hard coded 4 byte long
					{
						c = c | (uint)0xff << shift;
						shift +=8;
					}
				}
				stack.Push(c);
			}
			for ( int x=0,counter=stack.Count; x<counter; x++) output.Write( (uint)stack.Pop() );
			output.Flush();
			output=null;

			return mem;
		}

		public static MemoryStream decompress(AmxHeader header,Stream from)
		{

			BinaryWriter output;
			BinaryReader input;
			MemoryStream mem;
			System.Collections.Stack stack;
			byte[] code;
			
			input = new BinaryReader(from);
			mem = new MemoryStream((int)input.BaseStream.Length);
			output = new BinaryWriter(mem);
			
			output.Write(input.ReadBytes(header.Cod));
			input.BaseStream.Seek(header.Cod, SeekOrigin.Begin);

			code = new byte[header.Hea-header.Cod];
			input.BaseStream.Seek((long)header.Cod,SeekOrigin.Begin); // seek to the beginning of the code section
			code = input.ReadBytes(code.Length);
			input.Close();

			stack = new System.Collections.Stack(code.Length);

			uint c;      // 32 bit unsigned
			short shift; // 16 bit signed
			uint codesize = (uint)code.Length;

			while (codesize  > 0)
			{
				c=0;
				shift=0;

				do 
				{
					codesize--;
					c = c | (uint)(code[codesize] & 0x7f) << shift;
					shift+=7;
				}while ( (codesize >0) && ( (code[codesize-1] & 0x80) !=0) );

				if ( (code[codesize] &0x40) != 0)
				{
					while (shift < (8 * 4 ) )  // hard coded 4 byte long
					{
						c = c | (uint)0xff << shift;
						shift +=8;
					}
				}
				stack.Push(c);
			}
			for ( int x=0,counter=stack.Count; x<counter; x++) output.Write( (uint)stack.Pop() );
			output.Flush();
			output=null;

			return mem;
		}


		public static bool ExportFile(IAmxInstance file, string outpath)
		{
			bool retval = false;
			if (file!=null && file.Header.Valid && !File.Exists(outpath))
			{
				BinaryWriter writer=null;
				AmxStream reader=null;
				try 
				{
					writer = new BinaryWriter(File.OpenWrite(outpath));
					reader = file.GetStream();
					writer.Write(reader.ReadBytes(file.Length));
					retval = true;
				}
				catch (Exception e)
				{
					Console.WriteLine("an exception occured: ");
					Console.WriteLine(e.Message);
					Console.WriteLine(e.StackTrace);
				}
				finally
				{
					if (writer!=null)
					{
						writer.Flush();
						writer.Close();
						writer=null;
					}
					if (reader!=null)
					{
						reader.Close();
						reader=null;
					}
				}				
			}
			return retval;
		}

		public static bool ExportFile(IAmxContainer container, Bits bits, string outpath)
		{
			IAmxInstance file=null;
			foreach(IAmxDescription d in container)
			{
				if (d.Bits==bits)
				{
					file = container.GetFile(d);
				}
			}
			if (file!=null)
			{
				return ExportFile(file,outpath);
			}
			return false;
		}

		public static bool ExportFile(string infile, Bits bits, string outpath)
		{
			return false;
		}

	}


	public class AmxHeader
	{
		public const int AMX_MAGIC = 0xf1e0;

		protected int size;
		protected int magic;
		protected int file_version;
		protected int amx_version;
		protected AMX_FLAGS flags;
		protected int defsize;

		protected Bits bithint;

		protected int cod;
		protected int dat;
		protected int hea; 
		protected int stp;
		protected int cip;

		protected int natives_ptr;
		protected int names_ptr;
		protected int pubvars_ptr;
		protected int tags_ptr;
		protected int libraries_ptr;
		protected int publics_ptr;

		protected int publics_count;
		protected int natives_count;
		protected int libraries_count;
		protected int pubvars_count;
		protected int tags_count;

		protected int publics_location;
		protected int natives_location;
		protected int libraries_location;
		protected int pubvars_location;
		protected int tags_location;
		protected int names_location;

		protected AmxNative[] natives;
		protected AmxNative[] pubvars;
		protected AmxNative[] tags;
		protected AmxNative[] publics;
		protected AmxNative[] libraries;

		public AmxHeader(AmxHeader header)
		{
			this.size= header.size;
			this.magic=header.magic;
			this.file_version =header.file_version;
			this.amx_version=header.amx_version;
			this.flags = header.flags;
			this.defsize = header.defsize;
			this.cod=header.cod;
			this.dat=header.dat;
			this.hea=header.hea;
			this.stp=header.stp;
			this.cip=header.cip;
			this.bithint=header.bithint;
		}
		public AmxHeader(AmxStream reader) : this(reader,Bits._32){}
		public AmxHeader(AmxStream reader,Bits @default_bits)
		{
			size=reader.ReadInt32();
			magic=reader.ReadUInt16();
			file_version=reader.ReadByte();
			amx_version=reader.ReadByte();  
			flags=(AMX_FLAGS)reader.ReadInt16();
			defsize=reader.ReadInt16();
			cod=reader.ReadInt32();          
			dat=reader.ReadInt32();          
			hea=reader.ReadInt32();          
			stp=reader.ReadInt32();          
			cip=reader.ReadInt32();  
			bithint=@default_bits;
		}


		public virtual int Length
		{
			get
			{
				return size;
			}
		}
		public virtual int Magic
		{
			get
			{
				return magic;
			}
		}
		public virtual int FileVersion
		{
			get
			{
				return file_version;
			}
		}
		public virtual int AmxVersion
		{
			get
			{
				return amx_version;
			}
		}
		public virtual AMX_FLAGS Flags
		{
			get
			{
				return flags;
			}
		}
		public virtual int DefSize
		{
			get
			{
				return defsize;
			}
		}


		public Bits BitHint
		{
			get
			{
				return bithint;
			}
		}


		public bool Valid
		{
			get
			{
				return (magic == AMX_MAGIC);
			}
		}


		public virtual int Cod
		{
			get
			{
				return cod;
			}
		}

		public virtual int Dat
		{
			get
			{
				return dat;
			}
		}
		public virtual int Hea
		{
			get
			{
				return hea;
			}
		}
		public virtual int Stp
		{
			get
			{
				return stp;
			}
		}
		public virtual int Cip
		{
			get
			{
				return cip;
			}
		}


		public virtual AmxNative[] Natives
		{
			get
			{
				return natives;
			}
		}

		public virtual AmxNative[] Publics
		{
			get
			{
				return publics;
			}
		}

		public virtual AmxNative[] Tags
		{
			get
			{
				return tags;
			}
		}

		public virtual AmxNative[] Vars
		{
			get
			{
				return pubvars;
			}
		}

		public virtual AmxNative[] Libraries
		{
			get
			{
				return libraries;
			}
		}


		public bool GetFlag(AMX_FLAGS flag)
		{
			return ( (flags & flag) == flag);
		}


		public virtual void LoadTables(Stream reader)
		{
			AmxStream bin = new AmxStream(reader);
			this.LoadTables(bin);
		}
		public virtual void LoadTables(AmxStream reader)
		{
			if (publics_ptr!=-1)
			{
				publics = LoadTable(reader,this.bithint,publics_ptr,publics_count,defsize);
				if (!ValidateNatives(publics,false))
				{
					this.bithint = IncreaseBitHint(this.bithint);
				}
				publics = LoadTable(reader,this.bithint,publics_ptr,publics_count,defsize);
			}
			if (natives_ptr!=-1)
			{
				natives = LoadTable(reader,this.bithint,natives_ptr,natives_count,defsize);
			}
			if (libraries_ptr!=-1)
			{
				libraries = LoadTable(reader,this.bithint,libraries_ptr,libraries_count,defsize);
			}
			if (pubvars_ptr!=-1)
			{
				pubvars = LoadTable(reader,this.bithint,pubvars_ptr,pubvars_count,defsize);
			}
			if (publics_ptr!=-1)
			{
				tags = LoadTable(reader,this.bithint,tags_ptr,tags_count,defsize);
			}
		}


		protected bool ValidateNatives(AmxNative[] table, bool checkzero)
		{
			bool invalid=false;
			if (checkzero)
			{
				if (table.Length>0)
				{
					foreach(AmxNative nat in table)
					{
						if (nat.Data==null || nat.Address==0)
						{
							invalid=true;
							break;
						}
					}
				}
			}
			else
			{
				if (table.Length>0)
				{
					foreach(AmxNative nat in table)
					{
						if (nat.Data==null)
						{
							invalid=true;
							break;
						}
					}
				}
			}
			return !invalid;;
		}

		protected static Bits IncreaseBitHint(Bits current)
		{
			switch (current)
			{
				case Bits._8:	return Bits._16;
				case Bits._16:	return Bits._32;
				case Bits._32:	return Bits._64;
				default:		throw new ArgumentException("bithint cannot be increased beyond 64 bits");
			}
		}


		private AmxNativeFixed[] LoadTable(AmxStream reader,Bits bits, long baseaddr, int number, int size)
		{
			AmxNativeFixed[] retval = null;
			if (number>0)
			{
				retval = new AmxNativeFixed[number];
				long pos = reader.Position;
				reader.Seek(baseaddr,SeekOrigin.Begin);
				for (int i=0;i<number;i++)
				{
					retval[i]= new AmxNativeFixed(reader,size,bits);
				}
				reader.Seek(pos,SeekOrigin.Begin);
			}
			else
			{
				retval = new AmxNativeFixed[0];
			}
			return retval;
		}
	}

	public class AmxNative
	{
		protected string data;
		protected int address;

		public virtual string Data
		{
			get
			{
				return data;
			}
		}
		public virtual int Address
		{
			get
			{
				return address;
			}
		}
	}


	public class AmxHeader_4_win : AmxHeader
	{
		public AmxHeader_4_win(AmxStream reader,AmxHeader header) : base(header)
		{
			publics_location = (int)reader.Position;
			publics_count = (int)reader.ReadInt16();
			publics_ptr = reader.ReadInt32();

			natives_location = (int)reader.Position;
			natives_count = (int)reader.ReadInt16();
			natives_ptr = reader.ReadInt32();

			libraries_location = (int)reader.Position;
			libraries_count = (int)reader.ReadInt16();
			libraries_ptr  = reader.ReadInt32();

			pubvars_location = (int)reader.Position;
			pubvars_count = (int)reader.ReadInt16();
			pubvars_ptr=reader.ReadInt32();

			tags_location = -1;
			names_location = -1;
		}

	}


	public class AmxHeader_5_win : AmxHeader
	{     
		private int reserved; 

		public AmxHeader_5_win(AmxStream reader,AmxHeader header) : base(header)
		{
			publics_location = (int)reader.Position;
			publics_count = (int)reader.ReadInt16();
			publics_ptr = reader.ReadInt32();

			natives_location = (int)reader.Position;
			natives_count = (int)reader.ReadInt16();
			natives_ptr = reader.ReadInt32();

			libraries_location = (int)reader.Position;
			libraries_count = (int)reader.ReadInt16();
			libraries_ptr  = reader.ReadInt32();

			pubvars_location = (int)reader.Position;
			pubvars_count = (int)reader.ReadInt16();
			pubvars_ptr=reader.ReadInt32();

			tags_location = (int)reader.Position;
			tags_count = (int)reader.ReadInt16();
			tags_ptr = reader.ReadInt32();

			reserved = (int)reader.ReadInt16();

			names_location = -1;
			names_ptr=-1;
		}


		public int Reserved
		{
			get
			{
				return reserved;
			}
		}

	}


	public class AmxHeader_4_lin : AmxHeader
	{
		public AmxHeader_4_lin(AmxStream reader,AmxHeader header) : base(header)
		{
			publics_location = (int)reader.Position;
			publics_count = reader.ReadInt32();
			publics_ptr = reader.ReadInt32();

			natives_location = (int)reader.Position;
			natives_count = reader.ReadInt32();
			natives_ptr = reader.ReadInt32();

			libraries_location = (int)reader.Position;
			libraries_count = reader.ReadInt32();
			libraries_ptr  = reader.ReadInt32();

			pubvars_location = (int)reader.Position;
			pubvars_count = reader.ReadInt32();
			pubvars_ptr=reader.ReadInt32();

			names_location = -1;
			tags_location = -1;
		}

	}


	public class AmxHeader_5_lin : AmxHeader
	{
		private int reserved; 

		public AmxHeader_5_lin(AmxStream reader,AmxHeader header) : base(header)
		{
			publics_location = (int)reader.Position;
			publics_count = reader.ReadInt32();
			publics_ptr = reader.ReadInt32();

			natives_location = (int)reader.Position;
			natives_count = reader.ReadInt32();
			natives_ptr = reader.ReadInt32();

			libraries_location = (int)reader.Position;
			libraries_count = reader.ReadInt32();
			libraries_ptr  = reader.ReadInt32();

			pubvars_location = (int)reader.Position;
			pubvars_count = reader.ReadInt32();
			pubvars_ptr = reader.ReadInt32();

			tags_location = (int)reader.Position;
			tags_count = reader.ReadInt32();
			tags_ptr = reader.ReadInt32();

			reserved = reader.ReadInt32();

			names_location = -1;
			names_ptr=-1;
		}


		public int Reserved
		{
			get
			{
				return reserved;
			}
		}

	}


	public class AmxHeader_6 : AmxHeader
	{

		public AmxHeader_6(AmxStream reader,AmxHeader header) : base(header)
		{
			publics_ptr  =reader.ReadInt32();    
			natives_ptr  =reader.ReadInt32();      
			libraries_ptr=reader.ReadInt32();    
			pubvars_ptr  =reader.ReadInt32();     
			tags_ptr     =reader.ReadInt32();  
      
			publics_count =   (int)( (natives_ptr-publics_ptr)   / defsize);
			natives_count =   (int)( (libraries_ptr-natives_ptr) / defsize);
			libraries_count = (int)( (pubvars_ptr-libraries_ptr) / defsize);
			pubvars_count =   (int)( (tags_ptr-pubvars_ptr)      / defsize);
			tags_count =      (int)( (tags_ptr-this.cod)       / defsize);

			names_location=-1;
			names_ptr=-1;
		}
	}


	public class AmxHeader_7 : AmxHeader
	{
		public AmxHeader_7(AmxStream reader,AmxHeader header) : base(header)
		{
			publics_ptr  =reader.ReadInt32();    
			natives_ptr  =reader.ReadInt32();      
			libraries_ptr=reader.ReadInt32();    
			pubvars_ptr  =reader.ReadInt32();     
			tags_ptr     =reader.ReadInt32();  
			names_ptr    =reader.ReadInt32();
      
			publics_count =   (int)( (natives_ptr-publics_ptr)   / defsize);
			natives_count =   (int)( (libraries_ptr-natives_ptr) / defsize);
			libraries_count = (int)( (pubvars_ptr-libraries_ptr) / defsize);
			pubvars_count =   (int)( (tags_ptr-pubvars_ptr)      / defsize);
			tags_count =      (int)( (names_ptr-tags_ptr)        / defsize);
		}


		public sealed override void LoadTables(AmxStream reader)
		{
			publics = LoadTable(reader,publics_ptr,publics_count);
			if (!ValidateNatives(publics,false))
			{
				this.bithint = IncreaseBitHint(this.bithint);
				publics = LoadTable(reader,publics_ptr,publics_count);
			}
		
			natives = LoadTable(reader,natives_ptr,natives_count);
			libraries = LoadTable(reader,libraries_ptr,libraries_count);
			pubvars = LoadTable(reader,pubvars_ptr,pubvars_count);
			tags = LoadTable(reader,tags_ptr,tags_count);
		}


		private AmxNative[] LoadTable(AmxStream reader,long baseaddr, int number)
		{
			AmxNative[] retval =null;
			if (number>0)
			{ 
				long pos = reader.Position;
				reader.Seek(baseaddr,SeekOrigin.Begin);
				retval = new AmxNativeVariable[number];
				for (int i=0;i<number;i++)
				{
					retval[i] = new AmxNativeVariable(reader,this.bithint);
				}
				reader.Seek(pos,SeekOrigin.Begin);
			}
			else if (number==0)
			{
				retval = new AmxNativeVariable[0];
			}
			else
			{
				throw new Exception("negative count for a header table is not permissable");
			}
			return retval;
		}

	}



	public class AmxHeader_8 : AmxHeader_7
	{
		public AmxHeader_8(AmxStream reader,AmxHeader header) 
			: base(reader,header)
		{
		}
	}



	public class AmxNativeFixed : AmxNative
	{
		public AmxNativeFixed(AmxStream reader, int size, Bits bits)
		{
			address = reader.ReadValInt(bits);
            byte[] bytes = reader.ReadBytes(size-((int)bits));
			AsciiStringDecoder dec = new AsciiStringDecoder((int)bits);
			int strlen = dec.GetCharCount(bytes,0,bytes.Length);
			if (strlen>0)
			{
				data = dec.GetString(bytes,0,strlen);
			}
			//data = System.Text.ASCIIEncoding.ASCII.GetString(bytes,0,bytes.Length).TrimEnd('\0');
		}
	}

	public class AmxNativeVariable : AmxNative
	{
		private int stringaddress;

		public AmxNativeVariable(AmxStream reader,Bits bits)
		{
			int position =-1;
			address = reader.ReadValInt(bits);
			stringaddress = reader.ReadValInt(bits);
			if (stringaddress >0 && stringaddress <reader.Length)
			{
				position = (int)reader.Position;
				reader.Seek((long)stringaddress,SeekOrigin.Begin);
				byte read = reader.ReadInt8();
				ArrayList list = new ArrayList(20);
				while (read!=0 && reader.Position<reader.Length)
				{
					list.Add(read);
					read = reader.ReadInt8();
				}
				if (read==0 && list.Count>0)
				{
					byte[] bytes = (byte[])list.ToArray(typeof(byte));
					AsciiStringDecoder dec = new AsciiStringDecoder((int)bits);
					data = dec.GetString(bytes,0,bytes.Length);
					bytes=null;
				}
				list=null;
				
			}

			if (position>0)
			{
				reader.Seek(position, SeekOrigin.Begin);
			}
            
		}
	}




	[Flags()]
	public enum AMX_FLAGS : int
	{
		CHAR16=0x1,
		DEBUG=0x2,
		COMPACT=0x4,
		BIGENDIAN=0x8,
		NOCHECKS=0x10
	}


	public class AmxStream : Stream
	{
		private Stream basestream;
		private long bytesread;
		private long length;
		private byte[] buffer;

		public AmxStream(Stream stream) : this(stream,stream.Length)
		{

		}
		public AmxStream(Stream stream, long length)
		{
			lock (this)
			{
				buffer = new byte[8];
				basestream = stream;
				this.length=length;
				bytesread=0;
			}
		}

		~AmxStream()
		{
			lock (this)
			{
				if (basestream!=null)
				{
					basestream.Close();
					basestream=null;
				}
			}
		}


		
		public sealed override bool CanRead
		{
			get
			{
				return basestream.CanRead;
			}
		}

		
		public sealed override bool CanSeek
		{
			get
			{
				return basestream.CanSeek ;
			}
		}

		public sealed override bool CanWrite
		{
			get
			{
				return false;
			}
		}


		[System.Diagnostics.DebuggerStepThroughAttribute]
		public sealed override int Read(byte[] buffer, int offset, int count)
		{
			int read = basestream.Read(buffer,offset,count);
			bytesread+=read;
			return read;
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public sealed override int ReadByte()
		{
			int read = basestream.ReadByte ();
			bytesread+=read;
			return read;
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public sealed override long Seek(long offset, SeekOrigin origin)
		{
			long retval = 0;
			if (basestream.CanSeek)
			{
				retval = basestream.Seek(offset,origin);
			}
			return retval;
		}

		public sealed override void Write(byte[] buffer, int offset, int count)
		{
			return;
		}

		public sealed override void WriteByte(byte value)
		{
			return;
		}

		public sealed override void Close()
		{
			if (basestream!=null)
			{
				basestream.Close ();
			}
		}

		
		#region redirects to the base stream
		public sealed override void Flush()
		{
			basestream.Flush();
		}

		public sealed override void SetLength(long value)
		{
			return;
		}

		public sealed override System.Runtime.Remoting.ObjRef CreateObjRef(Type requestedType)
		{
			return basestream.CreateObjRef (requestedType);
		}

		protected sealed override System.Threading.WaitHandle CreateWaitHandle()
		{
			return this.CreateWaitHandle ();
		}

		public sealed override IAsyncResult BeginRead(byte[] buffer, int offset, int count, AsyncCallback callback, object state)
		{
			return basestream.BeginRead (buffer, offset, count, callback, state);
		}

		public sealed override IAsyncResult BeginWrite(byte[] buffer, int offset, int count, AsyncCallback callback, object state)
		{
			return basestream.BeginWrite (buffer, offset, count, callback, state);
		}
		public sealed override int EndRead(IAsyncResult asyncResult)
		{
			return basestream.EndRead (asyncResult);
		}
		public sealed override void EndWrite(IAsyncResult asyncResult)
		{
			basestream.EndWrite (asyncResult);
		}

		public sealed override bool Equals(object obj)
		{
			return basestream.Equals (obj);
		}
		public sealed override int GetHashCode()
		{
			return basestream.GetHashCode ();
		}
		public sealed override object InitializeLifetimeService()
		{
			return basestream.InitializeLifetimeService ();
		}
		public sealed override string ToString()
		{
			return basestream.ToString ();
		}

		#endregion

		
		public sealed override long Position
		{
			get
			{
				return basestream.Position;
			}
			set
			{
			}
		}

		
		public sealed override long Length
		{
			get
			{
				return length;
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public byte ReadInt8()
		{
			int read = basestream.ReadByte();
			if (read!=-1)
			{
                bytesread+=read;
			}
			return (byte)read;


		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public Int16 ReadInt16()
		{
			if (this.Read(buffer,0,2)==2)
			{
				return (Int16)ToInt(buffer,2,0);
			}	
			else
			{
				throw new ArgumentException("could not read required umber of characters from the basestream");
			}
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public Int32 ReadInt32()
		{
			if (this.Read(buffer,0,4)==4)
			{
				return (Int32)ToInt(buffer,4,0);
			}
			else
			{
				throw new ArgumentException("could not read required umber of characters from the basestream");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public Int64 ReadInt64()
		{
			if (this.Read(buffer,0,8)==8)
			{
				return (Int64)ToInt(buffer,8,0);
			}
			else
			{
				throw new ArgumentException("could not read required umber of characters from the basestream");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public UInt16 ReadUInt16()
		{
			if (this.Read(buffer,0,2)==2)
			{
				return (UInt16)ToInt(buffer,2,0);
			}	
			else
			{
				throw new ArgumentException("could not read required umber of characters from the basestream");
			}
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public UInt32 ReadUInt32()
		{
			if (this.Read(buffer,0,4)==4)
			{
				return (UInt32)ToInt(buffer,4,0);
			}
			else
			{
				throw new ArgumentException("could not read required umber of characters from the basestream");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public UInt64 ReadUInt64()
		{
			if (this.Read(buffer,0,8)==8)
			{
				return (UInt64)ToInt(buffer,8,0);
			}
			else
			{
				throw new ArgumentException("could not read required umber of characters from the basestream");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public int Peek()
		{
			if (basestream!=null)
			{
				long position = basestream.Position;
				Int32 retval = this.ReadInt32();
				basestream.Seek(position,SeekOrigin.Begin);
				return retval;
			}
			else
			{
				throw new ObjectDisposedException("");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public byte[] ReadBytes(int count)
		{
			byte[] retval;
			int dim =0;
			int read=0;
			if (count>(basestream.Length-bytesread))
			{
				dim = (int)(basestream.Length-bytesread);
			}
			else
			{
				dim =count;
			}
			retval = new byte[dim];
			read = basestream.Read(retval,0,dim);
			bytesread+=read;
			if (read!=dim)
			{
				retval = null;
				throw new IOException("number of bytes requested of the stream could not be read");
			}
			return retval;
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public ValueType ReadIntValue(Bits bits)
		{
			ValueType retval;
			switch (bits)
			{
				case Bits._8:
					retval = (ValueType)this.ReadByte();
					break;
				case Bits._16:
					retval = (ValueType)this.ReadInt16();
					break;
				case Bits._32:
					retval = (ValueType)this.ReadInt32();
					break;
				case Bits._64:
					retval = (ValueType)this.ReadInt64();
					break;
				default:
					throw new Exception("cannot read " + bits.ToString("D") +" from the basestream");
					//break;
			}
			return retval;
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public ValInt ReadValInt(Bits bits)
		{
			ValInt retval;
			switch (bits)
			{
				case Bits._8:
					retval = new ValInt(this.ReadByte());
					break;
				case Bits._16:
					retval = new ValInt(this.ReadInt16());
					break;
				case Bits._32:
					retval = new ValInt(this.ReadInt32());
					break;
				case Bits._64:
					retval = new ValInt(this.ReadInt64());
					break;
				default:
					throw new Exception("cannot read " + bits.ToString("D") +" from the basestream");
					//break;
			}
			return retval;
		}


		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static long ToInt(byte[] bytes,int length, int offset)
		{
			long retval=0L;
			if ( (offset+length) <=bytes.Length)
			{
				for (byte i=0;i<length;i+=1)
				{
					retval|=(long)(((long)bytes[offset+i])<<(8*i));
				}			
			}
			return retval;
		}

	}

}
