package src.Maths {
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class MathVector {
		public var x:Number;
		public var y:Number;
		
		public function MathVector(x:Number = 0, y:Number = 0) {
			Initialise(x, y);
		}
		
		public function Initialise(x:Number = 0, y:Number = 0):void {
			this.x = x;
			this.y = y;
		}
		
		public function Add(v:MathVector):MathVector {
			return new MathVector(x + v.x, y + v.y);
		}
			
		public function AddTo(v:MathVector):MathVector {
			x += v.x;
			y += v.y;
			return this;
		}
		
		public function SubFrom(v:MathVector):MathVector {
			x -= v.x;
			y -= v.y;
			return this;
		}
		
		public function SubScalar(s:Number):MathVector {
			return new MathVector(x - s, y - s);
		}
		
		public function AddScalar(s:Number):MathVector {
			return new MathVector(x + s, y + s);
		}
		
		public function SubScalarFrom(s:Number):MathVector {
			x -= s;
			y -= s;
			return this;
		}
		
		public function AddScalarTo(s:Number):MathVector {
			x += s;
			y += s;
			return this;
		}
		
		public function AddX(x:Number):MathVector {
			return new MathVector(x + x, y);
		}
		
		public function AddY(y:Number):MathVector {
			return new MathVector(x, y + y);
		}	
		
		public function SubX(x:Number):MathVector {
			return new MathVector(x - x, y);
		}
		
		public function SubY(y:Number):MathVector {
			return new MathVector(x, y - y);
		}
		
		public function AddXTo(x:Number):MathVector {
			this.x += x;
			return this;
		}
		
		public function AddYTo(y:Number):MathVector {
			this.y += y;
			return this;
		}
		
		public function SubXFrom(x:Number):MathVector {
			x -= x;
			return this;
		}
		
		public function SubYFrom(y:Number):MathVector {
			y -= y;
			return this;
		}
		
		public function Sub(v:MathVector):MathVector {
			return new MathVector(x - v.x, y - v.y);
		}
		
		public function Mul(v:MathVector):MathVector {
			return new MathVector(x * v.x, y * v.y);
		}
		
		public function MulTo(v:MathVector):MathVector {
			x *= v.x;
			y *= v.y;
			return this;
		}
		
		public function Div(v:MathVector):MathVector {
			return new MathVector(x / v.x, y / v.y);
		}
		
		public function MulScalar(s:Number):MathVector {
			return new MathVector(x * s, y * s);
		}
		
		public function MulScalarTo(s:Number):MathVector {
			x *= s;
			y *= s;
			return this;
		}
		
		public function MulAddScalarTo(v:MathVector, s:Number):MathVector {
			x += v.x * s;
			y += v.y * s;
			return this;
		}
		
		public function MulSubScalarTo(v:MathVector, s:Number):MathVector {
			x -= v.x * s;
			y -= v.y * s;
			return this;
		}
		
		public function Dot(v:MathVector):Number {
			return x * v.x + y * v.y;
		}
		
		public function get m_LenSqr():Number {
			return Dot(this);
		}
		
		public function get m_Len():Number {
			return Math.sqrt(m_LenSqr);
		}
		
		public function get m_Abs():MathVector {
			return new MathVector(Math.abs(x), Math.abs(y));
		}
		
		public function get m_Unit():MathVector {
			var invLen:Number = 1.0 / m_Len;
			return MulScalar(invLen);
		}
			
		public function get m_Floor():MathVector {
			return new MathVector(Math.floor(x), Math.floor(y));
		}
		
		public function Clamp(min:MathVector, max:MathVector):MathVector {
			return new MathVector(Math.max(Math.min(x, max.x), min.x), Math.max(Math.min(y, max.y), min.y));
		}
		
		public function ClampInto(min:MathVector, max:MathVector):MathVector {
			x = Math.max(Math.min(x, max.x), min.x);
			y = Math.max(Math.min(y, max.y), min.y);
			return this;
		}
		
		public function get m_Perp():MathVector {
			return new MathVector(-y, x);
		}
		
		public function get m_Neg():MathVector {
			return new MathVector(-x, -y);
		}
		
		public function NegTo():MathVector {
			x = -x;
			y = -y;
			return this;
		}
		
		public function Equal(v:MathVector):Boolean {
			return x == v.x && y == v.y;
		}
		
		public static function FromAngle(angle:Number):MathVector {
			return new MathVector(Math.cos(angle), Math.sin(angle));
		}
		
		public function ToAngle():Number {
			var angle:Number = Math.atan2(y, x);
			
			// make the returned range 0 -> 2*PI
			if (angle < 0.0) {
				angle += (Math.PI * 2);
			}
			return angle;
		}
		
		public static function RandomRadius(r:Number):MathVector {
			return new MathVector(Math.random() * 2 - 1, Math.random() * 2 - 1).MulScalar(r);
		}
		
		public static function FromPoint(point:Point):MathVector {
			return new MathVector(point.x, point.y);
		}
		
		public function get ToPoint():Point {
			return new Point(x, y);
		}
		
		public function Clear():void {
			x = 0;
			y = 0;
		}
		
		public function Clone():MathVector {
			return new MathVector(x, y);
		}
		
		public function toString():String {
			return "x=" + x + ",y=" + y;
		}
		
		public function CloneInto(v:MathVector):MathVector {
			x = v.x;
			y = v.y;
			return this;
		}
		
		public function MaxInto(b:MathVector):MathVector {
			x = Math.max(x, b.x);
			y = Math.max(y, b.y);
			
			return this;
		}
		
		public function MinInto(b:MathVector):MathVector {
			x = Math.min(x, b.x);
			y = Math.min(y, b.y);
			return this;
		}
		
		public function Min(b:MathVector):MathVector {
			return new MathVector(x, y).MinInto(b);
		}
		
		public function Max(b:MathVector):MathVector {
			return new MathVector(x, y).MaxInto(b);
		}
			
		public function AbsTo():void {
			x = Math.abs(x);
			y = Math.abs(y);
		}
		
		public function UnitTo():MathVector {
			var invLen:Number = 1.0 / m_Len;
			x *= invLen;
			y *= invLen;
			return this;
		}
		
		public function IsNaN():Boolean {
			return isNaN(x) || isNaN(y);
		}
		
		public function get m_MajorAxis():MathVector {
			if (Math.abs(x) > Math.abs(y)) {
				return new MathVector(Scalar.Sign(x), 0);
			} else {
				return new MathVector(0, Scalar.Sign(y));
			}
		}
		
		public function FloorTo():MathVector {
			x = Math.floor(x);
			y = Math.floor(y);
			return this;
		}
		
		public function RoundTo():MathVector {
			x = Math.floor(x + 0.5);
			y = Math.floor(y + 0.5);
			return this;
		}
		
		public function Distance(v:MathVector):Number {
			 return Math.sqrt(Math.pow((v.x - this.x),2) + Math.pow((v.y - this.y),2));
		}
		
		public function get CValue():Number {
			return Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
		}
		
		public function Mean():Number {
			return (this.x + this.y) / 2;
		}
	}
}