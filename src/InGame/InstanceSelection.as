package  src.InGame{
	/**
	 * ...
	 * @author Xiler
	 */
	import src.Characters.PlayerClasses.*;
	import src.Maps.*;
	import src.Characters.Enemies.*;
	
	public class InstanceSelection {
		private static var maps:int = 5;
		private static var enemies:int = 2;
		private static var players:int = 2;
		
		public static const TYPE_ZOMBIE:String = "typeZombie";
		public static const TYPE_ENTITY:String = "typeEntity";
		
		public static const LOZZO:String = "lozzo";
		public static const RALF:String = "ralf";
		
		private static var currentEnemyType:String;
		private static var currentPlayerType:String;
		
		private static var currentMap:IMap;
		
		public static function set map(newMap:IMap):void {
			currentMap = newMap;
		}
		public static function get map():IMap {
			return currentMap;
		}
		public static function get TEST_MAP():IMap {
			return new TestMap();
		}
		public static function get TEST_MAP2():IMap {
			return new TestMap2();
		}
		public static function get TEST_MAP3():IMap {
			return new TestMap3();
		}
		public static function get TEST_MAP4():IMap {
			return new TestMap4();
		}
		public static function get TEST_MAP5():IMap {
			return new TestMap5();
		}
		public static function get MAP_RANDOM():IMap {
			var randomNumber:Number = Math.floor(Math.random() * maps);
			switch (randomNumber) {
				case 0:
					return TEST_MAP;
					break;
				case 1:
					return TEST_MAP2;
					break;
				case 2:
					return TEST_MAP3;
					break;
				case 3:
					return TEST_MAP4;
					break;
				case 4:
					return TEST_MAP5;
					break;
				default:
					return null;
					break;
			}
		}
		
		public static function set enemyType(newEnemyType:String):void {
			currentEnemyType = newEnemyType;
		}
		
		public static function get newEnemy():Enemy {
			switch (currentEnemyType) {
				case TYPE_ZOMBIE:
					return new Zombie();
					break;
				case TYPE_ENTITY:
					return new Entity();
					break;
				default:
					throw new Error("failure to provide a enemy type");
					break;
			}
		}
		public static function get ENEMY_TYPE_RANDOM():String {
			var randomNumber:Number = Math.floor(Math.random() * enemies);
			switch (randomNumber) {
				case 0:
					return TYPE_ZOMBIE
					break;
				case 1:
					return TYPE_ENTITY;
					break;
				default:
					return null;
					break;
			}
		}
		
		public static function set playerType(newPlayerType:String):void {
			currentPlayerType = newPlayerType;
		}
		
		public static function get newPlayer():Player {
			switch (currentPlayerType) {
				case RALF:
					return new Ralf();
					break;
				case LOZZO:
					return new Lozzo();
					break;
				default:
					throw new Error("failure to provide a player type");
					break;
			}
		}
		public static function get PLAYER_TYPE_RANDOM():String {
			var randomNumber:Number = Math.floor(Math.random() * players);
			switch (randomNumber) {
				case 0:
					return RALF
					break;
				case 1:
					return LOZZO
					break;
				default:
					return null;
					break;
			}
		}
	}
}