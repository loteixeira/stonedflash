package async
{
	import flash.utils.*;

	/**
	 * @author lteixeira
	 */
	public class AsyncLoop extends AsyncThread
	{
		private var conditionCallback:Function;

		public function AsyncLoop(loopCallback:Function = null, conditionCallback:Function = null, enterCallback:Function = null, exitCallback:Function = null, param:Object = null)
		{
			super(loopCallback, enterCallback, exitCallback, param);
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
