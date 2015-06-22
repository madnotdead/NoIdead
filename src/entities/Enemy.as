package entities 
{
	import flash.geom.Point;
	import misc.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import worlds.GameWorld;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Enemy extends Entity 
	{

		private var _enemyAnim:Spritemap = null;
		private var _health:Number = 100;
		private var _speedX:Number = 100;
		private var _speedY:Number = 100;
		private var _chasingSpeed:Number = 175;
		private var _direction:String;
		private var _position:Point = new Point(x, y);
		public function Enemy(x:Number=0, y:Number=0, direction:String = Constants.LEFT, graphic:Graphic=null, mask:Mask=null) 
		{
			_enemyAnim = new Spritemap(Assets.ENEMY_ANIM, 16, 16);
			_enemyAnim.add("main", [0, 1, 2],10);
			_enemyAnim.add("death", [3],10,false);
			
			graphic = _enemyAnim;
			
			mask = new Pixelmask(Assets.ENEMY_MASK);
			
			_direction = direction;
			
			type = "enemy";
			
			super(x, y, graphic, mask);
			
			_position.x = x;
			_position.y = y;
		}
		
		override public function added():void 
		{
			super.added();
			
			if (_direction == Constants.LEFT)
			{
				_speedX = Constants.INITIAL_SPEED;
				_speedY = 0;// Utils.randomRange( -Constants.INITIAL_SPEED, Constants.INITIAL_SPEED);
				x = 0;
				y = Utils.randomRange(0, FP.screen.height -16);
			}
			
			if (_direction == Constants.RIGHT)
			{
				_speedX = -Constants.INITIAL_SPEED;
				_speedY = 0;// Utils.randomRange( -Constants.INITIAL_SPEED, Constants.INITIAL_SPEED);
				x = FP.screen.width;
				y = Utils.randomRange(0, FP.screen.height-16);
			}
			
			if (_direction == Constants.UP)
			{
				_speedX = 0;// Utils.randomRange( -Constants.INITIAL_SPEED, Constants.INITIAL_SPEED);;
				_speedY = Constants.INITIAL_SPEED;
				
				y = 0;
				x = Utils.randomRange(0, FP.screen.width-16);
			}
			
			if (_direction == Constants.DOWN)
			{
				_speedX = 0;// Utils.randomRange(-Constants.INITIAL_SPEED,Constants.INITIAL_SPEED);
				_speedY = -Constants.INITIAL_SPEED;
				
				x = Utils.randomRange(0, FP.screen.width - 16);
				y = FP.screen.height;
			}
			
			
			_enemyAnim.play("main");
		}
		
		override public function update():void 
		{
			super.update();
			
			if ( Point.distance( Position,GameWorld(world).currentPlayer.Position) < 100)
			{
				moveTowards(GameWorld(world).currentPlayer.Position.x, GameWorld(world).currentPlayer.Position.y, _chasingSpeed * FP.elapsed, "level");
			}
			else
			{
				moveBy(_speedX * FP.elapsed, _speedY * FP.elapsed, "level");
			}
			
			_position.x = x;
			_position.y = y;
		}
		
		public function get Position():Point
		{
			return _position;
		}
	}

}