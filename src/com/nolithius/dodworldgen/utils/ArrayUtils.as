package com.nolithius.dodworldgen.utils
{
	/**
	 * Array Utilities
	 * @author Ebyan Alvarez-Buylla
	 */
	public class ArrayUtils
	{
		/**
		 * Shuffle the provided array (randomize the order of the elements).
		 * @param	array		The array to shuffle.
		 * @param	iterations	The amount of times to shuffle (1 is sufficient).
		 */
		public static function shuffle(array:Array, iterations:uint = 1):void
		{
			for(var i:uint = 0; i < iterations; i++)
			{
				var arrayLength:uint = array.length;
				for(var j:uint = 0; j < arrayLength; j++)
				{
					swap(array, j, int(Math.random()*array.length));
				}
			}
		}
		
		
		/**
		 * Swap elements in an array.
		 * Called by shuffle(), and can be used standalone.
		 * @param	array
		 * @param	firstIndex
		 * @param	secondIndex
		 */
		public static function swap(array:Array, firstIndex:uint, secondIndex:uint):void
		{
			var temp = array[firstIndex];
			array[firstIndex] = array[secondIndex];
			array[secondIndex] = temp;
		}
	}
}