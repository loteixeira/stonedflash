//
// async library
// Copyright (C) 2013 Lucas Teixeira (Disturbed Coder)
// Project page: https://github.com/loteixeira/async
//
// This software is distribuited under the terms of the Do What the Fuck You Want to Public License
// http://www.wtfpl.net/txt/copying/
//
package async
{
	import flash.events.*;

	public class AsyncJob extends EventDispatcher
	{
		private var tasks:Array;
		private var current:int;

		public function AsyncJob(...args)
		{
			tasks = [];
			readFromArray(args);
			current = 0;
		}

		public function get taskCount():uint
		{
			return tasks.length;
		}

		public function get currentIndex():uint
		{
			return current;
		}

		public function get currentTask():IAsyncTask
		{
			return tasks[current];
		}

		public function overridePriority(priority:String):void
		{
			var l:uint = tasks.length;

			for (var i:uint; i < l; i++)
				tasks[i].priority = priority;
		}

		public function go():void
		{
			runNextTask();
		}

		public function cancel():void
		{
			if (currentIndex >= taskCount)
				return;

			var task:IAsyncTask = tasks[current];
			task.exit();
		}

		private function readFromArray(array:Array):void
		{
			var l:uint = array.length;

			for (var i:uint = 0; i < l; i++)
			{
				var data:* = array[i];

				if (data is IAsyncTask)
					tasks.push(data);
				else if (data is Array)
					readFromArray(data);
				else
					throw new TypeError("AsyncJob constructor expects only IAsyncJob and Array types");
			}
		}

		private function runNextTask():void
		{
			if (current >= tasks.length)
			{
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}

			var task:IAsyncTask = tasks[current];
			task.addEventListener(Event.OPEN, taskOpen);
			task.addEventListener(Event.COMPLETE, taskComplete);
			task.start();
		}

		private function taskOpen(e:Event):void
		{
			dispatchEvent(new Event(Event.OPEN));
		}

		private function taskComplete(e:Event):void
		{
			var task:IAsyncTask = tasks[current];
			task.removeEventListener(Event.OPEN, taskOpen);
			task.removeEventListener(Event.COMPLETE, taskComplete);
			dispatchEvent(new Event(Event.CLOSE));
			current++;
			runNextTask();
		}
	}
}