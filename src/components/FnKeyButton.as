package components
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import model.ConfigManager;

	public class FnKeyButton extends MovieClip
	{
		private var skin:MovieClip;
		private var c:TextField;
		private var btn:MovieClip;
		private var _enable:Boolean=true; 
		public var key:String;
		public function FnKeyButton(mc:MovieClip)
		{
			this.skin=mc;
			this.c=this.skin.c;
			this.c.mouseEnabled=false;
			this.btn=this.skin.btn;
			this.btn.addEventListener(MouseEvent.ROLL_OVER,onMouseRollFun);
			this.btn.addEventListener(MouseEvent.ROLL_OUT,onMouseOutFun);
			this.btn.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownFun);
			this.btn.addEventListener(MouseEvent.MOUSE_UP,onMouseUpFun);
			this.btn.stop();
		}
		private function onMouseDownFun(e:MouseEvent):void
		{
			this.btn.gotoAndStop(3);
		}
		private function onMouseUpFun(e:MouseEvent):void
		{
			this.btn.gotoAndStop(1);
			dispatchEvent(new Event('click'));
		}
		private function onMouseRollFun(e:MouseEvent):void
		{
			this.btn.gotoAndStop(2);
		}
		private function onMouseOutFun(e:MouseEvent):void
		{
			this.btn.gotoAndStop(1);
		}
		public function setVisible(b:Boolean):void
		{
			this.skin.visible=b;
		}
		public function getVisible():Boolean
		{
			return this.skin.visible;
		}
		public function getSkin():MovieClip
		{
			return this.skin;
		}
		public function updateKey(kc:String):void
		{
			this.key=kc;
			var label:Object=ConfigManager.keyCodeToLabel(kc);
			c.text=label.d;
			var w:Number=c.textWidth;
			this.skin.btn.width=w+20;
			c.x=0;
			c.width=w+20;
		}
		
	}
}