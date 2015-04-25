package ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import components.LayerSelect;
	
	public class LayerList extends Sprite
	{
		public static const CHANGE:String='LayerList.CHANGE';
		public static const HAP:Number=31;
		private var items:Array;
		public var selectIndex:int;
		public function LayerList()
		{
			
		}
		public function select(ix:int,isEvt:Boolean=true):void
		{
			if(ix>=items.length){
				return;
			}
			unSelectAll();
			selectIndex = ix;
			var item:LayerSelect=items[ix] as LayerSelect;
			item.select=true;
			if(isEvt){
				dispatchEvent(new Event(CHANGE));
			}
		}
		public function init(ix:int):void
		{
			clearAll();
			items=[];
			for(var i:int=0;i<ix;i++){
				var layerSelect:LayerSelect=new LayerSelect(i.toString());
				layerSelect.addEventListener(MouseEvent.CLICK,onClickFun);
				this.addChild(layerSelect);
				layerSelect.x=i*HAP;
				items.push(layerSelect);
			}
			select(0);
		}
		public function unSelectAll():void
		{
			for(var i:int=0;i<items.length;i++){
				var item:LayerSelect=items[i] as LayerSelect;
				item.select=false;
			}
		}
		private function clearAll():void
		{
			if(items && items.length){
				for(var i:int=0;i<items.length;i++){
					var item:LayerSelect=items[i] as LayerSelect;
					this.removeChild(item);
					item.removeEventListener(MouseEvent.CLICK,onClickFun);
				}
			}
		}
		private function onClickFun(e:MouseEvent):void
		{
			var ix:int=0;
			var item:LayerSelect=e.currentTarget as LayerSelect;
			ix=items.indexOf(item);
			select(ix);
		}
	}
}