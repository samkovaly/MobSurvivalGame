package src.UIPages.Pages {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import src.UIPages.Page;
	import src.UIPages.PageManager;
	import src.UIPages.PrimitiveUI.MenuButton;
	import src.InGame.InstanceSelection;
	/**
	 * ...
	 * @author Xiler
	 */
	public final class MainMenu extends Page {
		private const middleX:uint = GlobalConstants.stageWidth / 2;
		private const spacingY:uint = 65;
		private const offsetY:uint = 150;
		private const buttonWidth:uint = 550;
		private const buttonHeight:uint = 45;
		
		private var quickPlay:MenuButton;
		private var setupSurvival:MenuButton;
		private var achievements:MenuButton;
		private var howToPlay:MenuButton;
		
		
		public function MainMenu(pageManager:PageManager,displayParent:Sprite) {
			super(pageManager, displayParent);
			
			quickPlay = new MenuButton(false, quickPlayListener, "Quick Play", middleX, 						spacingY*0 + offsetY , buttonWidth, buttonHeight);
			setupSurvival = new MenuButton(true, setupSurvivalListener, "Survival", middleX, 			spacingY*1 + offsetY, buttonWidth, buttonHeight);
			achievements = new MenuButton(false, achievementsListener, "Achievements", middleX, spacingY*2 + offsetY, buttonWidth, buttonHeight);
			howToPlay = new MenuButton(false, howToPlayListener, "How to Play", middleX, 			spacingY*3  +offsetY, buttonWidth, buttonHeight);
			addChild(quickPlay);
			addChild(setupSurvival);
			addChild(achievements);
			addChild(howToPlay);
			
			
		}
		private function quickPlayListener(event:MouseEvent):void {
			InstanceSelection.map = InstanceSelection.MAP_RANDOM;
			InstanceSelection.enemyType = InstanceSelection.ENEMY_TYPE_RANDOM;
			InstanceSelection.playerType = InstanceSelection.PLAYER_TYPE_RANDOM;
			pageManager.instanceCreationReady();
			pageManager.page = pageManager.inGame;
		}
		private function setupSurvivalListener(event:MouseEvent):void {
			this.pageManager.page = pageManager.instanceSetup;
		}
		private function achievementsListener(event:MouseEvent):void {
			this.pageManager.page = pageManager.achievements;
		}
		private function howToPlayListener(event:MouseEvent):void {
			this.pageManager.page = pageManager.howToPlay;
		}
	}
}