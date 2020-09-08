package src{
	import flash.display.Sprite;
	import flash.events.Event;
	import src.Maps.TestMap;
	import src.UIPages.PageManager;
	import src.UIPages.InstanceEvent;
	import src.InGame.InstanceHandler;
	import src.InGame.InstanceSelection;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class Main extends Sprite {
		private var pageManager:PageManager;
		private var instanceHandler:InstanceHandler;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			//load....
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//Entry...
			instanceHandler = new InstanceHandler(this);
			pageManager = new PageManager(this);
			
			pageManager.addEventListener(InstanceEvent.CREATION_READY, createInstance);
			pageManager.addEventListener(InstanceEvent.DELETION_READY, deleteInstance);
			
			
			
		}
		private function createInstance(event:InstanceEvent = null):void {
			instanceHandler.begin();
			
		}
		private function deleteInstance(event:InstanceEvent=null):void {
			instanceHandler.end();
		}	
	}
}