package components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class LayerSelect extends Sprite
	{
		private var skin:LayerSelectSkin;
		private var isSelected:Boolean=false;
		public static const SELECT:String='LayerSelect.SELECT';
		public function LayerSelect(tx:String)
		{
			this.skin=new LayerSelectSkin();
			this.addChild(skin);
			this.skin.gotoAndStop(1);
			this.skin.txt.text=tx;
			this.skin.txt.mouseEnabled=false;
			this.skin.txt.mouseWheelEnabled=false;
			this.skin.txt.autoSize=TextFieldAutoSize.CENTER;
			this.skin.txt.x=-this.skin.txt.width/2;
			this.skin.txt.y=-this.skin.txt.height/2;
			this.skin.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveFun);
			this.skin.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutFun);
			this.skin.addEventListener(MouseEvent.CLICK,onClickFun);
		}
		public function set select(b:Boolean):void
		{
			this.isSelected=b;
			if(b){
				this.skin.gotoAndStop(2);
			}else{
				this.skin.gotoAndStop(1);
			}
		}
		private function onMouseMoveFun(e:MouseEvent):void
		{
			if(isSelected){
				return;
			}
			this.skin.gotoAndStop(3);
		}
		private function onMouseOutFun(e:MouseEvent):void
		{
			if(isSelected){
				return;
			}
			this.skin.gotoAndStop(1);
		}
		private function onClickFun(e:MouseEvent):void
		{
			dispatchEvent(new Event(SELECT));
		}
	}
}