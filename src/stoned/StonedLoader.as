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
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;

	public class StonedLoader extends StonedTask
	{
		private var sourceData:*;
		private var context:LoaderContext;
		private var loader:Loader;
		private var _running:Boolean;

		public function StonedLoader(sourceData:*, context:LoaderContext = null)
		{
			super(null);

			if (!(sourceData is String) && !(sourceData is URLRequest) && !(sourceData is ByteArray))
				throw new Error("sourceData must be an instance of String, URLRequest or ByteArray");

			this.sourceData = sourceData;
			this.context = context;

			loader = new Loader();
			_running = false;
		}

		override public function get running():Boolean
		{
			return _running;
		}

		public function getLoader():Loader
		{
			return loader;
		}

		override public function start():void
		{
			super.start();

			if (sourceData is ByteArray)
				loader.contentLoaderInfo.addEventListener(Event.INIT, loaderComplete);
			else
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);

			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderComplete);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderComplete);

			if (sourceData is ByteArray)
			{
				loader.loadBytes(sourceData as ByteArray, context);
			}
			else
			{
				var urlRequest:URLRequest = sourceData is URLRequest ? sourceData as URLRequest : new URLRequest(sourceData);
				loader.load(urlRequest, context);
			}

			_running = true;
		}

		private function loaderComplete(e:Event):void
		{
			if (sourceData is ByteArray)
				loader.contentLoaderInfo.removeEventListener(Event.INIT, loaderComplete);
			else
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderComplete);

			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loaderComplete);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderComplete);

			_running = false;
			exit();
		}
	}
}