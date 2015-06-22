package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class InstructionWorld extends World 
	{
		
		private var _background:Image = null;
		private var _instruction:Image = null;
		public function InstructionWorld() 
		{
			super();
			
			//_background = new Image(Assets.PLAY);
			//_instruction = new Image(Assets.INSTRUCTIONS);
		}
		
		override public function begin():void 
		{
			super.begin();
			
			addGraphic(_background, 100);
			addGraphic(_instruction);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
				FP.world = new GameWorld();
		}
	}

}