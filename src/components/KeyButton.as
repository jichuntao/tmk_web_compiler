package components
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import model.ConfigManager;

	public class KeyButton extends MovieClip
	{
		protected var skin:MovieClip;
		protected var topTxt:TextField;
		protected var centerTxt:TextField;
		protected var bottomTxt:TextField;
		public var data:Object;
		public var config:Object;
		private var tween:TweenLite;
		private var icon:Sprite;
		public function KeyButton()
		{
			InitSkin();
		}
		public function InitSkin():void
		{
			var tf:TextFormat=new TextFormat('Helvetica',14,0x777777,true);
			skin = new KeySkin();
			this.addChild(skin);
			topTxt = new TextField();
			centerTxt = new TextField();
			bottomTxt = new TextField();
			this.topTxt.x=10;
			this.topTxt.y=6;
			this.topTxt.height=18;
			this.topTxt.autoSize=TextFieldAutoSize.LEFT;
			this.topTxt.mouseEnabled=false;
			this.topTxt.mouseWheelEnabled=false;
			this.topTxt.defaultTextFormat=tf;
			this.centerTxt.x=10;
			this.centerTxt.y=14;
			this.centerTxt.height=18;
			this.centerTxt.autoSize=TextFieldAutoSize.LEFT;
			this.centerTxt.mouseEnabled=false;
			this.centerTxt.mouseWheelEnabled=false;
			this.centerTxt.defaultTextFormat=tf;
			this.bottomTxt.x=10;
			this.bottomTxt.y=25;
			this.bottomTxt.height=18;
			this.bottomTxt.autoSize=TextFieldAutoSize.LEFT;
			this.bottomTxt.mouseEnabled=false;
			this.bottomTxt.mouseWheelEnabled=false;
			this.bottomTxt.defaultTextFormat=tf;
			this.addChild(this.topTxt);
			this.addChild(this.centerTxt);
			this.addChild(this.bottomTxt);
		}
		public function setConfig(_config:Object):void
		{
			config=_config;
			setW(this.config.w);
			if(this.config.n){
				this.visible=false;
			}
		}
		public function setData(_data:Object):void
		{
			this.data=_data;
			updateData();
		}
		private function updateData():void
		{
			setTopTxt('');
			setCenterTxt('');
			setBottomTxt('');
			if(icon){
				this.removeChild(icon);
				icon=null;
			}
			var kc:String=this.data.k;
			if(!kc){
				return;
			}
			var label:Object=ConfigManager.keyCodeToLabel(kc);
			if(label.min && this.config.w<label.min){
				if(label.st){
					setTopTxt(label.st);
				}
				if(label.sc){
					setCenterTxt(label.sc);
				}
				if(label.sb){
					setBottomTxt(label.sb);
				}
			}else{
				if(label.t){
					setTopTxt(label.t);
				}
				if(label.c){
					setCenterTxt(label.c);
				}
				if(label.b){
					setBottomTxt(label.b);
				}
			}
			if(label.i){
				icon = new label.i();
				this.addChild(icon);
				icon.x=7+(42-icon.width)/2;
				icon.y=4.5+(37-icon.height)/2;
			}
		}
		public function updateDataByVKB():void
		{
			updateData();
			var filter:GlowFilter = new GlowFilter(0x33BDE6);
			filter.blurX = 8;
			filter.blurY = 8;
			filter.strength = 500;
			filter.quality = BitmapFilterQuality.LOW;
			filter.inner = true;
			this.skin.filters=[filter];
			
			TweenPlugin.activate([GlowFilterPlugin]); 
			tween=TweenLite.to(skin, 1.6, {  glowFilter: { color:0x33FFFF, alpha:0, blurX:0, blurY:0 },onComplete:updateVKBComplete} );
		}
		private function updateVKBComplete():void
		{
			if(tween){
				tween.kill()
				this.skin.filters=[];
			}
		}
		private function setTopTxt(str:String):void
		{
			topTxt.text=str;
		}
		private function setCenterTxt(str:String):void
		{
			centerTxt.text=str;
		}
		private function setBottomTxt(str:String):void
		{
			bottomTxt.text=str;
		}
		private function setW(s:Number):void
		{
			this.skin.scaleX=s;
		}
		public function mouseOver():void
		{
			updateVKBComplete();
			var filter:GlowFilter = new GlowFilter(0x119FCF);
			filter.blurX = 8;
			filter.blurY = 8;
			filter.strength = 500;
			filter.quality = BitmapFilterQuality.LOW;
			filter.inner = true;
			this.skin.filters=[filter];
		}
		public function mouseOut():void
		{
			//this.skin.filters=[];
			TweenPlugin.activate([GlowFilterPlugin]); 
			tween=TweenLite.to(skin, 1, {  glowFilter: { color:0x33FFFF, alpha:0, blurX:0, blurY:0 },onComplete:updateVKBComplete} );
		}
	}
}