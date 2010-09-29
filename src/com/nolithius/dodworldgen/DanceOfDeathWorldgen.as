package com.nolithius.dodworldgen
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import com.nolithius.dodworldgen.maps.MultiplyMap;
	import com.nolithius.dodworldgen.maps.NoiseMap;
	import com.nolithius.dodworldgen.maps.RollingParticleMap;
	import com.nolithius.dodworldgen.screen.Screen;
	
	
	/**
	 * Dance of Death Worldgen Document Class
	 * @author Ebyan Alvarez-Buylla
	 */
	public class DanceOfDeathWorldgen extends Sprite
	{
		/**
		 * Constructor
		 */
		public function DanceOfDeathWorldgen()
		{
			// Initialize the screen
			Screen.init(this);
			
			generate();
			
			stage.addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		
		/**
		 * Generate a map.
		 * Called on load and on mouse click.
		 */
		private function generate():void
		{
			// Step 1: Generate noise map
			var noiseMap:NoiseMap = new NoiseMap();
			//noiseMap.normalize();
			//noiseMap.drawElevation();
			//noiseMap.setTileTypeByElevation();
			//noiseMap.draw();
			
			// Step 2: Generate rolling particle map
			var rollingParticleMap:RollingParticleMap = new RollingParticleMap();
			//rollingParticleMap.drawElevation();
			//rollingParticleMap.setTileTypeByElevation();
			//rollingParticleMap.draw();
			
			// Step 3: Multiply the maps together and assign terrain
			var multiplyMap:MultiplyMap = new MultiplyMap(noiseMap, rollingParticleMap);
			//multiplyMap.drawElevation();
			multiplyMap.setTileTypeByElevation();
			multiplyMap.draw();
		}
		
		
		/**
		 * Handle mouse click.
		 * Generates a new map.
		 * @param	event	The MouseEvent that invoked this mouseclick.
		 */
		private function handleClick(event:MouseEvent):void
		{
			generate();
		}
	}
}