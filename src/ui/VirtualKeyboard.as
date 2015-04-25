package ui
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import components.FnKeyButton;
	import components.VirtualKeyButton;
	
	import model.ConfigManager;
	import model.DataManager;
	import model.FnComBoxItem;
	import model.Utils;
	
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JCheckBox;
	import org.aswing.JComboBox;
	import org.aswing.JLabel;
	import org.aswing.JLabelButton;
	
	public class VirtualKeyboard extends BaseJFrame
	{
		private var skin:VirtualKeyboardSkin;
		private var configArr:Array;
		private var kctoitem:Object={};
		private var itemtokc:Dictionary=new Dictionary();
		private var selectKeyData:Object;
		private var fnSelectCombox:JComboBox;
		private var fnStartX:Number;
		public function VirtualKeyboard(owner:*=null, title:String="", modal:Boolean=true)
		{
			super(owner, title, true);
			initControl();
			initKeyBtn();
			initFnControl();
		}
		private function initControl():void
		{
			this.setActivable(false);
			this.setResizable(false);
			this.setDragable(true);
			this.getContentPane().setLayout(new EmptyLayout());
			skin = new VirtualKeyboardSkin();
			this.getContentPane().addChild(skin);
			this.setAlpha(0.92);
			var defaultAsFont:ASFont=new ASFont("Tahoma", 15, true, false, false, false);
			fnSelectCombox=new JComboBox();
			fnSelectCombox.setListData(DataManager.instance.getSelectComBoxItemList());
			fnSelectCombox.setFont(defaultAsFont);
			fnSelectCombox.setWidth(128);
			fnSelectCombox.setHeight(28);
			fnSelectCombox.setLocationXY(60,266);
			fnSelectCombox.setSelectedIndex(0);
			fnSelectCombox.setMaximumRowCount(7);
			this.getContentPane().append(fnSelectCombox);
			fnSelectCombox.setVisible(false);
			fnSelectCombox.addSelectionListener(onFnSelectBoxFun);
			fnStartX=220;
		}

		private function initKeyBtn():void
		{
			configArr=ConfigManager.virtualKeyboardConfig;
			var vkb:VirtualKeyButton;
			for(var i:int=0;i<configArr.length;i++){
				vkb=new VirtualKeyButton(this.skin[configArr[i]+'_btn']);
				vkb.addEventListener('select',onSelectFun);
				vkb.keycode=configArr[i];
				kctoitem[configArr[i]]=vkb;
				itemtokc[vkb]=configArr[i];
			}
			vkb = new VirtualKeyButton(this.skin['KC_FN_btn']);
			vkb.addEventListener('select',onFnClickFun);
			kctoitem['KC_FN']=vkb;
			itemtokc[vkb]='KC_FN';
		}
		private function unSelect():void
		{
			var vkb:VirtualKeyButton ;
			for(var key:String in kctoitem){
				vkb = kctoitem[key] as VirtualKeyButton;
				vkb.select=false;
			}
		}
		public function select(_obj:Object):void
		{
			this.selectKeyData=_obj;
			unSelect();
			fnSelectCombox.setVisible(false);
			fnSelectCombox.setSelectedIndex(0);
			hideAll();
			var keyData:Object=this.selectKeyData.key;
			var vkb:VirtualKeyButton;
			if((!keyData.k || keyData.k=='' )){
				vkb = kctoitem['KC_TRNS'] as VirtualKeyButton;
				vkb.select=true;
			}else if(keyData.k=='KC_FN'){
				vkb = kctoitem['KC_FN'] as VirtualKeyButton;
				vkb.select=true;
				initFn(keyData.fnData);
			}else{
				vkb = kctoitem[keyData.k] as VirtualKeyButton;
				vkb.select=true;
			}
		}
		private function onSelectFun(e:Event):void
		{
			var vkb:VirtualKeyButton=e.currentTarget as VirtualKeyButton;
			this.selectKeyData.key.k=vkb.keycode;
			this.selectKeyData.callback();
			if(isFnmode){
				fnvkey.updateKey(vkb.keycode);
				isFnmode=false;
				lay.visible=false;
				fn_ok.setX(fnvkey.getSkin().x+fnvkey.getSkin().width+25);
				return;
			}
			
			this.closeReleased();
		}
		
		private function onFnClickFun(e:Event):void
		{
			if(fnSelectCombox.isVisible()){
				return;
			}	
			unSelect();
			var vkb:VirtualKeyButton = kctoitem['KC_FN'] as VirtualKeyButton;
			vkb.select=true;
			fnSelectCombox.setVisible(true);
			fnSelectCombox.setSelectedIndex(0);
			hideAll();
		}
		private function onFnSelectBoxFun(e:Event):void
		{
			var obj:Object=fnSelectCombox.getSelectedItem();
			selectFn(obj.fnData);
		}
		private function initFn(obj:Object):void
		{
			var ix:int=0;
			if(!obj){
				obj=Utils.clone(ConfigManager.fnTypeList[0]);
			}
			ix=DataManager.instance.getSelectIndexByAction(obj.action);
			fnSelectCombox.setVisible(true);
			fnSelectCombox.setSelectedIndex(ix);
			selectFn(obj);
		}
		private function selectFn(obj:Object):void
		{
			var action:String=obj.action;
			var args:Object=obj.args;
			var type:int=obj.type;
			this['fn_Type'+type](args);
		}
		//-----vkeyboard
		private var laylist:LayerList;
		private var ctrl_cbox:JCheckBox;
		private var shift_cbox:JCheckBox;
		private var alt_cbox:JCheckBox;
		private var gui_cbox:JCheckBox;
		private var addLabel:JLabel;
		private var keyButtonLabel:JLabelButton;
		private var fnvkey:FnKeyButton;
		private var add_icon:MovieClip;
		private var fn_ok:JButton;
		private var lay:MovieClip;
		private var isFnmode:Boolean=false;
		private function initFnControl():void
		{
			add_icon = this.skin.add_icon;
			add_icon.gotoAndStop(1);
			lay = this.skin.lay;

			laylist = new LayerList();
			laylist.init(DataManager.instance.getLayerCount());
			laylist.y=280;
			laylist.x=220;
			this.getContentPane().addChild(laylist);
			     
			ctrl_cbox = new JCheckBox('Ctrl');
			ctrl_cbox.setLocationXY(200,266);
			ctrl_cbox.setSizeWH(50,30);
			
			shift_cbox = new JCheckBox('Shift');
			shift_cbox.setLocationXY(250,266);
			shift_cbox.setSizeWH(50,30);
			
			alt_cbox = new JCheckBox('Alt');
			alt_cbox.setLocationXY(300,266);
			alt_cbox.setSizeWH(50,30);
			
			gui_cbox = new JCheckBox('Win');
			gui_cbox.setLocationXY(350,266);
			gui_cbox.setSizeWH(50,30);
			
			fnvkey = new FnKeyButton(this.skin.fnvkey);
			fnvkey.addEventListener('click',onfnSelectKeyFun);
			
			fn_ok = new JButton('确定');
			fn_ok.setFont(new ASFont("Tahoma", 14, true, false, false, false));
			fn_ok.setBackground(new ASColor(0x73CF3E, 1));
			fn_ok.setWidth(60);
			fn_ok.setHeight(28);
			fn_ok.setY(266);
			fn_ok.addEventListener(MouseEvent.CLICK,onFnOkFun);
			
			
			this.getContentPane().append(ctrl_cbox);
			this.getContentPane().append(shift_cbox);
			this.getContentPane().append(alt_cbox);
			this.getContentPane().append(gui_cbox);
			this.getContentPane().append(fn_ok);
			this.getContentPane().setChildIndex(this.skin,this.getContentPane().numChildren-1);
			hideAll();
		}
		private function hideAll():void
		{
			laylist.init(DataManager.instance.getLayerCount());
			lay.visible=false;
			laylist.visible=false;
			add_icon.visible=false;
			fnvkey.setVisible(false);
			ctrl_cbox.setVisible(false);
			shift_cbox.setVisible(false);
			alt_cbox.setVisible(false);
			gui_cbox.setVisible(false);
			fn_ok.setVisible(false);
		}
		private function onFnOkFun(e:MouseEvent):void
		{
			this.selectKeyData.key.k='KC_FN';
			
			var fncomitem:FnComBoxItem=fnSelectCombox.getSelectedItem();
			this.selectKeyData.key.fnData={};
			this.selectKeyData.key.fnData['action']=fncomitem.action;
			this.selectKeyData.key.fnData['type']=fncomitem.type;
			if(fncomitem.type==0){
				this.selectKeyData.key.fnData['args']=[];
			}else if(fncomitem.type==1){
				this.selectKeyData.key.fnData['args']=[];
				this.selectKeyData.key.fnData['args'][0]=laylist.selectIndex;
			}else if(fncomitem.type==2){
				this.selectKeyData.key.fnData['args']=[];
				this.selectKeyData.key.fnData['args'][0]=laylist.selectIndex;
				this.selectKeyData.key.fnData['args'][1]=1;
			}else if(fncomitem.type==3){
				this.selectKeyData.key.fnData['args']=[];
				this.selectKeyData.key.fnData['args'][0]=laylist.selectIndex;
				this.selectKeyData.key.fnData['args'][1]=fnvkey.key;
			}else if(fncomitem.type==4){
				this.selectKeyData.key.fnData['args']=[];
				this.selectKeyData.key.fnData['args'].push(int(ctrl_cbox.isSelected()));
				this.selectKeyData.key.fnData['args'].push(int(shift_cbox.isSelected()));
				this.selectKeyData.key.fnData['args'].push(int(alt_cbox.isSelected()));
				this.selectKeyData.key.fnData['args'].push(int(gui_cbox.isSelected()));
			}else if(fncomitem.type==5){
				this.selectKeyData.key.fnData['args']=[];
				this.selectKeyData.key.fnData['args'].push(int(ctrl_cbox.isSelected()));
				this.selectKeyData.key.fnData['args'].push(int(shift_cbox.isSelected()));
				this.selectKeyData.key.fnData['args'].push(int(alt_cbox.isSelected()));
				this.selectKeyData.key.fnData['args'].push(int(gui_cbox.isSelected()));
				this.selectKeyData.key.fnData['args'].push(fnvkey.key);
			}else if(fncomitem.type==6){
				this.selectKeyData.key.fnData['args']=[];
				this.selectKeyData.key.fnData['args'][0]=1;
			}

			this.selectKeyData.callback();
			this.closeReleased();
		}
		private function fn_Type0(args:Object):void
		{
			hideAll();
		}
		private function fn_Type1(args:Object):void
		{
			hideAll();
			laylist.visible=true;
			laylist.x=fnStartX;
			var ix:int=int(args[0]);
			laylist.select(ix);
			fn_ok.setVisible(true);
			fn_ok.setX(200+laylist.width+20);
		}
		private function fn_Type2(args:Object):void
		{
			hideAll();
			laylist.visible=true;
			laylist.x=fnStartX;
			var ix:int=int(args[0]);
			laylist.select(ix);
			fn_ok.setVisible(true);
			fn_ok.setX(200+laylist.width+20);
		}
		private function fn_Type3(args:Object):void
		{
			hideAll();
			laylist.visible=true;
			laylist.x=fnStartX;
			var ix:int=0;
			if(args && args[0]){
				ix=args[0];
			}
			laylist.select(ix);
			add_icon.visible=true;
			add_icon.gotoAndStop(2);
			add_icon.x=200+laylist.width+5;
			fnvkey.setVisible(true);
			fnvkey.getSkin().x=200+laylist.width+25;
			var skey:String='KC_NO';
			if(args && args[1]){
				skey=args[1];
			}
			fnvkey.updateKey(skey);
			fn_ok.setVisible(true);
			fn_ok.setX(fnvkey.getSkin().x+fnvkey.getSkin().width+25);
		}
		private function onfnSelectKeyFun(e:Event):void
		{
			if(isFnmode){
				isFnmode=false;
				lay.visible=false;
				return;
			}
			lay.visible=true;
			lay.cow.x=fnvkey.getSkin().x+(fnvkey.getSkin().width/2)-15;
			isFnmode =true;
		}
		private function fn_Type4(args:Object):void
		{
			hideAll();
			ctrl_cbox.setVisible(true);
			shift_cbox.setVisible(true);
			alt_cbox.setVisible(true);
			gui_cbox.setVisible(true);
			ctrl_cbox.setLocationXY(200,266);
			shift_cbox.setLocationXY(250,266);
			alt_cbox.setLocationXY(300,266);
			gui_cbox.setLocationXY(350,266);
			ctrl_cbox.setSelected(false);
			shift_cbox.setSelected(false);
			alt_cbox.setSelected(false);
			gui_cbox.setSelected(false);
			if(args && args.length==4){
				ctrl_cbox.setSelected(Boolean(args[0]));
				shift_cbox.setSelected(Boolean(args[1]));
				alt_cbox.setSelected(Boolean(args[2]));
				gui_cbox.setSelected(Boolean(args[3]));
			}
			fn_ok.setVisible(true);
			fn_ok.setX(420);
		}
		private function fn_Type5(args:Object):void
		{
			hideAll();
			ctrl_cbox.setVisible(true);
			shift_cbox.setVisible(true);
			alt_cbox.setVisible(true);
			gui_cbox.setVisible(true);
			ctrl_cbox.setLocationXY(200,266);
			shift_cbox.setLocationXY(250,266);
			alt_cbox.setLocationXY(300,266);
			gui_cbox.setLocationXY(350,266);
			ctrl_cbox.setSelected(false);
			shift_cbox.setSelected(false);
			alt_cbox.setSelected(false);
			gui_cbox.setSelected(false);
			if(args && args.length==4){
				ctrl_cbox.setSelected(Boolean(args[0]));
				shift_cbox.setSelected(Boolean(args[1]));
				alt_cbox.setSelected(Boolean(args[2]));
				gui_cbox.setSelected(Boolean(args[3]));
			}
			add_icon.visible=true;
			add_icon.gotoAndStop(1);
			add_icon.x=gui_cbox.getX()+gui_cbox.getWidth();
			fnvkey.setVisible(true);
			fnvkey.getSkin().x=gui_cbox.getX()+gui_cbox.getWidth()+25;
			var skey:String='KC_NO';
			if(args && args[1]){
				skey=args[1];
			}
			fnvkey.updateKey(skey);
			fn_ok.setVisible(true);
			fn_ok.setX(fnvkey.getSkin().x+fnvkey.getSkin().width+25);
		}
		private function fn_Type6(args:Object):void
		{
			hideAll();
			fn_ok.setVisible(true);
			fn_ok.setX(220);
		}
	}
}