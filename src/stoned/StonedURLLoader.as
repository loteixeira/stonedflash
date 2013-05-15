//
// stonedflash library
// Copyright (C) 2013 Lucas Teixeira (Disturbed Coder)
// Project page: https://github.com/loteixeira/stonedflash
//
// This software is distribuited under the terms of the WTFPL
// http://www.wtfpl.net/txt/copying/
//
package stoned
{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public class StonedURLLoader extends StonedTask
	{
		private var sourceData:*;
		private var urlLoader:URLLoader;
		private var _running:Boolean;

		public function StonedURLLoader(sourceData:*, dataFormat:String = "text")
		{
			super(null);

			if (!(sourceData is String) && !(sourceData is URLRequest))
				throw new Error("sourceData must be an instance of String or URLRequest");

			this.sourceData = sourceData;

			urlLoader = new URLLoader();
			urlLoader.dataFormat = dataFormat;
			_running = false;
		}

		override public function get running():Boolean
		{
			return _running;
		}

		public function getURLLoader():URLLoader
		{
			return urlLoader;
		}

		override public function start():void
		{
			super.start();

			urlLoader.addEventListener(Event.COMPLETE, loaderComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, loaderComplete);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderComplete);

			var urlRequest:URLRequest = sourceData is URLRequest ? sourceData as URLRequest : new URLRequest(sourceData.toString());
			urlLoader.load(urlRequest);

			_running = true;
		}

		private function loaderComplete(e:Event):void
		{
			urlLoader.removeEventListener(Event.COMPLETE, loaderComplete);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, loaderComplete);
			urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderComplete);

			_running = false;
			exit();
		}
	}
}