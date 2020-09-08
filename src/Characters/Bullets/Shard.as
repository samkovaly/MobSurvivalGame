package src.Characters.Bullets {
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class Shard extends Bullet {
		
		public function Shard(startingX:Number, startingY:Number, endingX:Number, endingY:Number, target:String=TARGET_ENEMIES) {
			super(startingX, startingY, endingX, endingY, 1000, target); // 700 = speed
			this.x_damage = 55;
		}
	}
}