package src.Characters.Bullets {
	import flash.display.MovieClip;
	import src.Characters.Bullets.Projectile
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class Bullet extends Projectile {
		
		public function Bullet(startingX:Number, startingY:Number, endingX:Number, endingY:Number,speed:Number, target:String=TARGET_ENEMIES):void {
			super(startingX, startingY, endingX, endingY, speed, target);
			
			// ABSTRACT CLASS FOR A REGULAR LINEAR BULLET
			x_applyGravity = false;
		}
	}
}