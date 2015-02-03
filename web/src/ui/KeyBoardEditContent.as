package ui
{
	import flash.display.Sprite;

	public class KeyBoardEditContent extends Sprite
	{
		private var config:Object;
		private var data:Object;
		private static const KEYBTN_W:Number=56;
		private static const KEYBTN_H:Number=56;
		
		private var matrix:Array=[];
		private var itemArr:Array=[];
		public function KeyBoardEditContent()
		{
		}
		public function initData(_data:Object):void
		{
			this.data=_data;
		}
		public function initConfig(cfg:Object):void
		{
			this.config=cfg;
		}
		public function init():void
		{
			var split:Array=this.data.split;
			var arr:Array=this.config.matrix;
			for(var i:int=0;i<this.config.row;i++){
				var row:Array=arr[i];
				matrix[i]=[];
				for(var j:int=0;j<row.length;j++){
					var keycfg:Object=row[j];
					if(keycfg.m==0){
						matrix[i].push(keycfg);
					}else{
						var sps:Array=keycfg.s[split[keycfg.m-1]];
						for(var k:int=0;k<sps.length;k++){
							sps[k].m=keycfg.m;
							matrix[i].push(sps[k]);
						}
					}
				}
			}
		}
		public function drawKeyboard():void
		{
			for(var i:int=0;i<this.config.row;i++){
				var y_offset:Number=i*KEYBTN_H;
				var x_offset:Number=0;
				var row:Array=matrix[i];
				itemArr[i]=[];
				for(var j:int=0;j<row.length;j++){
					var keycfg:Object=row[j];
					var keybtn:KeyButton=new KeyButton();
					keybtn.setW(keycfg.w);
					keybtn.x=x_offset;
					keybtn.y=y_offset;
					this.addChild(keybtn);
					itemArr[i].push(keybtn);
					x_offset+=keycfg.w*KEYBTN_W;
				}
			}
		}
		public function updateKeyLabel():void
		{
			var keymap:Array=this.data.keymap;
			for(var i:int=0;i<keymap.length;i++){
				for(var j:int=0;j<keymap[i].length;j++){
					if(itemArr[i][j]){
						KeyButton(itemArr[i][j]).setData(keymap[i][j]);
						//KeyButton(itemArr[i][j]).setTopTxt(keymap[i][j].k);
					}
				}
			}
		}
	}
}