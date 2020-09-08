package src.UIPages {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class InstanceEvent extends Event {
		public static const CREATION_READY:String = "creationReady";
		
		public static const DELETION_READY:String = "deletionReady";
		
		public function InstanceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event {
			return new InstanceEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("InstanceEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}