package src.InGame {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import src.Characters.IC;
	import src.Characters.MovingObject;
	import src.Main;
	import src.Characters.PlayerClasses.Player;
	import src.Characters.Bullets.Projectile
	import src.Maths.MathVector;
	/**
	 * ...
	 * @author Xiler
	 */
	public class DisplayHolder extends Sprite {
		
		private var mainClass:Main;
		private var _player:Player;
		
		private var _cameraWillMoveSprite:Sprite;
		private var _tilesSprite:Sprite;
		private var _enemySprite:Sprite;
		private var _projectileSprite:Sprite;
		private var _background:Sprite;
		
		
		public function DisplayHolder(mainClass:Main, playerLocation:Point, tileArray:Array) {
			this.mainClass = mainClass;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			this._player = InstanceSelection.newPlayer;
			this._player.initialize();
			
			_player.x = playerLocation.x;
			_player.y = playerLocation.y;
			
			this._cameraWillMoveSprite = new Sprite();
			this._tilesSprite = new Sprite();
			this._enemySprite = new Sprite();
			this._projectileSprite = new Sprite();
			
			// IT MATTERS WHICH ORDER THEY ARE ADDED!
			this._cameraWillMoveSprite.addChild(_tilesSprite);
			this._cameraWillMoveSprite.addChild(_enemySprite);
			this._cameraWillMoveSprite.addChild(_player);
			this._cameraWillMoveSprite.addChild(_projectileSprite);
			addChild(this._cameraWillMoveSprite);
			
			for (var x:int = 0; x < tileArray.length; x++) {
				for (var y:int = 0; y < tileArray[x].length; y++) {
					if (tileArray[x][y] != null) {
						_tilesSprite.addChild(tileArray[x][y].tile);
					}
				}
			}
		}
		public function get player():Player {
			return this._player;
		}
		
		public function addEnemy(enemy:MovingObject):void {
			_enemySprite.addChild(enemy);
			enemy.addedToStage();
		}
		public function removeEnemy(enemy:MovingObject):void {
			_enemySprite.removeChild(enemy);
		}
		public function addProjectile(projectile:MovingObject):void {
			_projectileSprite.addChild(projectile);
			projectile.addedToStage();
		}
		public function removeProjectile(projectile:MovingObject):void {
			_projectileSprite.removeChild(projectile);
		}
		
		private function addedToStage(event:Event):void {
			this._player.addedToStage();
			this._player.setCameraAndControls(stage, _cameraWillMoveSprite);
			stage.focus = stage;
		}
		private function removedFromStage(event:Event):void {
			
		}
	}
}