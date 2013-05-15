//
// async library
// Copyright (C) 2013 Lucas Teixeira (Disturbed Coder)
// Project page: https://github.com/loteixeira/async
//
// This software is distribuited under the terms of the Do What the Fuck You Want to Public License
// http://www.wtfpl.net/txt/copying/
//
package stoned
{
	import flash.events.*;

	public class StonedTask extends EventDispatcher implements IStonedTask
	{
		private var _priority:String;
		private var openEvent:Event;
		private var completeEvent:Event;

		protected var param:Object;

		public function StonedTask(param:Object = null)
		{
			this.param = param;

			_priority = StonedPriority.MEDIUM;
			openEvent = new Event(Event.OPEN);
			completeEvent = new Event(Event.COMPLETE);
		}

		public function get priority():String
		{
			return _priority;
		}

		public function set priority(value:String):void
		{
			_priority = value;
		}

		public function get running():Boolean
		{
			return false;
		}

		public function getParam():Object
		{
			return param;
		}

		public function setParam(param:Object):void
		{
			this.param = param;
		}

		public function start():void
		{
			dispatchEvent(openEvent);
		}

		public function run():Boolean
		{
			return false;
		}

		public function exit():void
		{
			dispatchEvent(completeEvent);
		}
	}
}