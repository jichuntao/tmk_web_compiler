package model
{
	
	
	public class DataManager
	{
		private static var _instance:DataManager;
		private var data:Object;
		private var config:Object;
		private var result:Object;
		public var keyboardType:String='epbt60';
		public var tmkVersion:String='1.2';
		public function DataManager()
		{
			
		}
		public static function get instance():DataManager
		{
			if(!_instance){
				_instance=new DataManager();
			}
			return _instance;
		}
		public function getData2():Object
		{
			return this.data;
		}
		public function ontest1():void
		{
			this.config=Testconfig.getTestConfig();
			this.data=Testconfig.getDefaultData();
			handleData();
		}
		public function ontest2():void
		{
			this.config=Testconfig.getTestConfig();
			this.data=Testconfig.getDefaultData();
			handleData();
		}
		public function getSelectComBoxItemList():Array
		{
			var ret:Array=[];
			var comArr:Array=ConfigManager.fnTypeList;
			for(var i:int=0;i<comArr.length;i++){
				ret.push(new FnComBoxItem(comArr[i]));
			}
			return ret;
		}
		public function getSelectIndexByAction(action:String):int
		{
			var ret:int=0;
			var comArr:Array=ConfigManager.fnTypeList;
			for(var i:int=0;i<comArr.length;i++){
				if(action==comArr[i].action){
					ret=i;
					break;
				}
			}
			return ret;
		}
		public function getData():Object
		{
			return result;
		}
		private function handleData():void
		{
			result={};
			var i:int=0;
			var j:int=0;
			var k:int=0;
			var matrix:Array=[];
			var layout:Array=data.layout;
			var config_matrix:Array=config.matrix;
			for(i=0;i<config_matrix.length;i++){
				var row:Array=config_matrix[i];
				matrix[i]=[];
				for(j=0;j<row.length;j++){
					var keycfg:Object=row[j];
					if(keycfg.m==0){
						matrix[i].push(keycfg);
					}else{
						var sps:Array=keycfg.s[layout[keycfg.m-1]];
						for(k=0;k<sps.length;k++){
							sps[k].m=keycfg.m;
							matrix[i].push(sps[k]);
						}
					}
				}
			}
			var tmp_layers:Array=[];
			for(i=0;i<data.layers.length;i++){
				var keymap:Array=data.layers[i];
				tmp_layers[i]=[];
				for(j=0;j<matrix.length;j++){
					tmp_layers[i][j]=[];
					for(k=0;k<matrix[j].length;k++){
						if(keymap[j] && keymap[j][k]){
							tmp_layers[i][j][k]=keymap[j][k];
						}else{
							tmp_layers[i][j][k]={'k':'KC_TRNS'};
						}
					}
				}
			}
			data.layers=tmp_layers;
			result.matrix=matrix;
			result.layers=data.layers;
		}
		public function getLayerCount():int
		{
			return data.layers.length;
		}
		public function addLayer():int
		{
			var ix:int=data.layers.push([])-1;
			handleData();
			return ix;
		}
		public function delLayer(ix:int):int
		{
			if(ix>=data.layers.length){
				return 0;
			}
			data.layers.splice(ix,1);
			if(ix>data.layers.length-1){
				ix=data.layers.length-1;
			}
			handleData();
			return ix;
		}
		public function packData():Object
		{
			var tempData:Object=Utils.clone(this.data);
			var obj:Array=[];
			obj[0]=tempData.layout;
			obj[1]=tempData.layers;
			obj[2]=keyboardType;
			obj[3]=tmkVersion;
			for(var i:int=0;i<tempData.layers.length;i++){
				for(var j:int=0;j<tempData.layers[i].length;j++){
					for(var k:int=0;k<tempData.layers[i][j].length;k++){
						var arr:Array=[];
						arr.push(tempData.layers[i][j][k].k);
						if(tempData.layers[i][j][k].k=='KC_FN'){
							if(!tempData.layers[i][j][k].fnData){
								tempData.layers[i][j][k].fnData=Utils.clone(ConfigManager.fnTypeList[0]);
							}
							var fnArr:Array=[];
							fnArr.push(getSelectIndexByAction(tempData.layers[i][j][k].fnData.action));
							fnArr.push(tempData.layers[i][j][k].fnData.args);
							arr.push(fnArr);
						}
						tempData.layers[i][j][k]=arr;
					}
				}
			}
			return obj;
		}
	}
}