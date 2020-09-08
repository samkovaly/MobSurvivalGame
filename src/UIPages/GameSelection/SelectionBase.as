package src.UIPages.GameSelection {
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Xiler
	 */
	internal class SelectionBase {
		//DATA
		private var x_title:String;
		private var x_picture:Sprite;
		private var x_bodyText:String;
		private var x_data;
		
		public function SelectionBase(title:String, picture:Sprite, bodyText:String, data):void {
			
			this.x_title = title;
			this.x_picture = picture;
			this.x_bodyText = bodyText;
			this.x_data = data;
			
		}
		
		public function get title():String {
			return this.x_title;
		}
		public function get picture():Sprite {
			return this.x_picture;
		}
		public function get bodyText():String {
			return this.x_bodyText;
		}
		public function get data() {
			return this.x_data;
		}
		
		public function toString():String {
			return this.x_title.concat(this.x_picture).concat(this.x_bodyText).concat(this.x_data);
		}
	}
}