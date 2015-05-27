package 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class ScaleWorld extends World 
	{
		protected var _gobblerType:uint;
		protected var _player:Gobbler;
		protected var _snacksGobbled:uint;
		protected var _maxSize:Boolean = false;
		protected var _snacks:uint = 0;
		
		public function ScaleWorld() 
		{
			//FP.screen.smoothing = true;
			super();
			
		}
		
		override public function begin():void 
		{
			centerCamera();
			
			_gobblerType = FP.rand(Assets.VARIATION_COUNT);
			_player = new Gobbler(_gobblerType);
			add(_player);
			createSmallSnack();
			createSmallSnack();
			createSmallSnack();
			super.begin();
		}
		
		override public function update():void 
		{
			if (Input.mouseDown)
			{
				var xl:int = Input.mouseX + FP.camera.x;
				var yl:int = Input.mouseY + FP.camera.y;
				_player.angle = FP.angle(xl, yl, _player.x, _player.y) - 90;
				_player.targetX = xl;
				_player.targetY = yl;
			}
			var s:Snack = Snack(_player.collide("snack", _player.x, _player.y))
			
			if (s != null && s.level < _player.level)
			{
				remove(s);
				_snacks--;
				
				if (_maxSize)
				{
					if (Math.random() > 0.4) createSmallSnack();
					if (Math.random() > 0.8) createSmallSnack();
				}
				else
				{
					createSmallSnack();
					if (Math.random() > 0.5) createBigSnack();
					if (Math.random() > 0.5) createSmallSnack();
				}
				
				_snacksGobbled++;
				
				if (_snacksGobbled >= 5)
				{
					levelUp();
				}
			}
			
			super.update();
		}
		
		protected function createSmallSnack():void
		{
			add(new Snack(FP.rand(FP.screen.width) + FP.camera.x, FP.rand(FP.screen.height) + FP.camera.y, FP.rand(Assets.VARIATION_COUNT), FP.clamp(_player.level - 1 - FP.rand(3), 0, 10)));
			_snacks++;
		}
		
		protected function createBigSnack():void
		{
			add(new Snack(FP.rand(FP.screen.width) + FP.camera.x, FP.rand(FP.screen.height) + FP.camera.y, FP.rand(Assets.VARIATION_COUNT), FP.rand(2) + _player.level));
			_snacks++;
		}
		
		protected function levelUp():void
		{
			_player.level++;
			
			// Player needs to stay at the same 32 pixel size.
			var currentSize:Number = 8 + 8 * _player.level;
			var screenScale:Number = 32 / currentSize;
			if (screenScale > 0.25)
			{
				FP.screen.scale = screenScale;
				FP.resize(800 * 1 / screenScale, 600 * 1 / screenScale);
				centerCamera();
			}
			else
			{
				screenScale = 0.25;
				FP.screen.scale = screenScale;
				FP.resize(800 * 1 / screenScale, 600 * 1 / screenScale);
				_maxSize = true;
				centerCamera();
			}
			
			_snacksGobbled = 0;
		}
		
		protected function centerCamera():void
		{
			FP.camera.x = -Math.round(FP.screen.width * 0.5);
			FP.camera.y = -Math.round(FP.screen.height * 0.5);
		}
		
	}

}