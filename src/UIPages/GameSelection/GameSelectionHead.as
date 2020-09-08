package src.UIPages.GameSelection {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import src.UIPages.TextCreator;
	import src.UIPages.PrimitiveUI.Graphic;
	import src.UIPages.PrimitiveUI.SimpleBoxButton;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class GameSelectionHead extends Sprite {
//CONSTANTS
		private var selectionData:SelectionData;
		
		private var mapSelection:TypeSelection;
		private var enemySelection:TypeSelection;
		private var playerSelection:TypeSelection;
		
		//GRAPHICS
		private var headTextField:TextField;
		private var headTextFormat:TextFormat = new TextFormat("Arial", 30, 0x000000, true, false, false, null, null, TextFormatAlign.CENTER);
		private var beginTextFormat:TextFormat = new TextFormat("Arial", 25, 0x000000, true, false, false, null, null, TextFormatAlign.CENTER);
		private var beginButton:SimpleBoxButton;
		
		public function GameSelectionHead(titleHeight:uint,headText:String,beginText:String,x:Number=0,y:Number=0, width:Number=0,height:Number=0) {
			this.selectionData = new SelectionData();
			
//GRPAHICS
//THREE SELECTION COLUMNS
			mapSelection = new TypeSelection("MAP", selectionData.mapPackage, titleHeight);
			mapSelection.y = titleHeight;
			addChild(mapSelection);
			
			enemySelection = new TypeSelection("ENEMY", selectionData.enemyPackage, titleHeight);
			enemySelection.x = GlobalConstants.stageWidth / 3;
			enemySelection.y = titleHeight;
			addChild(enemySelection);
			
			playerSelection = new TypeSelection("CHARACTER", selectionData.playerPackage, titleHeight);
			playerSelection.x = GlobalConstants.stageWidth * (2 / 3);
			playerSelection.y = titleHeight;
			addChild(playerSelection);
//TITLE OF PAGE
			this.headTextField = TextCreator.makeTextField(headText, 0, 0, false, "none", GlobalConstants.stageWidth, 40, headTextFormat);
			addChild(this.headTextField);
			Graphic.drawLine(this,0, titleHeight, GlobalConstants.stageWidth, titleHeight, 4);
//BEGIN BUTTON
			beginButton = new SimpleBoxButton(beginText,beginTextFormat,Begin, GlobalConstants.stageWidth/3, GlobalConstants.stageHeight - titleHeight, GlobalConstants.stageWidth*(2/3), titleHeight);
			addChild(beginButton);
		}
		
		private function Begin(event:MouseEvent):void {
			dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_DONE,
				mapSelection.selection,enemySelection.selection,playerSelection.selection));
		}
	}
}