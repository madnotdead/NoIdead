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
		
		private var _rounds:Number;
		private var _background:Image = null;
		private var _roundsText:Text = null;
		private var _roundsAmoutText:Text = null;
		private var _timeText:Text = null;
		private var _timeAmoutText:Text = null;
		private var _titleText:Text = null;
		private var _pressText:Text = null;
		private var _scoreText:Text = null;
		private var _scoreAmoutText:Text = null;
		private var _pressColorTween:ColorTween = null;
		
		
		public function GameOverWorld(times:Number,rounds:Number,score:Number) 
		{
			super();
			FP.screen.color = 0x009999;
			_rounds = rounds;
			//_background = new Image(Assets.SCORE_BACKGROUND);
			_roundsText = new Text("ROUNDS");
			_roundsText.scale = 4;
			_roundsText.x = (FP.screen.width - _roundsText.scaledWidth) / 2;
			_roundsText.y = 190;
			
			_roundsAmoutText = new Text(rounds.toString());
			_roundsAmoutText.scale = 4;
			_roundsAmoutText.x = (FP.screen.width - _roundsAmoutText.scaledWidth) / 2;
			_roundsAmoutText.y = 250;
			
			_timeText = new Text("TIME");
			_timeText.scale = 4;
			_timeText.x = 100
			_timeText.y = 320;
			
			_timeAmoutText = new Text(times.toString());
			_timeAmoutText.scale = 4;
			_timeAmoutText.x = 100;
			_timeAmoutText.y = 380;
			
			_scoreText = new Text("SCORE");
			_scoreText.scale = 4;
			_scoreText.x = 300;
			_scoreText.y = 320;
			
			_scoreAmoutText = new Text(score.toString());
			_scoreAmoutText.scale = 4;
			_scoreAmoutText.x = 300;
			_scoreAmoutText.y = 380;
			
			_titleText = new Text("GAME OVER");
			_titleText.scale = 5;
			_titleText.y = 50;
			_titleText.x = (FP.screen.width - _titleText.scaledWidth) / 2;
			
			_pressText = new Text("press any SPACE to restart");
			_pressText.scale = 1.5;
			_pressText.x = (FP.screen.width - _pressText.scaledWidth) / 2;
			_pressText.y = 530;
			
			_pressColorTween = new ColorTween(null, LOOPING);
			_pressColorTween.tween(2, 0x99FFFF, 0x9999FF, 1, 0);
		}
		
		override public function begin():void 
		{
			super.begin();
			
			addGraphic(_roundsText);
			addGraphic(_roundsAmoutText);
			addGraphic(_timeText);
			addGraphic(_timeAmoutText);
			addGraphic(_pressText);
			addGraphic(_titleText);
			addGraphic(_scoreText);
			addGraphic(_scoreAmoutText);
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
			
			if (Input.pressed(Key.SPACE))
			{
				FP.world = new IntroWorld();
			}
		}
		
	}

}