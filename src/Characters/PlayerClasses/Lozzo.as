package src.Characters.PlayerClasses {
	import src.InGame.SubscribedEvent;
	import flash.geom.Point;
	import src.Characters.Bullets.Projectile;
	import src.Characters.Bullets.Shard;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class Lozzo extends Player {
		
		public function Lozzo() {
			x_isMelee = false;
			x_attackRate = 10; // if attack rate is low like this, then the attack rate actualy depends on the attack animation and attackFrame.
			
			x_range = 100;
			
			this.attackFrame = 5;
			x_attackType = SubscribedEvent.DATA_ATTACK_RANGED;
		}
		override protected function getProjectileType(attackPoint:Point):Projectile {
			return new Shard(this.x, this.y-35, attackPoint.x, attackPoint.y, x_projectileTarget);
		}
		override protected function setAttackAnimation() {
			attackingTop = this.attackingTopAnimation;
		}
		
	}
}