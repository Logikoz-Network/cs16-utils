using System;

namespace Amx.Core
{
	public enum Align
	{
		Left,
		Right
	}
	public enum NumberFormat
	{
		SignedHex,
		Hex,
		Dec
	}

	public enum Bits : int
	{
		_8=1,
		_16=2,
		_32=4,
		_64=8
	}


	public struct ValInt : IComparable
	{
		private ValueType val;

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public ValInt(byte value)
		{
			this.val = Convert.ToInt32(value);
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public ValInt(Int16 value)
		{

			this.val = Convert.ToInt32(value);
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public ValInt(Int32 value)
		{
			this.val=value;
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public ValInt(Int64 value)
		{
			this.val=value;
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public ValInt(Int64 value,Bits length)
		{
			switch (length)
			{
				case Bits._8:
					this.val=(byte)value;
					break;
				case Bits._16:
					this.val=(Int16)value;
					break;
				case Bits._32:
					this.val=(Int32)value;
					break;
				case Bits._64:
					this.val=(Int64)value;
					break;
				default:
					this.val=(Int32)value;
					break;
			}
		}


		public ValueType Value
		{
			[System.Diagnostics.DebuggerStepThroughAttribute]
			get
			{
				return val;
			}
			[System.Diagnostics.DebuggerStepThroughAttribute]
			set
			{
				if (value is Int32 || value is Int64 ||value is Int16|| value is Byte)
				{
					val = value;
				}
				else
				{
					throw new ArgumentException("cannot assign objects of type " + value.GetType().ToString() + " to a ValInt");
				}
			}
		}

		public Type Contains
		{
			[System.Diagnostics.DebuggerStepThroughAttribute]
			get
			{
				return val.GetType();
			}
		}


		#region (Int64|Int32|Int16|byte)
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static explicit operator Byte(ValInt v)
		{
			if (v.val==null)
			{
				v.val=0;
			}
			return Convert.ToByte(v.val);
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static explicit operator Int16(ValInt v)
		{
			if (v.val==null)
			{
				v.val=0;
			}
			return Convert.ToInt16(v.val);
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static implicit operator Int32(ValInt v)
		{
			if (v.val==null)
			{
				v.val=0;
			}
			return Convert.ToInt32(v.val);
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static implicit operator Int64(ValInt v)
		{
			if (v.val==null)
			{
				v.val=0;
			}
			return Convert.ToInt64(v.val);
		}

		#endregion

		#region (ValInt)
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static implicit operator ValInt(Byte v)
		{
			return new ValInt(v);
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static implicit operator ValInt(Int16 v)
		{
			return new ValInt(v);
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static implicit operator ValInt(Int32 v)
		{
			return new ValInt(v);
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static implicit operator ValInt(Int64 v)
		{
			return new ValInt(v);
		}

		#endregion

		#region +
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator +(ValInt x,ValInt y)
		{
			if (x.val is Int64 || y.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x.val) + Convert.ToInt64(y.val)) );
			}
			else
			{
				return new ValInt( checked (Convert.ToInt32(x.val) + Convert.ToInt32(y.val)) );
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator +(Int32 x ,ValInt y)
		{
			if (y.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x) + Convert.ToInt64(y.val)) );
			}
			else
			{
				return new ValInt( checked (x + Convert.ToInt32(y.val)) );
			}
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator +(Int64 x ,ValInt y)
		{
			if (y.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x) + Convert.ToInt64(y.val)) );
			}
			else
			{
				return new ValInt( checked (x + Convert.ToInt32(y.val)) );
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator +(ValInt x ,Int32 y)
		{
			if (x.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x.val) + Convert.ToInt64(y)) );
			}
			else
			{
				return new ValInt( checked (Convert.ToInt32(x.val) + y) );
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator +(ValInt x ,Int64 y)
		{
			if (x.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x.val) + Convert.ToInt64(y)) );
			}
			else
			{
				return new ValInt( checked (Convert.ToInt32(x.val) + y) );
			}
		}

		#endregion

		#region -
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator -(ValInt x,ValInt y)
		{
			if (x.val is Int64 || y.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x.val) - Convert.ToInt64(y.val)) );
			}
			else
			{
				return new ValInt( checked (Convert.ToInt32(x.val) - Convert.ToInt32(y.val)) );
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator -(Int32 x ,ValInt y)
		{
			if (y.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x) - Convert.ToInt64(y.val)) );
			}
			else
			{
				return new ValInt( checked (x - Convert.ToInt32(y.val)) );
			}
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator -(Int64 x ,ValInt y)
		{
			if (y.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x) - Convert.ToInt64(y.val)) );
			}
			else
			{
				return new ValInt( checked (x - Convert.ToInt32(y.val)) );
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator -(ValInt x ,Int32 y)
		{
			if (x.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x.val) - Convert.ToInt64(y)) );
			}
			else
			{
				return new ValInt( checked (Convert.ToInt32(x.val) - y) );
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator -(ValInt x ,Int64 y)
		{
			if (x.val is Int64)
			{
				return new ValInt( checked (Convert.ToInt64(x.val) - Convert.ToInt64(y)) );
			}
			else
			{
				return new ValInt( checked (Convert.ToInt32(x.val) - y) );
			}
		}

		#endregion

		#region |
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator |(ValInt x,ValInt y)
		{
			if (x.val is Int64)
			{
				return new ValInt( ((Int64)x.val) | y );
			}
			else if (x.val is Int32)
			{
				return new ValInt( Convert.ToInt64((Int32)x.val) | y );
			}
			else if (x.val is Int16)
			{
				return new ValInt( Convert.ToInt64((Int16)x.val) | y );
			}
			else if (x.val is byte)
			{
				return new ValInt( Convert.ToInt64((byte)x.val) | y );
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator |(ValInt x, Int64 y)
		{
			if (x.val is Int64)
			{
				return new ValInt( ((Int64)x.val) | y );
			}
			else if (x.val is Int32)
			{
				return new ValInt( Convert.ToInt64((Int32)x.val) | y );
			}
			else if (x.val is Int16)
			{
				return new ValInt( Convert.ToInt64((Int16)x.val) | y );
			}
			else if (x.val is byte)
			{
				return new ValInt( Convert.ToInt64((byte)x.val) | y );
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator |(ValInt x, Int32 y)
		{
			if (x.val is Int64)
			{
				return new ValInt( ((Int64)x.val) | Convert.ToInt64(y) );
			}
			else if (x.val is Int32)
			{
				return new ValInt( ((Int32)x.val) | y );
			}
			else if (x.val is Int16)
			{
				return new ValInt( Convert.ToInt32((Int16)x.val) | y );
			}
			else if (x.val is byte)
			{
				return new ValInt( Convert.ToInt32((byte)x.val) | y );
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator |(Int64 x, ValInt y)
		{
			if (y.val is Int64)
			{
				return new ValInt( x | ((Int64)y.val) );
			}
			else if (y.val is Int32)
			{
				return new ValInt( x | Convert.ToInt64((Int32)y.val) );
			}
			else if (y.val is Int16)
			{
				return new ValInt( x | Convert.ToInt64((Int16)y.val)  );
			}
			else if (y.val is byte)
			{
				return new ValInt( x | Convert.ToInt64((byte)y.val)  );
			}
			else
			{
				throw new ArgumentException("type " + y.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator |(Int32 x, ValInt y)
		{
			if (y.val is Int64)
			{
				return new ValInt( Convert.ToInt64(x) | ((Int64)y.val) );
			}
			else if (y.val is Int32)
			{
				return new ValInt( x | ((Int32)y.val) );
			}
			else if (y.val is Int16)
			{
				return new ValInt( x | Convert.ToInt32((Int16)y.val)  );
			}
			else if (y.val is byte)
			{
				return new ValInt( x | Convert.ToInt32((byte)y.val)  );
			}
			else
			{
				throw new ArgumentException("type " + y.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		#endregion

		#region ==
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator ==(ValInt x, ValInt y)
		{
			if (x.val==null)
			{
				x.val=0;
			}
			if (y.val==null)
			{
				y.val=0;
			}
			if (x.val is Int64)
			{
				return ((Int64)x.val)==y;
			}
			else if (x.val is Int32)
			{
				return Convert.ToInt64((Int32)x.val)==y;
			}
			else if (x.val is Int16)
			{
				return Convert.ToInt64((Int16)x.val)==y;
			}
			else if (x.val is byte)
			{
				return Convert.ToInt64((byte)x.val)==y;
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator ==(ValInt x, Int64 y)
		{
			if (x.val==null)
			{
				x.val=0;
			}
			if (x.val is Int64)
			{
				return ((Int64)x.val).Equals(y);
			}
			else if (x.val is Int32)
			{
				return Convert.ToInt64((Int32)x.val).Equals(y);
			}
			else if (x.val is Int16)
			{
				return Convert.ToInt64((Int16)x.val).Equals(y);
			}
			else if (x.val is byte)
			{
				return Convert.ToInt64((byte)x.val).Equals(y);
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator ==(ValInt x, Int32 y)
		{
			if (x.val==null)
			{
				x.val=0;
			}

			if (x.val is Int32)
			{
				return ((Int32)x.val).Equals(y);
			}
			else if (x.val is Int64)
			{
				return x.val.Equals(Convert.ToInt64(y));
			}
			else if (x.val is Int16)
			{
				return Convert.ToInt32((Int16)x.val).Equals(y);
			}
			else if (x.val is byte)
			{
				return Convert.ToInt32((byte)x.val).Equals(y);
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator ==(Int64 x, ValInt y)
		{
			if (y.val==null)
			{
				y.val=0;
			}
			if (y.val is Int64)
			{
				return x.Equals((Int64)y.val);
			}
			else if (y.val is Int32)
			{
				return x.Equals(Convert.ToInt64((Int32)y.val));
			}
			else if (y.val is Int16)
			{
				return x.Equals(Convert.ToInt64((Int16)y.val));
			}
			else if (y.val is byte)
			{
				return x.Equals(Convert.ToInt64((byte)y.val));
			}
			else
			{
				throw new ArgumentException("type " + y.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator ==(Int32 x ,ValInt y)
		{
			if (y.val==null)
			{
				y.val=0;
			}
			if (y.val is Int64)
			{
				return x.Equals(Convert.ToInt64((Int32)y.val));
			}
			else if (y.val is Int32)
			{
				return x.Equals((Int32)y.val);
			}
			else if (y.val is Int16)
			{
				return x.Equals(Convert.ToInt32((Int16)y.val));
			}
			else if (y.val is byte)
			{
				return x.Equals(Convert.ToInt32((byte)y.val));
			}
			else
			{
				throw new ArgumentException("type " + y.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}

		#endregion

		#region !=
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator !=(ValInt x, ValInt y){return !(x==y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator !=(ValInt x, Int64 y){return !(x==y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator !=(ValInt x, Int32 y){return !(x==y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator !=(Int64 x, ValInt y){return !(x==y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator !=(Int32 x, ValInt y){return !(x==y);}

		#endregion

		#region >=
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator >=(ValInt x, Int64 y)
		{
			if (x.val is Int64)
			{
				return ((Int64)x.val)>=y;
			}
			else if (x.val is Int32)
			{
				return Convert.ToInt64((Int32)x.val)>=y;
			}
			else if (x.val is Int16)
			{
				return Convert.ToInt64((Int16)x.val)>=y;
			}
			else if (x.val is byte)
			{
				return Convert.ToInt64((byte)x.val)>=y;
			}
			else if (x.val==null)
			{
				return false;
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator >=(ValInt x, Int32 y)
		{
			if (x.val is Int32)
			{
				return ((Int32)x.val)>=y;
			}
			else if (x.val is Int64)
			{
				return ((Int64)x.val)>=(Convert.ToInt64(y));
			}
			else if (x.val is Int16)
			{
				return Convert.ToInt32((Int16)x.val)>=y;
			}
			else if (x.val is byte)
			{
				return Convert.ToInt32((byte)x.val)>=y;
			}
			else if (x.val==null)
			{
				return false;
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator >=(Int64 x, ValInt y)
		{
			if (y.val is Int64)
			{
				return x>=((Int64)y.val);
			}
			else if (y.val is Int32)
			{
				return x>=Convert.ToInt64((Int32)y.val);
			}
			else if (y.val is Int16)
			{
				return x>=Convert.ToInt64((Int16)y.val);
			}
			else if (y.val is byte)
			{
				return x>=Convert.ToInt64((byte)y.val);
			}
			else if (y.val==null)
			{
				return false;
			}
			else
			{
				throw new ArgumentException("type " + y.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator >=(Int32 x, ValInt y)
		{
			if (y.val is Int32)
			{
				return x>=((Int32)y.val);
			}
			else if (y.val is Int64)
			{
				return (Convert.ToInt64(x))>=((Int64)y.val);
			}
			else if (y.val is Int16)
			{
				return x>=Convert.ToInt32((Int16)y.val);
			}
			else if (y.val is byte)
			{
				return x>=Convert.ToInt32((byte)y.val);
			}
			else if (y.val==null)
			{
				return false;
			}
			else
			{
				throw new ArgumentException("type " + y.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		
		#endregion

		#region <=
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator <=(ValInt x, Int64 y)
		{
			if (x.val is Int64)
			{
				return ((Int64)x.val)<=y;
			}
			else if (x.val is Int32)
			{
				return Convert.ToInt64((Int32)x.val)<=y;
			}
			else if (x.val is Int16)
			{
				return Convert.ToInt64((Int16)x.val)<=y;
			}
			else if (x.val is byte)
			{
				return Convert.ToInt64((byte)x.val)<=y;
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator <=(ValInt x, Int32 y)
		{
			if (x.val is Int32)
			{
				return ((Int32)x.val)<=y;
			}
			else if (x.val is Int64)
			{
				return ((Int64)x.val)<=(Convert.ToInt64(y));
			}
			else if (x.val is Int16)
			{
				return Convert.ToInt32((Int16)x.val)<=y;
			}
			else if (x.val is byte)
			{
				return Convert.ToInt32((byte)x.val)<=y;
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator <=(Int64 x, ValInt y)
		{
			if (y.val is Int64)
			{
				return x<=((Int64)y.val);
			}
			else if (y.val is Int32)
			{
				return x<=Convert.ToInt64((Int32)y.val);
			}
			else if (y.val is Int16)
			{
				return x<=Convert.ToInt64((Int16)y.val);
			}
			else if (y.val is byte)
			{
				return x<=Convert.ToInt64((byte)y.val);
			}
			else
			{
				throw new ArgumentException("type " + y.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator <=(Int32 x, ValInt y)
		{
			if (y.val is Int32)
			{
				return x<=((Int32)y.val);
			}
			else if (y.val is Int64)
			{
				return (Convert.ToInt64(x))<=((Int64)y.val);
			}
			else if (y.val is Int16)
			{
				return x<=Convert.ToInt32((Int16)y.val);
			}
			else if (y.val is byte)
			{
				return x<=Convert.ToInt32((byte)y.val);
			}
			else
			{
				throw new ArgumentException("type " + y.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}
		
		#endregion

		#region >
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator >(ValInt x, Int64 y){return !(x<=y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator >(ValInt x, Int32 y){return !(x<=y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator >(Int64 x, ValInt y){return !(x<=y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator >(Int32 x, ValInt y){return !(x<=y);}
		#endregion

		#region <
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator <(ValInt x, Int64 y){return !(x>=y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator <(ValInt x, Int32 y){return !(x>=y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator <(Int64 x, ValInt y){return !(x>=y);}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static bool operator <(Int32 x, ValInt y){return !(x>=y);}
		#endregion

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator %(ValInt x, Int64 y)
		{
			if (x.val is Int64)
			{
				return ((Int64)x.val) % y;
			}
			else if (x.val is Int32)
			{
				return Convert.ToInt64((Int32)x.val) % (y);
			}
			else if (x.val is Int16)
			{
				return Convert.ToInt64((Int16)x.val) % (y);
			}
			else if (x.val is byte)
			{
				return Convert.ToInt64((byte)x.val) % (y);
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator %(ValInt x, Int32 y)
		{
			if (x.val is Int64)
			{
				return ((Int64)x.val) % Convert.ToInt64(y);
			}
			else if (x.val is Int32)
			{
				return ((Int32)x.val) % (y);
			}
			else if (x.val is Int16)
			{
				return Convert.ToInt32((Int16)x.val) % (y);
			}
			else if (x.val is byte)
			{
				return Convert.ToInt32((byte)x.val) % (y);
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}


		[System.Diagnostics.DebuggerStepThroughAttribute]
		public static ValInt operator ~(ValInt x)
		{
			if (x.val is Int64)
			{
				return (~((Int64)x.val));
			}
			else if (x.val is Int32)
			{
				return (~Convert.ToInt64((Int32)x.val));
			}
			else if (x.val is Int16)
			{
				return (~Convert.ToInt64((Int16)x.val));
			}
			else if (x.val is byte)
			{
				return (~Convert.ToInt64((byte)x.val));
			}
			else
			{
				throw new ArgumentException("type " + x.val.GetType().ToString() + " cannot be converted to an integer for comparison");
			}
		}


		[System.Diagnostics.DebuggerStepThroughAttribute]
		public override string ToString()
		{
			return val.ToString ();
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public string ToString(string formatter)
		{
			string retval;
			if ( this.val is Int64)
			{
				retval = ((Int64)this.val).ToString(formatter);
			}
			else if ( this.val is Int32)
			{
				retval = ((Int32)this.val).ToString(formatter);
			}
			else if (this.val is Int16)
			{
				retval = ((Int16)this.val).ToString(formatter);
			}
			else if (this.val is byte)
			{
				retval = ((byte)this.val).ToString(formatter);
			}
			else
			{
				throw new ArgumentException("");
			}
			return retval;
		}
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public override bool Equals(object obj)
		{
			if(this.val==null)
			{
				this.val=0;
			}
			return ( 0 == this.CompareTo(obj));
			/*
			if (val!=null)
			{
				if (obj is ValInt)
				{
					return this.val.Equals( ((ValInt)obj).val  );
				}
				else if (obj is Int32 && this.val is Int32)
				{
					return (Convert.ToInt32(obj).Equals(Convert.ToInt32(this.val)));
				}
				else if (obj is Int64 && this.val is Int64)
				{
					return (Convert.ToInt64(obj).Equals(Convert.ToInt64(this.val)));
				}
				else if (obj is Int16 && this.val is Int16)
				{
					return (Convert.ToInt16(obj).Equals(Convert.ToInt16(this.val)));
				}
				else if (obj is byte && this.val is byte)
				{
					return (Convert.ToByte(obj).Equals(Convert.ToByte(this.val)));
				}
				else
				{
					throw new ArgumentException();
				}
			}
			else
			{
				return (val==null);
			}
			*/

		}

		[System.Diagnostics.DebuggerStepThroughAttribute]
		public override int GetHashCode()
		{
			if (val!=null)
			{
				return val.GetHashCode();
			}
			else
			{
				return base.GetHashCode ();
			}
		}


		#region IComparable Members
		[System.Diagnostics.DebuggerStepThroughAttribute]
		public int CompareTo(object obj)
		{
			int retval=0;
			if (obj is ValInt)
			{
				ValInt v = (ValInt)obj;
				if (v.val==null)
				{
					v.val=0;
				}
				if (v.val is Int64)
				{
					obj = (Int64)v.val;
				}
				else if (v.val is Int32)
				{
					obj = (Int32)v.val;
				}
				else if (v.val is Int16)
				{
					obj = (Int16)v.val;				
				}
				else if (v.val is byte)
				{
					obj = (byte)v.val;				
				}
				else
				{
					throw new ArgumentException("");
				}
			}
			if (obj is Int64)
			{
				if (this.val is Int64)
				{
					retval = ((Int64)this.val).CompareTo((Int64)obj);
				}
				else if (this.val is Int32)
				{
					retval = (Convert.ToInt64((Int32)this.val)).CompareTo((Int64)obj);
				}
				else if (this.val is Int16)
				{
					retval = (Convert.ToInt64((Int16)this.val)).CompareTo((Int64)obj);
				}
				else if (this.val is byte)
				{
					retval = (Convert.ToInt64((byte)this.val)).CompareTo((Int64)obj);
				}
				else
				{
					throw new ArgumentException("");
				}
			}
			else if (obj is Int32)
			{
				if (this.val is Int64)
				{
					retval = ((Int64)this.val).CompareTo(Convert.ToInt64((Int32)obj));
				}
				else if (this.val is Int32)
				{
					retval = ((Int32)this.val).CompareTo((Int32)obj);
				}
				else if (this.val is Int16)
				{
					retval = (Convert.ToInt32((Int16)this.val)).CompareTo((Int32)obj);
				}
				else if (this.val is byte)
				{
					retval = (Convert.ToInt32((byte)this.val)).CompareTo((Int32)obj);
				}
				else
				{
					throw new ArgumentException("");
				}
			}
			else if (obj is Int16)
			{
				if (this.val is Int64)
				{
					retval = ((Int64)this.val).CompareTo(Convert.ToInt64((Int16)obj));
				}
				else if (this.val is Int32)
				{
					retval = ((Int32)this.val).CompareTo(Convert.ToInt32((Int16)obj));
				}
				else if (this.val is Int16)
				{
					retval = ((Int16)this.val).CompareTo((Int16)obj);
				}
				else if (this.val is byte)
				{
					retval = (Convert.ToInt16((byte)this.val)).CompareTo((Int16)obj);
				}
				else
				{
					throw new ArgumentException("");
				}
			}
			else if (obj is byte)
			{
				if (this.val is Int64)
				{
					retval = ((Int64)this.val).CompareTo(Convert.ToInt64((byte)obj));
				}
				else if (this.val is Int32)
				{
					retval = ((Int32)this.val).CompareTo(Convert.ToInt32((byte)obj));
				}
				else if (this.val is Int16)
				{
					retval = ((Int16)this.val).CompareTo(Convert.ToInt16((byte)obj));
				}
				else if (this.val is byte)
				{
					retval = ((byte)this.val).CompareTo((byte)obj);
				}
				else
				{
					throw new ArgumentException("");
				}
			}
			return retval;
		}

		#endregion
	}


	public class Options : ICloneable
	{
		public DebugOptions debugops;
		public FormatOptions format;

		public bool ShowSource;
		public bool ShowRaw;

		public Options()
		{
			format = new FormatOptions();
			debugops = new DebugOptions();
			ShowSource=false;
			ShowRaw=false;
		}


		#region ICloneable Members

		public object Clone()
		{
			Options retval = new Options();
			retval.format = this.format.Clone() as FormatOptions;
			retval.debugops=(DebugOptions)this.debugops.Clone();
			retval.ShowSource=this.ShowSource;
			retval.ShowRaw=this.ShowRaw;
			return retval;
		}

		#endregion
	}

	public class FormatOptions : ICloneable
	{
		public NumberOptions Offset;
		public NumberOptions NumberParams;
		public StringOptions Opcode;
		public StringOptions Comment;
		public StringOptions StringParams;
		public StringOptions Spacer;
		public StringOptions Indent;
		public string NewLine;

		public FormatOptions()
		{
			Indent = new StringOptions(4,1,Align.Left,' ',false);
			Offset = new NumberOptions(8,0,Align.Right,NumberFormat.Hex,0,' ');
			Opcode = new StringOptions(12,0,Align.Left,' ',false);
			Spacer = new StringOptions(2,1,Align.Left,' ',false);

			NumberParams = new NumberOptions(12,0,Align.Right,NumberFormat.SignedHex,0,' ');
			StringParams = new StringOptions(12,1,Align.Left,' ',false);

			Comment = new StringOptions(1,1,Align.Left,';',false);
			
			
			NewLine = Environment.NewLine;
		}

		#region ICloneable Members

		public object Clone()
		{
			FormatOptions retval = new FormatOptions();
			retval.Offset=(NumberOptions)this.Offset.Clone();
			retval.NumberParams=(NumberOptions)this.NumberParams.Clone();
			retval.Opcode=(StringOptions)this.Opcode.Clone();
			retval.StringParams=(StringOptions)this.StringParams.Clone();
			retval.Comment=(StringOptions)this.Comment.Clone();
			retval.Spacer=(StringOptions)this.Spacer.Clone();
			retval.Indent=(StringOptions)this.Indent.Clone();
			retval.NewLine=this.NewLine;
			return retval;
		}

		#endregion
	}


	public struct NumberOptions : ICloneable
	{
		public int MaxWidth;
		public int MinWidth;
		public int NumWidth;
		public Align Alignment;
		public NumberFormat Format;
		public char PadChar;

		public NumberOptions (int maxwidth,int minwidth, Align align, NumberFormat format, int numwidth, char padchar)
		{
			this.MinWidth = minwidth;
			this.MaxWidth = Math.Max(maxwidth,minwidth);
			this.Alignment = align;
			this.Format = format;
			this.NumWidth=numwidth;
			this.PadChar = padchar;
		}


		public NumberOptions Modify(Align newalignment)
		{
			NumberOptions retval = (NumberOptions)this.Clone();
			retval.Alignment=newalignment;
			return retval;			
		}
		public NumberOptions Modify(NumberFormat newformat)
		{
			NumberOptions retval = (NumberOptions)this.Clone();
			retval.Format=newformat;
			return retval;		
		}
		public NumberOptions Modify(char newpadchar)
		{
			NumberOptions retval = (NumberOptions)this.Clone();
			retval.PadChar=newpadchar;
			return retval;	
		}
		public NumberOptions ModifyMax(int newmax)
		{
			NumberOptions retval = (NumberOptions)this.Clone();
			retval.MaxWidth=newmax;
			return retval;	
		}
		public NumberOptions ModifyMin(int newmin)
		{
			NumberOptions retval = (NumberOptions)this.Clone();
			retval.MinWidth=newmin;
			return retval;	
		}
		public NumberOptions ModifyNumWidth(int newwidth)
		{
			NumberOptions retval = (NumberOptions)this.Clone();
			retval.NumWidth=newwidth;
			return retval;	
		}


		#region ICloneable Members

		public object Clone()
		{
			return new NumberOptions(this.MaxWidth,this.MinWidth,this.Alignment,this.Format,this.NumWidth,this.PadChar);
		}

		#endregion
	}

	public struct StringOptions : ICloneable
	{
		public char PadChar;
		public Align Alignment;
		public int MinWidth;
		public int MaxWidth;
		public bool Truncate;

		public StringOptions(int maxwidth, int minwidth,Align alignment,char padchar, bool truncate)
		{
			this.PadChar=padchar;
			this.Alignment=alignment;
			this.MaxWidth=Math.Max(minwidth,maxwidth);
			this.MinWidth=minwidth;
			this.Truncate=truncate;
		}


		#region ICloneable Members

		public object Clone()
		{
			
			return new StringOptions(this.MaxWidth,this.MinWidth,this.Alignment,this.PadChar, this.Truncate);
		}

		#endregion
	}
	public struct DebugOptions : ICloneable
	{
		public bool ShowLineOps;
		public bool ShowFileOps;
		public bool ShowSymbolOps;
		public bool ShowSrangeOps;
		public bool ShowSymtagOps;
		public bool ShowBoundsOps;
		public bool ShowCodeLines;

		#region ICloneable Members

		public object Clone()
		{
			DebugOptions retval = new DebugOptions();
			retval.ShowLineOps=this.ShowLineOps;
			retval.ShowFileOps= this.ShowFileOps;
			retval.ShowSymbolOps= this.ShowSymbolOps;
			retval.ShowSrangeOps= this.ShowSymbolOps;
			retval.ShowSymtagOps= this.ShowSymtagOps;
			retval.ShowBoundsOps= this.ShowBoundsOps;
			retval.ShowCodeLines= this.ShowCodeLines;
			return retval;
		}

		#endregion
	}

}
