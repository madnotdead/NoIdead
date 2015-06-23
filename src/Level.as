package  
{
	//import entities.Player;
	//import entities.Turret;
	import Assets;
	import misc.Constants;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author alex larioza
	 */
	public class Level extends Entity 
	{
		private var xml:XML;
		public var tile_layer1:Tilemap;//background
		public var collect_tile_layer:Tilemap;//collect
		public var survive_tile_layer:Tilemap;//survive
		public var destroy_tile_layer:Tilemap;//destroy
		private var grid:Grid;
		
	
		public function Level(rawData:Class) 
		{
			super(0, 0);
			
			// to check for level collisions
			type = Constants.LEVEL_TYPE;
			
			// FlashPunk function makes get all that data super easy!
			this.xml = FP.getXML(rawData);
		}
		
		override public function added():void 
		{
			super.added();
			
			// load tiles
			// bottom tile layer
			
			tile_layer1 = new Tilemap(Assets.TILES, xml.@width, xml.@height, 16, 16);
			tile_layer1.loadFromString(xml.tileset);
			trace(xml.tile_layer1);
			
			// top tile layer (details)
			collect_tile_layer = new Tilemap(Assets.TILES, xml.@width, xml.@height, 16, 16);
			collect_tile_layer.loadFromString(xml.collect);
			
			survive_tile_layer = new Tilemap(Assets.TILES, xml.@width, xml.@height, 16, 16);
			survive_tile_layer.loadFromString(xml.survive);
			
			destroy_tile_layer = new Tilemap(Assets.TILES, xml.@width, xml.@height, 16, 16);
			destroy_tile_layer.loadFromString(xml.destroy);
			// set graphic to graphiclist of tilesets, order matters!
			graphic = new Graphiclist(tile_layer1, collect_tile_layer,survive_tile_layer,destroy_tile_layer);
			//graphic = tile_layer2;
			// load the collision grid
			grid = new Grid(xml.@width, xml.@height, 16, 16);
			grid.loadFromString(xml.grid, "");
			
			// set the grid to the mask of this entity
			mask = grid;
			
			// load entities
			var list:XMLList; // holds an xmllist
			var element:XML; // a specific xml element
			
			// for each player in the xml list
			//list = xml.entities.player1;
			//for each (element in list) {
				//// add it
				//world.add(new entities.PlayerOne(element.@x, element.@y));
			//}
			//
			// for each player in the xml list
			//list = xml.entities.player;
			//for each (element in list) {
				//// add it
				//player = new Player(element.@x, element.@y);
				//world.add(player);
			//}
			
			//list = xml.entities.turret;
			//
			//for each( element in list)
			//{
				//world.add(new Turret(element.@x, element.@y, element.@turretType));
			//}
		}
		
		override public function update():void 
		{
			super.update();
			//FP.camera.x = player.x - 200;// - FP.halfWidth) * FP.screen.scale;
			//FP.camera.y = player.y - 130;// - FP.halfHeight) * FP.screen.scale;
		}
	}

}