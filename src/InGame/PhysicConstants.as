package src.InGame {
	/**
	 * ...
	 * @author Xiler
	 */
	public class PhysicConstants {
		
		public static const gravity:Number = 2.15* GlobalConstants.gridSize;
		public static const maxFallSpeed:Number = 9 * GlobalConstants.gridSize;
		public static const minRunSpeed:Number = .4 * GlobalConstants.gridSize;
		public static const groundFriction:Number = 0.6;
		
		public static const jumpTileSnap:Number = 0.3 * GlobalConstants.gridSize;	//0.3
		public static const collideXOffset:Number = 0.20 * GlobalConstants.gridSize;	// Should generaly stay between .10 and .30
		public static const collideYOffset:Number = 0.65 * GlobalConstants.gridSize;			//.75 also when 42.5x65 ish
		
		public static const projectileCharSmooth:Number = 0.85; 
		// means how deep the projectile does until a collision. 1=normal basic pure collision 
		//between c and aabb. 0 = no collision. .5= it gets half way in before a collisoin. (this is here to make the projectile collisions with
		// enemies/the player look more natural.
		
	}
}