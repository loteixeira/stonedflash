//
// async library
// Copyright (C) 2013 Lucas Teixeira (Disturbed Coder)
// Project page: https://github.com/loteixeira/async
//
// This software is distribuited under the terms of the Do What the Fuck You Want to Public License
// http://www.wtfpl.net/txt/copying/
//
package async
{
	import flash.events.*;

	public interface IAsyncTask extends IEventDispatcher
	{
		function get priority():String;
		function set priority(value:String):void;
		function get running():Boolean;

		function start():void;
		function run():Boolean;
		function exit():void;
	}
}