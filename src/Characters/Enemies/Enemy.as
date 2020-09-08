package src.Characters.Enemies {
	/**
	 * ...
	 * @author Xiler
	 */
	import src.Characters.Character;
	import src.Characters.PlayerClasses.Player;
	import flash.geom.Point;
	import src.InGame.SubscribedEvent;
	import src.Characters.Bullets.Projectile;
	import flash.display.MovieClip;
	import src.Maths.Collide;
	
	
	public class Enemy extends Character {
		
		private var baseAI:BaseAI;
		private var getPathCounter:int;
		private var FPS:int = GlobalConstants.FPS;
		
		private var direction:String;
		
		protected var x_player:Character;
		
		// Abstract
		public function Enemy() {
			x_type=ENEMY
			getPathCounter = FPS;
			x_dispatcher = SubscribedEvent.ENEMY;
			x_projectileTarget = Projectile.TARGET_PLAYER;
		}
		
		override public function update(timePassed:Number):void {
			
			x_tryToMove = false;
			
			turnToFace(x_player);
			if(!inRange()){
				//									    every three frames... coul maybe be FPS later...
				if (Math.floor(getPathCounter /3) >= 1) {
					direction = baseAI.getDirection(this);
					getPathCounter = 0;
				}
				switch (direction) {
					case BaseAI.RIGHT:
						moveRight();
						break;
					case BaseAI.LEFT:
						moveLeft();
						break;
					case BaseAI.JUMP:
						tryToJump();
						break;
					case BaseAI.MOVE_HORIZ:
						this.moveHorizTowards(x_player);
						break;
				}
			}
			getPathCounter++;
			
			if (attacking && MovieClip(getChildAt(0)).currentFrame == attackFrame && inRange()) {
				//actuall attack
				attack();
			}
			if (attacking && MovieClip(getChildAt(0)).currentFrame == MovieClip(getChildAt(0)).totalFrames) { // getChildAt(0) should be the attacking animation... 
				// other way is messy and involves having specific classes refer to the animation themselves..... This way will have to do....
				stopAttack();
			}
			
			super.update(timePassed);
		}
		
		public function initializeAI(baseAI:BaseAI):void {
			this.baseAI = baseAI;
			this.x_player = baseAI.player;
		}
		override protected function startAttack():void {
			x_velocity.x = 0;
			setAnimation(ATTACKING);
			super.startAttack();
		}
		override protected function stopAttack():void {
			setAnimation(IDLE);
			super.stopAttack();
		}
		override protected function wantToAttack():Boolean {
			return inRange();
		}
		override protected function attackPoint():Point {
			return x_player.center.ToPoint;
		}
		
		override protected function inRange():Boolean {
			return Collide.characterInRange(this, x_player);
			
		}
		
		public function reset():void {
			this.x_health = healthMax;
			setAnimation(IDLE);
		}
	}
}