package src.Characters.Enemies{
	import src.Characters.Enemies.Enemy;
	import flash.geom.Point;
	import src.InGame.SubscribedEvent;
	import src.Characters.Bullets.Bullet;
	import src.Characters.Bullets.Orb;
	import src.Characters.Bullets.Projectile;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class Entity extends Enemy {
		
		public function Entity() {
			x_isMelee = false;
			x_accelerationX = 2 * GlobalConstants.gridSize;
			x_walkSpeed = 1.75 * GlobalConstants.gridSize;
			x_jumpSpeed = 12.5 * GlobalConstants.gridSize;
			
			x_range = 250;
			x_attackRate = 2000;
			
			healthMax = 20;
			x_attackType = SubscribedEvent.DATA_ATTACK_RANGED;
			attackFrame = 20;
			reset();
		}
		override protected function getProjectileType(attackPoint:Point):Projectile {
			return new Orb(this.x, this.y+10, attackPoint.x, attackPoint.y, x_projectileTarget); // the specific thing to this Entity function is the new Orb() part.
		}
	}
}