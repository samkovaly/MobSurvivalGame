package src.Characters {
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import src.Characters.Bullets.Projectile;
	import src.InGame.SubscribedEvent;
	import src.Maths.Scalar;
	/**
	 * ...
	 * @author Xiler
	 */
	public class Character extends DeployableObject {
		
		protected var x_facingDirection:int = 1;
		
		protected var x_jumpSpeed:Number;
		protected var x_walkSpeed:Number;
		
		protected var x_hitDamage:Number;
		public var healthMax:uint;
		protected var x_health:uint;
		protected var x_isMelee:Boolean;
		protected var x_range:Number;
		
		protected var x_projectileTarget:String;
		protected var x_dispatcher:String;
		protected var x_attackType:String;
		
		protected var x_attackRate:Number;
		protected var attackTimer:Timer;
		protected var readyToAttack:Boolean = true;
		protected var attacking:Boolean;
		protected var attackFrame:int;
		protected const ATTACKING:String = "Attacking"; // Enemy classes use this as it is, while player classes append this to whatever
		// animation is currently playing.
		
		public function Character() {
			
		}
		public function get facingDirection():int {
			return this.x_facingDirection;
		}
		public function set facingDirection(newDirection:int):void {
			this.x_facingDirection = newDirection;
			this.scaleX = this.x_facingDirection;
		}
		public function get range():Number {
			return this.x_range;
		}
		public function get hitDamage():Number {
			return this.x_hitDamage;
		}
		override public function update(timePassed:Number):void {
			x_velocity.x = Scalar.Clamp( x_velocity.x, -x_walkSpeed, x_walkSpeed);
			
			if (wantToAttack() && readyToAttack) {
				startAttack();
			}
			
			if (currentAnimation == IDLE && x_tryToMove) {
				setAnimation(WALKING);
			}
			
			super.update(timePassed);
		}
		
		private function attackTimerEvent(event:TimerEvent):void {
			attackTimer.stop();
			readyToAttack = true;
		}
		
		protected function moveLeft():void {
				x_velocity.AddXTo( -x_accelerationX);
				facingDirection= -1;
				this.scaleX = x_facingDirection;
				x_tryToMove = true;
		}
		protected function moveRight():void {
				x_velocity.AddXTo( x_accelerationX);
				facingDirection = 1;
				this.scaleX = x_facingDirection;
				x_tryToMove = true;
		}
		protected function tryToJump():void {
			if (x_jumpAvalable && x_onGround && !x_isHoldingJump) {
				x_jumpAvalable = false;
				x_doubleJumpAvalable = true;
				x_velocity.AddYTo( -x_jumpSpeed);
				setAnimation(JUMPING);
			}else if (canDoubleJump && !x_isHoldingJump && !x_onGround && x_doubleJumpAvalable) {
				x_doubleJumpAvalable = false;
				x_velocity.AddYTo( -x_jumpSpeed-x_velocity.y);
			}
		}
		
		protected function get canDoubleJump():Boolean {
			return false;
		}
		
		public function get health():Number {
			return this.x_health;
		}
		public function damage(amount:Number):void {
			x_health = Math.max(x_health - amount, 0);
			if (x_health == 0) {
				die();
			}
		}
		
		public function die():void {
			dispatchEvent(new SubscribedEvent(SubscribedEvent.CHARACTER,SubscribedEvent.DIE));
		}
		
		public function moveHorizTowards(other:Character):void {
			if (other.x < this.x) {
				moveLeft();
			}else {
				moveRight();
			}
		}
		public function turnToFace(other:Character):void {
			if (other.x < this.x) {
				facingDirection = -1;
			}else {
				facingDirection = 1;
			}
		}
		
		protected function wantToAttack():Boolean {
			return false;
		}
		protected function attackPoint():Point {
			return null;
		}
		
		protected function startAttack():void {
			attacking = true;
		}
		protected function stopAttack():void {
			attacking = false;
		}
		protected function attack():void {
			var subscribedEvent:SubscribedEvent = new SubscribedEvent(x_dispatcher, SubscribedEvent.ATTACK);
			var newProjectile:Projectile;
			if (!x_isMelee) { // if is ranged
				newProjectile = getProjectileType(attackPoint()); //get projectile associated with this ranged class
			}else {
				subscribedEvent.inputDamageAmount(x_hitDamage);
			}
			subscribedEvent.inputAttackData(x_attackType, newProjectile); // newProjectile will be null for melee characters
			dispatchEvent(subscribedEvent);
			
			
			readyToAttack = false;
			attackTimer.start();
		}
		protected function getProjectileType(attackPoint:Point):Projectile {
			return null; //just so it returns something. (eyes roll)
		}
		protected function inRange():Boolean {
			// abstract
			return false;
		}
		
		public function initialize():void {
			attackTimer = new Timer(x_attackRate, 0);
			attackTimer.addEventListener(TimerEvent.TIMER, attackTimerEvent);
			setAnimation(IDLE);
		}
		override public function end():void {
			attackTimer.stop();
			attackTimer.removeEventListener(TimerEvent.TIMER, attackTimerEvent);
		}
	}
}