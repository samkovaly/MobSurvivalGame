package  src.InGame{
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.geom.Rectangle;
	import src.Characters.Character;
	import src.Characters.MovingObject;
	import src.Characters.Enemies.BaseAI;
	import src.Characters.Enemies.Zombie;
	import src.Characters.Enemies.Enemy;
	import src.Characters.PlayerClasses.Player;
	import src.Characters.Bullets.Projectile
	import src.Maths.MathVector;
	import src.Maths.RectangleBoundaryCheck;
	import src.Characters.PlayerClasses.PlayerCamera;
	
	internal class GameManager {
		private var subscribed:Array;
		
		private var mapOperator:MapOperator;
		private var displayHolder:DisplayHolder;
		private var baseAI:BaseAI;
		
		private var lastTime:int;
		private var timePassed:Number;
		
		private var x_player:Player;
		private var playerTileLocation:MathVector;
		
		private var enemyPool:Array;
		private var enemiesActive:Array;
		private const enemyPoolMax:uint = 100; // how many are made
		private var enemiesOnScreen:uint = 10;
		
		public function GameManager(mapOperator:MapOperator, displayHolder:DisplayHolder):void {
			this.mapOperator = mapOperator;
			mapOperator.gameManager = this;
			this.displayHolder = displayHolder;
			this.x_player = displayHolder.player;
			
			this.baseAI = new BaseAI(this.x_player, this.mapOperator);
			subscribed = new Array();
			this.subscribe(this.x_player);
			enemiesActive = new Array();
			generateEnemyPool();
			lastTime = getTimer();
		}
		public function get player():Player {
			return this.x_player;
		}
		
		public function subscribe(movingObject:MovingObject):void {
			subscribed.push(movingObject);
			movingObject.mapOperator = this.mapOperator;
			
			if (movingObject.type == MovingObject.PROJECTILE) {
				movingObject.addEventListener(SubscribedEvent.HIT, projectileHit);
			}else {
				movingObject.addEventListener(SubscribedEvent.ATTACK, attack);
				movingObject.addEventListener(SubscribedEvent.CHARACTER_DAMAGED, characterDamaged);
			}
			if(movingObject.type==MovingObject.PLAYER){
				movingObject.addEventListener(SubscribedEvent.DIE, playerDie);
			}else if (movingObject.type == MovingObject.ENEMY) {
				movingObject.addEventListener(SubscribedEvent.DIE, enemyDie);
			}
		}
		
		public function unsubscribe(movingObject:MovingObject):void {
			for (var i in subscribed) {
				if (subscribed[i] == movingObject) {
					if (movingObject.type == MovingObject.PROJECTILE) {
						movingObject.removeEventListener(SubscribedEvent.HIT, projectileHit);
					}else {
						movingObject.removeEventListener(SubscribedEvent.ATTACK, attack);
						movingObject.removeEventListener(SubscribedEvent.CHARACTER_DAMAGED, characterDamaged);
					}
					if(movingObject.type==MovingObject.PLAYER){
						movingObject.removeEventListener(SubscribedEvent.DIE, playerDie);
					}else if (movingObject.type == MovingObject.ENEMY) {
						movingObject.removeEventListener(SubscribedEvent.DIE, enemyDie);
					}
					subscribed.splice(i, 1);
					break;
				}
			}
		}
		
		public function loop(event:Event):void {
			//ENTIRE GAME LOOP
			timePassed = getTimer() - lastTime;
			lastTime += timePassed;
			timePassed /= 1000;
			
			baseAI.calculatePlayerTileLocation();
			for (var i:int = 0; i < subscribed.length; i++) {
				subscribed[i].update(timePassed);
			}
			
			
			updatePlayerPosition();
			migrateEnemies();
		}
		
		private function updatePlayerPosition():void {
			this.playerTileLocation = mapOperator.worldToTilePoint(x_player.groundPosition);
		}
		
		public function get enemies():Array {
			return this.enemiesActive;
		}
		
		private function generateEnemyPool():void {
			enemyPool = new Array();
			var newEnemy:Enemy;
			for (var i:int = 0; i < enemyPoolMax; i++) {
				newEnemy = InstanceSelection.newEnemy;
				newEnemy.initialize();
				newEnemy.initializeAI(this.baseAI);
				enemyPool.push(newEnemy);
			}
		}
		
		private function migrateEnemies():void {
			for (var i:int = 0; i < (enemiesOnScreen - enemiesActive.length); i++) {
				var newEnemy:Enemy = enemyPool.pop();
				findSpawnForEnemy(newEnemy);
				enemiesActive.push(newEnemy);
				subscribe(newEnemy);
				displayHolder.addEnemy(newEnemy);
				newEnemy.reset();
			}
		}
		private function findSpawnForEnemy(enemy:Enemy):void {
			
			var placeFound:Boolean = false;
			
			var enemyRectangle:Rectangle;
			var mapRectanlge:Rectangle = new Rectangle(0, 0, mapOperator.mapWidth * mapOperator.gridSize,
				mapOperator.mapHeight * mapOperator.gridSize);
			var playerSeeingWindow:Rectangle = PlayerCamera.playerSeeingWindow;
			
			var enemyRectLoc1:MathVector;
			var enemyRectLoc2:MathVector;
			var enemyRectLoc3:MathVector;
			var enemyRectLoc4:MathVector;
			
			while (!placeFound) {
				
				enemy.x = Math.round(Math.random() * mapRectanlge.width);
				enemy.y = Math.round(Math.random() * mapRectanlge.height);
				
				enemyRectangle = new Rectangle(enemy.x - enemy.halfExtents.x, enemy.y - enemy.halfExtents.y, enemy.width, enemy.height);
				
				enemyRectLoc1 = mapOperator.worldToTilePoint(new MathVector(enemyRectangle.x, enemyRectangle.y));
				enemyRectLoc2 = mapOperator.worldToTilePoint(new MathVector(enemyRectangle.x + enemyRectangle.width, enemyRectangle.y));
				enemyRectLoc3 = mapOperator.worldToTilePoint(new MathVector(enemyRectangle.x + enemyRectangle.width, enemyRectangle.y));
				enemyRectLoc4 = mapOperator.worldToTilePoint(new MathVector(enemyRectangle.x + enemyRectangle.width, enemyRectangle.y + enemyRectangle.height));
				
				if (RectangleBoundaryCheck.rectangleWithinRectangle(enemyRectangle, mapRectanlge, true)) {
					if (mapOperator.isOpenTile(mapOperator.getTile(enemyRectLoc1.x,enemyRectLoc1.y))
					&& mapOperator.isOpenTile(mapOperator.getTile(enemyRectLoc2.x,enemyRectLoc2.y)) 
					&& mapOperator.isOpenTile(mapOperator.getTile(enemyRectLoc3.x,enemyRectLoc3.y)) 
					&& mapOperator.isOpenTile(mapOperator.getTile(enemyRectLoc4.x, enemyRectLoc4.y))) {
						if (RectangleBoundaryCheck.rectangleOutsideRectangle(enemyRectangle, playerSeeingWindow, true)) {
							placeFound = true;
						}
					}
				}
			}
		}
		
		private function removeEnemy(enemy:Enemy):void {
			displayHolder.removeEnemy(enemy);
			enemiesActive.splice(enemiesActive.indexOf(enemy), 1);
			enemyPool.push(enemy);
			unsubscribe(enemy);
		}
		
		
		
		private function attack(event:SubscribedEvent):void {
			if (event.typeOfAttack == SubscribedEvent.DATA_ATTACK_RANGED) {
				displayHolder.addProjectile(event.typeOfProjectile);
				subscribe(event.typeOfProjectile);
				
			}else if (event.typeOfAttack == SubscribedEvent.DATA_ATTACK_MELEE) {
				if (event.dispatcher == SubscribedEvent.PLAYER) {
					var closestEnemy:Character = mapOperator.scanClosestEnemyToCharacter(x_player);
					
					// if a enemy was hit with melee from the player. null would mean no hit occured, (player against enemy attacking collision
					// is done within GameManager, while enemy against player is done within the Enemy class.
					if (closestEnemy != null) {
						var enemyDamagedEvent:SubscribedEvent = new SubscribedEvent(SubscribedEvent.ENEMY, SubscribedEvent.CHARACTER_DAMAGED);
						enemyDamagedEvent.inputDamageAmount(player.hitDamage);
						closestEnemy.dispatchEvent(enemyDamagedEvent);
					}
					
				}else{ //dispatcher must be an enemy - inRange of Enemy class has already checked the collision for us
					var playerDamagedEvent:SubscribedEvent = new SubscribedEvent(SubscribedEvent.PLAYER,SubscribedEvent.CHARACTER_DAMAGED);
					playerDamagedEvent.inputDamageAmount(event.damageAmount);
					player.dispatchEvent(playerDamagedEvent);
				}
			}
		}
		
		
		private function characterDamaged(event:SubscribedEvent):void {
			var character:Character=Character(event.currentTarget);
			character.damage(event.damageAmount);
		}
		
		private function playerDie(event:SubscribedEvent):void {
			
		}
		private function enemyDie(event:SubscribedEvent):void {
			removeEnemy(Enemy(event.currentTarget));
		}
		
		private function projectileHit(event:SubscribedEvent):void {
			var projectile:MovingObject = MovingObject(event.target);
			displayHolder.removeProjectile(projectile);
			unsubscribe(projectile);
		}
		
		
		
		public static function endGameByQuit():void {
			
		}
		public function endGameByDeath():void {
			
		}
	}
}