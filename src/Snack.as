package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.tweens.misc.VarTween;
	
	/**
	 * ...
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Snack extends Entity 
	{
		protected var _image:Image;
		protected var _level:uint;
		protected var _spin:Number;
		public function Snack(x:Number, y:Number, snackIndex:uint, snackLevel:uint) 
		{
			_image = new Image(Assets["SNACK_" + snackIndex]);
			//_image.smooth = true;
			_image.centerOrigin();
			super(x, y, _image);
			level = snackLevel;
			_spin = (Math.random() - 0.5) * 4;
			layer = 1;
			type = "snack";
		}
		
		public function get level():uint { return _level; }
		public function set level(value:uint):void
		{
			var i:Image = _image;
			_level = value;
			var scaleValue:Number = (8 + 8 * _level) / Assets.DEFAULT_SIZE;
			var scaleSize:Number = (8 + 8 * _level);
			_image.scale = 0;
			var scale:VarTween = new VarTween(function():void { i.scale = (8 + 8 * _level) / Assets.DEFAULT_SIZE; i.smooth = true; } );
			scale.tween(_image, "scale", (8 + 8 * _level) / Assets.DEFAULT_SIZE, 10);
			addTween(scale, true);
			setHitbox(scaleSize - 4, scaleSize - 4, scaleSize * 0.5 - 2, scaleSize * 0.5 - 2);
		}
		
		override public function update():void 
		{
			super.update();
			_image.angle += _spin;
		}
		
	}

}