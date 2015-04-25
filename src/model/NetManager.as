package model
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class NetManager
	{
		private static var _instance:NetManager;
		
		private var dic:Dictionary=new Dictionary();
		public var serverUrl:String='http://127.0.0.1:9128/';
//		public var serverUrl:String='http://123.57.250.164:9128/';
		public function NetManager()
		{
		}
		public static function get instance():NetManager
		{
			if(!_instance){
				_instance=new NetManager();
			}
			return _instance;
		}
		public function call(handle:String,query:String='',data:Object=null,callback:Function=null):void
		{
			var urlLoader:URLLoader=new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE,onLoadOverFun);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onLoadErrFun);
			if(query=='')
			{
				query='';
			}else{
				query='?'+query;
			}
			var urlRequest:URLRequest=new URLRequest();
			urlRequest.method=URLRequestMethod.POST;
			urlRequest.url=serverUrl+handle+query;
			urlRequest.data=data;
			urlLoader.load(urlRequest);
			var obj:Object={};
			obj.handle=handle;
			obj.query=query;
			obj.callback=callback;
			dic[urlLoader]=obj;
		}
		
		public function download(filename:String,progress:Function=null,callback:Function=null):void
		{
			var urlLoader:URLLoader=new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE,onLoadOverFun);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onLoadErrFun);
			urlLoader.addEventListener(ProgressEvent.PROGRESS,onLoadProgressFun);
			urlLoader.load(new URLRequest(serverUrl+filename));
			var obj:Object={};
			obj.progress=progress;
			obj.callback=callback;
			dic[urlLoader]=obj;
		}
		
		private function onLoadProgressFun(e:ProgressEvent):void
		{
			var urlLoader:URLLoader=e.currentTarget as URLLoader;
			var obj:Object=dic[urlLoader];
			if(obj.progress){
				obj.progress(e.bytesLoaded,e.bytesTotal);
			}
		}
		private function onLoadOverFun(e:Event):void
		{
			var urlLoader:URLLoader=e.currentTarget as URLLoader;
			var ret:ByteArray=urlLoader.data as ByteArray;
			var obj:Object=dic[urlLoader];
			if(obj.callback){
				obj.callback(null,ret);
			}
			delete dic[urlLoader];
		}
		private function onLoadErrFun(e:IOErrorEvent):void
		{
			var urlLoader:URLLoader=e.currentTarget as URLLoader;
			var ret:ByteArray=urlLoader.data as ByteArray;
			var obj:Object=dic[urlLoader];
			if(obj.callback){
				obj.callback(e.toString(),null);
			}
			delete dic[urlLoader];
		}
	}
}