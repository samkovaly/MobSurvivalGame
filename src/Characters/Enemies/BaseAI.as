package src.Characters.Enemies {
	import flash.sampler.NewObjectSample;
	import src.Characters.Character;
	import src.InGame.MapOperator;
	import src.Maths.MathVector;
	import src.Maths.Scalar;
	import flash.display.MovieClip
	/**
	 * ...
	 * @author Xiler
	 */
	public final class BaseAI {
		private static const bordersOfNode:Array = new Array(
			new MathVector( -1, 0), new MathVector(1, 0), new MathVector(0, -1), new MathVector(0, 1));
		
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const JUMP:String = "jump";
		public static const MOVE_HORIZ:String = "MoveHoriz";
		public static const STILL:String = "still";
		
		private var _player:Character;
		private var mapOperator:MapOperator;
		
		private var playerTileLocation:MathVector;
		
		
		
		private var openList:Array;
		private var closedList:Array;
		private var mapOperatorArray:Array;
		private var complete:Boolean;
		
		
		public function BaseAI(_player:Character,mapOperator:MapOperator):void {
			this._player = _player;
			this.mapOperator = mapOperator;
			
			openList = new Array();
			closedList = new Array();
			mapOperatorArray = mapOperator.tiles;
		}
		public function get player():Character {
			return this._player;
		}
		
		public function calculatePlayerTileLocation():void {
			playerTileLocation = mapOperator.worldToTilePoint(player.groundPosition);
		}
		public function getDirection(enemy:Character):String {
			
			if (Math.random() > .95) {
				return JUMP;
			}
			if (Math.random() > .95) {
				return STILL;
			}
			if (enemy.x < player.x) {
				if (Math.random() > .85) {
					return LEFT;
				}else{
					return RIGHT;
				}
			}else {
				if (Math.random() > .85) {
					return RIGHT
				}else{
					return LEFT;
				}
			}
			
			//clearRects(enemy);
			
			
			/*
			var enemyTileLocation:MathVector = mapOperator.worldToTilePoint(enemy.groundPosition);
			
			if (playerTileLocation.Equal(enemyTileLocation)) {
				return MOVE_HORIZ;
			}
			
			var currentNode:AStarNode = new AStarNode(enemyTileLocation, playerTileLocation);
			currentNode.setAsOrigin();
			var examiningNode:AStarNode;
			
			openList = [currentNode];
			closedList = [];
			complete = false;
			
			while (!complete) {
				
				for (var i in bordersOfNode) {
					examiningNode = new AStarNode(new MathVector(currentNode.X + bordersOfNode[i].x, currentNode.Y + bordersOfNode[i].y),playerTileLocation);
					//IF IT IS A NULL TILE (OPEN SPACE) THEN ADD IT TO OPENLIST
					if ((mapOperator.isOpenTile(mapOperator.getTile(examiningNode.X, examiningNode.Y)) || mapOperator.isJumpTile(mapOperator.getTile(examiningNode.X, examiningNode.Y)))
						&& !examiningNode.isThisInArray(closedList)) {
						if (!examiningNode.isThisInArray(openList)) {
							openList.push(examiningNode);
							examiningNode.parentNode = currentNode;
						}else {
							// STUFF TO DO WITH G THAT SWITCHES PARENTS... BUT G IS 0, SO THERE IS NO NEED... FOR NOW.
						}
						closedList.push(examiningNode);
						if (examiningNode.X == playerTileLocation.x && examiningNode.Y == playerTileLocation.y) {
							complete = true;
							var loopDone:Boolean = false;
							var moveDirectionNode:AStarNode;
							moveDirectionNode = examiningNode;
							//drawRectAt(moveDirectionNode.X, moveDirectionNode.Y, 0x01AD5B, enemy);
							while (!loopDone) {
								if (moveDirectionNode.parentNode.checkIfOrigin()) {
									//means we have found the first move node, and moveDirectionNode keeps its value, and is used below
									loopDone = true;
								}else {
									moveDirectionNode = moveDirectionNode.parentNode;
									//drawRectAt(moveDirectionNode.X, moveDirectionNode.Y, 0x01AD5B, enemy);
								}
							}
						}
					}
				}
				openList.sortOn("F", Array.NUMERIC);
				currentNode = openList[0];
				closedList.push(currentNode);
				openList.splice(0, 1);
			}
			var originalNode:AStarNode = moveDirectionNode.parentNode;
			var difX:int = moveDirectionNode.X - originalNode.X;
			var difY:int = moveDirectionNode.Y - originalNode.Y;
			if (difX == 1) {
				return RIGHT;
			}else if (difX == -1) {
				return LEFT;
			}else if (difY == -1) {
				return JUMP;
			}else {
				return STILL;
			}
			*/
			
		}
		
		public function clearRects(enemy:MovieClip):void {
			//MovieClip(enemy.stage.getChildAt(0)).MovieClip(getChildAt(0)).MovieClip(getChildAt(0)).graphics.clear();
		}
		public function drawRectAt(x:int, y:int, color:Number, enemy:MovieClip):void {
			//MovieClip(enemy.stage.getChildAt(0)).MovieClip(getChildAt(0)).MovieClip(getChildAt(0)).graphics.lineStyle(5, color);
			//MovieClip(enemy.stage.getChildAt(0)).MovieClip(getChildAt(0)).MovieClip(getChildAt(0)).graphics.drawRect(x * GlobalConstants.gridSize, y * GlobalConstants.gridSize, GlobalConstants.gridSize, GlobalConstants.gridSize);
		}
	}
}