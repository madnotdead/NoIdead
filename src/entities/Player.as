package entities 
{
	import flash.geom.Point;
	import Assets;
	import misc.Constants;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	//import worlds.Game;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Player extends Entity 
	{
		private var image:Image = null;
		private var spriteMap:Spritemap = null;
		private const SPEED:Number = 100;
		private var isDead:Boolean = false;
		
		private var position:Point = new Point();
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			
			spriteMap = new Spritemap(Assets.PLAYER_SS, 16, 16);
			spriteMap.add("idle", [0],10);
			spriteMap.add("down", [1, 2], 10,false);
			spriteMap.add("idle_up", [3], 10);
			spriteMap.add("right" , [6, 7, 8], 10, false);
			spriteMap.add("left" , [10, 11, 12], 10, false);
			spriteMap.add("up", [4, 5], 10,false);
			spriteMap.add("dead", [9], 10,false);
			
			graphic = spriteMap;
			
			spriteMap.play("idle");
			
			mask = new Pixelmask(Assets.PLAYER_MASK);
			
			type = Constants.PLAYER_TYPE;
			name = Constants.PLAYER_TYPE;
			super(x, y, graphic, mask);
			position.x = x;
			position.y = y;
		}
		
		
		override public function update():void 
		{
			super.update();
			
			if (spriteMap.currentAnim == "dead" && spriteMap.complete)
			{
				this.collidable = false;
				//this.visible = false;
			}
			
			if (isDead) return;
			
			if (Input.check(Key.LEFT))
			{
				spriteMap.play("left");
				moveBy( -SPEED * FP.elapsed, 0, "level");
				
			}
			
			if (Input.check(Key.RIGHT))
			{
				spriteMap.play("right");
				moveBy(SPEED * FP.elapsed, 0, "level");
			}
			
			if (Input.check(Key.UP))
			{
				spriteMap.play("up");
				moveBy(0,-SPEED * FP.elapsed, "level");
			}
			
			if (Input.check(Key.DOWN))
			{
				spriteMap.play("down");
				moveBy(0,SPEED * FP.elapsed, "level");
			}
			
			if (spriteMap.currentAnim != "idle" && spriteMap.complete)
			{
				spriteMap.play("idle");
			}
			//var bullet:Bullet = collide(Constants.BULLET_TYPE, x, y) as Bullet;
			//
			//if (bullet)
			//{
				//trace("collided with bullet");
				//spriteMap.play("dead");
				//isDead = true;
			//}
			
			position.x = x;
			position.y = y;
		}
		
		
		public function get Position():Point
		{
			return position; 
		}
	}

}