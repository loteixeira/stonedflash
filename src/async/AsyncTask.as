package async
{
	import flash.events.*;

	public class AsyncTask extends EventDispatcher implements IAsyncTask
	{
		private var openEvent:Event;
		private var completeEvent:Event;

		protected var param:Object;

		public function AsyncTask(param:Object = null)
		{
			this.param = param;

			openEvent = new Event(Event.OPEN);
			completeEvent = new Event(Event.COMPLETE);
		}

		public function get running():Boolean
		{
			return false;
		}

		public function getParam():Object
		{
			return param;
		}

		public function setParam(param:Object):void
		{
			this.param = param;
		}

		public function start():void
		{
			dispatchEvent(openEvent);
		}

		public function run():Boolean
		{
			return false;
		}

		public function exit():void
		{
			dispatchEvent(completeEvent);
		}
	}
}