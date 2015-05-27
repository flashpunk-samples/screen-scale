package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.tweens.misc.AngleTween;
	
	/**
	 * ...
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Gobbler extends Entity 
	{
		protected var _image:Image;
		protected var _level:uint;
		public var targetX:int;
		public var targetY:int;
		protected var _at:AngleTween;
		protected var _speed:Number;
		
		
		public function Gobbler(animalIndex:uint = 0) 
		{
			_image = new Image(Assets["PLAYER_" + animalIndex]);
			//_image.smooth = true;
			_image.centerOrigin();
			
			targetX = 0;
			targetY = 0;
			_at = new AngleTween();
			super(0, 0, _image);
			level = 3;
		}
		
		public function get angle():Number { return _image.angle; }
		public function set angle(value:Number):void
		{
			_at.cancel();
			_at.tween(_image.angle, value, 10);
			addTween(_at, true);
		}
		
		public function get level():uint { return _level; }
		public function set level(value:uint):void
		{
			_level = value;
			_image.scale = (8 + 8 * _level) / Assets.DEFAULT_SIZE;
			setHitbox(_image.scaledWidth - 4, _image.scaledHeight - 4, _image.scaledWidth * 0.5 - 2, _image.scaledHeight * 0.5 - 2);
			_speed = _level * 1.5;
		}
		
		override public function update():void 
		{
			moveTowards(targetX, targetY, _speed);
			if (_at != null && _at.active)
			{
				_image.angle = _at.angle;
			}
			super.update();
		}
		
	}

}