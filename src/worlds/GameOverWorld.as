package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class GameOverWorld extends World 
	{
		
		private var _score:Number;
		private var _background:Image = null;
		private var _scoreText:Text = null;
		private var _scoreAmoutText:Text = null;
		
		private var _titleText:Text = null;
		private var _pressText:Text = null;
		private var _pressColorTween:ColorTween = null;
		
		
		public function GameOverWorld(score:Number) 
		{
			super();
			FP.screen.color = 0x00FF00;
			_score = score;
			//_background = new Image(Assets.SCORE_BACKGROUND);
			_scoreText = new Text("SCORE");
			_scoreText.scale = 4;
			_scoreText.x = (FP.screen.width - _scoreText.scaledWidth) / 2;
			_scoreText.y = 190;
			
			_scoreAmoutText = new Text(_score.toString());
			_scoreAmoutText.scale = 4;
			_scoreAmoutText.x = (FP.screen.width - _scoreAmoutText.scaledWidth) / 2;
			_scoreAmoutText.y = 350;
			
			_titleText = new Text("GAME OVER");
			_titleText.scale = 3;
			_titleText.y = 50;
			_titleText.x = (FP.screen.width - _titleText.scaledWidth) / 2;
			
			_pressText = new Text("press any key to restart");
			_pressText.scale = 1.5;
			_pressText.x = (FP.screen.width - _pressText.scaledWidth) / 2;
			_pressText.y = 530;
			
			_pressColorTween = new ColorTween(null, LOOPING);
			_pressColorTween.tween(2, 0x99FFFF, 0x9999FF, 1, 0);
		}
		
		override public function begin():void 
		{
			super.begin();
			trace("SCORE: " + _score);
			//addGraphic(_background, 100);
			addGraphic(_scoreText);
			addGraphic(_scoreAmoutText);
			addGraphic(_pressText);
			addGraphic(_titleText);
			
			addTween(_pressColorTween);
			
			FP.camera.x = 0;
			FP.camera.y = 0;
			FP.screen.scale = 1;
			FP.resetCamera();
		}
		
		override public function update():void 
		{
			super.update();
	
			_pressText.color = _pressColorTween.color;
			
			if (Input.pressed(Key.ANY))
			{
				FP.world = new IntroWorld();
			}
		}
		
	}

}