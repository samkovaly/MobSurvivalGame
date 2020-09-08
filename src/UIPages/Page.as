package src.UIPages {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import src.UIPages.PrimitiveUI.SimpleBoxButton;
	/**
	 * ...
	 * @author Xiler
	 */
	//ABSTRACT CLASS!!!
	public class Page extends Sprite {
		
		public static const MAIN_MENU_HEIGHT:uint = 35;
		
		protected var displayParent:Sprite;
		protected var pageManager:PageManager;
		
		protected var mainMenu:SimpleBoxButton;
		protected var mainMenuTextFormat:TextFormat = new TextFormat("Arial", 25, 0x000000, true, false, false, null, null, TextFormatAlign.CENTER);
		
		public function Page(pageManager:PageManager, displayParent:Sprite,initiateMainMenu:Boolean=false) {
			this.pageManager = pageManager;
			this.displayParent = displayParent;
			
			if (initiateMainMenu) {
				mainMenu = new SimpleBoxButton("Main Menu", mainMenuTextFormat, toMainMenu, 0,
					GlobalConstants.stageHeight - MAIN_MENU_HEIGHT, GlobalConstants.stageWidth / 3, MAIN_MENU_HEIGHT);
				addChild(mainMenu);
			}
		}
		public function load() {
			displayParent.addChild(this);
		}
		public function unLoad() {
			displayParent.removeChild(this);
		}
		protected function toMainMenu(event:MouseEvent):void {
			pageManager.page = pageManager.mainMenu;
		}
	}
}