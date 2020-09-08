package src.Characters {
	import src.Maths.MathVector;
	/**
	 * ...
	 * @author Xiler
	 */
	public class AABB implements IAABB {
		private var x_position:MathVector;
		private var x_halfExtents:MathVector;
		
		public function AABB(position:MathVector, halfExtents:MathVector) {
			this.x_position = position;
			this.x_halfExtents = halfExtents;
		}
		public function get center( ):MathVector {
			return this.x_position;
		}
		public function get halfExtents( ):MathVector {
			return this.x_halfExtents;
		}
	}
}