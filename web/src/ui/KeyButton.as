package ui
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class KeyButton extends MovieClip
	{
		protected var skin:MovieClip;
		protected var topTxt:TextField;
		protected var bottomTxt:TextField;
		public var data:Object;
		public var config:Object;
		public function KeyButton()
		{
			InitSkin();
		}
		public function InitSkin():void
		{
			skin = new KeySkin();
			this.addChild(skin);
			topTxt = new TextField();
			bottomTxt = new TextField();
			this.topTxt.x=10;
			this.topTxt.y=6;
			this.topTxt.mouseEnabled=false;
			this.topTxt.mouseWheelEnabled=false;
			this.addChild(this.topTxt);
			this.bottomTxt.x=10;
			this.bottomTxt.x=25;
		}
		public function setData(b:Object):void
		{
			this.data=b;
			setTopTxt(this.data.k);
		}
		public function setTopTxt(str:String):void
		{
			topTxt.text=str;
		}
		public function setBottomTxt(str:String):void
		{
			bottomTxt.text=str;
		}
		public function setW(s:Number):void
		{
			this.skin.scaleX=s;
		}
	}
}