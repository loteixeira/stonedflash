package async
{
	import flash.events.*;

	public interface IAsyncTask extends IEventDispatcher
	{
		function get running():Boolean;

		function start():void;
		function run():Boolean;
		function exit():void;
	}
}