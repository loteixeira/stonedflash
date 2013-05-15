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

	public interface IStonedTask extends IEventDispatcher
	{
		function get priority():String;
		function set priority(value:String):void;
		function get running():Boolean;

		function start():void;
		function run():Boolean;
		function exit():void;
	}
}