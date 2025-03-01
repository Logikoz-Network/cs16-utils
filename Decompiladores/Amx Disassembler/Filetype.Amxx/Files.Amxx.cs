using Amx.Core;

namespace Files.Amxx
{
	using System;
	using System.IO;
	using System.Collections;

	using Files;
	using Files.Amx;

	using ICSharpCode.SharpZipLib.Zip.Compression;
	using ICSharpCode.SharpZipLib.Zip.Compression.Streams;



	public class AmxxFile : IAmxContainer
	{
		//							 =  B X M A
		// public const int HeaderNumber=0x414d5842;

		protected string path;
		protected int magic;
		protected int number;
		protected AmxxEntry[] headers;

		public AmxxFile(string path)
		{
			FileStream fs=null;
			//BinaryReader bin=null;
			if (File.Exists(path))
			{
				this.path = path;
				try
				{
					fs = File.Open(path,FileMode.Open,FileAccess.Read);
				
					////catch(Exception e)
					////{
					////	fs=null;
					////	System.Windows.Forms.MessageBox.Show("error in AMX_FILE.ctor\r\n\r\n" + e.Message +"\r\n\r\n"+ e.StackTrace );
					////}

					if (fs!=null)
					{
						BinaryReader reader = new BinaryReader(fs);
						this.ReadContainerHeader(reader);
						this.ReadContainerEntries(reader);
					}

				}
				finally
				{
					if (fs!=null)
					{
						fs.Close();
						fs=null;
					}
				}
			}
		}


		protected AmxxFile(int magic, int number, BinaryReader reader)
		{
			this.magic=magic;
			this.ReadContainerHeader(reader);
			this.ReadContainerEntries(reader);
		}


		protected virtual void ReadContainerHeader(BinaryReader bin)
		{
			if (bin!=null)
			{
				magic = bin.ReadInt32();
				if (magic == this.MagicNumber)
				{
					this.number = (int)bin.ReadByte();
				}
			}
		}
		protected virtual void ReadContainerEntries(BinaryReader bin)
		{
			if (bin!=null && number>0)
			{
				this.headers = new AmxxEntry[number];
				for (int i=0;i<number;i++)
				{
					//headers[i] = new AmxxEntry(bin,path);
					headers[i]=this.GetNewEntry(path);
					headers[i].Read(bin);
					if (i>0)
					{
						headers[i-1].Length=headers[i].Start - headers[i-1].Start;
					}
					if (i==number-1)
					{
						headers[i].Length = (int) ( bin.BaseStream.Length - headers[i].Start);
					} 
				}
			}
		}

		protected virtual AmxxEntry GetNewEntry(string path)
		{
			return new AmxxEntry(path);
		}


		public virtual int MagicNumber
		{
			get
			{
				return 0x414d5842; //  B X M A
			}
		}


		private Stream GetStreamFromDescription(IAmxDescription description)
		{
			Stream retval = null;
			if (
				this.path == description.Path
				&&
				description.Valid
				)
			{
				FileStream fs = null;
				try
				{
					fs = new FileStream(description.Path,FileMode.Open,FileAccess.Read,FileShare.Read);
					MemoryStream output = new MemoryStream();
					{
						MemoryStream buffer = new MemoryStream(description.Length);
						{
							BinaryReader reader = new BinaryReader(fs);
							reader.BaseStream.Seek(description.Start,SeekOrigin.Begin);
							buffer.Write(reader.ReadBytes(description.Length),0,description.Length);
							reader=null;
						}
						buffer.Seek(0L,SeekOrigin.Begin); // get back the beginning of the buffer before we try to read.
						{
							InflaterInputStream inflater = new InflaterInputStream(buffer);
							byte[] buf = new byte[1024];
							int read = 0;
							while (inflater.Available!=0)
							{
								read = inflater.Read(buf,0,buf.Length);
								output.Write(buf,0,read);
							}
							inflater=null;
						}
						buffer.Close();
						buffer=null;
					}
					output.Seek(0L,SeekOrigin.Begin);
					retval = output;
				}
				finally
				{
					if (fs!=null)
					{
						fs.Close();
						fs=null;
					}
				}
			} 
			return retval;
		}

		private AmxStream GetAmxStream(IAmxDescription description)
		{
			AmxStream retval = null;
			Stream stream = this.GetStreamFromDescription(description);
			if (stream!=null)
			{
				retval = new AmxStream(stream);
				stream=null;
			}
			return retval;
		}


		public virtual IAmxInstance GetFile(IAmxDescription description)
		{
			IAmxInstance retval = null;

			Stream stream = this.GetStreamFromDescription(description);
			retval = new AmxFile(stream,this,description);

			return retval;
		}


		#region IAmxContainer Members

		public virtual int Count
		{
			get
			{
				int retval = 0;
				if (headers!=null)
				{
					retval = headers.Length;
				}
				return retval;
			}

		}

		public virtual string Path
		{
			get
			{
				return path;
			}
		}

		public virtual string Name
		{
			get
			{
				return System.IO.Path.GetFileNameWithoutExtension(path);
			}
		}

		public virtual AmxStream GetStream(IAmxDescription description)
		{
			foreach (AmxxEntry entry in headers)
			{
				if (
					entry.Bits == description.Bits 
					&&
					entry.Path == description.Path
					&&
					entry.Valid
					)
				{
					return this.GetAmxStream(description);
					//return this.GetStreamFromDescription(description);
				}
			}
			return null;
		}

		#endregion

		#region IEnumerable Members

		public IEnumerator GetEnumerator()
		{
			return new AmxxFileEnumerator(headers);
		}

		#endregion

	}


	public class AmxxEntry : IAmxDescription
	{
		protected Bits bits;
		protected int offset;
		protected int stacksize;
		protected int length;
		protected string path;

		public AmxxEntry(string path)
		{
			this.path=path;
		}
		/*
		public AmxxEntry(BinaryReader stream, string path)
		{
			this.path=path;
			int bitint = (int)stream.ReadByte();
			if (Enum.IsDefined(typeof(Bits),bitint))
			{
				bits = (Bits)bitint;
				stacksize = stream.ReadInt32();
				offset = stream.ReadInt32();
			}
			length=-1;
		}

		*/

		public virtual void Read(BinaryReader reader)
		{
			if (reader!=null)
			{
				int bitint = (int)reader.ReadByte();
				if (Enum.IsDefined(typeof(Bits),bitint))
				{
					bits = (Bits)bitint;
					stacksize = reader.ReadInt32();
					offset = reader.ReadInt32();
				}
			}
			length=-1;
		}



		public virtual Bits Bits
		{
			get
			{
				return bits;
			}
		}

		public virtual int Start
		{
			get
			{
				return offset;
			}
		}

		public virtual int Stacksize
		{
			get
			{
				return stacksize;
			}
		}
		public virtual int Length
		{
			get
			{
				return length;
			}
			set
			{
				length=value;
			}
		}
		public virtual bool Valid
		{
			get
			{
				return (length!=-1);
			}
		}
		public virtual string Name
		{
			get
			{
				return System.IO.Path.GetFileNameWithoutExtension(path);
			}
		}
		public virtual string Path
		{
			get
			{
				return path;
			}
		}
	}




	public abstract class AmxxFileEx : AmxxFile
	{
		// public const int HeaderNumber = 0x414D5858; // A M X X

		private int version;

		public AmxxFileEx(string path)
			: base(path){}


		public override int MagicNumber
		{
			get
			{
				return 0x414D5858; // A M X X
			}
		}


		protected override void ReadContainerHeader(BinaryReader bin)
		{
			if (bin!=null)
			{
				this.magic=bin.ReadInt32();
				if (magic==this.MagicNumber)
				{
					version = (int)bin.ReadInt16();
					if (version==this.MagicVersion)
					{
						number = (int)bin.ReadByte();
					}
				}
			}
		}


		public abstract int MagicVersion
		{
			get;
		}

		public virtual int Version
		{
			get
			{
				return this.version;
			}
		}
	}


	public abstract class AmxxEntryEx : AmxxEntry
	{

		//int8_t	cell size

		//int32_t	imagesize	(uncompressed size of image)
		//int32_t	disksize	(compressed size of image)

		//int32_t	memsize		(stack size, hdr.stp)
		//int32_t	offs		(offset in file)

		protected int imagesize;
		protected int disksize;


		public AmxxEntryEx(string path)
			: base(path){}

		public override void Read(BinaryReader reader)
		{
			if (reader!=null)
			{
				int bitint = (int)reader.ReadByte();
				if (Enum.IsDefined(typeof(Bits),bitint))
				{
					bits = (Bits)bitint;

					imagesize=reader.ReadInt32();
					disksize=reader.ReadInt32();

					stacksize = reader.ReadInt32();
					offset = reader.ReadInt32();
				}
			}
			length=-1;
		}

	}




	public class AmxxFile3 : AmxxFileEx
	{
		public AmxxFile3(string path)
			: base(path){}


		public override int MagicVersion
		{
			get
			{
				return 0x0300;
			}
		}


		protected override AmxxEntry GetNewEntry(string path)
		{
			return new AmxxEntry3(path);
		}


	}


	public class AmxxEntry3 : AmxxEntryEx
	{
		public AmxxEntry3(string path)
			: base(path){}
	}



	public class AmxxFileEnumerator : IEnumerator
	{
		private int pos;
		private AmxxEntry[] files;

		public AmxxFileEnumerator(AmxxEntry[] list)
		{
			if (list!=null && list.Length>0)
			{
				files=list;
				this.Reset();
			}
			else
			{
				throw new InvalidOperationException("cannot initialze an enumerator over a null or 0 length file list");
			}
		}


		#region IEnumerator Members

		public void Reset()
		{
			pos=-1;
		}

		public object Current
		{
			get
			{
				if (pos>=0 && pos<files.Length)
				{
					return files[pos];
				}
				else
				{
					throw new InvalidOperationException("Invalid file index in AmxxFileEnumerator");
				}

			}
		}

		public bool MoveNext()
		{
			pos+=1;
			return (pos<files.Length);
		}

		#endregion
	}


	public class AmxxFiletype : IFiletype
	{
		#region IFiletype Members

		public string FriendyName
		{
			get
			{
				return "Amxx";
			}
		}

		public string Description
		{
			get
			{
				return "This type of file contains one or more zlib compressed amx files";
			}
		}

		public string Name
		{
			get
			{
				return "Amxx";
			}
		}

		public string Extension
		{
			get
			{
				
				return ".amxx";
			}
		}

		public string FilterText
		{
			get
			{
				return "Amx Mod X Files (*.amxx)";
			}
		}

		public string FilterMask
		{
			get
			{
				return "*.amxx";
			}
		}


		public IAmxContainer GetContainer(string path)
		{
			IAmxContainer retval = new AmxxFile(path);
			if (retval.Count==0)
			{
				retval = new AmxxFile3(path);
			}
			if (retval.Count==0)
			{
				retval=null;			  
			}
			return retval;
		}

		public IAmxInstance GetInstance(string path, Bits bits)
		{
			IAmxInstance inst = null;
			IAmxContainer cont = this.GetContainer(path);
			foreach (IAmxDescription desc in cont)
			{
				if (desc.Bits==bits && desc.Valid)
				{
					inst = cont.GetFile(desc);
					break;
				}
			}
			return inst;
		}

		#endregion
	}
}