package com.nolithius.dodworldgen.maps
{
	/**
	 * Terrain tile for world map.
	 * @author Ebyan Alvarez-Buylla
	 */
	public class TerrainTile
	{
		public static const TERRAIN_TILE_TYPE_BLANK:uint = 0;
		public static const TERRAIN_TILE_TYPE_FOREST:uint = 1;
		public static const TERRAIN_TILE_TYPE_DEEP_WATER:uint = 2;
		public static const TERRAIN_TILE_TYPE_SHALLOW_WATER:uint = 3;
		public static const TERRAIN_TILE_TYPE_PLAINS:uint = 4;
		public static const TERRAIN_TILE_TYPE_COASTLINE:uint = 5;
		public static const TERRAIN_TILE_TYPE_MOUNTAIN:uint = 6;
		public static const TERRAIN_TILE_TYPE_HILL:uint = 7;
		
		
		public static const TILE_COLOR_BLACK:uint = 0x000000;
		public static const TILE_COLOR_BLUE:uint = 0x0000fc;
		public static const TILE_COLOR_BROWN:uint = 0xa47541;
		public static const TILE_COLOR_GREEN:uint = 0x009900;
		public static const TILE_COLOR_LIGHT_BLUE:uint = 0x118cff;
		public static const TILE_COLOR_LIGHT_GRAY:uint = 0xd2d2d2;
		public static const TILE_COLOR_LIME_GREEN:uint = 0x00FF00;
		public static const TILE_COLOR_WHITE:uint = 0xFFFFFF;
		public static const TILE_COLOR_YELLOW:uint = 0xFFFF00;
		
		private static const SHALLOW_WATER_THRESHOLD:uint = 40;
		private static const COASTLINE_THRESHOLD:uint = 15;
		private static const PLAINS_THRESHOLD:uint = 35;
		private static const MOUNTAIN_THRESHOLD:uint = 25;
		private static const HILL_THRESHOLD:uint = 50;
				
		
		public var x:uint;
		public var y:uint;
		public var elevation:Number = 0;
		public var name:String;
		public var ascii:uint = 32;
		public var foregroundColor:uint = 0xFFFFFF;
		public var backgroundColor:uint = 0x000000;
		
		private var _type:uint;
		
		
		/**
		 * Constructor
		 * @param	p_x		X position.
		 * @param	p_y		Y position.
		 */
		public function TerrainTile(p_x:uint, p_y:uint)
		{
			x = p_x;
			y = p_y;
		}
		
		
		/**
		 * Getter: type.
		 */
		public function get type():uint
		{
			return _type;
		}
		
		
		/**
		 * Setter: type.
		 * Grab the corresponding tile type definition in TerrainTileTypes and apply properties.
		 */
		public function set type(value:uint):void
		{
			_type = value;
			
			var tileType:Object = TerrainTileTypes.TERRAIN_TILE_TYPES[value];
			
			if (tileType)
			{
				name = tileType.name;
				ascii = tileType.ascii;
				foregroundColor = tileType.foregroundColor;
				backgroundColor = tileType.backgroundColor;
			}
		}
		
		
		/**
		 * Set the terrain tile type by elevation.
		 * @param	waterLine
		 */
		public function setTypeByElevation(waterLine:uint = 128):void
		{
			if (elevation < waterLine)
			{
				if (elevation > waterLine - SHALLOW_WATER_THRESHOLD)
				{
					type = TERRAIN_TILE_TYPE_SHALLOW_WATER;
				}
				else
				{
					type = TERRAIN_TILE_TYPE_DEEP_WATER;
				}
			}
			else
			{
				if (elevation < waterLine + COASTLINE_THRESHOLD)
				{
					type = TERRAIN_TILE_TYPE_COASTLINE;
				}
				else if (elevation < waterLine + PLAINS_THRESHOLD)
				{
					type = TERRAIN_TILE_TYPE_PLAINS;
				}
				else if (elevation > Map.ELEVATION_MAX - MOUNTAIN_THRESHOLD)
				{
					type = TERRAIN_TILE_TYPE_MOUNTAIN;
				}
				else if (elevation > Map.ELEVATION_MAX - HILL_THRESHOLD)
				{
					type = TERRAIN_TILE_TYPE_HILL;
				}
				else
				{
					type = TERRAIN_TILE_TYPE_FOREST;
				}
			}
		}
	}
}