package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Score extends Entity 
	{
		private var _score:Number = 0;
		
		public function Score(x:Number=0, y:Number=0, scale:Number= 1, graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = new Text("Score: " + _score);
			Text(graphic).scale = scale;
			layer = 50;
			super(x, y, graphic, mask);
		}
		
		public function get GetScore():Number
		{
			return _score;
		}
		public function AddScore(nScore:Number):void
		{
			_score+= nScore;
			Text(graphic).text = "Score: " + _score;
		}
	}

}