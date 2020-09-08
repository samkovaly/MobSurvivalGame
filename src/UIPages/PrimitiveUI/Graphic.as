package src.UIPages.PrimitiveUI {
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Xiler
	 */
	public class Graphic {
		
		public static function drawLine(to:Sprite,sx:Number, sy:Number, ex:Number, ey:Number,thickness:Number=1,alpha:Number=1,color:Number=0x000000):void{
			to.graphics.lineStyle(thickness, color, alpha);
			to.graphics.moveTo(sx, sy);
			to.graphics.lineTo(ex, ey);
		}
		public static function drawRect(to:Sprite,x:Number, y:Number, width:Number, height:Number,alpha:Number=1,color:Number=0x000000):void{
			to.graphics.lineStyle();
			to.graphics.beginFill(color, alpha);
			to.graphics.drawRect(x, y, width, height);
		}
		public static function drawOutline(to:Sprite, x:Number, y:Number, width:Number, height:Number, thickness:Number=1, alpha:Number=1, color:Number=0x000000):void {
			to.graphics.endFill();
			to.graphics.lineStyle(thickness, color, alpha);
			to.graphics.drawRect(x, y, width, height);
		}
	}
}