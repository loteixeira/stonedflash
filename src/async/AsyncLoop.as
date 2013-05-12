package async
{
	import flash.utils.*;

	/**
	 * @author lteixeira
	 */
	public class AsyncLoop extends AsyncThread
	{
		private var conditionCallback:Function;
		private var enterCallback:Function;

		public function AsyncLoop(loopCallback:Function = null, conditionCallback:Function = null, enterCallback:Function = null, exitCallback:Function = null, param:Object = null)
		{
			super(loopCallback, exitCallback, param);
			this.conditionCallback = conditionCallback;
			this.enterCallback = enterCallback;
		}

		public function condition():Boolean
		{
			if (conditionCallback != null)
				return conditionCallback(param);

			return false;
		}

		override public function start():void
		{
			super.start();
			
			if (enterCallback != null)
				enterCallback(param);
		}

		override internal function runInternal():void
		{
			if (condition())
			{
				run();
				timeoutId = setTimeout(runInternal, 0);
			}
			else
			{
				exit();
			}
		}
	}
}
