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
	import net.flashpunk.Sfx;
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
		private var _bulletSpeed:Number = 0;
		private var _sound:Sfx = null;
		
		public function Bullet(x:Number=0, y:Number=0, direction:String = "NONE", owner:String = "NONE", graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = new Image(Assets.BULLET);
			
			if (owner == "NONE")
			{
				var num:Number = Utils.randomRange(1, 6);
				
				if(num>3)
					spriteAnim = new Spritemap(Assets.BULLET_BLUE_ANIM, 16, 16);
				else
					spriteAnim = new Spritemap(Assets.BULLET_RED_ANIM, 16, 16);
					
				_bulletSpeed = Constants.BULLET_SPEED;
				_sound = new Sfx(Assets.BULLET_SOUND);
			}	
			else
			{
				_bulletSpeed = Constants.PLAYER_BULLET_SPEED;
				spriteAnim = new Spritemap(Assets.PLAYER_BULLET_ANIM, 16, 16);
				_sound = new Sfx(Assets.PLAYER_SHOOT);
			}
			
			spriteAnim.add("bullet", [0, 1, 2, 3], 10);
			
			graphic = spriteAnim;
			
			mask = new Pixelmask(Assets.BULLET);
			
			type = owner != "NONE" ? Constants.PLAYER_BULLET_TYPE :Constants.BULLET_TYPE;
			
			bulletDirection = direction;
			
			super(x, y, graphic, mask);
			
		}
		
		override public function added():void 
		{
			super.added();
			
			if (type == Constants.BULLET_TYPE)
			{
				if (bulletDirection == Constants.LEFT)
				{
					speedX = _bulletSpeed;
					speedY = Utils.randomRange( -_bulletSpeed, _bulletSpeed);
					x = 145;
					y = Utils.randomRange(175, 360);
				}
				
				if (bulletDirection == Constants.RIGHT)
				{
					speedX = -_bulletSpeed;
					speedY = Utils.randomRange( -_bulletSpeed, _bulletSpeed);
					x = 445;
					y = Utils.randomRange(175, 360);
				}
				
				if (bulletDirection == Constants.UP)
				{
					speedY = _bulletSpeed;
					speedX = Utils.randomRange( -_bulletSpeed, _bulletSpeed);;
					y = 175;
					x = Utils.randomRange(145, 445);
				}
				
				if (bulletDirection == Constants.DOWN)
				{
					speedY = -_bulletSpeed;
					speedX = Utils.randomRange( -_bulletSpeed, _bulletSpeed);
					y = 360;
					x = Utils.randomRange(145, 445);
				}
			}
			else
			{
				if (bulletDirection == Constants.LEFT)
				{
					speedX = _bulletSpeed;
					speedY = 0
				}
				
				if (bulletDirection == Constants.RIGHT)
				{
					speedX = -_bulletSpeed;
					speedY = 0;
				}
				
				if (bulletDirection == Constants.UP)
				{
					speedY = _bulletSpeed;
					speedX = 0;
				}
				
				if (bulletDirection == Constants.DOWN)
				{
					speedY = -_bulletSpeed;
					speedX = 0;
				}
			}
			
			spriteAnim.play("bullet");
			_sound.play();
		}
		
		override public function update():void 
		{
			super.update();
			
			var speedModifier:Number = 1;// Game(world).SpeedModifier;
			x += speedX * FP.elapsed * speedModifier;
			y += speedY * FP.elapsed * speedModifier;
			
			
			var e:Entity = collide("level", x, y);
			
			if (e)
				FP.world.remove(this);
		}
		
	}

}