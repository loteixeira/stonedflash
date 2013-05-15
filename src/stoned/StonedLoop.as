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

	/**
	 * @author lteixeira
	 */
	public class StonedLoop extends StonedThread
	{
		private var conditionCallback:Function;

		public function StonedLoop(param:Object = null, enterCallback:Function = null, conditionCallback:Function = null, loopCallback:Function = null, exitCallback:Function = null)
		{
			super(param, enterCallback, loopCallback, exitCallback);
			this.conditionCallback = conditionCallback;
		}

		public function condition():Boolean
		{
			if (conditionCallback != null)
				return conditionCallback(param);

			return false;
		}

		override internal function runInternal():void
		{
			if (condition())
			{
				run();
				setupTimeout();
			}
			else
			{
				exit();
			}
		}
	}
}
