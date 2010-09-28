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
		
		
		/**
		 * Find an element in the provided array.
		 * @param	array		The array in which to search.
		 * @param	element		The element to match.
		 * @param	comparator	The comparator function to apply, if null, executes a standard Array.indexOf()
		 * @return				The index of the element, if found, otherwise -1.
		 */
		public static function find(array:Array, element:*, comparator:Function = null):int
		{
			if(comparator != null)
			{
				var arrayLength:uint = array.length
				for(var i:uint = 0; i < arrayLength; i++)
				{
					if(comparator(element, array[i]))
					{
						return i;
					}
				}
				
				// Nothing found
				return -1;
			}
			else
			{
				return array.indexOf(element);
			}
		}
		
		
		/**
		 * Get a random element from the provided array.
		 * @param	array	The array from which to grab the random element.
		 * @return			The random element.
		 */
		public static function getRandom(array:Array):*
		{
			if (array.length > 0)
			{
				return array[Math.round(Math.random() * array.length) - 1];
			}
			else
			{
				return null;
			}
		}
	}
}