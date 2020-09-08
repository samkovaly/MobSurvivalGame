package src.Characters {
	import flash.display.MovieClip;
	import src.Characters.IAABB;
	import src.Characters.Bullets.Shard;
	import src.InGame.MapOperator;
	import src.Maths.CollideInfo;
	import src.Maths.MathVector;
	import src.InGame.PhysicConstants;
	
	/**
	 * ...
	 * @author Xiler
	 */
	
	 // GRANDFATHER ABSTRACT CLASS
	public class MovingObject extends MovieClip {
		
		protected var x_type:String;
		public static const ENEMY:String = "enemy";
		public static const PLAYER:String = "player";
		public static const PROJECTILE:String = "projectile";
		
		protected var x_mapOperator:MapOperator;
		
		protected var x_collideInfo:CollideInfo;
		
		protected var x_position:MathVector;
		protected var x_positionCorrect:MathVector;
		protected var x_velocity:MathVector;
		protected var x_applyGravity:Boolean;
		
		protected var min:MathVector;
		protected var max:MathVector;
		
		protected var predictedPos:MathVector;
		
		public function MovingObject():void {
			x_velocity = new MathVector();
			x_positionCorrect = new MathVector();
			
			x_collideInfo = new CollideInfo();
		}
		public function get type():String {
			return this.x_type;
		}
		
		public function addedToStage():void {
			this.x_position = new MathVector(x, y);
		}
		public function get center():MathVector {
			return this.x_position;
		}
		protected function set position(newPosition:MathVector):void {
			this.x_position = newPosition;
			this.x = x_position.x;
			this.y = x_position.y;
		}
		public function get velocity():MathVector {
			return this.x_velocity;
		}
		
		public function set mapOperator(mapOperator:MapOperator):void {
			this.x_mapOperator = mapOperator;
		}
		
		public function update(timePassed:Number):void {
			if (x_applyGravity) { // SOME PROJECTILES MIGHT BE FORMING PARABALAS, IDK YET...
				x_velocity.AddYTo(PhysicConstants.gravity);
				x_velocity.y = Math.min(x_velocity.y, PhysicConstants.maxFallSpeed);
			}
			
			predictedPos = x_position.Clone().MulAddScalarTo( x_velocity, timePassed );
			
			min = x_position.Min( predictedPos );
			max = x_position.Max( predictedPos );
		}
		public function collisionResponse(normal:MathVector=null, dist:Number=0, timePassed:Number=0) {
			// ABSTRACT METHOD
		}
		
		
		public function end():void {
			//adstract
		}
	}
}