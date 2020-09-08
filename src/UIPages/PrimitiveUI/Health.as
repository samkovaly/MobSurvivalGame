package src.UIPages.PrimitiveUI {
	import flash.display.MovieClip;
	import src.Characters.PlayerClasses.Player;
	import src.Characters.PlayerClasses.PlayerEvent;
	/**
	 * ...
	 * @author Xiler
	 */
	public class Health extends MovieClip{
		private var player:Player;
		
		public function Health(x:Number,y:Number,width:Number,height:Number):void {
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		public function initialize(player:Player):void {
			this.player = player;
			this.player.addEventListener(PlayerEvent.HEALTH_CHANGE, healthChange);
			healthChange();
		}
		private function healthChange(event:PlayerEvent=null):void {
			this.healthBar.scaleX = player.health / player.healthMax;
		}
	}
}