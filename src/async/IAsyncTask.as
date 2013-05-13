package async
{
	import flash.events.*;

	public interface IAsyncTask extends IEventDispatcher
	{
		function get priority():String;
		function set priority(value:String):void;
		function get running():Boolean;

		function start():void;
		function run():Boolean;
		function exit():void;
	}
}