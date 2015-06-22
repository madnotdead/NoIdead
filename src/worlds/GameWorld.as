package worlds 
{
	import entities.Bullet;
	import entities.Enemy;
	import entities.Item;
	import entities.Player;
	import entities.Score;
	import entities.Timer;
	import net.flashpunk.Entity;
	//import entities.Word;
	import misc.Constants;
	import misc.Utils;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author madnotdead
	 */
	public class GameWorld extends World
	{
		
		public var GameScore:Score = null;
		
		private var _phaseTime:Number = 10;
		
		private var _gameTimeCounter:Number = 0;
		
		private var _speed:Number = Constants.INITIAL_SPEED;
		
		private var _background:Image = null;
		
		private var _mainTheme:Sfx = null;
		
		private var _currentPhase:Number = Constants.SURVIVE;
		
		private var _phaseCount:Number = 3;
		
		private var _timer:Timer = null;
		
		private var _prevPhase:Number = Constants.SURVIVE;
		
		private var _collectTimeRate:Number = 1;
		
		private var _collectTime:Number = 0;
		
		private var _player:Player = null;
		
		private var _itemSpawnRate:Number = 1;
		private var _itemSpawnCount:Number = 0;
		
		private var _enemySpawnRate:Number = 1;
		private var _enemySpawnCounter:Number = 0;
		
		private var _bulletSpawnRate:Number = 1;
		private var _bulletSpawnCounter:Number = 0;
		
		private var _currentEnemyDirection:String = Constants.LEFT;
		private var _cameraY:Number = 100;
		private var _cameraX:Number = 100;
		private var _cameraSize:Number = 400;
		public function GameWorld() 
		{
			FP.screen.color = 0x330000;
			GameScore = new Score(_cameraSize, _cameraSize + 75,1);
			_timer = new Timer(210, 60, 0, false);
			_player = new Player(FP.screen.width / 2, FP.screen.height / 2);
			
			//_background = new Image(Assets.PLAY);
			
			//_mainTheme = new Sfx(Assets.MAIN);
			//_mainTheme.loop();
		}
		
		override public function begin():void 
		{
			super.begin();
			//addGraphic(_background,100);
			add(GameScore);
			add(_timer);
			add(_player);
			
			FP.camera.x = 100;
			FP.camera.y = 100;
			FP.screen.scale = 1.5;
		}
		override public function update():void 
		{
			super.update();
			
			//trace("Current phase: " + _currentPhase);
			
			if (_currentPhase == Constants.SURVIVE)
			{
				_bulletSpawnCounter += FP.elapsed;
				
				if(_bulletSpawnCounter >= _bulletSpawnRate)
				{
					_bulletSpawnRate = Utils.randomRange(.3, .5);
					_bulletSpawnCounter = 0;
					add(new Bullet(0,0,GetBulletDirectionByIndex(Utils.randomRange(1, 4))));
					trace("_bulletSpawnCounter: " + _bulletSpawnCounter);
				}
			}
			
			if (_currentPhase == Constants.COLLECT)
			{
				_itemSpawnCount += FP.elapsed;
				
				if(_itemSpawnCount >= _itemSpawnRate)
				{
					_itemSpawnRate = Utils.randomRange(2, 3);
					_itemSpawnCount = 0;
					add(new Item());
					trace("_itemSpawnRate: " + _itemSpawnRate);
				}
				
			}
			
			if (_currentPhase == Constants.DESTROY)
			{
				_enemySpawnCounter += FP.elapsed;
				
				if(_enemySpawnCounter >= _enemySpawnRate)
				{
					_enemySpawnRate = Utils.randomRange(.5, 1.5);
					_enemySpawnCounter = 0;
					add(new Enemy(0, 0, _currentEnemyDirection));
					trace("_enemySpawnRate: " + _enemySpawnRate);
				}
			}
			
			
			if (_timer.Time % _phaseTime == 0)
			{ 
				_gameTimeCounter += FP.elapsed;
				
				if (_gameTimeCounter >= 1)
				{
					GetNextPhase();
					//trace("Current phase after GetNextPhase(): " + _currentPhase);
					_gameTimeCounter = 0;
				}
			}
			
		}
		
		public function GetNextPhase():void
		{
			_prevPhase = _currentPhase;
			CleanPrevPhase(_prevPhase);
			_currentPhase++;
			
			if (_currentPhase == _phaseCount)
				_currentPhase = Constants.SURVIVE;
			
			if (_currentPhase == Constants.DESTROY)
				_currentEnemyDirection = GetBulletDirectionByIndex(Utils.randomRange(1, 4));
			
				trace("prevPhase: " + _prevPhase);
				trace("_currentPhase: " + _currentPhase);
		}
		
		private function CleanPrevPhase(prevPhase:Number):void
		{
			if (prevPhase == Constants.COLLECT)
			{
				var itemsArray:Array = new Array();
				getType("item", itemsArray);
				removeList(itemsArray);
			}
			
			if (prevPhase == Constants.SURVIVE)
			{
				var bulletsArray:Array = new Array();
				getType("bullet", bulletsArray);
				removeList(bulletsArray);
			}
			
			if (prevPhase == Constants.DESTROY)
			{
				var enemiesArray:Array = new Array();
				getType("enemy", enemiesArray);
				removeList(enemiesArray);
			}
		}
		
		private function GetBulletDirectionByIndex(index:Number):String
		{
			var direction:String = "";
			
			switch (index) 
			{
				case 1:
					direction = Constants.UP;	
				break;
				case 2:
					direction = Constants.DOWN;
				break;
				case 3:
					direction = Constants.LEFT;
				break;
				case 4:
					direction = Constants.RIGHT;
				break;
				default:
				return Constants.UP;
				break;
			}
			
			return direction;
		}
		
		public function get currentPlayer():Player
		{
			return _player;
		}
	}

}