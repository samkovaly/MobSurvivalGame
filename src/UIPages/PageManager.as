package src.UIPages {
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import src.UIPages.Pages.*;
	/**
	 * ...
	 * @author Xiler
	 */
	public  class PageManager extends EventDispatcher{
		
		private var currentPage:Page;
		
		private var enterPage:Page;
		private var mainMenuPage:Page;
		private var instanceSetupPage:Page;
		private var achievementsPage:Page;
		private var howToPlayPage:Page;
		private var inGamePage:Page;
		
		public function PageManager(displayParent:Sprite) {
			
			enterPage = new Enter(this,displayParent);
			mainMenuPage = new MainMenu(this, displayParent);
			instanceSetupPage = new InstanceSetup(this, displayParent);
			achievementsPage = new Achievements(this, displayParent);
			howToPlayPage = new HowToPlay(this, displayParent);
			inGamePage = new InGame(this, displayParent);
			
			page = enterPage
		}
		
		public function set page(pageToSet:Page):void {
			if (currentPage) {
				currentPage.unLoad();
			}
			currentPage = pageToSet;
			currentPage.load();
		}
		public function get page():Page {
			return this.currentPage;
		}
		public function get enter():Page {
			return this.enterPage;
		}
		public function get mainMenu():Page {
			return this.mainMenuPage;
		}
		public function get instanceSetup():Page {
			return this.instanceSetupPage;
		}
		public function get achievements():Page {
			return this.achievementsPage;
		}
		public function get howToPlay():Page {
			return this.howToPlayPage;
		}
		public function get inGame():Page {
			return this.inGamePage;
		}
		
		public function instanceCreationReady() {
			dispatchEvent(new InstanceEvent(InstanceEvent.CREATION_READY));
		}
		public function instanceDeletionReady() {
			dispatchEvent(new InstanceEvent(InstanceEvent.DELETION_READY));
		}
	}

}