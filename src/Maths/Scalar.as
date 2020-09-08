package src.Maths {
	import flash.geom.ColorTransform;
	import flash.utils.Endian;
	
	public class Scalar {
		static public const kMaxRandValue:uint = 65535;
		
		static public function Frac(n:Number):Number {
			var abs:Number = Math.abs(n);
			return abs - Math.floor(abs);
		}
		
		static public function Wrap(x:Number, range:Number):Number {
			var t:Number = x / range;
			var ft:Number = Frac(t);
			return range * ft;
		}
		
		static public function EaseOut(x:Number):Number {
			var a:Number = x - 1;
			return a * a * a + 1;
		}
		
		static public function EaseOutVel(x:Number):Number {
			var a:Number = x - 1;
			return a * a * 3;
		}
		
		static public function RandBetween(a:Number, b:Number):Number {
			return Math.random() * (b - a) + a;
		}
		
		static public function RandBetweenInt(a:int, b:int):int {
			return int(RandBetween(a, b));
		}
		
		static public function RandUint():int {
			return uint(Math.random() * kMaxRandValue);
		}
		
		static public function RandInt():int {
			return int(Math.random() * kMaxRandValue);
		}
		
		static public function FromMathVector(v:MathVector):Number {
			return Math.atan2(v.y, v.x);
		}
		
		static public function MakeColour(r:uint, g:uint, b:uint):uint {
			return r | (g << 8) | (b << 16);
		}
		
		static public function RedFromColour(c:uint):uint {
			return c & 0xff;
		}
		
		static public function GreenFromColour(c:uint):uint {
			return (c >> 8) & 0xff;
		}
		
		static public function BlueFromColour(c:uint):uint {
			return (c >> 16) & 0xff;
		}
		
		static public function InfinityCurve(x:Number):Number {
			return -1 / (x + 1) + 1;
		}
		
		static public function ColorTransformFromBGR(bgr:uint):ColorTransform {
			return new ColorTransform(Scalar.BlueFromColour(bgr) / 255.0, Scalar.GreenFromColour(bgr) / 255.0, Scalar.RedFromColour(bgr) / 255.0);
		}
		
		static public function ColorTransformFromRGB(rgb:uint):ColorTransform {
			return new ColorTransform(Scalar.RedFromColour(rgb) / 255.0, Scalar.GreenFromColour(rgb) / 255.0, Scalar.BlueFromColour(rgb) / 255.0);
		}
		
		static public function RadToDeg(radians:Number):Number {
			return (radians / Math.PI) * 180;
		}
		
		static public function Clamp(a:Number, min:Number, max:Number):Number {
			a = Math.max(min, a);
			a = Math.min(max, a);
			return a;
		}
		
		static public function Sign(a:Number):Number {
			return a >= 0 ? 1 : -1;
		}
		
		static public function Close(origin:Number, isIt:Number, closeValue:Number):Boolean {
			var high:Number = Math.abs(origin) + closeValue;
			var low:Number = Math.abs(origin) - closeValue;
			return (isIt > low) && (isIt < high);
		}
	}
}
