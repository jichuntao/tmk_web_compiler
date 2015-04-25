package model
{
	import flash.utils.ByteArray;

	public class Utils
	{
		public static function clone(source:Object):Object{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(source);
			byteArray.position = 0;
			return byteArray.readObject();
		}
	}
}