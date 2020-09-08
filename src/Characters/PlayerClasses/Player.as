package src.Characters.PlayerClasses {
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import src.InGame.SubscribedEvent;
	import src.Maths.MathVector;
	import src.Characters.Character;
	import src.Characters.Bullets.Projectile;
	
	public class Player extends Character {
		protected var IDLE_ATTACKING:String;
		protected var WALKING_ATTACKING:String;
		protected var JUMPING_ATTACKING:String;
		
		
		public static var instance:Player;
		
		private var controls:PlayerControls;
		private var camera:PlayerCamera;
		
		protected var attackingTop:MovieClip; 
		protected var attackingAnimationPlaying:Boolean;
		
		public function Player() {
			IDLE_ATTACKING = IDLE.concat(ATTACKING);
			WALKING_ATTACKING = WALKING.concat(ATTACKING);
			JUMPING_ATTACKING = JUMPING.concat(ATTACKING);
			x_type = PLAYER;
			instance = this;
			x_accelerationX = 1 * GlobalConstants.gridSize;
			x_walkSpeed = 3 * GlobalConstants.gridSize;
			x_jumpSpeed = 15 * GlobalConstants.gridSize;
			
			healthMax = 500;
			x_health = healthMax;
			x_dispatcher = SubscribedEvent.PLAYER;
			x_projectileTarget = Projectile.TARGET_ENEMIES;
		}
		
		override protected function get canDoubleJump():Boolean {
			return true;
		}
		
		override public function update(timePassed:Number):void {
			keyboardControls();
			if (attacking && attackingTop.currentFrame == attackFrame) {
				//actuall attack
				attack();
			}
			if (attacking && attackingTop.currentFrame == attackingTop.totalFrames) {
				stopAttack();
			}
			
			if (currentAnimation == IDLE_ATTACKING && x_tryToMove) {
				setAnimation(WALKING);
			}
			
			super.update(timePassed);
			
			camera.fixOnPlayer();
		}
		private function keyboardControls():void {
			x_tryToMove = false;
			if (controls.getKeyCode(Keyboard.A)) {
				moveLeft();
			}
			if (controls.getKeyCode(Keyboard.D)) {
				moveRight();
			}
			if (controls.getKeyCode(Keyboard.W)) {
				tryToJump();
				x_isHoldingJump = true;
			}else {
				x_isHoldingJump = false;
			}
			
			controls.updateCameraDirection();
			
			
		}
		public function setCameraAndControls(stage:DisplayObjectContainer, cameraWillMoveSprite:DisplayObjectContainer):void {
			camera = new PlayerCamera(this, cameraWillMoveSprite);
			controls = new PlayerControls(stage,cameraWillMoveSprite,camera);
		}
		
		override protected function wantToAttack():Boolean {
			return controls.mouseDown && !attacking && inRange();
		}
		override protected function attackPoint():Point {
			return controls.getattackPoint();
		}
		override protected function startAttack():void {
			super.startAttack();
			setAnimation(currentAnimation);
		}
		override protected function stopAttack():void {
			super.stopAttack();
			setAnimation(currentAnimation);
		}
		override protected function setAnimation(newAnimation:String):void {
			var attackAnimationFrame:int = -1; // -1 by default, so not continueing an attack animation across animation lines by default
			if (attacking) {
				if (attackingAnimationPlaying) {
					attackAnimationFrame = attackingTop.currentFrame;
				}
				newAnimation = newAnimation.concat(ATTACKING);
				attackingAnimationPlaying = true;
			}else if (attackingAnimationPlaying) {
				newAnimation = newAnimation.replace(ATTACKING,"");
				attackingAnimationPlaying = false;
			}
			super.setAnimation(newAnimation);
			if (attacking) {
				setAttackAnimation();
				if (attackAnimationFrame != -1) {
					attackingTop.gotoAndPlay(attackAnimationFrame);
				}
			}
		}
		protected function setAttackAnimation() {
			// specific classes to ovveride and set a varialbe that only their symbol counterparts can set.
		}
		override protected function inRange():Boolean {
			// hit detecion occurs at the GameManager level...
			return true;
		}
		override public function damage(amount:Number):void {
			super.damage(amount);
			dispatchEvent(new PlayerEvent(PlayerEvent.HEALTH_CHANGE));
		}
		override public function initialize():void {
			stop();
			super.initialize();
		}
	}
}