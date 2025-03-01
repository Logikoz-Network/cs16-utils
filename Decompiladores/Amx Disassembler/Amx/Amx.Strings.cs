using System;

namespace Amx.Strings
{
	using System.Text;
	using Amx.Core;


	public abstract class StringDecoder : Decoder
	{
		protected int sizeof_cell;

		public abstract int GetAlignedCharCount(int count);
		public abstract string GetString(byte[] bytes, int index, int count);

	}

	public abstract class StringEncoder : Encoder
	{
		public abstract int GetByteCount(char[] chars, int index, int count, int sizeof_cell, bool flush);

	}


	public class AsciiStringDecoder : StringDecoder
	{
		public AsciiStringDecoder(int sizeof_cell)
		{
			this.sizeof_cell=sizeof_cell;
		}


		public override bool Equals(object obj)
		{
			return base.Equals (obj);
		}
		public override int GetHashCode()
		{
			return base.GetHashCode ();
		}
		public override string ToString()
		{
			return base.ToString ();
		}


		public override int GetCharCount(byte[] bytes, int index, int count)
		{
			if (bytes==null)
			{
				throw new ArgumentNullException();
			}
			if (index<0 || count<0 || (index+count)>bytes.Length)
			{
				throw new ArgumentOutOfRangeException();
			}

			int i=index;
			int ccount=0;

			while (i<(index+count) && bytes[i]!=0)
			{
				ccount+=1;
				i+=1;
			}

			return ccount;
		}

		public override int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex)
		{
			if (bytes==null || chars==null)
			{
				throw new ArgumentNullException();
			}
			if (
				(byteCount<0 || byteIndex<0 || charIndex<0)
				||
				( (byteIndex+byteCount)>bytes.Length )
				||
				( charIndex > chars.Length)
				)
			{
				throw new ArgumentOutOfRangeException();
			}

			int i=byteIndex;
			int ccount=0;

			while (i<(byteIndex+byteCount) && bytes[i]!=0)
			{
				chars[charIndex+ccount]=(char)bytes[i];
				ccount+=1;
				i+=1;
			}


			return ccount;
		}

		public override string GetString(byte[] bytes, int index, int count)
		{
			string retval =null;
			char[] chars;
			int charcount = this.GetCharCount(bytes,index,count);
			if (charcount>0)
			{
				chars=new char[charcount];
				this.GetChars(bytes,index,count,chars,0);
				retval = new string(chars);
			}
			return retval;
		}

		public override int GetAlignedCharCount(int count)
		{
			int retval = count;
			retval+=1; //0 terminator;
			while ((retval%sizeof_cell)!=0)
			{
				retval+=1;
			}
			return retval;
		}

	}


	public class PackedStringDecoder : StringDecoder
	{
		public PackedStringDecoder(int sizeof_cell)
		{
			this.sizeof_cell=sizeof_cell;
		}


		public override bool Equals(object obj)
		{
			return base.Equals (obj);
		}
		public override string ToString()
		{
			return base.ToString ();
		}
		public override int GetHashCode()
		{
			return base.GetHashCode ();
		}


		public override int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex)
		{
			int count=0;
			if (byteCount>0)
			{
				int i=(byteIndex+(sizeof_cell-1));
				int j=(byteIndex);
				while (count<byteCount && i<bytes.Length && bytes[i]!=0)
				{
					chars[charIndex+count]=(char)bytes[i];
					if (i!=j)
					{
						i-=1;
					}
					else
					{
						j+=sizeof_cell;
						i=(j+(sizeof_cell-1));
					}
					count+=1;
				}
			}
			return count;
		}

		public override int GetCharCount(byte[] bytes, int index, int count)
		{
			int retval =-1;
			int ccount=0;
			if (count>0)
			{
				int i=(index+(sizeof_cell-1));
				int j=(index);
				while (i<bytes.Length && bytes[i]!=0)
				{
					if (i!=j)
					{
						i-=1;
					}
					else
					{
						j+=sizeof_cell;
						i=(j+(sizeof_cell-1));
					}
					ccount+=1;
				}
			}
			if (ccount>0 && ccount<=count)
			{
				retval = ccount;
			}
			return retval;
		}

		public override string GetString(byte[] bytes,int index, int count)
		{
			string retval =null;
			char[] chars;
			int charcount = this.GetCharCount(bytes,index,count);
			if (charcount>0)
			{
				chars=new char[charcount];
				this.GetChars(bytes,index,count,chars,0);
				retval = new string(chars);
			}
			return retval;
		}
		public override int GetAlignedCharCount(int count)
		{
			int retval = count;
			retval+=1; //0 terminator;
			//while ((retval%sizeof_cell)!=0)
			//{
			//	retval+=1;
			//}
			int diff = (retval % sizeof_cell);
			if (diff!=0)
			{
				retval+=(sizeof_cell-diff);
			}
			//retval+=(sizeof_cell-(retval%sizeof_cell));
			if ((retval%sizeof_cell)!=0)
			{
				retval=-1;
			}
			return retval;
		}

	}

	public class PackedStringEncoder : Encoder
	{
		private int l_padded;
		private int l_length;
		//private byte[] l_bytes;

		public override bool Equals(object obj)
		{
			return base.Equals (obj);
		}
		public override int GetHashCode()
		{
			return base.GetHashCode ();
		}
		public override string ToString()
		{
			return base.ToString ();
		}


		public override int GetBytes(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex, bool flush)
		{
			int count=0;
			int l_padding=l_padded;

			// if it was padded and i can move back that far, do so
			if (l_padding>0 && charIndex>=l_padding )
			{
				charIndex-=l_padding;
				l_length-=l_padding;
			}
			count=l_length;
		
			int i=(byteIndex+3);
			int j=(byteIndex);
			while (count<(charIndex + charCount) && (charIndex+count)<chars.Length && chars[charIndex+count]!=0)
			{
				bytes[charIndex+i]=(byte)chars[charIndex+count];
				if (i!=j)
				{
					i-=1;
				}
				else
				{
					j+=4;
					i=(j+3);
				}
				count+=1;
			}
		
			count+=1; // 0 terminator
			int offset= (count%4);
			if (offset!=0)
			{
				l_padding = (4-offset);
				count=count+l_padding;
			}

			return count;
		}
		public override int GetByteCount(char[] chars, int index, int count, bool flush)
		{
			int ccount=0;
			int l_padding=0;

			if (l_padded!=0)
			{
				l_length-=l_padded;
				l_padded=0;
			}
			ccount=l_length;

			while (ccount<(index + count) && (index+ccount)<chars.Length && chars[index+ccount]!=0)
			{
				ccount+=1;
			}
			ccount+=1; // 0 terminator

			int offset= (ccount%4);
			if (offset!=0)
			{
				l_padding = (4-offset);
				ccount=ccount+l_padding;
			}

			if (flush)
			{
				l_padded=0;
				l_length=0;
			}
			else
			{
				l_padded=l_padding;
				l_length=ccount;
			}
			return ccount;
		}


		public byte[] GetBytes(string str)
		{
			char[] chars=null;
			byte[] bytes=null;
			chars=str.ToCharArray();
			int bytecount = this.GetByteCount(chars,0,chars.Length,true);
			if (bytecount>0)
			{
				bytes=new byte[bytecount];
				this.GetBytes(chars,0,chars.Length,bytes,0,true);
			}
			return bytes;
		}

	}


	public class PaddedStringDecoder : StringDecoder
	{
		public PaddedStringDecoder(int sizeof_cell)
		{
			this.sizeof_cell=sizeof_cell;
		}


		public override bool Equals(object obj)
		{
			return base.Equals (obj);
		}
		public override string ToString()
		{
			return base.ToString ();
		}
		public override int GetHashCode()
		{
			return base.GetHashCode ();
		}


		public override int GetCharCount(byte[] bytes, int index, int count)
		{
			int retval = -1;
			int i=index;
			int ccount=0;
			bool breakout=false;
			bool terminated = false;
			while (
					i<(bytes.Length-(sizeof_cell-1)) && 
					i<(index+count) //&& 
					//bytes[i]!=0
					)
			{
				for (int j=0;j<(sizeof_cell);j+=1)
				{
					switch (j)
					{
						case 0:
							terminated |= (bytes[i+j] == 0);
							break;
						default:
							breakout |= (bytes[i+j] != 0);
							break;
					}
				}
				if (!breakout && !terminated)
				{
					i+=sizeof_cell;
					ccount+=1;
				}
				else
				{
					break;
				}
			}
			if (index!=i && terminated &&  ccount<=count && ccount>0)
			{
				retval = ccount;
			}
			return retval;
		}
		public override int GetChars(byte[] bytes, int byteStart, int charCount, char[] chars, int charIndex)
		{
			/*
			int i=index;
			int count=charIndex;
			while (
				i<(bytes.Length-3) &&
				count<byteCount && 
				bytes[i]!=0 && 
				bytes[i+1]==0 && 
				bytes[i+2]==0 && 
				bytes[i+3]==0)
			{
				chars[count]=(char)bytes[i];
				i+=4;
				count+=1;
			}
			return count;	
			*/

			int retval = -1;
			int i=byteStart;
			int ccount=0;
			bool breakout=false;
			bool terminated = false;
			while (
				i<(bytes.Length-(sizeof_cell-1)) && 
				i<(byteStart+((charCount+1)*sizeof_cell)) //&& 
				//bytes[i]!=0
				)
			{
				for (int j=0;j<(sizeof_cell);j+=1)
				{
					switch (j)
					{
						case 0:
							terminated |= (bytes[i+j] == 0);
							break;
						default:
							breakout |= (bytes[i+j] != 0);
							break;
					}
				}
				if (!breakout && !terminated)
				{
					chars[charIndex+ccount] = (char)bytes[i];
					i+=sizeof_cell;
					ccount+=1;
				}
				else
				{
					break;
				}
			}
			if (byteStart!=i && terminated && ccount==charCount && ccount>0)
			{
				retval = ccount;
			}
			return retval;
		}

		public override string GetString(byte[] bytes,int index, int count)
		{
			string retval =null;
			char[] chars;
			int charcount = this.GetCharCount(bytes,index,count);
			if (charcount>0)
			{
				chars=new char[charcount];
				this.GetChars(bytes,index,count,chars,0);
				retval = new string(chars);
			}
			return retval;
		}

		public override int GetAlignedCharCount(int count)
		{
			return ((count*sizeof_cell)+sizeof_cell);
		}
	}

}
