package async
{
	import flash.events.*;

	public class AsyncTask extends EventDispatcher implements IAsyncTask
	{
		private var _priority:String;
		private var openEvent:Event;
		private var completeEvent:Event;

		protected var param:Object;

		public function AsyncTask(param:Object = null)
		{
			this.param = param;

			_priority = AsyncPriority.MEDIUM;
			openEvent = new Event(Event.OPEN);
			completeEvent = new Event(Event.COMPLETE);
		}

		public function get priority():String
		{
			return _priority;
		}

		public function set priority(value:String):void
		{
			_priority = value;
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