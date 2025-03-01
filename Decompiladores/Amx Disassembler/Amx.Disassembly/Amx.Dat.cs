#define newstrings
using System;

namespace Amx.Dat
{
	using System.Collections;
	using System.Text;
	using Amx.Core;
	using Amx.Strings;


	public enum DatEntryType
	{
		Bad,
		Unknown,
		Variable,
		Array,
		String,
		MultiArray				
	}

	public enum DatNameStrength
	{
		Runtime,
		Symbol,
		User
		
	}

	public enum DatEntryProvidence
	{
		Symbols,
		Detected
	}


	public interface IDatEntry : IComparable
	{
		int Start
		{
			get;
		}

		int End
		{
			get;
		}

		int Length
		{
			get;
		}

		DatEntryType Type
		{
			get;
		}

		IDatEntry Owner
		{
			get;
			set;
		}

		bool InArray
		{
			get;
		}

		string Name
		{
			get;
			set;
		}
		DatNameStrength NameType
		{
			get;
			set;
		}
		DatEntryProvidence Providence
		{
			get;
		}
		bool Contains(int address);
		bool Contains(IDatEntry entry);
		bool Overlaps(IDatEntry entry);
		bool Good
		{
			get;
		}
	}


	public sealed class DatHelpers
	{
		private DatHelpers(){}


		public static IDatEntry CreateDatEntry(byte[] data,int sizeof_cell, DatEntryMultiarrayDescription description, bool trymulti, bool trystring, bool tryarray,bool tryvariable )
		{

			IDatEntry retval=null;

			if (trymulti)
			{
				//retval = new MultiEntry(ref data,description);
				retval = MultiEntry.CreateFromDescription(data,sizeof_cell,description);
				if ( (retval.Start%sizeof_cell)!=0 || (retval.Length%sizeof_cell)!=0)
				{
					retval = retval;
				}
				if (retval.Type!=DatEntryType.Bad) 
				{
					return retval;
				}
			}

			if (trystring)
			{
				retval = new StringEntry(data,sizeof_cell,description.value,description.bound_value*4);
				if (retval.Type!=DatEntryType.Bad) 
				{
					return retval;
				}
			}

			if (tryarray)
			{
				retval = new ArrayEntry(data,sizeof_cell,description.value,description.bound_value*sizeof_cell);
				if (retval.Type!=DatEntryType.Bad) 
				{
					if (retval.Length>1 || !tryvariable)
					{
						return retval;
					}
					else
					{
						retval = new VariableEntry(data,sizeof_cell,description.value);
					}
				}
			}

			if (tryvariable)
			{
				retval = new VariableEntry(data,sizeof_cell,description.value);
				if (retval.Type!=DatEntryType.Bad)
				{
					return retval;
				}
			}
			return new BadEntry();
		}

		public static IDatEntry CreateDatEntry(byte[] data,int sizeof_cell, int start, int length, bool trymulti, bool trystring, bool tryarray,bool tryvariable )
		{

			IDatEntry retval=null;

			if (trymulti)
			{
				if ( (length%sizeof_cell) ==0 )
				{
					retval = new MultiEntry(data,sizeof_cell,start,(length/sizeof_cell));
					if (retval.Type!=DatEntryType.Bad) 
					{
						return retval;
					}
				}

				retval = new MultiEntry(data,sizeof_cell,start,length);

				if (retval.Type!=DatEntryType.Bad) 
				{
					return retval;
				}
			}

			if (trystring)
			{
				retval = new StringEntry(data,sizeof_cell,start,length);
				if (retval.Type!=DatEntryType.Bad) 
				{
					return retval;
				}
			}

			if (tryarray)
			{
				retval = new ArrayEntry(data,sizeof_cell,start,length);
				if (retval.Type!=DatEntryType.Bad) 
				{
					if (retval.Length>1 || !tryvariable)
					{
						return retval;
					}
					else
					{
						retval = new VariableEntry(data,sizeof_cell,start);
					}
				}
			}

			if (tryvariable)
			{
				retval = new VariableEntry(data,sizeof_cell,start);
				if (retval.Type!=DatEntryType.Bad)
				{
					return retval;
				}
			}

			return new BadEntry();
		}

		public static IDatEntry CreateDatEntry(byte[] data,int sizeof_cell, int start, bool trymulti, bool trystring, bool tryarray,bool tryvariable)
		{
			IDatEntry retval=null;

			if (trymulti)
			{
				retval = new MultiEntry(data,sizeof_cell,start);
				if (retval.Type!=DatEntryType.Bad) 
				{
					if ((retval.Start%sizeof_cell)!=0 || (retval.Length%sizeof_cell)!=0)
					{
						retval = retval;
					}
					return retval;
				}
			}

			if (trystring)
			{
				retval = new StringEntry(data,sizeof_cell,start);
				if (retval.Type!=DatEntryType.Bad) 
				{
					return retval;
				}
			}

			if (tryarray)
			{
				retval = new ArrayEntry(data,sizeof_cell,start);
				if (retval.Type!=DatEntryType.Bad) 
				{
					if (retval.Length>1 || !tryvariable)
					{
						return retval;
					}
					else
					{
						retval = new VariableEntry(data,sizeof_cell,start);
					}
				}
			}

			if (tryvariable)
			{
				retval = new VariableEntry(data,sizeof_cell,start);
				if (retval.Type!=DatEntryType.Bad)
				{
					return retval;
				}
			}

			return new BadEntry();;
		}


		#region old version
		/*
		public static bool ResolveOcclusion( ResourceList entries,byte[] data,int sizeof_cell)
		{
			bool again=true;
			bool changemade=false;
			int count=0;
			while (again && count <5)
			{
				again=false;
				for (int i=0;i<entries.Count;i++)
				{
					IDatEntry dei = entries[i] as IDatEntry;
					if ( (dei.Start%sizeof_cell)==0 && ((dei.End+1)%sizeof_cell)==0 )
					{
						for (int j=0;j<entries.Count;j++)
						{
							if ( i!=j )
							{
								IDatEntry dej = entries[j] as IDatEntry;
								if(	(dei.Contains( dej ) )	)
								{
									if ( dei.Type>=dej.Type)
										entries.Remove(entries[j]);
									else
										entries.Remove(entries[i]);
									again=true;
									changemade=true;
									break;
								}
								else if ( dei.Overlaps( dej )  )
								{
									if  (dei.Type>=dej.Type)
										entries.Remove(entries[j]);
									else
										entries.Remove(entries[i]);
									again=true;
									changemade=true;
									break;
								}
							}
						}
					}
					else
					{
						// misaligned
						entries.RemoveAt(i);
						entries.Sort();
						again=true;
					}
					//count+=1;
					if (again) break;
					
				}
			}
			entries.Sort();
			return changemade;
		}
		
		
		public static bool ResolveGaps(ResourceList entries, byte[] data,int sizeof_cell)
		{
			bool changemade=false;
			for (int i=0;i<entries.Count-1;i++)
			{
				if (i==0)
				{
					IDatEntry dat = (IDatEntry)entries[i];
					if (dat.Start!=0)
					{
						IDatEntry entry = DatHelpers.CreateDatEntry(data,sizeof_cell,0,dat.Start,true,true,true,true);
						if (entry.Type!=DatEntryType.Bad)
						{
							entries.Insert(i,entry);
							MultiEntry mentry = entry as MultiEntry;
							if (mentry!=null)
							{
								foreach (IDatEntry sub in mentry.Data)
								{
									entries.Add(sub);
								}
							}
							changemade=true;
						}
					}
				}
					// special case the end
				else if (i==entries.Count-1)
				{
					IDatEntry dat = (IDatEntry)entries[entries.Count];
					if (dat.End!=data.Length)
					{
						IDatEntry entry = DatHelpers.CreateDatEntry(data,sizeof_cell,dat.End+1,data.Length-dat.End,true,true,true,true);
						if (entry.Type!=DatEntryType.Bad)
						{
							entries.Insert(i+1,entry);
							MultiEntry mentry = entry as MultiEntry;
							if (mentry!=null)
							{
								foreach (IDatEntry sub in mentry.Data)
								{
									entries.Add(sub);
								}
							}
							changemade=true;
						}
					}
				}
					// all internal cases
				else
				{
					IDatEntry dat1 = (IDatEntry)entries[i];
					IDatEntry dat2 = (IDatEntry)entries[i+1];
					if ( dat1.End+1 != dat2.Start )
					{
						IDatEntry entry = DatHelpers.CreateDatEntry(
							data,
							sizeof_cell,
							dat1.End+1,
							(dat2.Start-1)-dat1.End
							,true,true,true,true);
						if (entry.Type!=DatEntryType.Bad)
						{
							entries.Insert(i+1,entry);
							MultiEntry mentry = entry as MultiEntry;
							if (mentry!=null)
							{
								foreach (IDatEntry sub in mentry.Data)
								{
									entries.Add(sub);
								}
							}
							changemade=true;
						}	
					}
				}
			}
			return changemade;
		}


		*/
		#endregion


		public static bool ResolveOcclusion(ResourceList entries,byte[] data,int sizeof_cell)
		{

			bool again=true;
			bool changemade=false;
			//int count=0;

			IDatEntry dat1 = null;
			IDatEntry dat2 = null;

			while (again)
			{
				again=false;
				for (int i=0;i<entries.Count-1;i++)
				{
					dat1 = entries[i];
					dat2 = entries[i+1];

					if (	
						dat1.Contains( dat2 )
						||
						dat1.Overlaps( dat2 ) 
						)
					{
						if ( dat1.Type>=dat2.Type)
						{
							entries.Remove(dat2);
						}
						else
						{
							entries.Remove(dat1);
						}
						again=true;
						changemade=true;
						break;
					}
				}
			}

			/*
			while (again && count <5)
			{
				again=false;
				for (int i=0;i<entries.Count;i++)
				{
					IDatEntry dei = entries[i] as IDatEntry;
					if ( (dei.Start%sizeof_cell)==0 && ((dei.End+1)%sizeof_cell)==0 )
					{
						for (int j=0;j<entries.Count;j++)
						{
							if ( i!=j )
							{
								IDatEntry dej = entries[j] as IDatEntry;
								if(	(dei.Contains( dej ) )	)
								{
									if ( dei.Type>=dej.Type)
										entries.Remove(entries[j]);
									else
										entries.Remove(entries[i]);
									again=true;
									changemade=true;
									break;
								}
								else if ( dei.Overlaps( dej )  )
								{
									if  (dei.Type>=dej.Type)
										entries.Remove(entries[j]);
									else
										entries.Remove(entries[i]);
									again=true;
									changemade=true;
									break;
								}
							}
						}
					}
					else
					{
						// misaligned
						entries.RemoveAt(i);
						entries.Sort();
						again=true;
					}
					//count+=1;
					if (again) break;
					
				}
			}
			*/
			//entries.Sort();
			return changemade;
		}


		public static bool ResolveGaps(ResourceList entries, byte[] data,int sizeof_cell)
		{
			bool changemade=true;

			IDatEntry datx = null;
			IDatEntry daty = null;

			while (changemade)
			{
				changemade=false;

				for (int index=0;index<entries.Count;index++)
				{
					
					datx = null;
					daty = null;

					if (index==0)
					{
						datx = entries[index];
						if (datx.Start!=0)
						{
							daty = DatHelpers.CreateDatEntry(
									data,
									sizeof_cell,
									0,
									datx.Start,
									true,true,true,true
								);
							if (daty.Type!=DatEntryType.Bad)
							{
								entries.Add(daty);
								changemade=true;
								break;
							}
						}
					}
					else if (index == (entries.Count-1) )
					{
						datx = entries[index];
						if (datx.End+1 < data.Length)
						{
							daty = DatHelpers.CreateDatEntry(
									data,
									sizeof_cell,
									//datx.Start,
									datx.End+1,
									//data.Length,
									true,true,true,true
								);
							if (daty.Type!=DatEntryType.Bad)
							{
								entries.Add(daty);
								changemade=true;
								break;
							}
						}
					}
					else
					{
						datx = entries[index];
						daty = entries[index+1];
						if ( datx.End+1 < daty.Start )
						{
							IDatEntry entry = DatHelpers.CreateDatEntry(
									data,
									sizeof_cell,
									datx.End+1,
									(daty.Start-1)-datx.End
									,true,true,true,true
								);
							if (entry.Type!=DatEntryType.Bad)
							{
								entries.Add(entry);
								changemade=true;
								break;
							}	
						}
					}
					datx = null;
					daty = null;
				}
			}
			/*
			for (int i=0;i<entries.Count-1;i++)
			{
				
				if (i==0)
				{
					IDatEntry dat = (IDatEntry)entries[i];
					if (dat.Start!=0)
					{
						IDatEntry entry = DatHelpers.CreateDatEntry(data,sizeof_cell,0,dat.Start,true,true,true,true);
						if (entry.Type!=DatEntryType.Bad)
						{
							entries.Insert(i,entry);
							MultiEntry mentry = entry as MultiEntry;
							if (mentry!=null)
							{
								foreach (IDatEntry sub in mentry.Data)
								{
									entries.Add(sub);
								}
							}
							changemade=true;
							i=0;
						}
					}
				}
					// special case the end
				else if (i==entries.Count-1)
				{
					IDatEntry dat = (IDatEntry)entries[entries.Count];
					if (dat.End!=data.Length)
					{
						IDatEntry entry = DatHelpers.CreateDatEntry(data,sizeof_cell,dat.End+1,data.Length-dat.End,true,true,true,true);
						if (entry.Type!=DatEntryType.Bad)
						{
							entries.Insert(i+1,entry);
							MultiEntry mentry = entry as MultiEntry;
							if (mentry!=null)
							{
								foreach (IDatEntry sub in mentry.Data)
								{
									entries.Add(sub);
								}
							}
							changemade=true;
							i=0;
						}
					}
				}
					// all internal cases
				else
				{
					IDatEntry dat1 = (IDatEntry)entries[i];
					IDatEntry dat2 = (IDatEntry)entries[i+1];
					if ( dat1.End+1 != dat2.Start )
					{
						IDatEntry entry = DatHelpers.CreateDatEntry(
							data,
							sizeof_cell,
							dat1.End+1,
							(dat2.Start-1)-dat1.End
							,true,true,true,true);
						if (entry.Type!=DatEntryType.Bad)
						{
							entries.Insert(i+1,entry);
							MultiEntry mentry = entry as MultiEntry;
							if (mentry!=null)
							{
								foreach (IDatEntry sub in mentry.Data)
								{
									entries.Add(sub);
								}
							}
							i=0;
							changemade=true;
						}	
					}
				}
			}
			*/
			return changemade;
		}


		public static bool Contiguous(ResourceList entries, int sizeof_cell, int datalength)
		{
			bool gapfound=false;
			int lastend = 0;
			for (int i=0;i<entries.Count; i++)
			{
				IDatEntry entry = entries[i];

				if (entry.Start!=lastend)
				{
					gapfound=true;
					break;
				}
                				
				lastend = entry.End+1;
			}
			return ( (!gapfound) && (lastend==datalength));
		}


		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt ToInt(byte[] bytes,int length, int offset)
		{
			//int retval=0;
			ValInt retval = 0;
			//ValInt rtval = 0;
			if ( (offset+length) <=bytes.Length)
			{
				/*
				if (length == 4)
				{
					rtval =
						(
						(bytes[offset])
						|
						(bytes[offset+1]<<8)
						|
						(bytes[offset+2]<<16)
						|
						(bytes[offset+3]<<24)
						);
				}
				else if (length==8)
				{
					rtval =
						(
						(bytes[offset])
						|
						(bytes[offset+1]<<8)
						|
						(bytes[offset+2]<<16)
						|
						(bytes[offset+3]<<24)
						|
						(bytes[offset+4]<<32)
						|
						(bytes[offset+5]<<40)
						|
						(bytes[offset+6]<<48)
						|
						(bytes[offset+7]<<56)
						);
				}
				for (int i=0;i<length;i+=1)
				{
					int shift = (8*i);
					int location = offset+i;
					retval|=(bytes[location]<<shift);
				}	

				if (retval != rtval)
				{
					throw new Exception();
				}
				*/

				for (int i=0;i<length;i+=1)
				{
					retval|=(bytes[offset+i]<<(8*i));
				}	
				
			}
			
			return retval;
		}


	}


	public class DatCounters
	{
		private int strings;
		private int multi;
		private int array;
		private int variable;

		public DatCounters()
		{
			this.Reset();
		}


		public void Reset()
		{
			strings=0;
			multi=0;
			array=0;
			variable=0;
		}

		public string GetName(DatEntryType type)
		{
			string retval;
			switch (type)
			{
				case DatEntryType.String:
					retval = "str_" + this.String.ToString("D3");
					break;
				case DatEntryType.MultiArray:
					retval = "mul_" + this.Multi.ToString("D3");
					break;
				case DatEntryType.Array:
					retval = "arr_" + this.Array.ToString("D3");
					break;
				case DatEntryType.Variable:
					retval = "var_" + this.Variable.ToString("D3");
					break;
				default:
					throw new Exception("cannot allocate name for " +type.ToString() + " type");
			}
			return retval;
		}


		public int String
		{
			get
			{
				return (strings++);
			}
		}

		public int Array
		{
			get
			{

				return (array++);
			}
		}

		public int Multi
		{
			get
			{
				return (multi++);
			}
		}

		public int Variable
		{
			get
			{
				return (variable++);
			}
		}

	}


	public class DatEntryOffsetComparer : IComparer
	{
		#region IComparer Members

		public int Compare(object x, object y)
		{
			int retval = 0;
			IDatEntry dx = x as IDatEntry;
			int iy = (int)y;
			if (dx!=null)
			{
				retval = dx.Start.CompareTo(iy);
			}
			else
			{
				retval = -1;
			}
			return retval;
		}

		#endregion
	}


	public class DatEntryMultiarrayDescription : IComparable
	{
		public int offset;
		public ValInt value;
		public int bound_offset;
		public ValInt bound_value;
		public int bound_offset_2;
		public ValInt bound_value_2;
		public bool found;

		#region IComparable Members

		public int CompareTo(object obj)
		{
			int retval=0;
			DatEntryMultiarrayDescription objde = obj as DatEntryMultiarrayDescription;
			if (objde!=null)
			{
				retval = value.CompareTo(objde.value);
			}
			else
			{
				throw new ArgumentException("Object passed for comparison was not a DatEntryMultiarrayDescription instance");
			}
			// TODO:  Add DatEntryMultiarrayDescription.CompareTo implementation
			return retval;
		}

		#endregion
	}


	public class DatArrayDescription : IEnumerable,IEnumerator
	{
		private Hashtable dimensions;
		private int start;

		private int position;

		public DatArrayDescription(int start)
		{
			this.start = start;
			dimensions = new Hashtable();
		}


		public void Add(int index, int value)
		{
			if (dimensions.Contains(index))
			{
				throw new ArgumentException("index " + index.ToString() + " is already present in the ArrayDescription");
			}
			if (value<0)
			{
				throw new ArgumentException("value " + value.ToString() +" is less than 0 and cannot be added as an array dimension");
			}
			dimensions.Add(index,value);
		}


		public int Start
		{
			get
			{
				return this.start;
			}
		}
		public bool Valid
		{
			get
			{

				bool retval = true;
				for (int index=0;index<dimensions.Count;index++)
				{
					if (!dimensions.ContainsKey(index))
					{
						retval = false;
					}
				}
				return retval;
			}
		}

		public int Count
		{
			get
			{
				return dimensions.Count;
			}
		}


		public int this[int index]
		{
			get
			{
				if (dimensions.ContainsKey(index))
				{
					return (int)dimensions[index];
				}
				else
				{
					throw new ArgumentOutOfRangeException("index " +index.ToString() + " is not present withing the ArrayDescription dimensions table");
				}
			}
		}

		#region IEnumerable Members

		public IEnumerator GetEnumerator()
		{
			return this;
		}

		#endregion

		#region IEnumerator Members

		public void Reset()
		{
			position=-1;
		}

		public object Current
		{
			get
			{
				if (position>=0 && position<dimensions.Count)
				{
					return (int)dimensions[position] ;
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
			return (position<dimensions.Count);
		}


		#endregion
	}
	

	public class StringEntry : IDatEntry
	{
		private int l_start;
		private int l_length;
		private int l_end;
		private string l_data;
		private bool l_valid;
		private IDatEntry l_owner;
		private DatNameStrength namestrength;
		private DatEntryProvidence providence;
		private string l_name;
		private bool l_packed;

		// deterministic
		public StringEntry(byte[] data,int sizeof_cell, int start, int length)
		{
			l_name=null;
			char[] chars=null;
			int strlen=0;
			int charlen=0;
			// check the bounds
			if (start<0 || start>data.Length || length>data.Length || length<0 || (start+length)>data.Length)
			{
				l_valid=false;
				return;
			}

			int chrlen;
			StringDecoder dec = null;
			PackedStringDecoder pack = new PackedStringDecoder(sizeof_cell);
			PaddedStringDecoder pad = new PaddedStringDecoder(sizeof_cell);

			//chrlen = LocatePackedString(data,start,length);
			strlen = pack.GetCharCount(data,start,length);

			if (strlen>0)
			{
				dec = pack;
				pad = null;
				//dec = new PackedStringDecoder(sizeof_cell);
			}
			else
			{
				//chrlen = LocateString(data,start,length);
				strlen = pad.GetCharCount(data,start,length);
				//if (strlen!=chrlen)
				//{
				//	strlen=strlen;
				//}
				if (strlen>0)
				{
					dec = pad;
					pack = null;
					//dec = new PaddedStringDecoder(sizeof_cell);
				}
			}

			if (dec!=null)
			{
				charlen=dec.GetCharCount(data,start,length);
				if (charlen>0)
				{
					chars=new char[charlen];
					chrlen = dec.GetChars(data,start,charlen,chars,0);
					if (charlen==chrlen/*dec.GetChars(data,start,charlen,chars,0)*/)
					{
						l_data=new string(chars);
						l_length = dec.GetAlignedCharCount(chars.Length);
						l_packed=(dec is PackedStringDecoder);
					}
					else
					{
						throw new Exception("string and char lengths are not equal");
					}
				}
			}

			l_valid = (l_data!=null && l_data.Length>0);
			l_start=start;
			l_end=l_start+l_length-1;
			if (l_data!=null)
			{
				foreach (char c in l_data)
				{
					if (!char.IsLetterOrDigit(c) && !char.IsPunctuation(c) && !char.IsWhiteSpace(c) && !char.IsSymbol(c) /*&& !char.IsSeparator(c) && !char.IsControl(c)*/ )
					{
						l_valid=false;
						return;
					}
				}
			}
		}
		// optimistic
		public StringEntry(byte[] data,int sizeof_cell, int start)
		{
			l_name=null;
			char[] chars=null;
			int strlen=0;
			int charlen=0;
			// check the bounds
			l_start=start;
			if (start<0 || start>data.Length)
			{
				l_valid=false;
				return;
			}

#if newstrings
			StringDecoder dec = null;
			PackedStringDecoder pack = new PackedStringDecoder(sizeof_cell);
			PaddedStringDecoder pad = new PaddedStringDecoder(sizeof_cell);

			//strlen = LocatePackedString(data,start);
			strlen = pack.GetCharCount(data,start,data.Length);
			if (strlen>0)
			{
				dec = pack;
				pad = null;
				//dec = new PackedStringDecoder(sizeof_cell);
			}
			else
			{
				//strlen = LocateString(data,start);
				strlen = pad.GetCharCount(data,start,data.Length);
				if (strlen>0)
				{
					//dec = new PaddedStringDecoder(sizeof_cell);
					dec = pad;
					pack = null;
				}
			}

			if (dec!=null)
			{
				charlen=dec.GetCharCount(data,start,data.Length);
				if (charlen>0)
				{
					chars=new char[charlen];
					if (charlen==dec.GetChars(data,start,charlen,chars,0))
					{
						l_data=new string(chars);
						l_length = dec.GetAlignedCharCount(chars.Length);
						l_packed=(dec is PackedStringDecoder);
					}
					else
					{
						throw new Exception("string and char lengths are not equal");
					}
				}
			}
#else
			
			#region old code
			
			strlen = LocatePackedString(data,start);
			if (strlen>0)
			{
				charlen=PackedDecoder.GetCharCount(data,start,strlen);
				if (charlen>0)
				{
					chars = new char[charlen];
					if (charlen == PackedDecoder.GetChars(data,start,charlen,chars,0))
					{
						l_data=new string(chars);
						l_length=PackedDecoder.GetAlignedLength(charlen);
						l_packed=true;
					}
					else
					{
						throw new Exception("string and char lengths are not equal");
					}
				}
			}
			else
			{
				strlen = LocateString(data,start);
				if (strlen>0)
				{
					charlen=PaddedDecoder.GetCharCount(data,start,strlen);
					if (charlen>0)
					{
						chars=new char[charlen];
						if (charlen==PaddedDecoder.GetChars(data,start,charlen,chars,0))
						{
							l_data=new string(chars);
							l_length=(l_data.Length*4)+4;
							l_packed=false;
						}
						else
						{
							throw new Exception("string and char lengths are not equal");
						}
					}
				}

			}
			
			#endregion
#endif

			l_valid = (l_data!=null && l_data.Length>0);
			l_start=start;
			l_end=l_start+l_length-1;
			if (l_data!=null)
			{
				foreach (char c in l_data)
				{
					if (!char.IsLetterOrDigit(c) && !char.IsPunctuation(c) && !char.IsWhiteSpace(c) && !char.IsSymbol(c) /*&& !char.IsSeparator(c) && !char.IsControl(c)*/ )
					{
						l_valid=false;
						return;
					}
				}
			}
		}

		// empty
		/*
		public StringEntry(ref byte[] data, int start,bool allowempty)
		{

			l_name=null;
			char[] chars=null;
			int strlen=0;
			int charlen=0;
			// check the bounds
			l_start=start;
			if (start<0 || start>data.Length)
			{
				l_valid=false;
				return;
			}
			
			strlen = LocatePackedString(data,start);
			if (strlen>0)
			{
				charlen=PackedDecoder.GetCharCount(data,start,strlen);
				if (charlen>0)
				{
					chars = new char[charlen];
					if (charlen == PackedDecoder.GetChars(data,start,charlen,chars,0))
					{
						l_data=new string(chars);
						l_length=PackedDecoder.GetPackedLength(charlen);
						l_packed=true;
					}
					else
					{
						throw new Exception("string and char lengths are not equal");
					}
				}
			}
			else
			{
				strlen = LocateString(data,start);
				if (strlen>0)
				{
					charlen=PaddedDecoder.GetCharCount(data,start,strlen);
					if (charlen>0)
					{
						chars=new char[charlen];
						if (charlen==PaddedDecoder.GetChars(data,start,charlen,chars,0))
						{
							l_data=new string(chars);
							l_length=(l_data.Length*4)+4;
							l_packed=false;
						}
						else
						{
							throw new Exception("string and char lengths are not equal");
						}
					}
				}

			}
			l_valid = (l_data!=null && l_data.Length>0);
			if (l_data!=null)
			{
				foreach (char c in l_data)
				{
					if (!char.IsLetterOrDigit(c) && !char.IsPunctuation(c) && !char.IsWhiteSpace(c) && !char.IsSymbol(c) 
					//&& !char.IsSeparator(c) && !char.IsControl(c)
					)
					{
						l_valid=false;
						return;
					}
				}
			}

			// check the bounds

			
			l_name= null;
			l_start=start;
			if (start<0 || start>data.Length)
			{
				l_valid=false;
				return;
			}
			int i=0;
			bool nonascii =false;
			while ((start+i)<data.Length && data[start+i]!=0 )
			{
				nonascii = (data[start+i]<byte.MinValue || data[start+i]>byte.MaxValue);
				if (nonascii) break;
				i+=4;
			}
			if (nonascii)
			{
				l_valid=false;
				return;
			}
			byte[] l_bytes = new byte[i/4];
			for (int j=0;j<i;j+=4)
			{
				l_bytes[j/4]=data[start+j];
			}
			l_data = System.Text.ASCIIEncoding.ASCII.GetString(l_bytes);
			foreach (char c in l_data)
			{
				if (!char.IsLetterOrDigit(c) && !char.IsPunctuation(c) && !char.IsWhiteSpace(c) && !char.IsSymbol(c) 
				//&& !char.IsSeparator(c) && !char.IsControl(c)
				)
				{
					l_valid=false;
					return;
				}
			}
			if (l_data.Length!=0 || data[start]==0)
			{
				l_length=(l_data.Length*4)+4;
				l_valid=true;
			}
			else
			{
				l_valid=false;
			}
			
		}
		*/


		public string Data
		{
			get
			{
				return l_data.Replace("\n","^n");
			}
		}

		public bool Packed
		{
			get
			{
				return l_packed;
			}
		}


		#region IDatEntry Members
		public int Start
		{
			get
			{
				return l_start;
			}
		}

		public int End
		{
			get
			{
				return l_end;//l_start+l_length-1;
			}
		}

		public int Length
		{
			get
			{
				return l_length;
			}
		}

		public DatEntryType Type
		{
			get
			{
				if (l_valid)
				{
					return DatEntryType.String;
				}
				else
				{
					return DatEntryType.Bad;
				}
			}
		}

		public IDatEntry Owner
		{
			get
			{
				return l_owner;
			}
			set
			{
				l_owner= value;
			}
		}

		public  bool InArray
		{
			get
			{
				return l_owner!=null;
			}
		}

		public string Name
		{
			get
			{
				return l_name;
			}
			set
			{
				l_name = value;
			}
		}
		public bool Good
		{
			get
			{
				return this.l_valid;
			}
		}
		public DatNameStrength NameType
		{
			get
			{
				return namestrength;
			}
			set
			{
				namestrength  =value;
			}
		}
		public DatEntryProvidence Providence
		{
			get
			{
				return providence;
			}
			set
			{
				providence = value;
			}
		}
		public bool Contains(int address)
		{
			return (address>=l_start && address<= /*(l_start+l_length-1)*/ l_end);
		}
		public bool Contains(IDatEntry entry)
		{
			return (entry.Start>=l_start && entry.End<=/*(l_start+l_length-1)*/ l_end);
		}
		public bool Overlaps(IDatEntry entry)
		{
			return 
				(
				(entry.Start<this.End && entry.End>this.End)
				||
				(entry.Start>this.End && entry.End<this.End)
				);
		}

		#endregion

		#region IComparable Members

		public int CompareTo(object obj)
		{
			int retval=0;
			IDatEntry ideo = obj as IDatEntry;
			if (ideo!=null)
			{
				retval = this.Start.CompareTo(ideo.Start);
			}
			else
			{
				throw new ArgumentException();
			}
			return retval;
		}

		#endregion
	}

	public class ArrayEntry : IDatEntry
	{
		private int l_start;
		private DatNameStrength namestrength;	
		private DatEntryProvidence providence;
		private bool l_valid;
		private IDatEntry l_owner=null;
		private string l_name;
		private int cell;

		private ValInt[] l_values;
		private bool zeroedchecked;
		private bool stringchecked;
		private bool filledchecked;
		private bool zeroed;
		private bool @string;
		private bool filled;

		// deterministic
		public ArrayEntry(byte[] data,int sizeof_cell, int start, int length)
		{
			l_name=null;
			cell = sizeof_cell;
			if (start<0 || start>data.Length || length<=0 || start+length >data.Length)
			{
				l_valid=false;
				return;
			}
			l_start=start;

			//l_data = new byte[length];
			//Array.Copy(data,start,l_data,0,length);

			l_values = new ValInt[length/sizeof_cell];
			for (int i=0;i<(length/sizeof_cell);i++)
			{
				l_values[i]=(ValInt)DatHelpers.ToInt(data,sizeof_cell,start+(i*sizeof_cell));
			}

			//l_length=length;
			l_valid=true;
			zeroedchecked=false;
			stringchecked=false;
			filledchecked=false;
			zeroed=false;
			@string=false;
			filled=false;


		}
		// optimistic
		public ArrayEntry(byte[] data,int sizeof_cell, int start)
		{
			l_values = new ValInt[0];
		}


		public bool IsString()
		{
			if (!stringchecked)
			{
				@string = (l_values[l_values.Length-cell]==0) ;
				if (@string)
				{
					for (int i=0;i<l_values.Length-cell;i+=cell)
					{
						@string = (l_values[i]!=0 && ( l_values[i]<byte.MinValue || l_values[i]>byte.MaxValue ) );
						if (@string)
						{
							char c = Convert.ToChar(l_values[i]);
							if (!char.IsLetterOrDigit(c) && !char.IsPunctuation(c) && !char.IsWhiteSpace(c) && !char.IsSymbol(c) /*&& !char.IsSeparator(c) && !char.IsControl(c)*/ )
							{
								@string=false;
							}
						}
						if (!@string) break;
					}
				}
				stringchecked=true;
			}
			return @string;;
		}

		public bool IsZeroed()
		{
			if (!zeroedchecked)
			{
				if (!filledchecked)
				{
					this.IsHomegenous();
				}
				if (filled && l_values.Length>0)
				{
					zeroed = l_values[0].Equals( ( (ValueType) 0 ) );
				}
				else
				{
					zeroed=false;
				}
				zeroedchecked=true;
			}
			return zeroed;
		}

		public bool IsHomegenous()
		{
			if (!filledchecked)
			{
				//ValueType val;
				//ValueType newval;
				//
				//val = DatHelpers.ToInt(l_data,4,0);
				//for (int i=4;i<l_data.Length;i+=4)
				//{
				//	newval = (ValueType)DatHelpers.ToInt(l_data,4,i);
				//	if (!val.Equals(newval))
				//	{
				//		filled=false;
				//		break;
				//	}
				//	filled=true;
				//}

				for (int i=0;i<l_values.Length-1;i++)
				{
					if (!l_values[i].Equals(l_values[i+1]))
					{
						filled=false;
						break;
					}
					filled=true;
				}

				filledchecked=true;
			}
			return filled;
		}


		public ValInt FillValue
		{
			get
			{
				ValInt retval;
				if (!filledchecked)
				{
					this.IsHomegenous();
				}
				if (filled)
				{
					//retval = (ValueType)DatHelpers.ToInt(l_data,4,0);
					retval = l_values[0];
				}
				else
				{
					throw new Exception("the array is not homogenous");
				}
				return retval;
				
			}
		}

		public ValInt[] Values
		{
			get
			{
				return l_values;
			}
		}


		#region IDatEntry Members
		public int Start
		{
			get
			{
				return l_start;
			}
		}

		public int End
		{
			get
			{
				//return l_start+l_length-1;
				return l_start+(l_values.Length*cell)-1;
			}
		}

		public int Length
		{
			get
			{
				return l_values.Length;
			}
		}

		public DatEntryType Type
		{
			get
			{
				if (l_valid)
				{
					return DatEntryType.Array;
				}
				else
				{
					return DatEntryType.Bad;
				}
			}
		}

		public  bool InArray
		{
			get
			{
				return l_owner!=null;
			}
		}

		public string Name
		{
			get
			{
				return l_name;
			}
			set
			{
				l_name=  value;
			}
		}
		public bool Good
		{
			get
			{
				return this.l_valid;
			}
		}
		public DatNameStrength NameType
		{
			get
			{
				return namestrength;
			}
			set
			{
				namestrength  =value;
			}
		}
		public DatEntryProvidence Providence
		{
			get
			{
				return providence;
			}
			set
			{
				providence = value;
			}
		}
		public bool Contains(int address)
		{
			//return (address>=l_start && address<= (l_start+l_length-1));
			return (address>=l_start && address<= this.End);
		}
		public bool Contains(IDatEntry entry)
		{
			//return (entry.Start>=l_start && entry.End<=(l_start+l_length-1));
			return (entry.Start>=l_start && entry.End<=this.End);
		}
		public bool Overlaps(IDatEntry entry)
		{
			return 
				(
				(entry.Start<this.End && entry.End>this.End)
				||
				(entry.Start>this.End && entry.End<this.End)
				);
		}

		public IDatEntry Owner
		{
			get
			{
				return l_owner;
			}
			set
			{
				l_owner= value;
			}
		}

		#endregion			

		#region IComparable Members

		public int CompareTo(object obj)
		{
			int retval=0;
			IDatEntry ideo = obj as IDatEntry;
			if (ideo!=null)
			{
				retval = this.Start.CompareTo(ideo.Start);
			}
			else
			{
				throw new ArgumentException();
			}
			return retval;
		}

		#endregion
	}

	public class MultiEntry : IDatEntry
	{
		private int l_start;
		private int l_length;
		private DatNameStrength namestrength;
		private DatEntryProvidence providence;
		private int l_constant;
		private IDatEntry[] l_data;
		private bool l_valid;
		private IDatEntry l_owner;
		private string l_name;

		public MultiEntry(byte[] data,int sizeof_cell, int start, int bound1, int bound2)
		{
			l_name=null;
			if (start<0 || start>data.Length  || bound1<2 || bound2<2 || (start+(sizeof_cell*bound1)+(sizeof_cell*bound1*bound2))>data.Length)
			{
				l_valid=false;
				return;
			}

			bool increasing=true;
			int factor=0;
			int[,] index = new int[bound1,2];

			#region index parser code
/*
			for (int i=0;i<bound1;i++)
			{
				index[i,0]= start+( sizeof_cell * i );  // the address of this entry
				index[i,1]= DatHelpers.ToInt(data,sizeof_cell,index[i,0]); // number of bytes in which the entry starts
				switch (i)
				{
					case 0: // first read, no comparisons can be made yet
						break;
					case 1: // set up the present values
						factor = (index[i,1] + sizeof_cell) - index[i-1,1];
						increasing = ((index[i,1] + sizeof_cell)>=index[i-1,1]);
						break;
					default: // test to see if things are staying withing the pattern
						if (factor!=-1)  // is the difference between addresses constant?
						{
							int tempfactor = ((index[i,1] + sizeof_cell) - index[i-1,1]);
							if (tempfactor!=factor)
							{
								factor=-1;
							}
						}
						if (increasing) // is the pointed to value allways greater than the last one?
						{
							increasing = ((index[i,1] + sizeof_cell)>=index[i-1,1]);
						}
						break;
				}
			}
			*/
			#endregion

			indexparser(data,sizeof_cell,start,bound1,out increasing,out factor,out index);

			// the value of the first element should be the same as the 
			// address of the cell following the last entry in the table index.
			if ( 
				(start+index[0,1])
				==
				(index[index.GetLength(0)-1,0]+sizeof_cell)
				&& increasing
				&& factor==bound2
				)
			{
				l_data = new IDatEntry[index.GetLength(0)];
			}

			if (l_data!=null)
			{
				if (factor!=-1)
				{
					l_constant=factor/sizeof_cell;
				}
				else
				{
					l_constant=-1;
				}
				l_start=start;
				l_length=l_data[l_data.Length-1].End-(l_start-1);
				if ( (l_start%sizeof_cell)!=0 || (l_length%sizeof_cell)!=0 )
				{
					throw new Exception("alignment error");
				}
				l_valid=true;
			}
			else
			{
				l_valid=false;
			}
		}


		public MultiEntry(byte[] data,int sizeof_cell, int start, int bound)
		{
			l_name=null;
			if (start<0 || start>data.Length  || bound<2 || (start+(sizeof_cell*bound))>data.Length)
			{
				l_valid=false;
				return;
			}

			bool increasing=true;
			int factor=0;
			int[,] index = new int[bound,2];

			indexparser(data,sizeof_cell,start,bound, out increasing, out factor, out index);

			#region index parser code

/*
			for (int i=0;i<bound;i++)
			{
				index[i,0]= start+( sizeof_cell * i );  // the address of this entry
				index[i,1]= DatHelpers.ToInt(data,sizeof_cell,index[i,0]); // number of bytes in which the entry starts
				switch (i)
				{
					case 0: // first read, no comparisons can be made yet
						break;
					case 1: // set up the present values
						factor = (index[i,1] + sizeof_cell) - index[i-1,1];
						increasing = ( (index[i,1] + sizeof_cell )>=index[i-1,1]);
						break;
					default: // test to see if things are staying within the pattern
						if (factor!=-1)  // is the difference between addresses constant?
						{
							int tempfactor = ( (index[i,1] + sizeof_cell) - index[i-1,1]);
							if (tempfactor!=factor)
							{
								factor=-1;
							}
						}
						if (increasing) // is the pointed to value allways greater than the last one?
						{
							increasing = ((index[i,1] + sizeof_cell)>=index[i-1,1]);
						}
						break;
				}
			}
			*/
			#endregion

			// the value of the first element should be the same as the 
			// address of the cell following the last entry in the table index.
			
			if ( 
				(start+index[0,1])
				==
				(index[index.GetLength(0)-1,0]+sizeof_cell)
				&&
				increasing
				)
			{
				l_data = new IDatEntry[index.GetLength(0)];
				IDatEntry entry;
				if (factor==-1)
				{
					#region non-constant array members
					// a multidimensional array index with bounds elements of varying lengths
					for (int i=0;i<index.GetLength(0);i++)
					{
						if (i<index.GetLength(0)-1)  // the entries in the array
						{
							entry = DatHelpers.CreateDatEntry(
								data,
								sizeof_cell,
								(index[i,0]+index[i,1]),
								((index[i+1,0]+index[i+1,1])-(index[i,0]+index[i,1])),
								false,true,true,true
								);
							if (entry.Type!=DatEntryType.Bad)
							{
								entry.Owner=this;
								l_data[i]=entry;
							}
							else
							{
								l_data=null;
								break;
							}
							#region standard code 
							/*
							entry = new StringEntry(
									data,
									sizeof_cell,
									(index[i,0]+index[i,1]),
									((index[i+1,0]+index[i+1,1])-(index[i,0]+index[i,1]))
								);
							if (entry.Type==DatEntryType.Bad)
							{
								entry = new ArrayEntry(
										data,
										sizeof_cell,
										(index[i,0]+index[i,1]),
										((index[i+1,0]+index[i+1,1])-(index[i,0]+index[i,1]))
									);
								if (entry.Type==DatEntryType.Bad || entry.Length==ucell)
								{
									entry = new VariableEntry( 
											data,
											sizeof_cell,
											(index[i,0]+index[i,1])
										);
								}
							}
							if (entry.Type!=DatEntryType.Bad)
							{
								entry.Owner=this;
								l_data[i]=entry;
							}
							else
							{
								l_data=null;
								break;
							}
							*/
							#endregion
						}
						else // the final entry, length is unknown
						{
							entry = DatHelpers.CreateDatEntry(
								data,
								sizeof_cell,
								(index[i,0]+index[i,1]),
								false,true,true,true
								);
							if (entry.Type!=DatEntryType.Bad)
							{
								entry.Owner=this;
								l_data[i]=entry;
							}
							else
							{
								l_data=null;
								break;
							}
							#region standard code
							/*
							entry = new StringEntry(
								data,
								sizeof_cell,
								(index[i,0]+index[i,1])
								);
							if (entry.Type==DatEntryType.Bad)
							{
								entry = new ArrayEntry(
									data,
									sizeof_cell,
									(index[i,0]+index[i,1])
									);
								if (entry.Type==DatEntryType.Bad || entry.Length==sizeof_cell)
								{
									entry = new VariableEntry( 
										data,
										sizeof_cell,
										(index[i,0]+index[i,1])
										);
								}
							}
							if (entry.Type!=DatEntryType.Bad)
							{
								entry.Owner=this;
								l_data[i]=entry;
							}
							*/
							#endregion

						}						
					}
					#endregion
				}
				else if ( (factor%sizeof_cell)==0)
				{
					#region constant array members
					// a multidimensional array index with bounds elements of constant length
					if (factor>sizeof_cell)
					{
						for (int i=0;i<index.GetLength(0);i++)
						{

							entry = DatHelpers.CreateDatEntry(
								data,
								sizeof_cell,
								(index[i,0]+index[i,1]),
								factor,
								true,true,true,true);
							if (entry.Type!=DatEntryType.Bad)
							{
								entry.Owner=this;
								l_data[i]=entry;
							}
							else
							{
								l_data=null;
								break;
							}

							#region standard code
							/*
							entry = new StringEntry( 
								data,
								sizeof_cell,
								(index[i,0]+index[i,1]),
								factor
								);
							if (entry.Type==DatEntryType.Bad)
							{
								entry = new ArrayEntry(	
									data,
									sizeof_cell,
									(index[i,0]+index[i,1]),
									factor
									);
								if (entry.Type==DatEntryType.Bad || entry.Length==ucell)
								{
									entry = new VariableEntry(
										data,
										sizeof_cell,
										(index[i,0]+index[i,1])
										);
								}
							}
							if (entry.Type!=DatEntryType.Bad)
							{
								entry.Owner=this;
								l_data[i]=entry;
							}
							*/
							#endregion
						}
					}
					else
					{
						for (int i=0;i<index.GetLength(0);i++)
						{
							entry = new StringEntry(
								data,
								sizeof_cell,
								(index[i,0]+index[i,1]),
								factor
								);
							if (entry.Type==DatEntryType.Bad)
							{
								entry = new VariableEntry(
									data,
									sizeof_cell,
									(index[i,0]+index[i,1])
									);
							}
							if (entry.Type!=DatEntryType.Bad)
							{
								entry.Owner=this;
								l_data[i]=entry;
							}
						}

					}
					#endregion
				}
				else
				{
					l_data=null;
				}
			}

			#region validity checks
			if (l_data!=null)
			{
				if (factor!=-1)
				{
					l_constant=factor/sizeof_cell;
				}
				else
				{
					l_constant=-1;
				}
				l_start=start;
				l_length=l_data[l_data.Length-1].End-(l_start-1);
				if ( (l_start%sizeof_cell)!=0 || (l_length%sizeof_cell)!=0 )
				{
					//throw new Exception("alignment error");
					l_valid=false;
				}
				else
				{
					l_valid=true;
				}
			}
			else
			{
				l_valid=false;
			}
			#endregion

		}

		
		public MultiEntry(byte[] data,int sizeof_cell,DatEntryMultiarrayDescription desc,bool sheep)// : this(ref data, desc.value, desc.bound_value_2>0 ? desc.bound_value_2 : desc.bound_value)
		{
				
		}

		public MultiEntry(byte[] data,int sizeof_cell, int start) : this(data,sizeof_cell,start,DatHelpers.ToInt(data,sizeof_cell,start)/sizeof_cell)
		{
					
		}


		private MultiEntry(int start,IDatEntry[] values)
		{
			l_data=values;
			l_start=start;
			l_valid=true;
		}


		public static MultiEntry CreateFromDescription(byte[] data,int sizeof_cell,DatEntryMultiarrayDescription desc)
		{
			//this(ref data, desc.value, desc.bound_value_2>0 ? desc.bound_value_2 : desc.bound_value)
			
			IDatEntry entry;
			// try using both;
			entry = new MultiEntry(data,sizeof_cell,desc.value,desc.bound_value_2,desc.bound_value);
			if (entry.Type==DatEntryType.Bad)
			{
				// now try the first
				entry = new MultiEntry(data,sizeof_cell,desc.value,desc.bound_value);
			}
			if (entry.Type==DatEntryType.Bad)
			{
				// now try the second
				entry = new MultiEntry(data,sizeof_cell,desc.value,desc.bound_value_2);
			}
			return (entry as MultiEntry);
		}


		public void indexparser(byte[] data, int sizeof_cell, int start, int bound,out bool increasing, out int factor, out int[,] index)
		{
			increasing=true;
			factor=0;
			index = new int[bound,2];
			for (int i=0;i<bound;i++)
			{
				index[i,0]= start+( sizeof_cell * i );  // the address of this entry
				index[i,1]= DatHelpers.ToInt(data,sizeof_cell,index[i,0]); // number of bytes in which the entry starts
				switch (i)
				{
					default: // test to see if things are staying within the pattern
						if (factor!=-1)  // is the difference between addresses constant?
						{
							int tempfactor = ( (index[i,1] + sizeof_cell) - index[i-1,1]);
							if (tempfactor!=factor)
							{
								factor=-1;
							}
						}
						if (increasing) // is the pointed to value allways greater than the last one?
						{
							increasing = ((index[i,1] + sizeof_cell)>=index[i-1,1]);
						}
						break;
					case 0: // first read, no comparisons can be made yet
						break;
					case 1: // set up the present values
						factor = (index[i,1] + sizeof_cell) - index[i-1,1];
						increasing = ( (index[i,1] + sizeof_cell )>=index[i-1,1]);
						break;
				}
			}
		}


		public int Bounds
		{
			get
			{
				int retval = 1;
				MultiEntry child = this;
				while (child!=null && child.Length>0)
				{
					retval+=1;
					if (child[0] is MultiEntry)
					{
						child=child[0] as MultiEntry;
					}
					else
					{
						child=null;
					}
				}
				return retval;
			}
		}
		public int GetBound(int bound)
		{
			int retval =0;
			int i=0;
			bool last =false;
			MultiEntry child = this;
			for ( ;i<bound;i++)
			{
				if (i==(bound-1))
				{
					last=true;
				}
				else if (child.l_data!=null && child.l_data.Length>0)
				{
					child = child[0] as MultiEntry;
				}
			}
			if (child!=null)
			{
				if (last && i==bound)
				{
					if(child.l_constant>=0)
					{
						retval = child[0].Length;
					}
					else
					{
						retval = 0;  // variable length children end up here
					}
				}
				else
				{
					retval = child.Data.Length;
				}
			}
			else
			{
				throw new ArgumentException("cannot get bounds");
			}
			return retval;
		}


		public int FirstBound
		{
			get
			{
				return l_data.Length;
			}
		}
		public int LastBound
		{
			get
			{
				return l_constant;
			}
		}

		public IDatEntry[] Data
		{
			get
			{
				return l_data;
			}
		}

		private IDatEntry this[int value]
		{
			get
			{
				IDatEntry retval = null;
				if (value>=0 && value<l_data.Length)
				{
					retval = l_data[value];
				}
				return retval;
			}
		}


		public bool IsHomegenous
		{
			get
			{
				bool retval = true;
				if (l_data!=null && l_data.Length>0)
				{
					DatEntryType type = l_data[0].Type;
					for (int i=1;i<l_data.Length;i++)
					{
						if (type != l_data[i].Type)
						{
							retval = false;
							break;
						}
					}
				}
				return retval;
			}
		}

		public DatEntryType LeastComplexity
		{
			get
			{
				DatEntryType retval = DatEntryType.Unknown;
				if (l_data!=null && l_data.Length>0)
				{
					DatEntryType type = l_data[0].Type;
					for (int i=1;i<l_data.Length;i++)
					{
						if (type < l_data[i].Type)
						{
							retval = l_data[i].Type;
						}
					}
				}
				return retval;
			}
		}

		public DatEntryType GreatestComplexity
		{
			get
			{
				DatEntryType retval = DatEntryType.Unknown;
				if (l_data!=null && l_data.Length>0)
				{
					DatEntryType type = l_data[0].Type;
					for (int i=1;i<l_data.Length;i++)
					{
						if (type > l_data[i].Type)
						{
							retval = l_data[i].Type;
						}
					}
				}
				return retval;
			}
		}


		#region IDatEntry Members
		public int Start
		{
			get
			{
				return l_start;
			}
		}

		public int End
		{
			get
			{
				return l_start+l_length-1;
			}
		}

		public int Length
		{
			get
			{
				return l_length;
			}
		}

		public DatEntryType Type
		{
			get
			{
				if (l_valid)
				{
					return DatEntryType.MultiArray;
				}
				else
				{
					return DatEntryType.Bad;
				}
			}
		}

		public IDatEntry Owner
		{
			get
			{
				return l_owner;
			}
			set
			{
				l_owner= value;
			}
		}

		public  bool InArray
		{
			get
			{
				return l_owner!=null;
			}
		}

		public string Name
		{
			get
			{
				return l_name;
			}
			set
			{
				l_name=value;
			}
		}
		public bool Good
		{
			get
			{
				return this.l_valid;
			}
		}
		public DatNameStrength NameType
		{
			get
			{
				return namestrength;
			}
			set
			{
				namestrength  =value;
			}
		}
		public DatEntryProvidence Providence
		{
			get
			{
				return providence;
			}
			set
			{
				providence = value;
			}
		}
		public bool Contains(int address)
		{
			return (address>=l_start && address<= (l_start+l_length-1));
		}
		public bool Contains(IDatEntry entry)
		{
			return (entry.Start>=l_start && entry.End<=(l_start+l_length-1));
		}
		public bool Overlaps(IDatEntry entry)
		{
			return 
				(
				(entry.Start<this.End && entry.End>this.End)
				||
				(entry.Start>this.End && entry.End<this.End)
				);
		}

		#endregion

		#region IComparable Members

		public int CompareTo(object obj)
		{
			int retval=0;
			IDatEntry ideo = obj as IDatEntry;
			if (ideo!=null)
			{
				retval = this.Start.CompareTo(ideo.Start);
			}
			else
			{
				throw new ArgumentException();
			}
			return retval;
		}

		#endregion
	}

	public class VariableEntry : IDatEntry
	{
		private int cell;
		private int l_start;
		private DatNameStrength namestrength;
		private DatEntryProvidence providence;
		private byte[] l_data;
		private bool l_valid;
		private IDatEntry l_owner=null;
		private string l_name;

		public VariableEntry(byte[] data,int sizeof_cell, int start)
		{
			l_name=null;
			if (start<0 || start>data.Length || start+sizeof_cell >data.Length)
			{
				l_valid=false;
				return;
			}
			l_start=start;
			l_data = new byte[sizeof_cell];
			Array.Copy(data,start,l_data,0,sizeof_cell);
			cell = sizeof_cell;
			l_valid=true;
		}


		public ValInt Value
		{
			get
			{
				return DatHelpers.ToInt(l_data,cell,0);
			}
		}

		public bool IsZeroed()
		{
			bool retval = true;
			foreach(byte b in l_data)
			{
				if (b!=0) 
				{
					retval = false;
					break;
				}
			}
			return retval;
		}


		#region IDatEntry Members
		public int Start
		{
			get
			{
				return l_start;
			}
		}

		public int End
		{
			get
			{
				return l_start+cell-1;
			}
		}

		public int Length
		{
			get
			{
				return cell;
			}
		}

		public DatEntryType Type
		{
			get
			{
				if (l_valid)
				{
					return DatEntryType.Variable;
				}
				else
				{
					return DatEntryType.Bad;
				}
			}
		}

		public IDatEntry Owner
		{
			get
			{
				return l_owner;
			}
			set
			{
				l_owner= value;
			}
		}

		public  bool InArray
		{
			get
			{
				return l_owner!=null;
			}
		}

		public string Name
		{
			get
			{
				return l_name;
			}
			set
			{
				l_name = value;
			}
		}

		public bool Good
		{
			get
			{
				return this.l_valid;
			}
		}
		public DatNameStrength NameType
		{
			get
			{
				return namestrength;
			}
			set
			{
				namestrength  =value;
			}
		}
		public DatEntryProvidence Providence
		{
			get
			{
				return providence;
			}
			set
			{
				providence = value;
			}
		}
		public bool Contains(int address)
		{
			return (address>=l_start && address<= (l_start+cell-1));
		}
		public bool Contains(IDatEntry entry)
		{
			return (entry.Start>=l_start && entry.End<=(l_start+cell-1));
		}
		public bool Overlaps(IDatEntry entry)
		{
			return 
				(
				(entry.Start<this.End && entry.End>this.End)
				||
				(entry.Start>this.End && entry.End<this.End)
				);
		}

		#endregion

		#region IComparable Members

		public int CompareTo(object obj)
		{
			int retval=0;
			IDatEntry ideo = obj as IDatEntry;
			if (ideo!=null)
			{
				retval = this.Start.CompareTo(ideo.Start);
			}
			else
			{
				throw new ArgumentException();
			}
			return retval;
		}

		#endregion
	}

	public class BadEntry : IDatEntry
	{
		private static BadEntry singleton;

		#region IDatEntry Members

		public int Start
		{
			get
			{
				// TODO:  Add BadEntry.Start getter implementation
				return 0;
			}
		}

		public int End
		{
			get
			{
				// TODO:  Add BadEntry.End getter implementation
				return 0;
			}
		}

		public int Length
		{
			get
			{
				// TODO:  Add BadEntry.Length getter implementation
				return 0;
			}
		}

		public Amx.Dat.DatEntryType Type
		{
			get
			{
				// TODO:  Add BadEntry.Type getter implementation
				return DatEntryType.Bad;
			}
		}

		public IDatEntry Owner
		{
			get
			{
				// TODO:  Add BadEntry.Owner getter implementation
				return null;
			}
			set
			{
				// TODO:  Add BadEntry.Owner setter implementation
			}
		}

		public bool InArray
		{
			get
			{
				// TODO:  Add BadEntry.InArray getter implementation
				return false;
			}
		}

		public string Name
		{
			get
			{
				// TODO:  Add BadEntry.Name getter implementation
				return null;
			}
			set
			{
				// TODO:  Add BadEntry.Name setter implementation
			}
		}

		public bool Good
		{
			get
			{
				return false;
			}
		}
		public DatNameStrength NameType
		{
			get
			{
				// TODO:  Add BadEntry.NameType getter implementation
				return DatNameStrength.Runtime;
			}
			set
			{
				// TODO:  Add BadEntry.NameType setter implementation
			}
		}

		public DatEntryProvidence Providence
		{
			get
			{
				return DatEntryProvidence.Detected;
			}
		}
		public bool Contains(int address)
		{
			return false;
		}

		public bool Contains(IDatEntry entry)
		{
			// TODO:  Add BadEntry.Amx.Dat.IDatEntry.Contains implementation
			return false;
		}

		public bool Overlaps(IDatEntry entry)
		{
			// TODO:  Add BadEntry.Overlaps implementation
			return false;
		}

		#endregion

		#region IComparable Members

		public int CompareTo(object obj)
		{
			return -1;
		}

		#endregion

		public static BadEntry Empty
		{
			get
			{
				if (BadEntry.singleton==null)
				{
					BadEntry.singleton=new BadEntry();
				}
				return BadEntry.singleton;
			}
		}
	}



	public struct ResourceEntry : IComparable
	{
		public ValInt Key;
		public IDatEntry Value;

		public ResourceEntry(ValInt key, IDatEntry value)
		{
			this.Key =key;
			this.Value=value;
		}


		#region IComparable Members

		public int CompareTo(object obj)
		{
			int retval =0;
			if ( obj is ResourceEntry )
			{
				retval =  this.Key.CompareTo(((ResourceEntry)obj).Key);
				if (retval == 0)
				{
					retval = this.Value.CompareTo( ((ResourceEntry)obj).Value );
				}
			}
			else if (obj is ValInt)
			{
				retval = this.Key.CompareTo( (ValInt)obj );
			}
			else
			{
				throw new ArgumentException();
			}
			return retval;
		}

		#endregion
	}


	public class ResourceList : IEnumerable
	{
		private class ResourceEntryKeyComparer : IComparer
		{
			#region IComparer Members

			public int Compare(object x, object y)
			{
				int retval = 0;
				
				if (x is ResourceEntry && y is ResourceEntry)
				{
					ResourceEntry rex = (ResourceEntry)x;
					ResourceEntry rey = (ResourceEntry)y;
                    retval = rex.Key.CompareTo(rey.Key);
				}
				else
				{
					throw new ArgumentException();
				}

				return retval;
			}

			#endregion
		}

		private class ResourceEntryValueComparer : IComparer
		{
			#region IComparer Members

			public int Compare(object x, object y)
			{
				int retval = 0;
				
				if (x is ResourceEntry && y is ResourceEntry)
				{
					ResourceEntry rex = (ResourceEntry)x;
					ResourceEntry rey = (ResourceEntry)y;
					retval = rex.Value.CompareTo(rey.Value);
				}
				else
				{
					throw new ArgumentException();
				}

				return retval;
			}

			#endregion
		}


		private class ResourceEntryKeyValIntComparer : IComparer
		{
			#region IComparer Members

			public int Compare(object x, object y)
			{
				int retval = 0;
				
				if (x is ResourceEntry && y is ValInt)
				{
					ResourceEntry rex = (ResourceEntry)x;
					ValInt vy = (ValInt)y;
					retval = rex.Key.CompareTo(vy);
				}
				else
				{
					throw new ArgumentException();
				}

				return retval;
			}

			#endregion
		}

		private class ResourceEntryDatValueComparer : IComparer
		{
			#region IComparer Members

			public int Compare(object x, object y)
			{
				int retval = 0;
				
				if (x is ResourceEntry && y is IDatEntry)
				{
					ResourceEntry rex = (ResourceEntry)x;
					IDatEntry rey = y as IDatEntry;
					retval = rex.Value.CompareTo(rey);
				}
				else
				{
					throw new ArgumentException();
				}

				return retval;
			}

			#endregion
		}

		

		private ArrayList bykey;
		private ArrayList byval;

		private ResourceEntryKeyComparer keykey;
		private ResourceEntryKeyValIntComparer valintkey;
		private ResourceEntryValueComparer valval;
		private ResourceEntryDatValueComparer datval;

		//private bool unique;

		public ResourceList():this(10){}
		public ResourceList(int capacity)
		{
			bykey= new ArrayList(capacity);
			byval = new ArrayList(capacity);

			keykey = new ResourceEntryKeyComparer();
			valval = new ResourceEntryValueComparer();
			valintkey = new ResourceEntryKeyValIntComparer();
			datval = new ResourceEntryDatValueComparer();

			//unique = true;
		}



		public void Add(IDatEntry entry)
		{
			ResourceEntry res = new ResourceEntry(entry.Start,entry);
			AddKey(res);
			AddValue(res);
		}


		public void Clear()
		{
			lock (this)
			{
				bykey.Clear();
				byval.Clear();
			}
		}


		public void Remove(IDatEntry entry)
		{
			int index = byval.BinarySearch(entry,datval);
			if (index>=0)
			{
				object rem = byval[index];
				byval.RemoveAt(index);
				bykey.Remove(rem);
			}
		}


		//public void Sort()
		//{
		//}


		public void Insert(int i, IDatEntry entry)
		{
			this.Add(entry);
		}


		public IDatEntry this[int index]
		{
			get
			{
				return ( (ResourceEntry)bykey[index]).Value as IDatEntry;
			}
		}


		public int Count
		{
			get
			{
				return bykey.Count;
			}
		}


		public IDatEntry ValueFromKey(ValInt key)
		{
			IDatEntry retval = null;
			int index = bykey.BinarySearch(key,valintkey);
			if (index>=0)
			{
				retval =   (  (ResourceEntry)bykey[index] ).Value as IDatEntry;
			}
			return retval;
		}

		public bool ContainsKey(ValInt key)
		{
			return (bykey.BinarySearch(key,valintkey) >=0);
		}


		public IDatEntry FromStart(ValInt key)
		{
			return ValueFromKey(key);
		}
		
		public bool ContainsEntryAt(ValInt key)
		{
			return ContainsKey(key);
		}
		


		private void AddKey(ResourceEntry res)
		{
			int index = bykey.BinarySearch(res,keykey);
			if (index >=0)
			{
				//unique=false;
				bykey.Insert(index,res);
			}
			else
			{
				index = ~index;
				bykey.Insert(index,res);
			}
		}

		private void AddValue(ResourceEntry res)
		{
			int index = byval.BinarySearch(res,valval);
			if (index >=0)
			{
				byval.Insert(index,res);
			}
			else
			{
				index = ~index;
				byval.Insert(index,res);
			}
		}


		private void RemoveKey(ResourceEntry res)
		{
			int index = bykey.BinarySearch(res.Key,keykey);
			if (index >=0)
			{
				bykey.RemoveAt(index);
			}
		}
		private void RemoveValue(ResourceEntry res)
		{
			int index = byval.BinarySearch(res.Value,valval);
			if (index >=0)
			{
				byval.RemoveAt(index);
			}
		}


		public IDictionaryEnumerator GetResourceEntryEnumerator()
		{
			return null;
		}

		public IEnumerator GetKeyEnumerator()
		{
			return null;
		}
		public IEnumerator GetValueEnumerator()
		{
			return new ResourceListValueEnumerator(byval);;
		}


		#region IEnumerable Members

		public IEnumerator GetEnumerator()
		{
			return this.GetValueEnumerator();
		}

		#endregion
	}


	public class ResourceListValueEnumerator : IEnumerator
	{
		private ResourceEntry[] items;
		private int position;

		public ResourceListValueEnumerator(ArrayList list)
		{
			items = new ResourceEntry[list.Count];
			list.CopyTo(0,items,0,list.Count);
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
				if (position>=0 && position<items.Length)
				{
					return ((ResourceEntry)items[position]).Value;
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
			return (position<items.Length);
		}

		#endregion


	}

	public class ResourceKeyValueEnumerator : IEnumerator
	{
		private ResourceEntry[] items;
		private int position;

		public ResourceKeyValueEnumerator(ArrayList list)
		{
			items = new ResourceEntry[list.Count];
			list.CopyTo(0,items,0,list.Count);
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
				if (position>=0 && position<items.Length)
				{
					return ((ResourceEntry)items[position]).Key;
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
			return (position<items.Length);
		}

		#endregion


	}

	public class ResourceEntryEnumerator : IDictionaryEnumerator
	{

		private ResourceEntry[] items;
		private int position;

		public ResourceEntryEnumerator(ArrayList list)
		{
			items = new ResourceEntry[list.Count];
			list.CopyTo(0,items,0,list.Count);
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
				if (position>=0 && position<items.Length)
				{
					return ((ResourceEntry)items[position]).Key;
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
			return (position<items.Length);
		}

		#endregion

		#region IDictionaryEnumerator Members

		public object Key
		{
			get
			{
				if (position>=0 && position<items.Length)
				{
					return ((ResourceEntry)items[position]).Key;
				}
				else
				{
					throw new InvalidOperationException("enumerator position is not valid");
				}
			}
		}

		public object Value
		{
			get
			{
				if (position>=0 && position<items.Length)
				{
					return ((ResourceEntry)items[position]).Value;
				}
				else
				{
					throw new InvalidOperationException("enumerator position is not valid");
				}
			}
		}

		public DictionaryEntry Entry
		{
			get
			{
				if (position>=0 && position<items.Length)
				{
					return new DictionaryEntry(
						((ResourceEntry)items[position]).Key,
						((ResourceEntry)items[position]).Value
						);
				}
				else
				{
					throw new InvalidOperationException("enumerator position is not valid");
				}
			}
		}

		#endregion


	}

}
