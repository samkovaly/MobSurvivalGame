package src.Characters{
	import src.Maths.MathVector
	
	public interface IC{
		function get center( ):MathVector
		function get radius( ):Number
		function get topLeft():MathVector;
		function get bottomRight():MathVector;
	}
}
