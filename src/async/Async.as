package async
{
	import flash.utils.*;
	
	/**
	 * @author lteixeira
	 */
	public class Async
	{
		public static const VERSION:String = "0.1.0";

		public static function thread(threadCallback:Function, exitCallback:Function = null, param:Object = null):void
		{
			setTimeout(threadProcess, 0, threadCallback, param);
		}
		
		private static function threadProcess(threadCallback:Function, exitCallback:Function, param:Object):void
		{
			if (threadCallback(param))
				setTimeout(threadProcess, 0, threadCallback, param);
			else if (exitCallback != null)
				exitCallback(param);
		}
		
		public static function loop(conditionCallback:Function, loopCallback:Function, exitCallback:Function = null, param:Object = null):void
		{
			setTimeout(loopProcess, 0, conditionCallback, loopCallback, param);
		}
		
		private static function loopProcess(conditionCallback:Function, loopCallback:Function, exitCallback:Function, param:Object):void
		{
			if (conditionCallback(param))
			{
				loopCallback(param);
				setTimeout(loopProcess, 0, conditionCallback, loopCallback, param);
			}
			else if (exitCallback != null)
			{
				exitCallback(param);
			}
		}
	}
}
