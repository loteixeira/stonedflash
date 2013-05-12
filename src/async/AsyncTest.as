package async
{
	import br.dcoder.console.*;

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	[SWF(width="800", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class AsyncTest extends Sprite
	{
		public function AsyncTest()
		{
			Console.create(this);
			Console.instance.draggable = false;
			Console.instance.resizable = false;
			cpln("async library version " + asyncVersion());
			cpln("starting test...");
			cpln("");

			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function addedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			stage.addEventListener(Event.RESIZE, resize);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			resize(null);
			start();
		}

		private function resize(e:Event):void
		{
			Console.instance.area = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight)
		}

		private function start():void
		{
			var param:Object = {i: 0};
			var thread:AsyncFor = new AsyncFor(run, condition, increment, enter, null, param);

			var job:AsyncJob = new AsyncJob(thread, [thread, thread, [thread]]);
			job.go();
		}

		private function condition(param:Object):Boolean
		{
			return param.i < 10;
		}

		private function increment(param:Object):void
		{
			param.i++;
		}

		private function run(param:Object):Boolean
		{
			cpln(param.i);
			return true;
		}

		private function enter(param:Object):void
		{
			cpln("##########");
			param.i = 0;
		}

		private function exit(param:Object):void
		{
		}
	}
}