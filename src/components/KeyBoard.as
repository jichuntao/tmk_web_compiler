package components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class KeyBoard extends Sprite
	{
		private static const KEYBTN_W:Number=56;
		private static const KEYBTN_H:Number=56;
		
		private var matrix:Array=[];
		private var itemArr:Array=[];
		private var keymap:Array;
		public var selectKeyData:Object;
		public function KeyBoard()
		{
			
		}
		public function initMatrix(_matrix:Array):void
		{
			this.matrix=_matrix;
		}

		public function init(_keymap:Array):void
		{
			this.keymap=_keymap;
			
			for(var i:int=0;i<this.matrix.length;i++){
				var y_offset:Number=i*KEYBTN_H;
				var x_offset:Number=0;
				var row:Array=matrix[i];
				itemArr[i]=[];
				for(var j:int=0;j<row.length;j++){
					var key_config:Object=row[j];
					var keybtn:KeyButton=new KeyButton();
					keybtn.setConfig(key_config);
					keybtn.setData(this.keymap[i][j]);
					keybtn.x=x_offset;
					keybtn.y=y_offset;
					keybtn.addEventListener(MouseEvent.ROLL_OVER,onKeyBtnOverFun);
					keybtn.addEventListener(MouseEvent.ROLL_OUT,onKeyBtnOutFun);
					keybtn.addEventListener(MouseEvent.CLICK,onClickFun);
					this.addChild(keybtn);
					itemArr[i].push(keybtn);
					x_offset+=key_config.w*KEYBTN_W;
				}
			}

		}
		private function onClickFun(e:MouseEvent):void
		{
			var item:KeyButton=e.currentTarget as KeyButton;
			this.selectKeyData={};
			this.selectKeyData.key=item.data;
			this.selectKeyData.callback=item.updateDataByVKB;
			dispatchEvent(new Event('select_key'));
		}
		private function onKeyBtnOverFun(e:MouseEvent):void
		{
			var item:KeyButton=e.currentTarget as KeyButton;
			item.mouseOver();
		}
		private function onKeyBtnOutFun(e:MouseEvent):void
		{
			var item:KeyButton=e.currentTarget as KeyButton;
			item.mouseOut();
		}
	}
}