package worlds 
{
	import net.flashpunk.Entity;
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
		private var _instructionHolder:Entity = null;
		public function InstructionWorld() 
		{
			super();
			FP.screen.color = 0xFFFFFF;
			//_background = new Image(Assets.PLAY);
			_instruction = new Image(Assets.INSTRUCTIONS);
		}
		
		override public function begin():void 
		{
			super.begin();
			
			//addGraphic(_background, 100);
			_instructionHolder = addGraphic(_instruction);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.ANY))
			{
				remove(_instructionHolder);
				FP.world = new GameWorld();
			}
		}
	}

}