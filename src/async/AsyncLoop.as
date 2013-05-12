package async
{
	import flash.events.*;

	/**
	 * @author lteixeira
	 */
	public class AsyncLoop extends EventDispatcher implements IAsyncTask
	{
		private var openEvent:Event;
		private var completeEvent:Event;

		public function AsyncLoop()
		{
			openEvent = new Event(Event.OPEN);
			completeEvent = new Event(Event.COMPLETE);
		}
		
		public function start():void
		{
			dispatchEvent(openEvent);
			Async.loop(condition, run, exit);
		}
		
		protected function condition():Boolean
		{
			return false;
		}
		
		protected function run():void
		{
		}
		
		private function exit():void
		{
			dispatchEvent(completeEvent);
		}
	}
}
