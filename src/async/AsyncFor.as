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
	import flash.utils.*;

	public class AsyncFor extends AsyncLoop
	{
		private var incrementCallback:Function;

		public function AsyncFor(loopCallback:Function = null, conditionCallback:Function = null, incrementCallback:Function = null, enterCallback:Function = null, exitCallback:Function = null, param:Object = null)
		{
			super(loopCallback, conditionCallback, enterCallback, exitCallback, param);
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