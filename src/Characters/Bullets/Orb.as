package src.Characters.Bullets {
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class Orb extends Bullet {
		
		public function Orb(startingX:Number, startingY:Number, endingX:Number, endingY:Number, target:String=TARGET_ENEMIES) {
			super(startingX, startingY, endingX, endingY, 400, target); // 400 is its speed
			this.x_damage = 40;
		}
	}
}