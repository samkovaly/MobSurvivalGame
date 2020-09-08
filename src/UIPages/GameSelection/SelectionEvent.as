package src.UIPages.GameSelection {
	import flash.events.Event;
	import src.Maps.IMap;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class SelectionEvent extends Event {
		public static const SELECTION_DONE:String = "selectionDone";
		
		private var x_mapSelection:IMap;
		private var x_enemySelection:String;
		private var x_playerSelection:String;
		
		public function SelectionEvent(type:String, mapSelection:IMap, enemySelection:String, playerSelection:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			this.x_mapSelection = mapSelection;
			this.x_enemySelection = enemySelection;
			this.x_playerSelection = playerSelection;
		} 
		
		public override function clone():Event {
			return new SelectionEvent(type, x_mapSelection,	x_enemySelection,	x_playerSelection, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("SelectionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get mapSelection():IMap {
			return this.x_mapSelection;
		}
		public function get enemySelection():String {
			return this.x_enemySelection;
		}
		public function get playerSelection():String {
			return this.x_playerSelection;
		}
	}
}