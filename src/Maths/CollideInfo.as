package src.Maths {
	/**
	 * ...
	 * @author Xiler
	 */
	public final class CollideInfo {
		public var normal:MathVector;
		public var dist:Number;
		
		public function setCollides(normal:MathVector,dist:Number) {
			this.normal = normal;
			this.dist = dist;
		}
		public function toString():String {
			return "normal: ".concat(normal).concat(" | dist: ").concat(dist);
		}
	}

}