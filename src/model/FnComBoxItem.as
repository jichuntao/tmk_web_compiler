package model
{
	

	public class FnComBoxItem
	{
		private var title:String;
		private var _type:int;
		private var _fnData:Object;
		public function FnComBoxItem(_fnData:Object)
		{
			this.title=LangManager.GetMessage(_fnData.action);
			this._fnData=_fnData;
		}
		public function toString():String
		{
			return title;
		}
		public function get action():String
		{
			return this._fnData.action;
		}
		public function get type():int
		{
			return this._fnData.type;
		}
		public function get args():Object
		{
			return this._fnData.args;
		}
		public function get fnData():Object
		{
			return _fnData;
		}
	}
}