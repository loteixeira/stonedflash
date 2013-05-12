package async
{
	import flash.events.*;

	/**
	 * @author lteixeira
	 */
	public class AsyncThread extends EventDispatcher implements IAsyncTask
	{
		private var openEvent:Event;
		private var completeEvent:Event;

		public function AsyncThread()
		{
			openEvent = new Event(Event.OPEN);
			completeEvent = new Event(Event.COMPLETE);
		}
		
		public function start():void
		{
			dispatchEvent(openEvent);
			Async.thread(run, exit);
		}
		
		protected function run():Boolean
		{
			return false;
		}
		
		private function exit():void
		{
			dispatchEvent(completeEvent);
		}
	}
}
