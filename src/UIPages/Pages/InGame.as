package src.UIPages.Pages {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import src.UIPages.Page;
	import src.UIPages.PageManager;
	import src.UIPages.PrimitiveUI.MenuButton;
	import src.UIPages.PrimitiveUI.Health;
	import src.InGame.GameManager;
	
	import src.Characters.PlayerClasses.Player;

	/**
	 * ...
	 * @author Xiler
	 */
	public final class InGame extends Page {
		
		private var Mm:MenuButton;
		private var healthBar:Health;
		
		private var player:Player;
		
		public function InGame(pageManager:PageManager,displayParent:Sprite) {
			super(pageManager, displayParent);
			
			Mm = new MenuButton(true, toMainMenu, "Main Menu", GlobalConstants.stageWidth-(75/2+10), GlobalConstants.stageHeight-(20+10), 75, 20, 0);
			addChild(Mm);
			
			healthBar = new Health(GlobalConstants.stageWidth/2,GlobalConstants.stageHeight-(17.5),100,15);
			addChild(healthBar);
		}
		override protected function toMainMenu(event:MouseEvent):void {
			pageManager.instanceDeletionReady();
			pageManager.page = pageManager.mainMenu;
		}
		override public function load() {
			super.load();
			
			this.player = Player.instance;
			
			healthBar.initialize(player);
		}
	}
}