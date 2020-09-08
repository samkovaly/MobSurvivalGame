package src.UIPages.PrimitiveUI {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import src.UIPages.UIConstants;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class MenuButton extends MovieClip {
		public static const UP:uint = 1;
		public static const OVER:uint = 2;
		public static const DOWN:uint = 3;
		
		//private var conversionWidth:Number;
		//private var conversionHeight:Number;
		
		public function MenuButton(active:Boolean,clickListener:Function,label:String = "Xiler",x:Number = UIConstants.DEFAULT_X,y:Number = UIConstants.DEFAULT_Y, 
			width:Number = UIConstants.DEFAULT_BTN_WIDTH, height:Number = UIConstants.DEFAULT_BTN_HEIGHT,hitAreaExtent:Number=UIConstants.DEFAULT_EXTENT) {
			
			
			this.initialize(active,label, x, y, width, height,hitAreaExtent);
			
			setUpState();
			this.addEventListener(MouseEvent.MOUSE_OUT, setUpState);
			this.addEventListener(MouseEvent.MOUSE_OVER, setOverState);
			this.addEventListener(MouseEvent.MOUSE_DOWN, setDownState);
			this.addEventListener(MouseEvent.MOUSE_UP, setOverState);
			
			this.addEventListener(MouseEvent.CLICK, clickListener);
		}
		private function initialize(active:Boolean, label:String, x:Number, y:Number, width:Number, height:Number,hitAreaExtent:Number):void {
			enabled = active;
			
			generateHitArea(hitAreaExtent);
			
			//conversionWidth = this.width / width;
			//conversionHeight = this.height / height;
			
			this.label = label;
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height + hitAreaExtent * 2;
			
		}
		public function set label(newLabel:String):void {
			_textField.text = newLabel;
		}
		
		private function setUpState(event:MouseEvent=null):void {
			this.gotoAndStop(UP);
		}
		private function setOverState(event:MouseEvent=null):void {
			this.gotoAndStop(OVER);
		}
		private function setDownState(event:MouseEvent=null):void {
			this.gotoAndStop(DOWN);
		}
		
		private function generateHitArea(hitAreaExtent:Number) {
			var newHitArea:Sprite = new Sprite();
			newHitArea.graphics.beginFill(0xFFFFFF, 0);
			
			//var newWidth:Number = this.width * conversionWidth;
			//var newHeight:Number = this.height * conversionHeight;
			
			newHitArea.graphics.drawRect( -((width / 2) + hitAreaExtent), -hitAreaExtent, width + (hitAreaExtent * 2), height + (hitAreaExtent * 2));
			addChild(newHitArea);
			
		}
	}
}