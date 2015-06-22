package entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import misc.Utils;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Item extends Entity 
	{
		private var customGravity:int= 40;
		private var touchGround:Boolean = false;
	
		public var itemName:String;
		private var timeLife:int = 3;
		private var timeLifeCounter:Number = 0;
		private var itemIndex:int;
		private var image:Image;
		private var position:Point = null;
		private var pickUpSfx:Sfx = null;
		//private var spriteS:Spritemap = null;
		public function Item(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			
			itemIndex = Utils.randomRange(0, 902);
			trace("itemIndex: " + itemIndex);
			if (itemIndex > 800)
			{
				image = new Image(Assets.ITEM_1);
			}
			else
			{	
				if (itemIndex > 200 && itemIndex <= 800)
				{
						image = new Image(Assets.ITEM_2);
				}
				else
				{
					if (itemIndex > 100 && itemIndex <= 200)
					{
						image = new Image(Assets.ITEM_3);
					}
					else
					{
						image = new Image(Assets.ITEM_4);
					}
				}
			}
			
			//pickUpSfx = new Sfx(Assets.PICK_UP);
			
			graphic = image;
			
			mask = new Pixelmask(Assets.ITEM_1);
			
			super(x, y, graphic, mask);
			
			type = "item";
		}
		
		override public function added():void 
		{
			super.added();
			
			position = new Point(Utils.randomRange(100, 400), Utils.randomRange(100, 400));
		
			var entity:Entity = collide("level", position.x, position.y) as Entity;
			
			while (entity)
			{
				position = new Point(Utils.randomRange(100, 400), Utils.randomRange(100, 400));
				entity = collide("level", position.x, position.y)  as Entity;
			}
			
			x = position.x;
			y = position.y;		
		}
		
		override public function update():void 
		{
			super.update();
			//checkGround();
			//if (touchGround)
			//{
				//timeLifeCounter += FP.elapsed;
				//
				//if (timeLifeCounter >= timeLife)
					//FP.world.remove(this);
					//
				//return;
			//}
				//
			//y += customGravity * FP.elapsed;
		}
		
		private function checkGround():void
		{
			if (collide("level", x, y))
			 touchGround = true;
			 else
			 touchGround = false;
		}
		
		public function collected():void{
			pickUpSfx.play();
			
			FP.world.remove(this);
		}
	}

}