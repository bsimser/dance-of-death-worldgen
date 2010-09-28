package com.nolithius.dodworldgen.maps
{
	import com.nolithius.dodworldgen.screen.Screen;
	
	
	/**
	 * Base Map Abstract Class.
	 * @author Ebyan Alvarez-Buylla
	 */
	public class Map
	{
		public static const ELEVATION_MAX:uint = 255;
		public static const WIDTH:uint = Screen.SCREEN_TILES_X;
		public static const HEIGHT:uint = Screen.SCREEN_TILES_Y;
		
		public var tiles:Array;
		
		
		/**
		 * Initialize the tiles array.
		 */
		protected function init():void
		{
			tiles = new Array(WIDTH);
			for (var ix:uint = 0; ix < WIDTH; ix++)
			{
				tiles[ix] = new Array(HEIGHT);
				
				for (var iy:uint = 0; iy < HEIGHT; iy++)
				{
					tiles[ix][iy] = new TerrainTile(ix, iy);
				}
			}
		}
		
		
		/**
		 * Draw elevation as a grayscale value.
		 */
		public function drawElevation():void
		{
			for (var ix:uint = 0; ix < WIDTH; ix++)
			{
				for (var iy:uint = 0; iy < HEIGHT; iy++)
				{
					// Convert to gray for drawing
					var b:uint = tiles[ix][iy].elevation;
					var color:uint = Math.min(0xFFFFFF, b << 16 | b << 8 | b);
					
					Screen.drawTile(0, ix, iy, 0, color);
				}
			}
		}
		
		
		/**
		 * Draw tiles by type.
		 * setTileTypeByElevation() must be called before.
		 */
		public function draw():void
		{
			for (var ix:uint = 0; ix < WIDTH; ix++)
			{
				for (var iy:uint = 0; iy < HEIGHT; iy++)
				{
					// Convert to gray for drawing
					var tile:TerrainTile = tiles[ix][iy];
					
					Screen.drawTile(tile.ascii, ix, iy, tile.foregroundColor, tile.backgroundColor);
				}
			}
		}
		
		
		/**
		 * Normalizes the elevation values from 0 to ELEVATION_MAX, and returns the highest point (useful to place dungeon)
		 * @param	arr	Array to normalize
		 * @return		The highest elevation TerrainTile.
		 */
		protected function normalize():void
		{
			var smallest:uint = 1000000;	// A large value, INT_MAX would work well here.
			var largest:uint = 0;
			
			// Find the largest and smallest tiles
			for (var ix:uint = 0; ix < WIDTH; ix++)
			{
				for (var iy:uint = 0; iy < HEIGHT; iy++)
				{
					if (tiles[ix][iy].elevation > largest)
					{
						largest = tiles[ix][iy].elevation;
					}
					if (tiles[ix][iy].elevation < smallest)
					{
						smallest = tiles[ix][iy].elevation;
					}
				}
			}
			
			// Normalize
			for (ix = 0; ix < WIDTH; ix++)
			{
				for (iy = 0; iy < HEIGHT; iy++)
				{
					var percent:Number = (tiles[ix][iy].elevation - smallest) / (largest-smallest);
					tiles[ix][iy].elevation = Math.round(percent * ELEVATION_MAX);
				}
			}
		}
		
		
		/**
		 * Calculate the elevation that corresponds to the waterline, and pass it into TerrainTile's setTypeByElevation().
		 * @param	waterline	The percentage of water in the world.
		 */
		public function setTileTypeByElevation(waterline:Number = 0.6):void
		{
			// Sample for accurate land-earth balance (do this on a separate loop, after the mask has been applied, and after normalized)
			var sample:Array = new Array();
			for (var ix:uint = 0; ix < WIDTH; ix++)
			{
				for (var iy:uint = 0; iy < HEIGHT; iy++)
				{
					sample.push(tiles[ix][iy].elevation);
				}
			}
			
			sample.sort(Array.NUMERIC);
			
			var threshold:uint = sample[uint(sample.length * waterline)];
			
			for (ix = 0; ix < WIDTH; ix++)
			{
				for (iy = 0; iy < HEIGHT; iy++)
				{
					tiles[ix][iy].setTypeByElevation(threshold);
				}
			}
		}
	}
}