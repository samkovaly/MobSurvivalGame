package src.UIPages.PrimitiveUI {
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.text.TextField;
	import flash.text.TextFormat;
	import src.UIPages.PrimitiveUI.SelectableButton;
	import src.UIPages.TextCreator;
	
	public class SimpleBoxButton extends SelectableButton {
		private var textTextField:TextField;
		
		public function SimpleBoxButton(text:String, textFormat:TextFormat, clickListener:Function, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) {
			super(clickListener, x, y, width, height);
			textTextField = TextCreator.makeTextField(text, 0, 0, false, "none", x_width, x_height, textFormat);
			addChild(textTextField);
		}
	}
}