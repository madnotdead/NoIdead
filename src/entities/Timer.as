package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Timer extends Entity 
	{
		
		private var timerText:Text = null;
		private var count:Number = 0;
		private var running:Boolean = true;
		private var _timeUp:Boolean = false;
		private var timeToElapsed:Number = 0;
		private var timeAmount:Number = 0;
		private var isCountDown:Boolean = true;
		public function Timer(x:Number=0, y:Number=0, settedTime:Number = 60, countDown:Boolean = false, graphic:Graphic=null, mask:Mask=null) 
		{
			
			timerText = new Text("Time: " + settedTime, x, y);
			graphic = timerText;
			timeAmount = settedTime;
			timeToElapsed = timeAmount;
			isCountDown = countDown;
			super(x, y, graphic, mask);
		}
		
		//private var i:int = 60; 
		
		override public function update():void 
		{
			super.update();
			
			if (!running) return;
			
			count += FP.elapsed;
			
			if (!isCountDown)
			{
				if (count >= 1)
				{
					timerText.text = "Time: " + ++timeToElapsed;
					count = 0;
				}
			}
			else
			{
				if (count >= 1)
				{
					timerText.text = "Time: " + --timeToElapsed;
					count = 0;
				}

				if (timeToElapsed <= 0)
				{
					_timeUp = true;
					Stop();
				}
			}
		}
		
		public function get Time():int
		{
			return timeToElapsed;
		}
		
		public function get TimeUp():Boolean
		{
			return _timeUp;
		}
		
		public function Stop():void
		{
			running = false;
		}
		
		public function Restart():void
		{
			running = true;
			timeToElapsed = timeAmount;
		}
	}

}