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
	import flash.utils.*;

	/**
	 * @author lteixeira
	 */
	public class StonedThread extends StonedTask
	{
		private var threadCallback:Function;
		private var enterCallback:Function;
		private var exitCallback:Function;
		private var timeoutId:int;

		public function StonedThread(threadCallback:Function = null, enterCallback:Function = null, exitCallback:Function = null, param:Object = null)
		{
			super(param);

			this.threadCallback = threadCallback;
			this.enterCallback = enterCallback;
			this.exitCallback = exitCallback;

			timeoutId = -1;
			priority = StonedPriority.MEDIUM;
		}

		override public function get running():Boolean
		{
			return timeoutId > -1;
		}
		
		override public function start():void
		{
			super.start();
			setupTimeout();

			if (enterCallback != null)
				enterCallback(param);
		}
		
		override public function run():Boolean
		{
			if (threadCallback != null)
				return threadCallback(param);

			return false;
		}
		
		override public function exit():void
		{
			if (!running)
				return;

			clearTimeout(timeoutId);
			timeoutId = -1;

			if (exitCallback != null)
				exitCallback(param);

			super.exit();
		}

		internal function runInternal():void
		{
			if (run())
				setupTimeout();
			else
				exit();
		}

		internal function setupTimeout():void
		{
			timeoutId = setTimeout(runInternal, getMilisecondsFromPriority());		
		}

		private function getMilisecondsFromPriority():uint
		{
			if (priority == StonedPriority.HIGHEST)
				return 0;

			if (priority == StonedPriority.HIGH)
				return 10;

			if (priority == StonedPriority.MEDIUM)
				return 50;

			if (priority == StonedPriority.LOW)
				return 100;

			return 500;
		}
	}
}
