package src.BackgroundArt {
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Xiler
	 */
	 
	public class Tile extends MovieClip {
		
		public function Tile(graphic:uint) {
			this.gotoAndStop(graphic);
		}
		
	}

}