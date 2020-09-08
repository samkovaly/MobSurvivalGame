package src.UIPages.GameSelection {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import src.UIPages.PrimitiveUI.SelectableButton;
	import src.UIPages.TextCreator;
	import src.UIPages.PrimitiveUI.Graphic;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class SelectionBaseButton extends SelectableButton {
//CONSTANTS
		
		private const bodyTextXOffset:uint = 2.5;
		private const bodyTextYOffset:uint = 0;
		
		private const pictureXPercentTakeup:Number = 0.42;
		private const imageBorderThickness:Number = 4;
//CLASSES
		private var x_selectionBase:SelectionBase;
//CHANGE VARS
		private var oldChangeY:Number;
		private var oldChangeHeight:Number;
		private var newChangeY:Number;
		private var newChangeHeight:Number;
		
//GRAPHICS
		private var titleTextFormat:TextFormat = new TextFormat("Arial", 20, 0x000000, true, false, false, null, null, TextFormatAlign.CENTER);
		private var title:TextField;
		
		private var bodyTextFormat:TextFormat = new TextFormat("Arial", 12, 0x000000, false, false, false, null, null, TextFormatAlign.CENTER);
		private var body:TextField;
		
		private var image:Sprite;
		
		private var imageBorder:Sprite;
//TRACKERS
		private var hasSetVariables:Boolean = false;
		
		public function SelectionBaseButton(clickListener:Function,selectionBase:SelectionBase, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, selectedHeight:Number=0) {
			super(clickListener, x, y, width, height);
			
			this.x_selectionBase = selectionBase;
			
			drawGraphics(selectedHeight);
		}
		
		private function drawGraphics(selectedHeight:Number):void {
			title = TextCreator.makeTextField(x_selectionBase.title, 0, 0, true, TextFieldAutoSize.CENTER, 0, 0, titleTextFormat);
			title.x = (this.width - title.width) / 2;
			title.y=(this.height - title.height) / 2;
			addChild(title);
			
			var titleTextHeight:Number = this.height;
			
			var pictureWidth:Number = x_width * pictureXPercentTakeup;
			var bodytextWidth:Number = (x_width - pictureWidth) - (2 * bodyTextXOffset);
			var bodyTextHeight:Number = selectedHeight - (titleTextHeight + (2 * bodyTextYOffset));
			body = TextCreator.makeTextField(x_selectionBase.bodyText, bodyTextXOffset, bodyTextYOffset + titleTextHeight, false, null,
				bodytextWidth, bodyTextHeight, bodyTextFormat, false, 1, false, 0, false, 0, true);
			
			image = x_selectionBase.picture;
			image.x = body.width + (2 * bodyTextXOffset);
			image.y = titleTextHeight + bodyTextYOffset;
			image.width = x_width * pictureXPercentTakeup;
			image.height = selectedHeight - (titleTextHeight + bodyTextYOffset);
			
			imageBorder = new Sprite();
			imageBorder.x = image.x;
			imageBorder.y = image.y;
			Graphic.drawLine(imageBorder, 0, 0, image.width, 0, imageBorderThickness);
			Graphic.drawLine(imageBorder, 0, 0, 0, image.height, imageBorderThickness);
			
		}
		
		public function get data() {
			return this.x_selectionBase.data;
		}
		override public function set selected(selected:Boolean):void {
			super.selected = selected;
			
			if (selected) {
				addChild(body);
				addChild(image);
				addChild(imageBorder);
			}else {
				removeShownData();
			}
		}
		public function removeShownData():void {
			removeChild(body);
			removeChild(image);
			removeChild(imageBorder);
		}
		public function clearBackground():void {
			super.selected = false;
		}
		
		public function set changeY(newChangeY:Number) {
			this.oldChangeY = this.y;
			this.newChangeY = newChangeY;
		}
		public function get changeY():Number {
			return this.newChangeY;
		}
		public function set changeHeight(newChangeHeight:Number) {
			this.oldChangeHeight = this.height;
			this.newChangeHeight = newChangeHeight;
		}
		public function get changeHeight():Number {
			return this.newChangeHeight;
		}
		public function updateChange(percentage:Number):void {
			this.y = (newChangeY - oldChangeY) * percentage + oldChangeY
			this.height = (newChangeHeight - oldChangeHeight) * percentage + oldChangeHeight;
		}
		public function finishChange():void {
			this.y = newChangeY;
			this.height = newChangeHeight;
		}
	}
}