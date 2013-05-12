package async
{
	import flash.events.*;
	import flash.utils.*;

	/**
	 * @author lteixeira
	 */
	public class AsyncThread extends AsyncTask
	{
		private var threadCallback:Function;
		private var exitCallback:Function;
		private var timeoutId:int;

		public function AsyncThread(threadCallback:Function = null, exitCallback:Function = null, param:Object = null)
		{
			super(param);

			this.threadCallback = threadCallback;
			this.exitCallback = exitCallback;

			timeoutId = -1;
		}

		override public function get running():Boolean
		{
			return timeoutId > -1;
		}
		
		override public function start():void
		{
			super.start();
			timeoutId = setTimeout(runInternal, 0);
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

		private function runInternal():void
		{
			if (run())
				timeoutId = setTimeout(runInternal, 0);
			else
				exit();
		}
	}
}
