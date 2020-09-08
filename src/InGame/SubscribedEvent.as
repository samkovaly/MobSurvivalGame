package src.InGame {
	import flash.events.Event;
	import src.Characters.Bullets.Projectile;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class SubscribedEvent extends Event {
		//who dispatched it?
		private var x_dispatcher:String;
		public static const PLAYER:String = "player";
		public static const ENEMY:String = "enemy";
		public static const CHARACTER:String = "character";
		public static const PROJECTILE:String = "projectile";
		//types of event
		public static const ATTACK:String = "attack";
		public static const HIT:String = "hit";
		public static const CHARACTER_DAMAGED:String = "characterDamaged";
		public static const DIE:String = "die";
		//data for events (not always used)
		public static const DATA_ATTACK_MELEE:String = "melee";
		public static const DATA_ATTACK_RANGED:String = "ranged";
		private var x_typeOfAttack:String;
		private var x_typeOfProjectile:Projectile;
		private var x_damageAmount:Number;
		
		public function SubscribedEvent(dispatcher:String, type:String,  bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			this.x_dispatcher = dispatcher;
			
		}
		public function get dispatcher():String {
			return this.x_dispatcher;
		}
		
		public function inputAttackData(typeOfAttack:String, typeOfProjectile:Projectile = null) {
			this.x_typeOfAttack = typeOfAttack;
			this.x_typeOfProjectile = typeOfProjectile;
		}
		
		public function get typeOfAttack():String {
			return this.x_typeOfAttack;
		}
		public function get typeOfProjectile():Projectile{
			return this.x_typeOfProjectile;
		}
		
		public function inputDamageAmount(amount:Number):void {
			this.x_damageAmount = amount;
		}
		public function get damageAmount():Number {
			return this.x_damageAmount;
		}
		
		public override function clone():Event {
			return new SubscribedEvent(this.x_dispatcher,this.type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return this.x_dispatcher.concat(" ").concat(this.type).concat(" ").concat(this.x_typeOfAttack).concat(" ")
				.concat(this.x_typeOfProjectile).concat(" ").concat(this.x_damageAmount);
		}
	}
}