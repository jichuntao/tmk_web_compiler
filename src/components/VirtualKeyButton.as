package components
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class VirtualKeyButton extends MovieClip
	{
		private var skin:MovieClip;
		private var btn:MovieClip;
		private var selected:Boolean=false;
		public var keycode:String;
		private var _enable:Boolean=true; 
		public function VirtualKeyButton(mc:MovieClip)
		{
			this.skin=mc;
			this.skin.addEventListener(MouseEvent.ROLL_OVER,onMouseRollFun);
			this.skin.addEventListener(MouseEvent.ROLL_OUT,onMouseOutFun);
			this.skin.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownFun);
			this.skin.addEventListener(MouseEvent.MOUSE_UP,onMouseUpFun);
			this.skin.stop();
		}
		private function onMouseDownFun(e:MouseEvent):void
		{
			if(!_enable){
				return;
			}
			this.skin.gotoAndStop(4);
		}
		private function onMouseUpFun(e:MouseEvent):void
		{
			if(!_enable){
				return;
			}
			this.skin.gotoAndStop(1);
			dispatchEvent(new Event('select'));
		}
		private function onMouseRollFun(e:MouseEvent):void
		{
			if(!_enable){
				return;
			}
			this.skin.gotoAndStop(2);
		}
		private function onMouseOutFun(e:MouseEvent):void
		{
			if(!_enable){
				return;
			}
			if(selected){
				this.skin.gotoAndStop(3);
			}else{
				this.skin.gotoAndStop(1);
			}
		}
		public function set select(b:Boolean):void
		{
			selected=b;
			if(b){
				this.skin.gotoAndStop(3);
			}else{
				this.skin.gotoAndStop(1);
			}
		}
		public function get select():Boolean
		{
			return selected;
		}
		public function set enable(b:Boolean):void
		{
			_enable=b;
			if(!b){
				this.skin.gotoAndStop(4);
			}else{
				this.skin.gotoAndStop(1);
			}
		}
		public function get enable():Boolean
		{
			return _enable;
		}
	}
}