package ui
{
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import model.DataManager;
	import model.NetManager;
	
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JLabel;
	import org.aswing.JOptionPane;
	

	public class MainFrame extends BaseJFrame
	{
		private var keyboardPanel:KeyBoardPanel;
		private var downLoadBtn:JButton;
		private var defaultAsFont:ASFont;
		private var msgLabel:JLabel;
		private var isDownLoadOver:Boolean=false;
		private var hexByteArr:ByteArray;
		public function MainFrame(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			this.setActivable(false);
			this.setResizable(false);
			this.setDragable(false);
			this.setClosable(false);
			this.getContentPane().setLayout(new EmptyLayout());
		}
		public function init():void
		{
			keyboardPanel = new KeyBoardPanel();
			keyboardPanel.init();
			keyboardPanel.setLocationXY(10,30);
			this.getContentPane().append(keyboardPanel);
			
			defaultAsFont=new ASFont("Tahoma", 18, true, false, false, false);
			downLoadBtn = new JButton('编译固件(.hex)');
			downLoadBtn.setFont(defaultAsFont);
			downLoadBtn.setBackground(new ASColor(0x73CF3E, 1));
			downLoadBtn.setSizeWH(150,40);
			this.getContentPane().append(downLoadBtn);
			downLoadBtn.addEventListener(MouseEvent.CLICK,onDownClickFun);
			
			msgLabel = new JLabel("",null,2);
			msgLabel.setFont(new ASFont("Tahoma", 14, true, false, false, false));
			msgLabel.setSizeWH(200,30);
			this.getContentPane().append(msgLabel);
		}
		
		private function onDownClickFun(e:MouseEvent):void
		{
			if(isDownLoadOver){
				isDownLoadOver=false;
				var fs:FileReference=new FileReference();
				fs.save(hexByteArr,'epbt.hex');
				resetDownBtn();
				return;
			}
			msgLabel.setText('正在编译...');
			downLoadBtn.setEnabled(false);
			downLoadBtn.setText('正在编译...');
			NetManager.instance.call('compile','',JSON.stringify(DataManager.instance.packData()),gethexCallback);
		}
		private function resetDownBtn():void
		{
			msgLabel.setText('');
			downLoadBtn.setEnabled(true);
			downLoadBtn.setText('编译固件(.hex)');
		}
		private function gethexCallback(err:String,data:ByteArray):void
		{
			if(err){
				JOptionPane.showMessageDialog('错误','          '+ err +'          ');
				resetDownBtn();
				return;
			}
			var jsonStr:String=data.toString();
			var ret:Object;
			try{
				ret=JSON.parse(jsonStr);
			}
			catch(e:Error){
				JOptionPane.showMessageDialog('错误','          '+ e +'          ');
				resetDownBtn();
				return;
			}
			if(ret.status=='success'){
				msgLabel.setText('编译成功，正在下载...');
				downLoadBtn.setText('正在下载...');
			}else{
				msgLabel.setText('编译失败,请检查重试！');
				resetDownBtn();
				return;
			}

			NetManager.instance.download(ret.path,onProgressFun,onDownLoadFun);
		}
		
		private function onProgressFun(loaded:Number,total:Number):void
		{
			msgLabel.setText('正在下载('+loaded+'bytes)');
		}
		
		private function onDownLoadFun(err:String,data:ByteArray):void
		{
			if(err){
				JOptionPane.showMessageDialog('错误','          ' + err + '          ');
				resetDownBtn();
				return;
			}
			isDownLoadOver=true;
			hexByteArr=data;
			msgLabel.setText('下载完成，请单击保存...');
			downLoadBtn.setEnabled(true);
			downLoadBtn.setText('保存');
		}
		
		public function resize(W:Number,H:Number):void
		{
			keyboardPanel.setSizeWH(W-10,360);
			downLoadBtn.setLocationXY(730,420);
			msgLabel.setLocationXY(downLoadBtn.getX()-200,425);
		}
	}
}