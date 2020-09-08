package src.Characters.Enemies{
	import flash.geom.Point;
	import src.InGame.SubscribedEvent;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class Zombie extends Enemy {
		
		public function Zombie() {
			x_isMelee = true;
			x_accelerationX = .5 * GlobalConstants.gridSize;
			x_walkSpeed = .85 * GlobalConstants.gridSize;
			x_jumpSpeed = 0 * GlobalConstants.gridSize; // does not jump
			
			x_range = this.halfExtents.x;
			x_hitDamage = 35;
			x_attackRate = 1000;
			
			healthMax = 110;
			x_attackType = SubscribedEvent.DATA_ATTACK_MELEE;
			attackFrame = 10;
			reset();
		}
	}
}