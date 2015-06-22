package worlds 
{
	//import entities.Word;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class IntroWorld extends World 
	{
		private var _background:Image = null;
		private var _titleText:Text = null;
		private var _pressText:Text = null;
		private var _pressColorTween:ColorTween = null;
		private var _holder:Image = null;
		

		
		public function IntroWorld() 
		{
			super();		
			FP.screen.color = 0x0066FF;

		}
		
		override public function begin():void 
		{
			super.begin();
			//_background = new Image(Assets.INTRO_BACKGROUND);
			
			
			_titleText = new Text("No IDead");
			_titleText.scale = 3;
			_titleText.y = 50;
			_titleText.x = (FP.screen.width - _titleText.scaledWidth) / 2;
			
			_pressText = new Text("press any key to start");
			_pressText.scale = 1.5;
			_pressText.x = (FP.screen.width - _pressText.scaledWidth) / 2;
			_pressText.y = 530;
			
			_pressColorTween = new ColorTween(null, LOOPING);
			_pressColorTween.tween(2, 0x99FFFF, 0x9999FF, 1, 0);
			
			//addGraphic(_background);
			addGraphic(_titleText);
			addGraphic(_pressText);
			
			addTween(_pressColorTween);
		}
		
		override public function update():void 
		{
			super.update();
			
			_pressText.color = _pressColorTween.color;
			
			if (Input.pressed(Key.ANY))
				FP.world = new InstructionWorld();
		}
		
	}

}