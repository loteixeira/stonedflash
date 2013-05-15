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
	import flash.utils.*;

	public class StonedFor extends StonedLoop
	{
		private var incrementCallback:Function;

		public function StonedFor(param:Object = null, enterCallback:Function = null, conditionCallback:Function = null, loopCallback:Function = null, incrementCallback:Function = null, exitCallback:Function = null)
		{
			super(param, enterCallback, conditionCallback, loopCallback, exitCallback);
			this.incrementCallback = incrementCallback;
		}

		public function increment():void
		{
			if (incrementCallback != null)
				incrementCallback(param);
		}

		override internal function runInternal():void
		{
			if (condition())
			{
				run();
				increment();
				setupTimeout();
			}
			else
			{
				exit();
			}
		}
	}
}