package src.Characters.Bullets {
	import src.InGame.SubscribedEvent;
	import src.Maths.MathVector;
	import src.Characters.MovingObject;
	import src.Characters.IC;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class Projectile extends MovingObject implements IC {
		protected var target:String;
		public static const TARGET_ENEMIES:String = "targetEnemies";
		public static const TARGET_PLAYER:String = "targetPlayer";
		
		private var x_radius:Number;
		protected var x_speed:Number;
		protected var x_damage:Number;
		
		// ABSTRACT CLASS FOR EITHER A PARABOLA BULLET OR A REGULAR BULLET
		public function Projectile(startingX:Number, startingY:Number, endingX:Number, endingY:Number, speed:Number, target:String=TARGET_ENEMIES):void {
			this.target = target;
			this.x_type = PROJECTILE;
			this.position = new MathVector(startingX, startingY);
			this.x_speed = speed;
			
			// MY OWN CREATION >:D
			var relativeX:Number = endingX - this.x
			var relativeY:Number = endingY - this.y
			var relativeRadius:Number = Math.sqrt(Math.pow(relativeX, 2) + Math.pow(relativeY, 2));
			
			this.x_velocity.x = (relativeX / relativeRadius) * x_speed;
			this.x_velocity.y = (relativeY / relativeRadius) * x_speed;
			this.rotation = (Math.atan2(this.x_velocity.y, this.x_velocity.x) / Math.PI) * 180;
		}
		override public function addedToStage():void {
			this.x_radius = (this.width + this.height) / 4;
			super.addedToStage();
		}
		public function get radius( ):Number {
			return this.x_radius
		}
		public function get topLeft():MathVector {
			return this.center.SubScalar(this.radius);
		}
		public function get bottomRight():MathVector {
			return this.center.AddScalar(this.radius);
		}
		
		public function get damage():Number {
			return this.x_damage;
		}
		
		override public function update(timePassed:Number):void {
			super.update(timePassed);
			
			min.SubScalarFrom(x_radius);
			max.AddScalarTo(x_radius);
			
			
			// for now, this has to come before the next two collision checks
			position = predictedPos;
			
			x_mapOperator.scanMapCollisionC(this, collisionResponse);
			if (target == TARGET_PLAYER) {
				x_mapOperator.scanPlayerCollisionC(this, collisionResponse);
			}else if (target == TARGET_ENEMIES) {
				x_mapOperator.scanEnemiesCollisionC(this, collisionResponse);
			}
		}
		override public function collisionResponse(normal:MathVector = null, dist:Number = 0, timePassed:Number = 0) {
			dispatchEvent(new SubscribedEvent(SubscribedEvent.PROJECTILE,SubscribedEvent.HIT));
		}
	}
}