package src.Characters.PlayerClasses {
	import flash.display.DisplayObjectContainer
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import src.InGame.PhysicConstants;
	import src.Maths.SmoothMotion;
	/**
	 * ...
	 * @author Xiler
	 */
	public class PlayerCamera {
		public static const cameraOffsetY:int = 75;
		public static const cameraOffsetX:int = 85;
		private const cameraSmoothRatio:Number = .88; // ratio of change of change of camera motion in the x direction
		private const directionSwitchTime:int = 850;
		
		private static var player:DisplayObjectContainer;
		private var containerToMove:DisplayObjectContainer;
		
		private var x_direction:int;
		public static const DIRECTION_LEFT:int =-1;
		public static const DIRECTION_RIGHT:int = 1;
		
		private var smoothXMotion:SmoothMotion;
		private var totalChanges:int;
		
		public function PlayerCamera(player:DisplayObjectContainer, containerToMove:DisplayObjectContainer):void {
			PlayerCamera.player = player;
			this.containerToMove = containerToMove;
			
			this.smoothXMotion = new SmoothMotion();
			totalChanges = Math.round(GlobalConstants.FPS * (directionSwitchTime / 1000));
			
			
			direction = DIRECTION_RIGHT;
			
			
			fixOnPlayer();
			
		}
		public function fixOnPlayer():void {
			
			containerToMove.x = Math.round(Math.min(Math.max( -player.x +(GlobalConstants.stageWidth / 2)- smoothXMotion.nextPosition,
				 -(containerToMove.width-GlobalConstants.stageWidth)),0));
			
			containerToMove.y = Math.round(Math.min(Math.max( -player.y +(GlobalConstants.stageHeight / 2) + cameraOffsetY,
				 - (containerToMove.height - GlobalConstants.stageHeight)), 0));
				 
			
		}
		
		public function set direction(newDirection:int):void {
			if(smoothXMotion.isDone){
				x_direction = newDirection;	
				smoothXMotion.startWith(totalChanges, cameraOffsetX * x_direction * -1, cameraOffsetX * x_direction, cameraSmoothRatio);
			}
		}
		public function get direction():int {
			return this.x_direction;
		}
		
		
		public static function get playerSeeingWindow():Rectangle {
			return new Rectangle((player.x - (GlobalConstants.stageWidth / 2)) - cameraOffsetX, (player.y - 
				(GlobalConstants.stageHeight / 2)) - cameraOffsetY,	GlobalConstants.stageWidth + (cameraOffsetX * 2), 
				GlobalConstants.stageHeight + (cameraOffsetY * 2));
		}
	}
}