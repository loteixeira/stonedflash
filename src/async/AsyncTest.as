package async
{
	import br.dcoder.console.*;

	import flash.display.*;

	[SWF(width="800", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class AsyncTest extends Sprite
	{
		public function AsyncTest()
		{
			Console.create(this);
			cpln("aaaa");
		}
	}
}