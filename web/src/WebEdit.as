package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.aswing.ASColor;
	import org.aswing.AsWingManager;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JTabbedPane;
	import org.aswing.border.LineBorder;
	
	import ui.KeyBoardPanel;
	import ui.SelectKeyboardFrame;
	
	[SWF(width=960,height=480,backgroundColor=0xFFFFFF,frameRate=20)]
	
	public class WebEdit extends Sprite
	{
		private var frame:JFrame;
		private var mainTable:JTabbedPane;
		private var keyboardPanel:KeyBoardPanel;
		private var selectKeyboardFrame:SelectKeyboardFrame;
		public function WebEdit()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
			this.stage.addEventListener(Event.RESIZE,resizeStage);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			AsWingManager.initAsStandard(this);
			initControl();
		}
		private function initControl():void
		{
			frame = new JFrame(this,'Keyboard WebEdit');
			frame.setActivable(false);
			frame.setResizable(false);
			frame.setDragable(false);
			frame.setClosable(false);
			
			frame.show();
			
			
			mainTable = new JTabbedPane();
			frame.getContentPane().append(mainTable);
			
			keyboardPanel = new KeyBoardPanel();
			
			var border0:LineBorder = new LineBorder();
			border0.setColor(new ASColor(0x0, 1));
			keyboardPanel.setBorder(border0);
			
			var panel2:JPanel = new JPanel(); 
			panel2.append(new JButton("button1")); 
			panel2.append(new JButton("button2")); 

			mainTable.appendTab(keyboardPanel,'KeyBoard');
			mainTable.appendTab(panel2,'LED');
			
			//selectKeyboardFrame = new SelectKeyboardFrame(this,'Select Keyboard');
			//selectKeyboardFrame.show();
			resizeStage();
		}
		
		private function resizeStage(e:Event=null):void
		{
			frame.setWidth(this.stage.stageWidth);
			frame.setHeight(this.stage.stageHeight);	
		}
	}
}