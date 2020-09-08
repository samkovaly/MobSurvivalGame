package src.Maths {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Xiler
	 */
	public class RectangleBoundaryCheck {
		
		public function RectangleBoundaryCheck() {
			
		}
		public static function rectangleWithinRectangle(smallerRectangle:Rectangle, biggerRectangle:Rectangle, pureCheck:Boolean):Boolean {
			// pureCheck means that if pureCheck is true, it returns true if the whole smallerRectangle is within the biggerRectangle, 
			// if pureCheck is false, then it returns true also if only part of the smallerRectangle is withing the biggerRectangle
			
			if (pureCheck) {
				return biggerRectangle.containsRect(smallerRectangle);
			}else {
				if (biggerRectangle.containsPoint(new Point(smallerRectangle.x , smallerRectangle.y)) 
				|| biggerRectangle.containsPoint(new Point(smallerRectangle.x + smallerRectangle.width, smallerRectangle.y))
				|| biggerRectangle.containsPoint(new Point(smallerRectangle.x , smallerRectangle.y + smallerRectangle.height))
				|| biggerRectangle.containsPoint(new Point(smallerRectangle.x + smallerRectangle.width, smallerRectangle.y + smallerRectangle.height))) {
					return true;
				}
				return false;
			}
			
		}
		public static function rectangleOutsideRectangle(smallerRectangle:Rectangle, biggerRectangle:Rectangle, pureCheck:Boolean):Boolean {
			// see above with pertaining to an 'outside of' check
			
			if (pureCheck) {
				if (!biggerRectangle.containsPoint(new Point(smallerRectangle.x , smallerRectangle.y)) 
				&& !biggerRectangle.containsPoint(new Point(smallerRectangle.x + smallerRectangle.width, smallerRectangle.y))
				&& !biggerRectangle.containsPoint(new Point(smallerRectangle.x , smallerRectangle.y + smallerRectangle.height))
				&& !biggerRectangle.containsPoint(new Point(smallerRectangle.x + smallerRectangle.width, smallerRectangle.y + smallerRectangle.height))) {
					return true;
				}
				return false;
			}else {
				return !biggerRectangle.containsRect(smallerRectangle);
			}
			
		}
	}
}