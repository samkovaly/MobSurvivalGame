package src.UIPages.PrimitiveUI {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Xiler
	 */
//ABSTRACT CLASS
	public class MenuButton2 extends Sprite {
		protected var x_width:Number;
		protected var x_height:Number;
		protected var x_isListening:Boolean;
		
		private var x_clickListener:Function
		protected var x_state:Function;
		
		public function MenuButton2(newClickListener:Function = null, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) {
			this.x = x;
			this.y = y;
			this.x_width = width;
			this.x_height = height;
			
			this.addEventListener(MouseEvent.ROLL_OUT, setUpState);
			this.addEventListener(MouseEvent.ROLL_OVER, setOverState);
			this.addEventListener(MouseEvent.MOUSE_DOWN, setDownState);
			this.addEventListener(MouseEvent.MOUSE_UP, setOverState);
			
			x_clickListener = newClickListener;
			isListening = true;
		}
		public function set clickListener(newClickListener:Function):void {
			if (newClickListener == null) {
				this.removeEventListener(MouseEvent.CLICK, x_clickListener);
			}else if (this.hasEventListener(MouseEvent.CLICK)) {
				this.removeEventListener(MouseEvent.CLICK, x_clickListener);
				this.x_clickListener = newClickListener;
				this.addEventListener(MouseEvent.CLICK, x_clickListener);
			}else{
				this.x_clickListener = newClickListener;
				this.addEventListener(MouseEvent.CLICK, x_clickListener);
			}
		}
		public function get clickListener():Function {
			return this.x_clickListener;
		}
		
		public function set isListening(isIt:Boolean):void {
			x_isListening = isIt;
			if (isIt) {
				clickListener = x_clickListener;
			}else {
				clickListener = null;
			}
		}
		
		public function doState():void {
			this.x_state();
		}
		
		protected function setUpState(event:MouseEvent = null):void {
			this.x_state = setUpState;
		}
		protected function setOverState(event:MouseEvent = null):void {
			this.x_state = setOverState;
		}
		protected function setDownState(event:MouseEvent = null):void {
			this.x_state = setDownState;
		}
		
		override public function set width(value:Number):void {
			this.x_width = value;
			redrawSelf();
		}
		override public function get width():Number {
			return this.x_width;
			redrawSelf();
		}
		override public function set height(value:Number):void {
			this.x_height = value;
			redrawSelf();
		}
		override public function get height():Number {
			return this.x_height;
		}
		protected function redrawSelf():void {
			
		}
	}
}