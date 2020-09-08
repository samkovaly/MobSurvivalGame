package src.UIPages.Pages {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import src.UIPages.Page;
	import src.UIPages.PageManager;
	import src.UIPages.PrimitiveUI.MenuButton;
	import src.UIPages.TextCreator;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public final class Enter extends Page {
		private var enter:MenuButton;
		private var titleText:TextField;
		
		public function Enter(pageManager:PageManager,displayParent:Sprite) {
			super(pageManager, displayParent);
			
			
			titleText = TextCreator.makeTextField(GlobalConstants.title, (GlobalConstants.stageWidth/2)-200, 35, true, TextFieldAutoSize.LEFT, 0, 0,
				new TextFormat("Arial", 50, 0x0072A8, true, true),  false, 1, false, 0, false, 0,false);
			addChild(titleText);
			
			enter = new MenuButton(true,enterListener,"Enter",GlobalConstants.stageWidth/2,375,350,25);
			addChild(enter);
		}
		private function enterListener(event:MouseEvent=null):void {
			pageManager.page = pageManager.mainMenu;
		}
	}
}