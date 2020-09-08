package src.Maths {
	/**
	 * ...
	 * @author Xiler
	 */
	public class Factorial {
		
		public function Factorial() {
			
		}
		public static function Additive(n:int):int {
			var returnNumber:int = 0;
			while (n > 0) {
				returnNumber += n;
				n--;
			}
			return returnNumber;
		}
		
		public static function Multiplicative(n:int):int {
			var returnNumber:int = 1;
			while (n > 0) {
				returnNumber *= n;
				n--;
			}
			return returnNumber;
		}
	}
}