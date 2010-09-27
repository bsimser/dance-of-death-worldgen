package com.nolithius.dodworldgen.maps
{
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class MultiplyMap extends Map
	{
		
		public function MultiplyMap(source:Map, mask:Map)
		{
			init();
			
			for (var ix:uint = 0; ix < WIDTH; ix++)
			{
				for (var iy:uint = 0; iy < HEIGHT; iy++)
				{
					// Multiply blending
					tiles[ix][iy].elevation = source.tiles[ix][iy].elevation * (mask.tiles[ix][iy].elevation/255);
				}
			}
			
			normalize();
		}
	}
}