package ui
{
	
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.DataManager;
	import model.NetManager;
	
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.Border;
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JLabel;
	import org.aswing.JOptionPane;
	import org.aswing.JPanel;
	import org.aswing.border.SideLineBorder;
	import org.aswing.event.FrameEvent;

	public class KeyBoardPanel extends JPanel
	{
		private var content:EditorContent;
		private var defaultAsFont:ASFont;
		private var editBtn:JButton;
		private var addLayerBtn:JButton;
		private var delLayerBtn:JButton;
//		private var exampleLayoutComboBox:JComboBox;
		private var layerList:LayerList;
		private var contentMask:Sprite;
		private var layerLabel:JLabel;
		private var kbbg:KbBg;
		private var virtualKb:VirtualKeyboard;
		private var grayLayer:Sprite;
		private var dataManager:DataManager=DataManager.instance;
		private var downloadBtn:JButton;
		
		public function KeyBoardPanel()
		{
			dataManager.ontest2();
			this.setLayout(new EmptyLayout());
			
			defaultAsFont=new ASFont("Tahoma", 16, true, false, false, false);
			editBtn = new JButton('Edit Layout');
			editBtn.setFont(defaultAsFont);
			editBtn.setWidth(120)
			editBtn.setHeight(30);
			editBtn.addEventListener(MouseEvent.CLICK,onEditLayoutFun);
			
			addLayerBtn = new JButton('添加');
			addLayerBtn.setFont(defaultAsFont);
			addLayerBtn.setBackground(new ASColor(0x73CF3E, 1));
			addLayerBtn.setWidth(60)
			addLayerBtn.setHeight(30);
			addLayerBtn.addEventListener(MouseEvent.CLICK,onAddLayerFun);
				
			delLayerBtn = new JButton('删除');
			delLayerBtn.setFont(defaultAsFont);
			delLayerBtn.setBackground(new ASColor(0xff3300, 1));
			delLayerBtn.setWidth(60)
			delLayerBtn.setHeight(30);
			delLayerBtn.addEventListener(MouseEvent.CLICK,onDelLayerFun);
			
			layerLabel = new JLabel('层: ',null,JLabel.RIGHT);
			layerLabel.setFont(defaultAsFont);
			layerLabel.setWidth(60)
			layerLabel.setHeight(30);
			
//			exampleLayoutComboBox=new JComboBox();
//			exampleLayoutComboBox.setFont(defaultAsFont);
//			exampleLayoutComboBox.setMaximumRowCount(7);
//			exampleLayoutComboBox.setWidth(120)
//			exampleLayoutComboBox.setHeight(30);
					
			
//			this.append(editBtn);
			this.append(addLayerBtn);
			this.append(delLayerBtn);
			this.append(layerLabel);
//			this.append(exampleLayoutComboBox);
			
			kbbg = new KbBg();
			
			content = new EditorContent();
			content.addEventListener('select_key',onSelectKeyFun);
			content.y=55;
			content.x=15;
			
			contentMask = new Sprite();
			contentMask.x=content.x;
			contentMask.y=content.y;
			
			this.addChild(kbbg);
			this.addChild(content);
			this.addChild(contentMask);
			
			layerList=new LayerList();
			layerList.addEventListener(LayerList.CHANGE,onChangeSelect);
			this.addChild(layerList);
			
			virtualKb=new VirtualKeyboard(this.getParent(),'Keycode Symbol Table');
			virtualKb.setSizeWH(730,340);
			
			addLayerBtn.setLocationXY(0,5);
			delLayerBtn.setLocationXY(addLayerBtn.getWidth()+addLayerBtn.getX()+4,5);
			layerLabel.setLocationXY(delLayerBtn.getWidth()+delLayerBtn.getX(),5);			
			layerList.x=layerLabel.getWidth()+layerLabel.getX()+14;
			layerList.y=19;
//			exampleLayoutComboBox.setListData([1,2,3,4,5,6]);
//			exampleLayoutComboBox.setSelectedIndex(0);
//			exampleLayoutComboBox.setLocationXY(870-exampleLayoutComboBox.getWidth(),14);
			editBtn.setLocationXY(870-editBtn.getWidth()-20,19);
		}
		public function init():void
		{
			content.init(dataManager.getData());
			layerList.init(dataManager.getLayerCount());
			initMask();
		}
		private function initMask():void
		{
			contentMask.graphics.clear();
			contentMask.graphics.beginFill(0xff0000,0.4);
			contentMask.graphics.drawRect(0,0,content.maskW,content.maskH);
			contentMask.graphics.endFill();
			content.mask=contentMask;
			kbbg.width=content.maskW+30;
			kbbg.height=content.maskH+30;
			kbbg.x=content.x+content.width/2;
			kbbg.y=content.y+content.height/2;
		}
		private function onChangeSelect(e:Event):void
		{
			content.showkb(layerList.selectIndex);
		}
		
		private function onSelectKeyFun(e:Event):void
		{
			var selectKeyData:Object=content.selectKeyData;
			showVirtualKeyBoard(selectKeyData);
		}
		
		private function showVirtualKeyBoard(_obj:Object):void
		{
			showGrayLayer();
			virtualKb.show();
			virtualKb.select(_obj);
			virtualKb.setLocationXY(content.x+(content.width-virtualKb.getWidth())/2+15,content.y+30);
			virtualKb.addEventListener(FrameEvent.FRAME_CLOSING,onVirtualHideFun);
		}
		private function onVirtualHideFun(e:FrameEvent):void
		{
			hideGrayLayer();
		}
		private function showGrayLayer():void
		{
			grayLayer = new Sprite();
			grayLayer.graphics.beginFill(0x999999,0.5);
			grayLayer.graphics.drawRoundRect(0,0,this.getParent().getWidth(),this.getParent().getHeight(),12,12);
			grayLayer.graphics.endFill();
			this.getParent().addChild(grayLayer);
			grayLayer.alpha=0.2;
			TweenLite.to(grayLayer,0.2,{alpha:1});
		}
		private function hideGrayLayer():void
		{
			TweenLite.to(grayLayer,0.2,{alpha:0,onComplete:onGrayLoayerHideFun});
		}
		private function onGrayLoayerHideFun():void
		{
			if(grayLayer){
				this.getParent().removeChild(grayLayer);
				grayLayer=null;
			}
		}
		private function onAddLayerFun(e:MouseEvent):void
		{
			if(dataManager.getLayerCount()>=10){
				return;
			}
			var ix:int=dataManager.addLayer();
			init();
			layerList.select(ix);
		}
		private function onDelLayerFun(e:MouseEvent):void
		{
			if(dataManager.getLayerCount()<=1){
				return;
			}
			showGrayLayer();
			var jp:JOptionPane=JOptionPane.showMessageDialog('提示','		您是否要删除第'+layerList.selectIndex+'层		',delLayerMsgCallback,this,true,null,3);
		}
		private function delLayerMsgCallback(ix:int):void
		{
			if(ix==1){
				var ix:int=dataManager.delLayer(layerList.selectIndex);
				init();
				layerList.select(ix);
			}
			hideGrayLayer();
		}
		private function onEditLayoutFun(e:MouseEvent):void
		{
			trace(JSON.stringify(dataManager.packData()));
			NetManager.instance.call('compile','',JSON.stringify(dataManager.packData()),pushCallback);
		}
		private function pushCallback(err:String,data:ByteArray):void
		{
			if(err){
				trace(err);
				return;
			}
			trace(data.toString());
		}
	}
}