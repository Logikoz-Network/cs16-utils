using System;
using Amx.Core;

namespace Files.Ramx
{
	using System.Collections;
	using System.IO;

	using Files;
	using Files.Amx;


	public class RamxFile : AmxFile
	{
		public RamxFile(string path, Bits bits) : base(path, bits)
		{
		}

		public override AmxStream GetStream()
		{
			AmxStream retval = null;
			if (this.Valid)
			{
				
				MemoryStream basestream;
				BinaryReader bin = new BinaryReader(File.OpenRead(this.path));
				basestream = new MemoryStream((int)bin.BaseStream.Length);
				basestream.Write(bin.ReadBytes((int)bin.BaseStream.Length),0,(int)bin.BaseStream.Length);
				bin=null;
				retval = new AmxStream(basestream);
				if (retval!=null)
				{
					retval.Seek(0,SeekOrigin.Begin);
				}
			}
			return retval;
		}

	}


	public class RawAmxFiletype : IFiletype
	{
		#region IFiletype Members

		public string FriendyName
		{
			get
			{
				return "Raw Amx";
			}
		}

		public string Description
		{
			get
			{
				return "This type of file contains a raw amx virtual machine which is guarenteed to be uncompressed and in which the header may not accurately reflect the state of the file itself";
			}
		}

		public string Name
		{
			get
			{
				return "RawAmx";
			}
		}

		public string Extension
		{
			get
			{
				
				return ".ramx";
			}
		}

		public string FilterText
		{
			get
			{
				return "Raw Amx Files (*.ramx)";
			}
		}

		public string FilterMask
		{
			get
			{
				return "*.ramx";
			}
		}


		public IAmxContainer GetContainer(string path)
		{
			return new RamxFile(path,Bits._32);
		}

		public IAmxInstance GetInstance(string path, Bits bits)
		{
			return new RamxFile(path,Bits._32);
		}

		#endregion
	}

}