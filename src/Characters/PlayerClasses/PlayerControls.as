package src.Characters.PlayerClasses {
	import flash.display.DisplayObjectContainer
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Xiler
	 */
	internal class PlayerControls {
		private var stage:DisplayObjectContainer;
		private var cameraWillMoveSprite:DisplayObjectContainer;
		private var playerCamera:PlayerCamera;
		
		private var keyCodes:Array;
		private var x_mouseDown:Boolean;
		
		private var switchSide:String;
		
		public function PlayerControls(stage:DisplayObjectContainer, cameraWillMoveSprite:DisplayObjectContainer, playerCamera:PlayerCamera) {
			this.stage = stage;
			this.cameraWillMoveSprite = cameraWillMoveSprite;
			this.playerCamera = playerCamera;
			
			
			keyCodes = new Array();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void {
			keyCodes[event.keyCode] = true;
		}
		private function keyUpHandler(event:KeyboardEvent):void {
			keyCodes[event.keyCode] = false;
		}
		public function getKeyCode(keyCode:int):Boolean {
			return keyCodes[keyCode];
		}
		
		private function mouseDownListener(event:MouseEvent):void {
			x_mouseDown = true;
		}
		private function mouseUpListener(event:MouseEvent):void {
			x_mouseDown = false;
		}
		public function get mouseDown():Boolean {
			return x_mouseDown;
		}
		public function getattackPoint():Point {
			return new Point(cameraWillMoveSprite.mouseX, cameraWillMoveSprite.mouseY);
		}
		
		public function updateCameraDirection():void {
			if (playerCamera.direction == PlayerCamera.DIRECTION_LEFT) {
				if (stage.mouseX > (GlobalConstants.stageWidth / 2) + PlayerCamera.cameraOffsetX) {
					playerCamera.direction = PlayerCamera.DIRECTION_RIGHT;
				}
			}else {
				if (stage.mouseX < (GlobalConstants.stageWidth / 2) - PlayerCamera.cameraOffsetX) {
					playerCamera.direction = PlayerCamera.DIRECTION_LEFT
				}
			}
		}
	}
}