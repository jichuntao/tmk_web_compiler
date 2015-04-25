package model
{
	
	public class LangManager
	{
		public static var Lang:String = 'CN';
		private static var Lang_CN:Object = {
			'ACTION_NO':'空操作',
			'ACTION_LAYER_MOMENTARY':'瞬时开启层',
			'ACTION_LAYER_ON':'开启层',
			'ACTION_LAYER_OFF':'关闭层',	
			'ACTION_LAYER_TOGGLE':'开关层',	
			'ACTION_LAYER_TAP_KEY':'瞬时开启,按键',	
			'ACTION_MODS':'修饰键',	
			'ACTION_MODS_KEY':'组合键',	
			'ACTION_MODS_ONESHOT':'单击修饰键',	
			'ACTION_MODS_TAP_TOGGLE':'开关修饰键',	
			'ACTION_LAYER_CLEAR':'清除层状态'
				
		};
		public static function GetMessage(key:String):String
		{
			var ret:String=LangManager['Lang_'+Lang][key];
			if(!ret){
				ret=key;
			}
			return ret
		}
	}
}