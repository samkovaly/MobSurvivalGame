package src.InGame {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import src.Characters.Character;
	import src.Characters.DeployableObject;
	import src.Characters.Bullets.Projectile;
	import src.Characters.PlayerClasses.Player;
	import src.Maths.MathVector;
	import src.Maths.Collide;
	import src.Maths.CollideInfo;
	import src.Characters.AABB;
	import src.Characters.IAABB;
	import src.Characters.IC;
	
	public class MapOperator extends Sprite {
		public var gridSize:int = GlobalConstants.gridSize;
		
		private var x_gameManager:GameManager;
		
		private var _mapOffsetX:int;
		private var _mapOffsetY:int;
		private var _mapWidth:int;
		private var _mapHeight:int
		
		private var tileArray:Array;
		
		public function MapOperator(tileArray:Array,mapRect:Rectangle) {
			this.tileArray = tileArray;
			this._mapOffsetX = mapRect.x;
			this._mapOffsetY = mapRect.y;
			this._mapWidth = mapRect.width;
			this._mapHeight = mapRect.height;
		}
		public function set gameManager(newGameManager:GameManager):void {
			this.x_gameManager = newGameManager;
		}
		
		public function get offsetX():int {
			return this._mapOffsetX;
		}
		public function get offsetY():int {
			return this._mapOffsetY;
		}
		
		public function get mapWidth():int {
			return this._mapWidth
		}
		
		public function get mapHeight():int {
			return this._mapHeight;
		}
		
		public function get tiles():Array {
			return this.tileArray;
		}
		public function getTile(x:int,y:int):String {
			//return tile type to detect for collision or not
			if (x < 0 || y < 0 || x >= _mapWidth || y >= _mapHeight){
				return GlobalConstants.NULL_TILE;
			}else if (tileArray[x][y] == null) {
				return GlobalConstants.OPEN_TILE;
			}else {
				return tileArray[x][y].type;
			}
		}
		public function tileToWorldPoint(tilePoint:MathVector):MathVector {
			return tilePoint.MulScalar(gridSize);
		}
		
		public function worldToTilePoint(worldPoint:MathVector):MathVector {
			var tilePoint:MathVector;
			tilePoint = worldPoint.Div(new MathVector(gridSize, gridSize));
			tilePoint.FloorTo();
			return tilePoint;
		}
		
		public function isRegTile(tileType:String):Boolean {
			if (tileType == GlobalConstants.REG_TILE) {
				return true;
			}
			return false;
		}
		
		public function isJumpTile(tileType:String):Boolean {
			if (tileType == GlobalConstants.JUMP_TILE) {
				return true;
			}
			return false;
		}
		public function isNullTile(tileType:String):Boolean {
			if (tileType == GlobalConstants.NULL_TILE || tileType== GlobalConstants.OPEN_TILE) {
				return true;
			}
			return false;
		}
		public function isOpenTile(tileType:String):Boolean {
			if (tileType == GlobalConstants.OPEN_TILE) {
				return true;
			}
			return false;
		}
		
		public function makeTileAABB(x:int,y:int):AABB{
			return new AABB(new MathVector(x * gridSize + gridSize / 2, y * gridSize + gridSize / 2), new MathVector(gridSize / 2, gridSize / 2));
		}
		
		public function scanMapCollisionAABB(a:IAABB, collideInfo:CollideInfo,functionToRespond:Function, min:MathVector, max:MathVector,timePassed:Number):void{
			min = worldToTilePoint(min);
			max = worldToTilePoint(max);
			
			for (var x:int = min.x; x <=max.x; x++) {
				for (var y:int = min.y; y <= max.y; y++) {
					var thisTile:Object = tileArray[x][y];
					if (thisTile != null) {
						var tileAABB:AABB = makeTileAABB(x, y);
						if (thisTile.type == GlobalConstants.REG_TILE) {
							if (Collide.AabbVsAabb(a, tileAABB, this, collideInfo)) {
								functionToRespond(collideInfo.normal,collideInfo.dist,timePassed);
							}
						}else if (thisTile.type == GlobalConstants.JUMP_TILE) {
							if (Collide.AabbVsAabbTopPlane(a,tileAABB,this,collideInfo)) {
								functionToRespond(collideInfo.normal,collideInfo.dist,timePassed);
							}
						}
					}
				}
			}
		}													// (Circle)
		public function scanMapCollisionC(a:IC, functionToRespond:Function):void {
			var min:MathVector = worldToTilePoint(a.topLeft);
			var max:MathVector = worldToTilePoint(a.bottomRight);
			if (min.x < 0 || min.y < 0 || max.x > _mapWidth || max.y > _mapHeight) {
				functionToRespond();
				return;
			}
			for (var x:int = min.x; x <=max.x; x++) {
				for (var y:int = min.y; y <= max.y; y++) {
					var thisTile:Object = tileArray[x][y];
					if (thisTile != null) {
						var tileAABB:AABB = makeTileAABB(x, y);
						if (thisTile.type == GlobalConstants.REG_TILE) {
							if (Collide.AabbVsC(a, tileAABB)) {
								functionToRespond();
								return;
							}
						}
					}
				}
			}
		}
		// functionToRespond lets the projectile know to unchild itself or whatever, and the dispatch event of the Enemy CHARACTER_DAMAGED event
		// is to let the enemy know that they have been hit.
		public function scanEnemiesCollisionC(a:Projectile, functionToRespond:Function):void {
			for (var i in x_gameManager.enemies) {
				var enemy:DeployableObject = x_gameManager.enemies[i];
				// preliminary collision detection
				if ((a.radius + enemy.halfExtents.CValue) > a.center.Distance(enemy.center)) {
					// now for the real stuff
					if (Collide.AabbVsC(IC(a), IAABB(enemy),PhysicConstants.projectileCharSmooth)) {
						var characterDamagedEvent:SubscribedEvent = new SubscribedEvent(SubscribedEvent.ENEMY,SubscribedEvent.CHARACTER_DAMAGED);
						characterDamagedEvent.inputDamageAmount(a.damage);
						enemy.dispatchEvent(characterDamagedEvent);
						functionToRespond();
						return;
					}
				}
			}
		}
		public function scanPlayerCollisionC(a:Projectile, functionToRespond:Function):void {
			var player:DeployableObject = x_gameManager.player;
			if (Collide.AabbVsC(IC(a), IAABB(player),PhysicConstants.projectileCharSmooth)) {
				var characterDamagedEvent:SubscribedEvent = new SubscribedEvent(SubscribedEvent.PLAYER,SubscribedEvent.CHARACTER_DAMAGED);
				characterDamagedEvent.inputDamageAmount(a.damage);
				player.dispatchEvent(characterDamagedEvent);
				functionToRespond();
			}
		}
		public function scanClosestEnemyToCharacter(character:Character):Character {
			var enemies:Array = x_gameManager.enemies;
			var closestEnemy:Character;
			for ( var i in enemies) {
				var enemy:Character = Character(enemies[i]);
				if (Collide.characterInRange(character, enemy)) {
					if (closestEnemy == null){
						closestEnemy = enemy;
					}else if (enemy.center.Distance(character.center) < closestEnemy.center.Distance(character.center)) {
						closestEnemy = enemy;
					}
				}
			}
			return closestEnemy;
		}
		
	}
}