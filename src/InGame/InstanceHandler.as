package  src.InGame{
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import src.BackgroundArt.*;
	import src.Characters.PlayerClasses.Player;
	import src.Maps.IMap;
	import src.Main;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class InstanceHandler extends Sprite {
		private const gridSize:uint = GlobalConstants.gridSize;
		
		private var mainClass:Main;
		private var mapOperator:MapOperator;
		private var gameManager:GameManager;
		private var displayHolder:DisplayHolder;
		
		
		
		public function InstanceHandler(mainClass:Main) {
			this.mainClass = mainClass;
		}
		public function begin() {
			var currentMap:IMap = InstanceSelection.map;
			parseMapData(currentMap.xmlData);
		}
		private function parseMapData(mapData:XML):void {
			
			var mapRectNode:XML = mapData.mapRect[0];
			var mapRect:Rectangle = new Rectangle(int(mapRectNode.@x), int(mapRectNode.@y), int(mapRectNode.@width), int(mapRectNode.@height));
			
			var tileArray:Array = new Array();
			var markerArray:Array = new Array();
			
			for each (var tileNode:XML in mapData.tile) {
				addTile(String(tileNode.@type), uint(tileNode.@graphic), int(tileNode.@x), int(tileNode.@y),tileArray,mapRect);
			}
			for each (var markerNode:XML in mapData.marker) {
				markerArray.push( { type: Number(markerNode.@type), x: Number(markerNode.@x), y: Number(markerNode.@y) } );
			}
			var playerLocation:Point = new Point();
			addPlayer(markerArray[markerArray.length - 1],playerLocation,mapRect);		// PLAYER LOCATION = MARKER_ARRAY[0]
			
			beginLoop(playerLocation,mapRect,tileArray);
			
		}
		private function addTile(type:String, graphic:uint, x:int, y:int,tileArray:Array,mapRect:Rectangle):void {
			x += -mapRect.x;
			y += -mapRect.y;
			var newTile:Sprite;
			if (type == GlobalConstants.REG_TILE) {
				newTile = new Tile(graphic);
			}else if (type == GlobalConstants.JUMP_TILE) {
				newTile = new JumpTile(graphic);
			}
			newTile.x = x * gridSize;
			newTile.y = y * gridSize;
			
			if (tileArray[x] == null) tileArray[x] = new Array();
			tileArray[x][y] = { tile:newTile, type:type, graphic:graphic };
		}
		private function addPlayer(playerObject:Object,playerLocation:Point,mapRect:Rectangle):void {
			playerObject.x += -mapRect.x;
			playerObject.y += -mapRect.y;
			var tempPlayer:Player = InstanceSelection.newPlayer;
			playerLocation.x = (playerObject.x * gridSize) + tempPlayer.width / 2;
			playerLocation.y = (playerObject.y * gridSize) +(gridSize / 2)  - (tempPlayer.height - gridSize);
			tempPlayer = null;
		}
		
		
		
		private function beginLoop(playerLocation:Point, mapRect:Rectangle, tileArray:Array) {
			mapOperator = new MapOperator(tileArray,mapRect);
			displayHolder = new DisplayHolder(mainClass, playerLocation,tileArray);
			
			gameManager = new GameManager(mapOperator, displayHolder);
			
			mainClass.addChild(displayHolder);
			
			addEventListener(Event.ENTER_FRAME, gameManager.loop);
		}
		
		public function end() {
			removeEventListener(Event.ENTER_FRAME, gameManager.loop);
			mainClass.removeChild(displayHolder);
			mapOperator = null;
			gameManager = null;
			displayHolder = null;
			
		}
	}
}