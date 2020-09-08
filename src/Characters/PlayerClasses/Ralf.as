package src.Characters.PlayerClasses {
	import src.InGame.SubscribedEvent;
	
	
	
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class Ralf extends Player {
		
		public function Ralf() {
			x_isMelee = true;
			x_attackRate = 1000;
			x_hitDamage = 1000;
			x_range = this.halfExtents.x ; //normal for all melee (except for a possible future hand-bending character which used ranged attacks
				// that specify as melee (just has a huge range - to compensate);
			this.attackFrame = 10;
			x_attackType = SubscribedEvent.DATA_ATTACK_MELEE;
		}
		override protected function setAttackAnimation() {
			attackingTop = this.attackingTopAnimation;
		}
	}
}