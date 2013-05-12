package async
{
	import flash.events.*;
	import flash.utils.*;

	/**
	 * @author lteixeira
	 */
	public class AsyncThread extends AsyncTask
	{
		public var priority:String;

		private var threadCallback:Function;
		private var exitCallback:Function;
		private var timeoutId:int;

		public function AsyncThread(threadCallback:Function = null, exitCallback:Function = null, param:Object = null)
		{
			super(param);

			this.threadCallback = threadCallback;
			this.exitCallback = exitCallback;

			timeoutId = -1;
			priority = AsyncPriority.MEDIUM;
		}

		override public function get running():Boolean
		{
			return timeoutId > -1;
		}
		
		override public function start():void
		{
			super.start();
			setupTimeout();
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
			if (priority == AsyncPriority.HIGHEST)
				return 0;

			if (priority == AsyncPriority.HIGH)
				return 10;

			if (priority == AsyncPriority.MEDIUM)
				return 50;

			if (priority == AsyncPriority.LOW)
				return 100;

			return 500;
		}
	}
}
