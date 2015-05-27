package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	[SWF(width="800", height="600", background="#aaaaaa")]
	
	/**
	 * Entry point.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Main extends Engine 
	{
		
		public function Main() 
		{
			super(800, 600, 60, true);
			//FP.console.enable();
		}
		
		override public function init():void 
		{
			super.init();
			FP.screen.color = 0xaaaaaa;
			FP.world = new ScaleWorld();
		}
		
	}
	
}