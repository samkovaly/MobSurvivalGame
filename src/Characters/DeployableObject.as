package src.Characters {
	import src.InGame.PhysicConstants;
	import src.Maths.CollideInfo;
	import src.Maths.MathVector;
	
	/**
	 * ...
	 * @author Xiler
	 */
	
	public  class DeployableObject extends MovingObject implements IAABB {
		protected const IDLE:String = "idle";
		protected const WALKING:String = "walking";
		protected const JUMPING:String = "jumping";
		protected var currentAnimation:String;
		
		private var x_halfExtents:MathVector;
		
		protected const x_groundFriction:Number = PhysicConstants.groundFriction;
		protected var x_applyFriction:Boolean;
		
		protected var x_accelerationX:Number;
		
		
		protected var x_jumpAvalable:Boolean;
		protected var x_doubleJumpAvalable:Boolean;
		protected var x_isHoldingJump:Boolean;
		protected var x_onGround:Boolean;
		protected var x_onGroundLast:Boolean;
		protected var x_tryToMove:Boolean;
		
		
		public function DeployableObject():void {
			x_applyGravity = true;
			x_applyFriction = true;
			this.x_halfExtents = new MathVector(width / 2, height / 2);
		}
		
		public function get halfExtents( ):MathVector {
			return this.x_halfExtents;
		}
		
		override public function update(timePassed:Number):void {
			if (x_velocity.x!=0 && Math.abs(x_velocity.x) < PhysicConstants.minRunSpeed) {
				x_velocity.x = 0;
				if (x_onGround) {
					setAnimation(IDLE);
				}
			}
			
			x_onGroundLast = x_onGround;
			x_onGround = false;
			
			super.update(timePassed);
			
			min.SubFrom( x_halfExtents);
			max.AddTo( x_halfExtents);
			x_mapOperator.scanMapCollisionAABB(this, x_collideInfo,collisionResponse, min, max, timePassed);
			
			if (x_velocity.y > 0 && x_onGroundLast) {
				setAnimation(JUMPING);
			}
			
			x_position.MulAddScalarTo( x_velocity.Add(x_positionCorrect), timePassed );
			position = x_position;
			x_positionCorrect.Clear( );
		}
		
		override public function collisionResponse(normal:MathVector=null, dist:Number=0, timePassed:Number=0) {
			
			// get the separation and penetration separately, this is to stop pentration 
			// from causing the objects to ping apart
			var separation:Number = Math.max(dist, 0);
			var penetration:Number = Math.min(dist, 0);
			
			// compute relative normal _velocity require to be object to an exact stop at the surface
			var nv:Number = x_velocity.Dot(normal) + separation / timePassed
			
			// accumulate the penetration correction, this is applied in Update() and ensures
			// we don't add any energy to the system
			x_positionCorrect.SubFrom(normal.MulScalar(penetration / timePassed));
			
			if (nv < 0) { // IF AN ACTUAL COLLISION
				
				// remove normal _velocity
				x_velocity.SubFrom(normal.MulScalar(nv));
				
				// is this some ground?
				if (normal.y < 0) {
					x_onGround = true;
					x_jumpAvalable = true;
					x_doubleJumpAvalable = true;
					
					// friction
					if (applyFriction) {
						// get the tanget from the normal (perp vector)
						var tangent:MathVector = normal.m_Perp;
						
						// compute the tangential _velocity, scale by friction
						var tv:Number = x_velocity.Dot(tangent) * x_groundFriction;
						
						// subtract that from the main _velocity
						x_velocity.SubFrom(tangent.MulScalar(tv));
					}
					
					if (!x_onGroundLast) {
						// landing transition to the animation of idle or walking
						if ( x_tryToMove) {
							setAnimation(WALKING);
						}else {
							setAnimation(IDLE);
						}
					}
				}
			}
		}
		public function get applyFriction():Boolean {
			return !x_tryToMove;
		}
		
		public function get groundPosition():MathVector {
			return this.center.Clone().AddYTo(this.x_halfExtents.y - (GlobalConstants.gridSize / 2));
		}
		
		protected function setAnimation(newAnimation:String):void {
			this.currentAnimation = newAnimation;
			this.gotoAndStop(this.currentAnimation);
		}
	}
}