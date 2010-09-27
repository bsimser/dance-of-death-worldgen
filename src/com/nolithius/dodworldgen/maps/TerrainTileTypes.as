package com.nolithius.dodworldgen.maps
{
	public class TerrainTileTypes
	{
		public static const TERRAIN_TILE_TYPES:Array = new Array
		(
			{
				name: "",
				ascii: 32,
				foregroundColor: TerrainTile.TILE_COLOR_WHITE,
				backgroundColor: TerrainTile.TILE_COLOR_BLACK
			},
			{
				name: "Forest",
				ascii: String("*").charCodeAt(0),
				foregroundColor: TerrainTile.TILE_COLOR_GREEN,
				backgroundColor: TerrainTile.TILE_COLOR_BLACK
			},
			{
				name: "Deep water",
				ascii: String("~").charCodeAt(0),
				foregroundColor: TerrainTile.TILE_COLOR_BLUE,
				backgroundColor: TerrainTile.TILE_COLOR_BLACK
			},
			{
				name: "Shallow water",
				ascii: String("~").charCodeAt(0),
				foregroundColor: TerrainTile.TILE_COLOR_LIGHT_BLUE,
				backgroundColor: TerrainTile.TILE_COLOR_BLACK
			},
			{
				name: "Plains",
				ascii: String(".").charCodeAt(0),
				foregroundColor: TerrainTile.TILE_COLOR_LIME_GREEN,
				backgroundColor: TerrainTile.TILE_COLOR_BLACK
			},
			{
				name: "Coastline",
				ascii: String(".").charCodeAt(0),
				foregroundColor: TerrainTile.TILE_COLOR_YELLOW,
				backgroundColor: TerrainTile.TILE_COLOR_BLACK
			},
			{
				name: "Mountains",
				ascii: String("^").charCodeAt(0),
				foregroundColor: TerrainTile.TILE_COLOR_LIGHT_GRAY,
				backgroundColor: TerrainTile.TILE_COLOR_BLACK
			},
			{
				name: "Hills",
				ascii: String("~").charCodeAt(0),
				foregroundColor: TerrainTile.TILE_COLOR_BROWN,
				backgroundColor: TerrainTile.TILE_COLOR_BLACK
			}
		);
	}
}