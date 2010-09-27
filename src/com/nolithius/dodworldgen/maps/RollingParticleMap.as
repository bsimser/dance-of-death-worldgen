package com.nolithius.dodworldgen.maps
{
	import flash.geom.Point;
	
	import com.nolithius.dodworldgen.utils.ArrayUtils;
	
	
	/**
	 * ...
	 * @author Ebyan Alvarez-Buylla
	 */
	public class RollingParticleMap extends Map
	{
		private static const PARTICLE_ITERATIONS:uint = 3000;
		private static const PARTICLE_LENGTH:uint = 50;
		
		
		public function RollingParticleMap()
		{
			init();
			
			for (var iterations:uint = 0; iterations < PARTICLE_ITERATIONS; iterations++)
			{
				// Start nearer the center
				var sourceX:uint = uint(Math.random() * (WIDTH-24) + 12);
				var sourceY:uint = uint(Math.random() * (HEIGHT-24) + 12);
								
				for (var length:uint = 0; length < PARTICLE_LENGTH; length++)
				{
					sourceX += Math.round(Math.random() * 2 - 1);
					sourceY += Math.round(Math.random() * 2 - 1);
										
					if (sourceX < 1 || sourceX > WIDTH -2 || sourceY < 1 || sourceY > HEIGHT - 2) break;
					
					var hood:Array = getNeighborhood(sourceX, sourceY);
					
					for (var i:uint = 0 ; i < hood.length; i++)
					{
						if (tiles[hood[i].x][hood[i].y].elevation < tiles[sourceX][sourceY].elevation)
						{
							sourceX = hood[i].x;
							sourceY = hood[i].y;
							break;
						}
					}
						
					tiles[sourceX][sourceY].elevation++;
				}
			}
			
			blurEdges();
			normalize();
		}
		
		
		/**
		 * Get the Moore neighborhood (3x3, 8 surrounding tiles, minus the center tile).
		 * @param	x	The x position of the center of the neighborhood.
		 * @param	y	The y position of the center of the neighborhood.
		 * @return	An array of neighbor Coords, shuffled.
		 */
		private function getNeighborhood(x:uint, y:uint):Array
		{
			var result:Array = new Array();
			
			for (var a:int = -1; a <= 1; a++)
			{
				for (var b:int = -1; b <= 1; b++)
				{
					if (a || b)
					{
						if (x + a >= 0 && x + a < WIDTH && y + b >= 0 && y + b < HEIGHT)
						{
							result.push(new Point(x + a, y + b));
						}
					}
				}
			}
			
			// Return the neighborhood in no particular order
			ArrayUtils.shuffle(result);
						
			return result;
		}
		
		
		/**
		 * "Blur" the edges of the tile array to ensure no hard edges.
		 */
		private function blurEdges():void
		{
			for (var ix:uint = 0; ix < WIDTH; ix++)
			{
				for (var iy:uint = 0; iy < HEIGHT; iy++)
				{
					// Multiply the outer edge and the second outer edge by some constants to ensure the world does not touch the edges.
					if (ix == 0 || ix == WIDTH -1 || iy == 0 || iy == HEIGHT -1) tiles[ix][iy].elevation *= 0.75;
					else if (ix == 1 || ix == WIDTH -2 || iy == 1 || iy == HEIGHT -2) tiles[ix][iy].elevation *= 0.88;
				}
			}
		}
	}
}