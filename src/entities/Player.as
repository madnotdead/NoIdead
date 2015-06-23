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
	import worlds.GameWorld;
	//import worlds.Game;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Player extends Entity 
	{
		private var _image:Image = null;
		private var _spriteMap:Spritemap = null;
		private const SPEED:Number = 100;
		private var _isDead:Boolean = false;
		
		private var _position:Point = new Point();
		
		private var _health:Number =100;
		
		private var _hasShield:Boolean = false;
		
		private var _shieldHits:Number = 0;
		private var _healthCounter:Number = 0;
		private var _timeStoppedCounter:Number = 0;
		private var _timeStopped:Boolean = false;
		private var _canStopTime:Boolean = false;
		private var _canShoot:Boolean = false;
		private var _shootDirection:String = Constants.LEFT;
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			
			_spriteMap = new Spritemap(Assets.PLAYER_SS, 16, 16);
			_spriteMap.add("idle", [0],10);
			_spriteMap.add("down", [1, 2], 10,false);
			_spriteMap.add("idle_up", [3], 10);
			_spriteMap.add("right" , [6, 7, 8], 10, false);
			_spriteMap.add("left" , [10, 11, 12], 10, false);
			_spriteMap.add("up", [4, 5], 10,false);
			_spriteMap.add("dead", [9], 10,false);
			
			graphic = _spriteMap;
			
			_spriteMap.play("idle");
			
			mask = new Pixelmask(Assets.PLAYER_MASK);
			
			type = Constants.PLAYER_TYPE;
			name = Constants.PLAYER_TYPE;
			super(x, y, graphic, mask);
			_position.x = x;
			_position.y = y;
		}
		
		
		override public function update():void 
		{
			super.update();
			
			if (_spriteMap.currentAnim == "dead" && _spriteMap.complete)
			{
				this.collidable = false;
				//this.visible = false;
			}
			
			if (IsDead) return;
			
//			_shootDirection = Constants.DOWN;
			
			if (Input.check(Key.LEFT))
			{
				_spriteMap.play("left");
				moveBy( -SPEED * FP.elapsed, 0, "level");
				_shootDirection = Constants.RIGHT;
				
			}
			
			if (Input.check(Key.RIGHT))
			{
				_spriteMap.play("right");
				moveBy(SPEED * FP.elapsed, 0, "level");
				_shootDirection = Constants.LEFT;
			}
			
			if (Input.check(Key.UP))
			{
				_spriteMap.play("up");
				moveBy(0, -SPEED * FP.elapsed, "level");
				_shootDirection = Constants.DOWN;
			}
			
			if (Input.check(Key.DOWN))
			{
				_spriteMap.play("down");
				moveBy(0, SPEED * FP.elapsed, "level");
				_shootDirection = Constants.UP;
			}
			
			if (Input.pressed(Key.SHIFT))
			{
				if (_canStopTime)
				{
					_timeStopped = true;
					_canStopTime = false;
				}
			}
			
			if (Input.pressed(Key.Z))
			{
				if (_canShoot)
				{
					trace("Shooting");
					FP.world.add(new Bullet(x, y, _shootDirection, "PLAYER"));
				}
			}
			
			if (_spriteMap.currentAnim != "idle" && _spriteMap.complete)
			{
				_spriteMap.play("idle");
			}
			
			var bullet:Bullet = collide(Constants.BULLET_TYPE, x, y) as Bullet;
			
			if (bullet)
			{
				trace("collided with bullet");
				
				FP.world.remove(bullet);
				
				if (_hasShield)
				{
					_shieldHits--;
					
					if (_shieldHits <= 0)
					{
						_spriteMap.play("dead");
						SetIsDead = true;
					}
				}
				else
				{
					_spriteMap.play("dead");
					SetIsDead = true;
				}
			}
			
			var e:Enemy = collide("enemy", x, y) as Enemy;
			
			if (e)
			{
				SustractHealth(17);
				FP.world.remove(e);
			}
			
			var item:Item = collide(Constants.ITEM_TYPE, x, y) as Item;
						
			if (item)
			{
				if (item.ItemType == Constants.ITEM_TYPE_1)
				{
					AddHealth(17);
				}
				
				if (item.ItemType == Constants.ITEM_TYPE_2)
				{
					AddHealth(3);
				}
				
				if (item.ItemType == Constants.ITEM_TYPE_3)
				{
					_canStopTime = true;
				}
				
				if (item.ItemType == Constants.ITEM_TYPE_4)
				{
					_hasShield = true;
					_shieldHits = 3;
				}
				
				item.Collected();
			}
			
			
			if (_timeStopped)
			{
				_timeStoppedCounter += FP.elapsed;
				
				if (_timeStoppedCounter > 3)
				{
					_timeStopped = false;
					_timeStoppedCounter = 0;
				}
				
			}
			else
			{
				_healthCounter += FP.elapsed;

				if (_healthCounter >= 1)
				{
					_healthCounter = 0;
					_health--;
				}
			}
			
			if (_health <= 0)
			{
				_spriteMap.play("dead");
				SetIsDead = true;
			}
			
			_position.x = x;
			_position.y = y;
		}
		
		private function AddHealth(amount:Number):void
		{
			_health += amount;
			
			if (_health > 100)
				_health = 100;
		}
		
		private function SustractHealth(amount:Number):void
		{
			_health -= amount;
			if (_health <= 0)
			{
				_health = 0;
				_isDead = true;
			}
		}
		
		public function get Position():Point
		{
			return _position; 
		}
		
		public function get Health():Number
		{
			return _health;
		}
						
		public function set SetCanShoot(value:Boolean):void
		{
			_canShoot = value;
		}
		
		public function get IsDead():Boolean
		{
			return _isDead;
		}
		
		private function set SetIsDead(dead:Boolean):void
		{
			if (dead)
				_health = 0;
				
			_isDead = dead;
			
		}
	}

}