package src.UIPages.Pages {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import src.UIPages.Page;
	import src.UIPages.PageManager;
	
	import src.InGame.InstanceSelection;
	import src.UIPages.GameSelection.GameSelectionHead;
	import src.UIPages.GameSelection.SelectionEvent;
	import src.UIPages.PrimitiveUI.SimpleBoxButton;
	/**
	 * ...
	 * @author Xiler
	 */
	public final class InstanceSetup extends Page {
		public const titleHeight:uint = Page.MAIN_MENU_HEIGHT;
		
		private var gameSelection:GameSelectionHead;
		
		public function InstanceSetup(pageManager:PageManager, displayParent:Sprite) {
			
			super(pageManager, displayParent, true);
			
			gameSelection = new GameSelectionHead(titleHeight,"MAP SELECTION","Begin");
			addChild(gameSelection);
			gameSelection.addEventListener(SelectionEvent.SELECTION_DONE, readyToLaunch);
			
			setChildIndex(mainMenu, numChildren - 1);
		}
		private function readyToLaunch(event:SelectionEvent = null):void {
			InstanceSelection.map = event.mapSelection;
			InstanceSelection.enemyType = event.enemySelection;
			InstanceSelection.playerType = event.playerSelection;
			pageManager.instanceCreationReady();
			pageManager.page = pageManager.inGame;
		}
	}
}