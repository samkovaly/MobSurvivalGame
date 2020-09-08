package src.Maths {
	import src.Characters.Character;
	import src.Characters.IAABB;
	import src.Characters.IC;
	import src.InGame.MapOperator;
	import src.InGame.PhysicConstants;
	
	public class Collide {
		public static function AabbVsAabbTopPlane(a:IAABB, b:IAABB, mapOperator:MapOperator,collideInfo:CollideInfo):Boolean {
			if (AabbVsAabb(a, b, mapOperator, collideInfo, true)) {
				if (collideInfo.normal.y < 0 && collideInfo.dist >= -PhysicConstants.jumpTileSnap){
					return true;
				}
			}
			return false;
		}
		
		static public function AabbVsAabb(a:IAABB, b:IAABB, mapOperator:MapOperator, collideInfo:CollideInfo,checkInternalEdge:Boolean=true):Boolean {
			var combinedExtentsA:MathVector = a.halfExtents.Clone().AddTo(b.halfExtents);
			
			var posB:MathVector = b.center;
			
			var delta:MathVector = posB.Sub(a.center);
			
			
			// form the closest plane to the point
			var planeN:MathVector = delta.m_MajorAxis.NegTo();
			
			var planeCenter:MathVector = planeN.Mul(combinedExtentsA).AddTo(posB);
			
			// distance point from plane
			var planeDelta:MathVector = a.center.Sub(planeCenter);
			
			var dist:Number = planeDelta.Dot(planeN);
			
			collideInfo.setCollides(planeN, dist);
			
			// check for internal edges
			if (checkInternalEdge) {
				//return true;
				return !IsInternalCollision(a, planeN, mapOperator);
			}
			return true;
		}
		
		public static function AabbVsC(a:IC, b:IAABB,collisionSmoothness:Number=1):Boolean {
			// collisionSmoothness means how deep the projectile does until a collision. 1=normal basic pure collision 
			//between c and aabb. 0 = no collision. .5= it gets half way in before a collisoin. (this is here to make the projectile collisoins look more natural.
				
			var squareDist:Number = 0;
			
			var bMinX:Number = b.center.x - (b.halfExtents.x*collisionSmoothness);
			var bMaxX:Number = b.center.x + (b.halfExtents.x*collisionSmoothness);
			var bMinY:Number = b.center.y - (b.halfExtents.y*collisionSmoothness);
			var bMaxY:Number = b.center.y + (b.halfExtents.y*collisionSmoothness);
			var aCenter:MathVector = a.center;
			if (a.center.x < bMinX) {
				squareDist += (bMinX - aCenter.x) * (bMinX - aCenter.x);
			}
			if (a.center.x > bMaxX) {
				squareDist += (aCenter.x - bMaxX) * (aCenter.x - bMaxX);
			}
			if (a.center.y < bMinY) {
				squareDist += (bMinY - aCenter.y) * (bMinY - aCenter.y);
			}
			if (a.center.y > bMaxY) {
				squareDist += (aCenter.y - bMaxY) * (aCenter.y - bMaxY);
			}
			
			var circleSquared:Number = Math.pow(a.radius, 2);
			
			return squareDist <= circleSquared;
			
		}
		
		private static function IsInternalCollision(collidingObject:IAABB, normal:MathVector, mapOperator:MapOperator):Boolean {
			if (normal.y == 1) {
				if (getTilesAroundObject(collidingObject,mapOperator,"top",PhysicConstants.collideXOffset,PhysicConstants.collideYOffset)) {
					return true;	
				}
			}
			if (normal.y == -1) {
				if (getTilesAroundObject(collidingObject,mapOperator,"bottom",PhysicConstants.collideXOffset,PhysicConstants.collideYOffset)) {
					return true;
				}
			}
			return false;
		}
// IS MY INTERNAL EDGE ELIMINATOR!!!
		private static function getTilesAroundObject(collidingObject:IAABB, mapOperator:MapOperator, side:String, 
			objectXOffset:Number, objectYOffset:Number):Boolean {
			
			var setY:Number;
			
			if (side == "top") {
				setY = (collidingObject.center.y-collidingObject.halfExtents.y) - objectYOffset;
			}else if (side == "bottom") {
				setY = (collidingObject.center.y + collidingObject.halfExtents.y) + objectYOffset;
			}
			
			var left:MathVector = new MathVector(collidingObject.center.x - (collidingObject.halfExtents.x - objectXOffset),setY);
			var right:MathVector = new MathVector(collidingObject.center.x + (collidingObject.halfExtents.x - objectXOffset),setY);
			
			var tileLeft:MathVector = mapOperator.worldToTilePoint(left);
			var tileRight:MathVector = mapOperator.worldToTilePoint(right);
			
			var tileTypeLeft:String = mapOperator.getTile(tileLeft.x, tileLeft.y);
			var tileTypeRight:String = mapOperator.getTile(tileRight.x, tileRight.y);
			
			var tileLeftThere:Boolean = mapOperator.isNullTile(tileTypeLeft);
			var tileRightThere:Boolean = mapOperator.isNullTile(tileTypeRight);
			
			if (side == "top" && mapOperator.isJumpTile(tileTypeLeft) && mapOperator.isJumpTile(tileTypeRight)) {
				tileLeftThere = true;
				tileRightThere = true;
			}
			
			if (tileLeftThere && tileRightThere) {
				return true;
			}
			return false;
		}
		
		public static function characterInRange(attacker:Character, defender:Character):Boolean {
			//if they are in physical range
			if ((attacker.center.Distance(defender.center) - (attacker.range + defender.halfExtents.x)) < 0) {
				// if their directions match up
				if (attacker.facingDirection == 1 && defender.center.x > attacker.center.x) {
					return true
				}else if (attacker.facingDirection == -1 && defender.center.x < attacker.center.x) {
					return true;
				}
			}
			return false;
		}
	}
}
