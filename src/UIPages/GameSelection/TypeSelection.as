package src.UIPages.GameSelection {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import src.UIPages.PrimitiveUI.Graphic;
	import src.UIPages.TextCreator;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class TypeSelection extends Sprite {
		
		private var titleTextFormat:TextFormat = new TextFormat("Arial", 25, 0x000000, true, false, false, null, null, TextFormatAlign.CENTER);
		private const thisTitleSpace:uint = 32.5;
		
		private var titleTextField:TextField;
		private var selectionButtons:Vector.<SelectionBaseButton>;
		private var x_selection;
		private var x_width:Number;
		private var x_height:Number;
		private var buttonHeight:Number;
		
		private var selectedHeight:uint = 150;
		
		private const changeSpeed:Number = .4;
		private var changeTimer:Timer;
		private var currentNewPick:SelectionBaseButton;
		private var currentOldPick:SelectionBaseButton;
		
		public function TypeSelection(title:String, selectionPackage:Vector.<SelectionBase>, titleHeight:uint):void {
			
			this.x_width = GlobalConstants.stageWidth / 3;
			this.x_height = GlobalConstants.stageHeight - (2 * titleHeight);
			
			this.titleTextField = TextCreator.makeTextField(title, 0, 0, false, null, x_width, thisTitleSpace, titleTextFormat);
			addChild(titleTextField);
			Graphic.drawLine(this, 0, 0, 0, thisTitleSpace,4);
			Graphic.drawLine(this, x_width, 0, x_width, thisTitleSpace,4);
			
			
			
			this.selectionButtons = new Vector.<SelectionBaseButton>
			
			buttonHeight = (x_height - (thisTitleSpace + selectedHeight)) / (selectionPackage.length - 1);
			
			for (var i in selectionPackage) {
				selectionButtons.push(new SelectionBaseButton(clickListener, selectionPackage[i], 0, 0, x_width, buttonHeight ,selectedHeight));
				addChild(selectionButtons[i]);
			}
			
			beginSelectChange(null, selectionButtons[0]);	// STARTS AT FIRST ONE
		}
		
		public function get selection() {
			return this.x_selection;
		}
		
		private function clickListener(event:MouseEvent):void {
			
			var oldPick:SelectionBaseButton;
			var newPick:SelectionBaseButton;
			if (!SelectionBaseButton(event.currentTarget).selected) {
				newPick = SelectionBaseButton(event.currentTarget);
				
				for each (var button:SelectionBaseButton in selectionButtons) {
					if (button.selected && button != newPick) {
						oldPick = button;
						break;
					}
				}
			}
			if(newPick) beginSelectChange(oldPick, newPick);
		}
		
		private function beginSelectChange(oldPick:SelectionBaseButton, newPick:SelectionBaseButton):void {
			this.currentOldPick = oldPick;
			this.currentNewPick = newPick;
			
			
			for ( var i in selectionButtons) {
				var button:SelectionBaseButton = selectionButtons[i];
				
				if (button != newPick) {
					button.changeHeight = buttonHeight;
					button.isListening = false;
				}else {
					button.changeHeight = selectedHeight;
				}
				if (i == 0) {
					button.changeY = thisTitleSpace;
				}else {
					button.changeY = selectionButtons[i - 1].changeY + selectionButtons[i - 1].changeHeight;
				}
			}
			if (oldPick != null) {
				oldPick.isListening = true;
				oldPick.clearBackground();
				oldPick.isListening = false;
			}
			newPick.selected = true;
			this.x_selection = newPick.data;
			
			changeTimer = new Timer(GlobalConstants.FPS, (changeSpeed * 1000) /GlobalConstants.FPS);
			changeTimer.addEventListener(TimerEvent.TIMER, changeUpdater);
			changeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, changeFinisher);
			changeTimer.start();
		}
		
		private function changeUpdater(event:TimerEvent):void {
			for ( var i in selectionButtons) {
				var button:SelectionBaseButton = selectionButtons[i];
				button.updateChange(changeTimer.currentCount / changeTimer.repeatCount);
				}
			}
		
		private function changeFinisher(event:TimerEvent):void {
			changeTimer.stop();
			changeTimer = null;
			
			for ( var i in selectionButtons) {
				var button:SelectionBaseButton = selectionButtons[i];
				
				if (button != currentNewPick) {
					button.isListening = true;
					button.doState();
				}
				button.finishChange();
			}
			
			if (currentOldPick != null) currentOldPick.removeShownData();
			currentOldPick = null;
			currentNewPick = null;
		}
	}
}