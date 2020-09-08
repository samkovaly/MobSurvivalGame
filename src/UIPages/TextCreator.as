package src.UIPages{
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	
	public class  TextCreator{
		
		/**
		 * Returns a textfield with the specified settings
		 * @param 		text					..if you don't know what this is then just get out.
		 * @param 		originX			starting point X
		 * @param 		originY			starting point Y
		 * @param			toAutoSize		If you want to use an autosizer or not
		 * @param 		autoSize			use TextFieldAutoSize.NONE for none.. use others for others
		 * @param 		width				width
		 * @param 		height				height
		 * @param 		textFormat		TextFormat object to which you supply
		 * @param 		selectable		wether select cursor shows up
		 * @param 		alpha				visibility (0-1)
		 * @param 		background	whether it has a background or not
		 * @param 		backgroundColor	color for background if you have one
		 * @param 		border					Wether a border is used
		 * @param 		borderColor			color for your border
		 * @param 		wordWrap				Wether to wordwrap when lines go past the width
		 * @param 		multiline					Wether it can have more than one line
		 * @param 		type						types.. like TextFieldType.INPUT, and ya...
		 */
		public static function makeTextField(text:String = "hi", originX:Number = 0, originY:Number = 0,toAutoSize:Boolean=false, autoSize:String = TextFieldAutoSize.LEFT, width:Number = 100, height:Number = 100,textFormat:TextFormat = null, selectable:Boolean = false, alpha:Number = 1, background:Boolean = false,backgroundColor:uint = 0xFFFFFF, border:Boolean = false, borderColor:uint = 0xFFFFFF, wordWrap:Boolean = false,multiline:Boolean=false,type:String=TextFieldType.DYNAMIC):TextField {
			var newTextField:TextField = new TextField();
			newTextField.text = text;
			newTextField.x = originX;
			newTextField.y = originY;
			if (toAutoSize) {
				newTextField.autoSize = autoSize;
			}else{
				newTextField.width = width;
				newTextField.height = height;
			}
			newTextField.background = background;
			newTextField.backgroundColor = backgroundColor;
			newTextField.border = border;
			newTextField.borderColor = borderColor;
			newTextField.setTextFormat(textFormat);
			newTextField.selectable = selectable;
			newTextField.alpha = alpha;
			newTextField.wordWrap = wordWrap;
			newTextField.multiline = multiline;
			newTextField.type = type;
			return newTextField;
		}
	}
}