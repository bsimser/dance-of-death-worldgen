package com.nolithius.dodworldgen.maps
{
	import flash.display.BitmapData;
	
	import com.nolithius.dodworldgen.screen.Screen;
	
	
	/**
	 * Perlin Noise Map
	 * @author Ebyan Alvarez-Buylla
	 */
	public class NoiseMap extends Map
	{
		/**
		 * Constructor.
		 * Generate a Perlin Noise Map.
		 */
		public function NoiseMap()
		{
			init();
			
			var bitmapData:BitmapData = new BitmapData(WIDTH, HEIGHT, false, 0);
			bitmapData.perlinNoise(WIDTH/2, HEIGHT/2, 8, uint(Math.random() * 10000), false, true, 7, true);
			var pixels:Vector.<uint> = bitmapData.getVector(bitmapData.rect);
						
			for (var i:uint = 0; i < pixels.length; i++)
			{
				var ix:uint = i % WIDTH;
				var iy:uint = uint(i / WIDTH);
				
				// Set the elevation to the blue value of this noise (grayscale)
				tiles[ix][iy].elevation = pixels[i] & 0x0000FF;
			}
		}
	}
}