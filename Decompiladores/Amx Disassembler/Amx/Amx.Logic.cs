using System;

namespace Amx.Logic
{
	using System.Collections;

	namespace Jumps
	{
		using Amx.Core;
		using Amx.Logic.Labels;

		public class Counters
		{
			private int casetbl;
			private int @switch;
			private int jump;

			public Counters()
			{
				this.Reset();
			}


			public void Reset()
			{
				casetbl=0;
				@switch=0;
				jump=0;
			}


			public int Jump
			{
				get
				{
					return (jump++);
				}
			}

			public int Switch
			{
				get
				{

					return (@switch++);
				}
			}

			public int Casetbl
			{
				get
				{
					return (casetbl++);
				}
			}

		
		}


		public struct CaseTriplet
		{
			public ValInt Position;
			public ValInt Value;
			public ValInt Target;

			public CaseTriplet(ValInt position, ValInt value, ValInt target)
			{
				this.Position=position;
				this.Value=value;
				this.Target=target;
			}

		}


		public abstract class AJump
		{
			protected ValInt position;
			protected bool absolute;
			protected Label label;

			public virtual string Name
			{
				get
				{
					return label.Name;
				}
				set
				{
					if (value!=label.Name)
					{
						label.Name = value;
					}
				}
			}

			public virtual ValInt Position
			{
				get
				{
					return position;
				}
			}

			public virtual ValInt Target
			{
				get
				{
					return label.Position;
				}
			}

			public virtual bool Absolute
			{
				get
				{
					return absolute;
				}
			}
			public virtual Label Label
			{
				get
				{
					return label;
				}
				set
				{
					label = value;
				}
			}
		}

		public class Switch : AJump
		{
			//public Switch(int position, int target) : this(position, target,Counters.Switch){}
			public Switch(ValInt position, ValInt target, int labelnumber)
			{
				this.position=position;
				this.absolute=false;
				this.label= new Label("switch_"+ labelnumber.ToString("D2"),target);
			}

		}

		public class Casetbl : AJump
		{
			int casenumber;
			ValInt cases;

			//public Casetbl(int position, int @default, int cases) : this(position,@default,cases,Counters.Casetbl){}
			public Casetbl(ValInt position, ValInt @default, ValInt cases, int labelnumber)
			{
				casenumber=labelnumber;
				this.cases = cases;
				this.position=position;
				this.label=new Label("casetble_"+labelnumber.ToString("D2"),@default);
			}


			public int TableNumber
			{
				get
				{
					return casenumber;
				}
			}
			public ValInt Cases
			{
				get
				{
					return cases;
				}
			}
		}

		public class Case : AJump
		{
			private ValInt value;

			public Case(CaseTriplet triplet, int labelrootnum, int labelnumber)
			{
				this.position=triplet.Position ;
				this.value=triplet.Value;
				this.label=new Label("case_"+labelrootnum.ToString("D2")+"_"+labelnumber.ToString("D2"),triplet.Target);

			}
			public Case(ValInt position,ValInt value, ValInt target, int labelrootnum, int labelnumber)
			{
				this.position=position;
				this.absolute=true;
				this.value=value;
				this.label=new Label("case_"+labelrootnum.ToString("D2")+"_"+labelnumber.ToString("D2"),target);
			}

			public ValInt Value
			{
				get
				{
					return value;
				}
				set
				{
					if (value!=this.value)
					{
						this.value=value;
					}
				}
			}
		}
		public class Jump : AJump
		{
			//public Jump(int position, int target) : this(position,target,Counters.Jump){}
			public Jump(ValInt position, ValInt target, int labelnumber)
			{
				this.position=position;
				this.absolute=false;
				this.label=new Label("jump_"+ labelnumber.ToString("D4"),target);
			}
		}

		public class JumpRelative : AJump
		{
			//public JumpRelative(int position, int count) : this(position, count,Counters.Jump){}
			public JumpRelative(ValInt position, ValInt count, int labelnumber)
			{
				this.position=count;
				this.absolute=true;
				this.label=new Label("jrel_"+ labelnumber.ToString("D4"),(this.position+count));
			}


			public ValInt Count
			{
				get
				{
					return this.position;
				}
			}

			public override ValInt Target
			{
				get
				{
					return (this.position+this.label.Position);
				}
			}


		}


		public class JumpEnumerator : IEnumerator
		{
			private AJump[] items;
			private int position;

			public JumpEnumerator(Hashtable values)
			{
				items = new AJump[values.Count];
				int i=0;
				foreach (object item in values.Values)
				{
					items[i]=(AJump)item;
					i+=1;
				}
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
						return items[position] as AJump;
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


		public class JumpTable : IEnumerable
		{
			private Hashtable positions;
			private ArrayList jumps;
			public LabelTable labels;

			public JumpTable() : this(10){}
			public JumpTable(int capacity)
			{
				positions = new Hashtable(capacity);
				jumps = new ArrayList(capacity);
				labels = new LabelTable(capacity);
			}

			~JumpTable()
			{
				if (jumps!=null)
				{
					jumps.Clear();
					jumps=null;
				}
				if (positions!=null)
				{
					positions.Clear();
					positions=null;
				}
				if (labels!=null)
				{
					labels.Clear();
					labels=null;
				}
			}


			public void Add(AJump jump)
			{
				if (!positions.Contains(jump.Position))
				{
					positions.Add(jump.Position,jump);
					jumps.Add(jump);
					if (!labels.Unique(jump.Label.Position))
					{
						Label newlabel = labels.GetLabel(jump.Label);
						if (newlabel!=null)
						{
							jump.Label=newlabel;
						}
					}
					else
					{
						labels.Add(jump.Label);
					}
				}
			}

			public void Remove(AJump jump)
			{
				if (positions.Contains(jump.Position))
				{
					positions.Remove(jump.Position);
					labels.Remove(jump.Label);
					jumps.Remove(jump);

				}
			}

			public void Clear()
			{
				if (labels!=null)
				{
					labels.Clear();
				}
				if (jumps!=null)
				{
					jumps.Clear();
				}
				if (positions!=null)
				{
					positions.Clear();
				}
			}

			public bool Contains(ValInt position)
			{
				return positions.Contains(position);
			}

			public AJump this[ValInt position]
			{
				get
				{
					AJump retval = null;

					retval = positions[position] as AJump;

					return retval;
				}
			}

			public int Count
			{
				get
				{
					return jumps.Count;
				}
			}


			#region IEnumerable Members

			public IEnumerator GetEnumerator()
			{
				return new JumpEnumerator(positions);
			}

			#endregion
		}

	}


	namespace Labels
	{
		public class LabelChangeEventArgs
		{
			private bool allowed;

			private bool positionchange;
			private bool labelchange;

			private int oldposition;
			private int newposition;

			private string oldlabel;
			private string newlabel;

			public LabelChangeEventArgs(int old, int @new)
			{
				allowed=true;
				positionchange=true;
				oldposition=old;
				newposition = @new;
			}
			
			public LabelChangeEventArgs(string old, string @new)
			{
				allowed=true;
				labelchange=true;
				oldlabel = old;
				newlabel = @new;
			}


			public bool PositionChange
			{
				get
				{
					return positionchange;
				}
			}
			public bool LabelChange
			{
				get
				{
					return labelchange;
				}
			}

			public string OldLabel
			{
				get
				{
					return oldlabel;
				}
			}

			public string NewLabel
			{
				get
				{
					return newlabel;
				}
			}
		
			public int OldPosition
			{
				get
				{
					return oldposition;
				}
			}
			public int NewPosition
			{
				get
				{
					return newposition;
				}
			}


			public bool Allowed
			{
				get
				{
					return allowed;
				}
				set
				{
					if (allowed)
					{
						allowed=value;
					}
				}
			}

		}

		public delegate void LabelChangeEventHandler(object sender, LabelChangeEventArgs e);
		public class Label : IComparable,ICloneable
		{
			public event LabelChangeEventHandler LabelChanging;
			public event EventHandler LabelChanged;

			private string name;
			private int position;

			public Label(string name, int position)
			{
				this.name=name;
				this.position=position;
			}


			public string Name
			{
				get
				{
					return name;
				}
				set
				{
					if (value!=name)
					{
					


					}
				}
			}

			public int Position
			{
				get
				{
					return position;
				}
				set
				{
					if (value!=position)
					{
						;
					}
				}
			}


			protected virtual bool OnLabelChanging(int old, int @new)
			{
				bool retval = true;
				if (LabelChanging!=null)
				{
					LabelChangeEventArgs args = new LabelChangeEventArgs(old,@new);
					LabelChangeEventHandler clients = (LabelChangeEventHandler)LabelChanging.Clone();
					clients(this,args);
					retval = args.Allowed;
				}
				return retval;
			}
			protected virtual bool OnLabelChanging(string old, string @new)
			{
				bool retval = true;
				if (LabelChanging!=null)
				{
					LabelChangeEventArgs args = new LabelChangeEventArgs(old,@new);
					LabelChangeEventHandler clients = (LabelChangeEventHandler)LabelChanging.Clone();
					clients(this,args);
					retval = args.Allowed;
				}
				return retval;
			}

			protected virtual void OnLabelChanged()
			{
				if (LabelChanged!=null)
				{
					LabelChanged(this,EventArgs.Empty);
				}
			}


			#region IComparable Members

			public int CompareTo(object obj)
			{
				int retval = 0;

				Label lo = obj as Label;
				if (lo!=null)
				{
					retval = this.name.CompareTo(lo.Name);
				}
				else
				{
					throw new ArgumentException("obj argument must be of type Label");
				}

				return retval;
			}

			#endregion

			#region ICloneable Members

			public object Clone()
			{
				return new Label(this.name, this.position);
			}

			#endregion
		}


		public class LabelComparer : IComparer
		{
			#region IComparer Members

			public int Compare(object x, object y)
			{
				int retval = 0;
				Label lx = x as Label;
				Label ly = y as Label;
				if (lx!=null && ly!=null)
				{
					retval = lx.CompareTo(ly);
				}
				else if (ly!=null)
				{
					retval = 1;
				}
				else
				{
					retval = -1;
				}
				return retval;
			}

			#endregion
		}

		public class LabelNameComparer : IComparer
		{
			#region IComparer Members

			public int Compare(object x, object y)
			{
				int retval = 0;
				Label lx = x as Label;
				string sy = y as string;
				if (lx!=null && sy!=null)
				{
					retval = lx.Name.CompareTo(sy);
				}
				else if (sy!=null)
				{
					retval = 1;
				}
				else
				{
					retval = -1;
				}
				return retval;
			}

			#endregion
		}

		public class LabelPositionComparer : IComparer
		{
			#region IComparer Members

			public int Compare(object x, object y)
			{
				int retval = 0;
				Label lx = x as Label;
				int iy = (int)y ;
				if (lx!=null)
				{
					retval = lx.Position.CompareTo(iy);
				}
				else 
				{
					retval = -1;
				}

				return retval;
			}

			#endregion
		}


		public class LabelEnumerator : IEnumerator
		{
			private Label[] items;
			private int position;

			public LabelEnumerator(Hashtable values)
			{
				items = new Label[values.Count];
				int i=0;
				foreach (object item in values.Values)
				{
					items[i]=(Label)item;
					i+=1;
				}
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
						return items[position] as Label;
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


		public class LabelTable : IEnumerable,ICloneable
		{
			protected Hashtable targets;

			public LabelTable():this(10){}
			public LabelTable(int capacity)
			{
				targets= new Hashtable(capacity);
			}

			~LabelTable()
			{
				if(targets!=null)
				{
					targets.Clear();
					targets=null;
				}
			}


			public bool Unique(int target)
			{
				return !targets.Contains(target);
			}
			public Label GetLabel(Label newlabel)
			{
				Label retval = null;

				Label target = targets[newlabel.Position] as Label;
				if (target!=null)
				{
					if (!target.Name.StartsWith("multi"))
					{
						target.Name.Replace(target.Name.Substring(0,target.Name.IndexOf("_")),"multi");
					}
					retval = target;
				}

				return retval;
			}


			public void Add(Label item)
			{
				if (!targets.Contains(item.Position))
				{
					targets.Add(item.Position,item);
				}			
			}
			public void Remove(Label item)
			{
				if (targets.Contains(item.Position))
				{
					targets.Remove(item.Position);
				}
			}

			public void Clear()
			{
				if (targets!=null)
				{
					targets.Clear();
				}
			}

			public bool Contains(int target)
			{
				return (targets[target]!=null);
			}

			public Label this[int target]
			{
				get
				{
					return (targets[target] as Label);
				}
			}


			#region IEnumerable Members

			public IEnumerator GetEnumerator()
			{
			
				return new LabelEnumerator(targets);
			}

			#endregion

			#region ICloneable Members

			public object Clone()
			{
				LabelTable retval = new LabelTable();
				foreach (DictionaryEntry entry in this.targets)
				{
					retval.targets.Add(entry.Key, (Label)( (entry.Value as Label).Clone() ));
				}
				return null;
			}

			#endregion
		}

	}


	namespace Debug
	{
		using Amx.Core;
		using Amx.Strings;


		public abstract class ASymbol
		{
			protected int offset;

			public virtual int Offset
			{
				get
				{
					return offset;
				}
			}
		}
		public abstract class SymbolExtension : ASymbol 
		{
			protected ASymbol owner;

			public virtual ASymbol Owner
			{
				get
				{
					return owner;
				}
				set
				{
					owner= value;
				}
			}
		}


		public enum SymbolFlagClass : int
		{
			global=0,
			local=1,
			@static=2
		}

		public enum SymbolFlagType : int
		{
			unknown=0,
			variable=1,
			variable_ptr=2,
			array=3,
			array_ptr=4,
			function=9,
			function_ptr=10,
		}

		public enum SymbolRelativeTo : int
		{
			COD,
			DAT,
			FRM
		}


		public class Symbol : ASymbol
		{
			private string name;
			private int position;
			private ArrayList extensions;
			private SymbolFlagClass @class;
			private SymbolFlagType type;

			public Symbol(int offset, ValInt position, ValInt flags, byte[] name)
			{
				this.offset=offset;
				this.position=position;
				if (name!=null)
				{
					AsciiStringDecoder decoder = new AsciiStringDecoder(4);
					this.name=decoder.GetString(name,0,name.Length);
					decoder=null;
				}
				this.type =   (SymbolFlagType) (flags & 0xff);
				this.@class = (SymbolFlagClass) ( (flags >> 8) & 0xff );
			}


			public SymbolFlagClass Class
			{
				get
				{
					return @class;
				}
			}

			public SymbolFlagType Type
			{
				get
				{
					return type;
				}
			}

			public SymbolRelativeTo Relative
			{
				get
				{
					SymbolRelativeTo retval;

					if (
						type==SymbolFlagType.function
						||
						type==SymbolFlagType.function_ptr
						)
					{
						retval = SymbolRelativeTo.COD;
					}
					else
					{
						if (
							@class==SymbolFlagClass.global
							||
							@class==SymbolFlagClass.@static
							)
						{
							retval = SymbolRelativeTo.DAT;
						}
						else
						{
							retval = SymbolRelativeTo.FRM;
						}

					}

					return retval;
				}
			}


			public void AddExtension(SymbolExtension ext)
			{
				if (extensions==null)
				{
					extensions = new ArrayList();
				}
				if (!extensions.Contains(ext))
				{
					extensions.Add(ext);
					ext.Owner=this;
				}
			}

			public string Name
			{
				get
				{
					return name;
				}
			}

			public ValInt Flag
			{
				get
				{
                    return ( 0x0 | ((int)type) | (((int)(@class)<<8)) );
				}
			}

			public ValInt Position
			{
				get
				{
					return position;
				}
			}
			public int ExtensionCount
			{
				get
				{
					int retval = 0;
					if (extensions!=null)
					{
						retval = extensions.Count;
					}
					return retval;
				}
			}

			public ArrayList Extensions
			{
				get
				{
					if(extensions==null)
					{
						extensions=new ArrayList();
					}
					return extensions;
				}
				set
				{
					extensions = value;
				}
			}
		}

		public class SymbolRange : SymbolExtension
		{
			private int value;
			private int rank;

			public SymbolRange(int position, int rank, int value)
			{
				this.offset=position;
				this.value=value;
				this.rank=rank;
			}

			public int Rank
			{
				get
				{
					return rank;
				}
			}


			public int Value
			{
				get
				{
					return value;
				}
			}
		}
		public class SymbolTag : SymbolExtension
		{
			private int value;

			public SymbolTag(int position, int value)
			{
				this.offset=position;
				this.value=value;
			}

			public int Value
			{
				get
				{
					return value;
				}
			}
		}


		public class File : ASymbol
		{
			private ValInt ordinal;
			private string info;

			public File(int offset,ValInt ordinal, byte[] info)
			{
				this.offset=offset;
				this.ordinal=ordinal;
				if (info!=null)
				{
					AsciiStringDecoder decoder = new AsciiStringDecoder(4);
					this.info=decoder.GetString(info,0,info.Length);
					decoder=null;
				}
			}


			public ValInt Ordinal
			{
				get
				{
					return ordinal;
				}
			}

			public string Information
			{
				get
				{
					return info;
				}
			}

		}

		public class Line : ASymbol
		{
			private ValInt number;
			private ValInt ordinal;

			public Line(int offset, ValInt ordinal, ValInt number)
			{
				this.number=number;
				this.offset=offset;
				this.ordinal=ordinal;
			}


			public ValInt Ordinal
			{
				get
				{
					return ordinal;
				}
			}

			public ValInt Number
			{
				get
				{
					return number;
				}
			}


		}


		public class SymbolTable : IDictionary
		{
			private Hashtable table;

			public SymbolTable()
			{
				table = new Hashtable();
			}


			public ASymbol this[int key]
			{
				get
				{
					return table[key] as ASymbol;
				}
				set
				{
					table[key]=value;
				}
			}


			#region IDictionary Members

			public bool IsReadOnly
			{
				get
				{
					return false;
				}
			}

			public IDictionaryEnumerator GetEnumerator()
			{
				return table.GetEnumerator();
			}

			public object this[object key]
			{
				get
				{
					return table[key];
				}
				set
				{
					table[key]=value;
				}
			}

			public void Remove(object key)
			{
				if (key==null)
				{
					throw new ArgumentNullException();
				}
				if (table.ContainsKey(key))
				{
                    table.Remove(key);
				}
			}

			public bool Contains(object key)
			{
				return table.ContainsKey(key);
			}

			public void Clear()
			{
				table.Clear();
			}

			public ICollection Values
			{
				get
				{
					return table.Values;
				}
			}

			public void Add(object key, object value)
			{
				if (key==null)
				{
					throw new ArgumentNullException();
				}
				if (table.ContainsKey(key))
				{
					throw new ArgumentException();
				}
				table.Add(key,value);
				// TODO:  Add SymbolTable.Add implementation
			}

			public ICollection Keys
			{
				get
				{
					return table.Keys;
				}
			}

			public bool IsFixedSize
			{
				get
				{
					return false;
				}
			}

			#endregion

			#region ICollection Members

			public bool IsSynchronized
			{
				get
				{
					return false;
				}
			}

			public int Count
			{
				get
				{
					return table.Count;
				}
			}

			public void CopyTo(Array array, int index)
			{
				if (array == null)
				{
					throw new ArgumentNullException();
				}
				if (index<0)
				{
					throw new ArgumentOutOfRangeException();
				}
				if (
					array.Rank>1 ||
					index >= array.Length ||
					table.Count >(array.Length - index) 
					)
				{
					throw new ArgumentException();
				}

				// TODO:  Add SymbolTable.CopyTo implementation
			}

			public object SyncRoot
			{
				get
				{
					return null;
				}
			}

			#endregion

			#region IEnumerable Members

			IEnumerator System.Collections.IEnumerable.GetEnumerator()
			{
				return new SymbolTableEnumerator(table);
			}

			#endregion
		}

		public class SymbolTableEnumerator : IEnumerator
		{
			private ArrayList items;
			private int position;

			public SymbolTableEnumerator(IDictionary dict)
			{
				items = new ArrayList(dict.Values);
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
					if (position>=0 && position<items.Count)
					{
						return items[position];
					}
					else
					{
						throw new InvalidOperationException();
					}
				}
			}

			public bool MoveNext()
			{
				position+=1;
				return (position>=0 && position<items.Count);
			}

			#endregion
		}

	}
}
