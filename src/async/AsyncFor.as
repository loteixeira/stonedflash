package async
{
	import flash.utils.*;

	public class AsyncFor extends AsyncLoop
	{
		private var incrementCallback:Function;

		public function AsyncFor(loopCallback:Function = null, conditionCallback:Function = null, incrementCallback:Function = null, exitCallback:Function = null, param:Object = null)
		{
			super(loopCallback, conditionCallback, exitCallback, param);
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
				timeoutId = setTimeout(runInternal, 0);
			}
			else
			{
				exit();
			}
		}
	}
}