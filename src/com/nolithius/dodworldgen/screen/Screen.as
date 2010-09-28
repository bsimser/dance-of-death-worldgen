package com.nolithius.dodworldgen.screen
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	public class Screen
	{
		// Constants
		public static const TILE_WIDTH:uint = 8;
		public static const TILE_HEIGHT:uint = 12;
		public static const SCREEN_TILES_X:uint = 88;
		public static const SCREEN_TILES_Y:uint = 32;
		public static const SCREEN_WIDTH:uint = TILE_WIDTH*SCREEN_TILES_X;
		public static const SCREEN_HEIGHT:uint = TILE_HEIGHT*SCREEN_TILES_Y;
				
		// UI
		public static var ascii:BitmapData;
		public static var screen:Bitmap;

		// Buffer to avoid redrawing
		public static var screenTiles:Array;
		
		
		public static function init(parent:Sprite)
		{
			screen = new Bitmap(new BitmapData(SCREEN_WIDTH, SCREEN_HEIGHT, false, 0x000000));
			parent.addChild(screen);
			ascii = new Ascii(1, 1);
			
			screenTiles = new Array(SCREEN_TILES_X);
			for(var i = 0; i < SCREEN_TILES_X; i++)
			{
				screenTiles[i] = new Array(SCREEN_TILES_Y);
				
				for(var j = 0; j < SCREEN_TILES_Y; j++)
				{
					screenTiles[i][j] = new ScreenTile();
				}
			}
		}
				
		
		// Draw blank tiles to specified rect. If none, clear entire screen.
		public static function clear(rect:Rectangle = null):void
		{
			if(rect)
			{
				for(var i:uint = 0; i < rect.width; i++)
				{
					for(var j: uint = 0; j < rect.height; j++)
					{
						drawTile(0, rect.x + i, rect.y + j);
					}
				}
			}
			else
			{
				for(i = 0; i < SCREEN_TILES_X; i++)
				{
					for(j = 0; j < SCREEN_TILES_Y; j++)
					{
						drawTile(0, i, j);
					}
				}
			}
		}
		
				
		public static function drawTile(index:uint, xPosition:uint, yPosition:uint, p_foregroundColor:uint = 0xFFFFFF, p_backgroundColor:uint = 0x000000):void
		{
			var xSource:uint = index % 16;
			var ySource:uint = uint(index / 16);

			// Check if tile has changed
			var currentMapTile:ScreenTile = screenTiles[xPosition][yPosition];

			// Proceed if any of the params are different from this tile in the buffer
			if(currentMapTile.ascii != index || currentMapTile.foregroundColor != p_foregroundColor || currentMapTile.backgroundColor != p_backgroundColor)
			{
				screen.bitmapData.lock();
				
				var tile:Vector.<uint> = ascii.getVector(new Rectangle(xSource*TILE_WIDTH, ySource*TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT));
				var tileLength:uint = tile.length;
				
				// One of the colors is different
				if(p_foregroundColor != 0xFFFFFF || p_backgroundColor != 0x000000)
				{
					for(var i:uint = 0; i < tileLength; i++)
					{
						if(tile[i] == 0xFFFFFFFF)
						{
							if(p_foregroundColor != 0xFFFFFF)
							{
								tile[i] = p_foregroundColor;
							}
						}
						else if(p_backgroundColor != 0x000000)
						{
							tile[i] = p_backgroundColor;
						}
					}
		
					screen.bitmapData.setVector(new Rectangle(xPosition*TILE_WIDTH, yPosition*TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT), tile);
				}
				// Neither are colorized
				else
				{
					screen.bitmapData.copyPixels(ascii, new Rectangle(xSource*TILE_WIDTH, ySource*TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT), new Point(xPosition*TILE_WIDTH, yPosition*TILE_HEIGHT));
				}
				
				// Commit to buffer
				screenTiles[xPosition][yPosition].ascii = index;
				screenTiles[xPosition][yPosition].foregroundColor = p_foregroundColor;
				screenTiles[xPosition][yPosition].backgroundColor = p_backgroundColor;
				
				screen.bitmapData.unlock();
			}
		}
	}
}