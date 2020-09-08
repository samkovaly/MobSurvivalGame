package src.UIPages.PrimitiveUI {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import src.UIPages.PrimitiveUI.Graphic;
	/**
	 * ...
	 * @author Xiler
	 */
	public class SelectableButton extends MenuButton2 {
		protected const borderThickness:Number = 4;
		
		
		protected var backgroundLayer:Sprite;
		private var border:Sprite;
		
		protected var x_selected:Boolean = false;
		
		//ABSTRACT CLASS
		public function SelectableButton(clickListener:Function, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0):void {
			super(clickListener, x, y, width, height);
			
			backgroundLayer = new Sprite()
			addChild(backgroundLayer);
			
			border = new Sprite();
			addChild(border);
			
			x_state = setUpState;
			redrawSelf();
		}
		
		override protected function setUpState(event:MouseEvent = null):void {
			if (!x_selected) {
				super.setUpState();
				if (x_isListening) {
					setBackgroundColor(upColor, upAlpha);
				}
			}
		}
		override protected function setOverState(event:MouseEvent = null):void {
			if (!x_selected) {
				super.setOverState();
				if (x_isListening) {
					setBackgroundColor(overColor, overAlpha);
				}
			}
		}
		override protected function setDownState(event:MouseEvent = null):void {
			if (!x_selected) {
				super.setDownState();
				if (x_isListening) {
					setBackgroundColor(overColor, overAlpha);
				}
			}
		}
		protected function setSelectedState(event:MouseEvent = null):void {
			setBackgroundColor(selectedColor, selectedAlpha);
			x_state = setSelectedState;
		}
		
		public function set selected(selected:Boolean):void {
			this.x_selected = selected;
			
			if (selected) {
				setSelectedState();
			}else {
				setUpState();
			}
		}
		public function get selected():Boolean {
			return this.x_selected;
		}
		
		protected function setBackgroundColor(color:Number, alpha:Number):void {
			removeBackgroundColor();
			Graphic.drawRect(backgroundLayer, 0, 0, x_width, x_height, alpha, color);
		}
		
		
		override protected function redrawSelf():void {
			border.graphics.clear();
			Graphic.drawOutline(border, 0, 0, x_width, x_height, borderThickness);
			x_state();
		}
		
		private function removeBackgroundColor():void {
			backgroundLayer.graphics.clear();
		}
		protected function get upColor():Number {
			return 0xFFFFFF
		}
		protected function get upAlpha():Number {
			return 1;
		}
		protected function get overColor():Number {
			return 0xAC1702
		}
		protected function get overAlpha():Number {
			return 1;
		}
		protected function get selectedColor():Number {
			return 0xAC1702
		}
		protected function get selectedAlpha():Number {
			return 1;
		}
	}
}