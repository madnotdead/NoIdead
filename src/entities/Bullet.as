package entities 
{
	import Assets;
	import misc.Constants;
	import misc.Utils;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	//import worlds.Game;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Bullet extends Entity 
	{
		
		private var image:Image = null;
		private var bulletType:int = 0;
		
		private var speedX:int;
		private var speedY:int;
	
		private var bulletDirection:String;
		private var spriteAnim:Spritemap;
		
		public function Bullet(x:Number=0, y:Number=0, direction:String = "NONE", graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = new Image(Assets.BULLET);
			
			var num:Number = Utils.randomRange(1, 6);
			
			if(num>3)
				spriteAnim = new Spritemap(Assets.BULLET_BLUE_ANIM, 16, 16);
			else
				spriteAnim = new Spritemap(Assets.BULLET_RED_ANIM, 16, 16);
				
			spriteAnim.add("bullet", [0, 1, 2, 3], 10);
			
			graphic = spriteAnim;
			
			mask = new Pixelmask(Assets.BULLET);
			
			type = Constants.BULLET_TYPE;
			
			bulletDirection = direction;
			
			super(x, y, graphic, mask);
			
		}
		
		override public function added():void 
		{
			super.added();
			
			if (bulletDirection == Constants.LEFT)
			{
				speedX = Constants.INITIAL_SPEED;
				speedY = Utils.randomRange( -Constants.INITIAL_SPEED, Constants.INITIAL_SPEED);
				x = 100;
				y = Utils.randomRange(100, 500);
			}
			
			if (bulletDirection == Constants.RIGHT)
			{
				speedX = -Constants.INITIAL_SPEED;
				speedY = Utils.randomRange( -Constants.INITIAL_SPEED, Constants.INITIAL_SPEED);
				x = 500;
				y = Utils.randomRange(100, 500);
			}
			
			if (bulletDirection == Constants.UP)
			{
				speedY = Constants.INITIAL_SPEED;
				speedX = Utils.randomRange( -Constants.INITIAL_SPEED, Constants.INITIAL_SPEED);;
				y = 100;
				x = Utils.randomRange(100, 500);
			}
			
			if (bulletDirection == Constants.DOWN)
			{
				speedY = -Constants.INITIAL_SPEED;
				speedX = Utils.randomRange( -Constants.INITIAL_SPEED, Constants.INITIAL_SPEED);
				y = 500;
				x = Utils.randomRange(100, 500);
			}
			
			spriteAnim.play("bullet");
		}
		
		override public function update():void 
		{
			super.update();
			
			var speedModifier:Number = 1;// Game(world).SpeedModifier;
			x += speedX * FP.elapsed * speedModifier;
			y += speedY * FP.elapsed * speedModifier;
			
			
			var e:Entity = collide("level", x, y);
			
			if (x < 100 || x > 500|| y < 0 || y > 500 || e)
				FP.world.remove(this);
		}
		
	}

}