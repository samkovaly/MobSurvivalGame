package src.Characters.PlayerClasses {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class PlayerEvent extends Event {
		public static const HEALTH_CHANGE:String = "healthChange";
		public static const DIE:String = "die";
		
		public function PlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event {
			return new PlayerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("PlayerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}