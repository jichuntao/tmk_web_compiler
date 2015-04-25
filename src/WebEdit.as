package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import org.aswing.AsWingManager;
	
	import ui.MainFrame;
	
	[SWF(width=920,height=500,backgroundColor=0xeeeeee,frameRate=20)]
	
	public class WebEdit extends Sprite
	{
		private var mainFrame:MainFrame;

		public function WebEdit()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			AsWingManager.initAsStandard(this);
			this.stage.addEventListener(Event.RESIZE,resizeStage);	
			initControl();
		}
		private function initControl():void
		{
			mainFrame = new MainFrame(this,'Keyboard WebEdit');
			mainFrame.show();
			mainFrame.init();
			resizeStage();
		}
		
		private function resizeStage(e:Event=null):void
		{
			mainFrame.setWidth(this.stage.stageWidth);
			mainFrame.setHeight(this.stage.stageHeight);
			setTimeout(resizeMainPanel,1);
		}
		
		private function resizeMainPanel():void
		{
			mainFrame.resize(mainFrame.getContentPane().getWidth(),mainFrame.getContentPane().getHeight());
		}
	}
}