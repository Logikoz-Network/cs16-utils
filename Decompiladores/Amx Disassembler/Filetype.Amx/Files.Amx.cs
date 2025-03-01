using System;
using Amx.Core;

namespace Files.Amx
{
	using System.IO;
	using System.Collections;

	using Files;

	public class AmxFile : IAmxDescription,IAmxInstance,IAmxContainer
	{
		protected string path;
		protected long size;
		protected long start;
		protected Bits bits;
		protected IAmxContainer container;
		protected IAmxDescription internaldescription;
		private AmxHeader header;

		public AmxFile(Stream stream,IAmxContainer container,IAmxDescription internaldescription) 
		{
			if (
				container!=null &&
				container.Path!=null &&
				internaldescription!=null &&
				stream!=null &&
				Enum.IsDefined(typeof(Bits),internaldescription.Bits))
			{
				AmxFileLoad(stream,bits,container.Path);
				this.bits=internaldescription.Bits;
				this.start=start;
				this.container=container;
				this.internaldescription=internaldescription;
			}

		}
		public AmxFile(string path, Bits bits)
		{
			FileStream fs=null;
			if (File.Exists(path) && Enum.IsDefined(typeof(Bits),bits))
			{
				try
				{
					fs = File.Open(path,FileMode.Open,FileAccess.Read);
					if (fs!=null)
					{
						AmxFileLoad(fs,bits,path);
					}
					this.container=null;
					this.internaldescription=null;
					
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

		~AmxFile()
		{
			//if (File.Exists(l_decompressed_path))
			//{
			//	File.Delete(l_decompressed_path);
			//}
		}


		private void AmxFileLoad(Stream stream,Bits bits,string path)
		{
			if (stream!=null && stream.CanRead && stream.CanSeek)
			{
				AmxStream reader= new AmxStream(stream);
				if (reader!=null)
				{
					this.start=stream.Position;
					this.path = path;
					this.bits= bits;
					header = AmxHelpers.GetHeader(reader);
					if (header.Valid)
					{
						this.bits=header.BitHint;
						size=header.Hea;
					}
					return;
				}
				reader=null;
			}
		}

		
		#region IAmxDescription Members

		public virtual Bits Bits
		{
			get
			{
				return bits;
			}
		}
		public virtual bool Valid
		{
			get
			{
				if (header!=null)
				{
					return header.Valid;
				}
				else
				{
					return false;
				}
			}
		}

		public virtual string Name
		{
			get
			{
				string l_path = null;
				if (container!=null)
				{
					l_path = container.Path;
				}
				else
				{
					l_path = path;
				}
				return System.IO.Path.GetFileNameWithoutExtension(l_path);
			}
		}
		public virtual string Path
		{
			get
			{
				string retval = null;
				if (container!=null)
				{
					retval = container.Path;
				}
				else
				{
					retval = path;
				}
				return retval;
			}
		}

		public virtual int Start
		{
			get
			{
				return 0;
			}
		}
		public virtual int Length
		{
			get
			{
				return (int)size;
			}
		}


		#endregion

		#region IAmxContainer Members

		public int Count
		{
			get
			{
				return 1;
			}
		}

		AmxStream IAmxContainer.GetStream(IAmxDescription description)
		{
			return this.GetStream();
		}

		public IAmxInstance GetFile(IAmxDescription description)
		{
			if (
				description.Bits==this.bits &&
				description.Path==this.path &&
				description.Valid == this.Valid
				)
			{
				return this;
			}
			else
			{
				return null;
			}
		}

		#endregion

		#region IAmxInstance Members

		public AmxHeader Header
		{
			get
			{
				return header;
			}
		}

		public virtual string InfoString
		{
			get
			{
				string retval=null;

				retval = this.Name + ", " + this.bits.ToString().Replace("_","") +" bit";
				if (container!=null)
				{
					retval += " (in " + System.IO.Path.GetFileName(path) + ")";
				}

				return retval;
			}
		}

		public virtual IAmxContainer Container
		{
			get
			{
				if (container==null)
				{
					return this;
				}
				else
				{
					return container;
				}
			}
		}

		public virtual IAmxDescription Description
		{
			get
			{
				if (internaldescription==null)
				{
					return this;
				}
				else
				{
					return internaldescription;
				}
			}
		}

		public virtual AmxStream GetStream()
		{
			AmxStream retval = null;
			MemoryStream basestream;
			if (container==null)
			{
				if ( header.GetFlag(AMX_FLAGS.COMPACT) )
				{
					basestream = AmxHelpers.decompress(header, path);
					retval = new AmxStream(basestream);
				}
				else
				{
					BinaryReader bin = new BinaryReader(File.OpenRead(path));
					basestream = new MemoryStream((int)bin.BaseStream.Length);
					basestream.Write(bin.ReadBytes((int)bin.BaseStream.Length),0,(int)bin.BaseStream.Length);
					bin=null;
				}
				retval = new AmxStream(basestream);
			}
			else
			{
				Stream stream = container.GetStream(internaldescription);
				if (stream!=null)
				{
					if ( header.GetFlag(AMX_FLAGS.COMPACT) )
					{
						basestream = AmxHelpers.decompress(header, stream);
						retval = new AmxStream(basestream);
					}
					else
					{
						retval = new AmxStream(stream);
					}
				}
			}
			if (retval!=null)
			{
				retval.Seek(0,SeekOrigin.Begin);
			}
			return retval;
		}
		
		#endregion

		#region IEnumerable Members

		public IEnumerator GetEnumerator()
		{
			return new AmxFileEnumerator(this);
		}

		#endregion
	}

	public class AmxFileEnumerator :IEnumerator
	{
		private AmxFile file;
		bool seen;

		public AmxFileEnumerator(AmxFile file)
		{
			this.file=file;
			this.Reset();
		}


		#region IEnumerator Members

		public void Reset()
		{
			seen=false;
		}

		public object Current
		{
			get
			{
				if (!seen)
				{
					return file;
				}
				else
				{
					throw new InvalidOperationException();
				}
			}
		}

		public bool MoveNext()
		{
			if (!seen) 
			{
				seen=true;
				return seen;
			}
			else
			{
				return false;
			}
		}

		#endregion
	}


	public class AmxFiletype : IFiletype
	{
		#region IFiletype Members

		public string FriendyName
		{
			get
			{
				return "Amx";
			}
		}

		public string Description
		{
			get
			{
				return "This type of file contains an amx virtual machine.";
			}
		}

		public string Name
		{
			get
			{
				return "Amx";
			}
		}

		public string Extension
		{
			get
			{
				
				return ".amx";
			}
		}

		public string FilterText
		{
			get
			{
				return "Amx Files (*.amx)";
			}
		}

		public string FilterMask
		{
			get
			{
				return "*.amx";
			}
		}


		public IAmxContainer GetContainer(string path)
		{
			return new AmxFile(path,Bits._32);
		}

		public IAmxInstance GetInstance(string path, Bits bits)
		{
			return new AmxFile(path,Bits._32);
		}

		#endregion
	}

}