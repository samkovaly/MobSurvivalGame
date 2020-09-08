package src.Maps {
	/**
	 * ...
	 * @author Xiler
	 */
	internal class Map implements IMap{
		protected var _xmlData:XML;
		
		public function Map() {
			
		}
		public function get xmlData():XML {
			return this._xmlData;
		}
		
		public function toString():String {
			return "I iz map";
		}
	}
}