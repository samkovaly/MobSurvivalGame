package src.Maths {
	/**
	 * ...
	 * @author Xiler
	 */
	import src.Maths.Factorial;
	public class SmoothMotion {
		
		private var x_timesChanged:int;
		private var x_totalChanges:int;
		private var x_startPosition:int;
		private var x_endPosition:int;
		private var x_divideRatio:Number;
		private var x_currentMovementAmount:Number;
		private var x_cumulativeMovementAmount:Number;
		private var x_done:Boolean;
		
		public function SmoothMotion():void {
			x_done = true;
		}
		public function startWith(totalChanges:int, startPosition:Number, endPosition:Number, ratioOfChange:Number):void {
			//don't touch anything! It is fine!
			x_done = false;
			
			x_startPosition = startPosition;
			x_endPosition = endPosition;
			x_timesChanged = 0;
			x_totalChanges = totalChanges;
			x_divideRatio = 1 / ratioOfChange;
			var timesCounter:int = totalChanges;
			var cumulativeCounter:Number = 0;
			while (timesCounter > 0) {
				timesCounter--;
				cumulativeCounter += Math.pow(x_divideRatio, timesCounter);
			}
			var otherSideAmount = (endPosition - startPosition) * (Math.pow(x_divideRatio, (totalChanges - 1)));
			x_currentMovementAmount = (otherSideAmount / cumulativeCounter) * x_divideRatio;
			x_cumulativeMovementAmount = x_startPosition;
			
		}
		public function get nextPosition():Number {
			if (!x_done) {
				x_currentMovementAmount /= x_divideRatio;
				x_cumulativeMovementAmount += x_currentMovementAmount;
				
				x_timesChanged++;
				
				if (x_timesChanged >= x_totalChanges) {
					x_done = true;
				}
				return x_cumulativeMovementAmount
			}else {
				return x_endPosition;
			}
		}
		
		public function get isDone():Boolean {
			return this.x_done;
		}
	}
}