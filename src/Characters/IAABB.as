package src.Characters{
	import src.Maths.MathVector
	
	public interface IAABB{
		function get center( ):MathVector
		function get halfExtents( ):MathVector
	}
}
