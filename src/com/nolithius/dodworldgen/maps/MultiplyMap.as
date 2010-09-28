package com.nolithius.dodworldgen.maps
{
	/**
	 * Multiply Map
	 * @author Ebyan Alvarez-Buylla
	 */
	public class MultiplyMap extends Map
	{
		/**
		 * Constructor
		 * Creates a map by multiplying the source and mask values, then normalizes.
		 * @param	source	The base map (any range allowed).
		 * @param	mask	The mask to multiply (values must be from 0 to ELEVATION_MAX).
		 */
		public function MultiplyMap(source:Map, mask:Map)
		{
			init();
			
			for (var ix:uint = 0; ix < WIDTH; ix++)
			{
				for (var iy:uint = 0; iy < HEIGHT; iy++)
				{
					// Multiply blending
					tiles[ix][iy].elevation = source.tiles[ix][iy].elevation * (mask.tiles[ix][iy].elevation/ELEVATION_MAX);
				}
			}
			
			normalize();
		}
	}
}