package ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import components.KeyBoard;

	public class EditorContent extends Sprite
	{
		public var HAP:Number=30;
		private var data:Object;
		private var kbItemArr:Array;
		public var maskH:Number;
		public var maskW:Number;
		public var kbH:Number;
		private var lastSelectkb:KeyBoard;
		public var selectkb:KeyBoard;
		public var selectIndex:int=0;
		public var selectKeyData:Object;
		public function EditorContent()
		{
			
		}
		public function init(obj:Object):void
		{
			this.data=obj;
			clearKbItemArr();
			kbItemArr=[];
			var matrix:Array=this.data.matrix;
			var layers:Array=this.data.layers;
			for(var i:int=0;i<layers.length;i++){
				var kb:KeyBoard=new KeyBoard();
				kb.addEventListener('select_key',onSelectFun);
				kb.initMatrix(matrix);
				kb.init(layers[i]);
				kb.visible=false;
				kbItemArr.push(kb);
				this.addChild(kb);
				//kb.alpha=0.5;
			}
			selectIndex=0;
			selectkb=kbItemArr[0];
			selectkb.visible=true;
			maskH=kb.height;
			maskW=kb.width;
			kbH=kb.height;
		}
		private function onSelectFun(e:Event):void
		{
			var kb:KeyBoard=e.currentTarget as KeyBoard;
			this.selectKeyData=kb.selectKeyData;
			dispatchEvent(new Event('select_key'));
		}
		public function update(obj:Object):void
		{
			
		}
		public function showkb(ix:int):void
		{
			if(selectIndex==ix){
				return;
			}
			selectIndex=ix;
			lastSelectkb=selectkb;
			selectkb = kbItemArr[ix] as KeyBoard;
//			selectkb.alpha=0;
			selectkb.visible=true;
			lastSelectkb.visible=false;
//			TweenLite.to(lastSelectkb,0.6,{alpha:0,onComplete:onHideKb});
//			TweenLite.to(selectkb,0.6,{alpha:1});
		}
		private function onHideKb():void
		{
			lastSelectkb.visible=false;
		}
		private function clearKbItemArr():void
		{
			if(kbItemArr && kbItemArr.length){
				for(var i:int=0;i<this.kbItemArr.length;i++){
					var item:KeyBoard=kbItemArr[i] as KeyBoard;
					this.removeChild(item);
				}
			}
		}
		
	}
}