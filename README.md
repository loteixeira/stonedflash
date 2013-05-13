# async version 0.1.0
Async is a set of tools to perform asynchronous tasks in Actionscript3 without too much pain.

**Download the latest tag:** link

# basic
Every async task must implements the interface IAsyncTask. Also, it needs to throw two events:
* Event.OPEN at start
* Event.COMPLETE at end

The interface IAsyncTask defines the following methods:
* start: run the task (throws Event.OPEN)
* run: iteration callback - the task runs until this method returns false
* exit: end of the task (throws Event.COMPLETE)

The class responsible to run a pack of tasks at once is AsyncJob. This class receives a list of tasks in contruction and throws Event.COMPLETE when the operation is complete.<br>
Example:
```actionscript
function runJob(tasks:Array):void
{
	var job:AsyncJob = new AsyncJob(tasks);
	job.addEventListener(Event.COMPLETE, jobComplete);
	job.go();
}
```

# concrete tasks
You may use the builtin concrete tasks available with the library. These classes simulates async operations such as threads, loops, etc.
All concrete tasks are based in callbacks, you can set free-functions as callbacks, without the need of extending the concrete task class.
However, it's possible also to extend a concrete task class and override the start, run and exit methods (without need of free-function callbacks).
Thus, you get two options: create a concrete task with free-function callbacks or extends a concrete task and reimplement the methods.

## AsyncThread
A AsyncThread uses three callbacks:
* enterCallback: called when the task starts
* runCallback: called at each iteraction - the task will run until this method returns false
* exitCallback: called when the task ends

Example - calculate the average value:
```actionscript
var averageTask:AsyncThread = new AsyncThread(
	// run
	function(p:Object):Boolean
	{
		for (var i:uint = 0; i < p.count; i++)
			p.result += p.values[i];

		p.result /= p.count;

		return false;
	},

	// enter
	function (p:Object):void
	{
		trace("#######");
		trace("Calculate the average value");

		for (var i:uint = 0; i < p.count; i++)
			p.values.push(Math.random());
	},

	// exit
	function (p:Object):void
	{
		trace("The average value is " + p.result);
	},

	// param
	{values: [], count: 10, result: 0}
);

var job:AsyncJob = new AsyncJob(averageTask);
job.go();
```

## AsyncLoop
A AsyncLoop uses four callbacks:
* conditionCallback: called before runCallback - the task keeps running until this method returns false
* enterCallback: called when the task starts
* runCallback: called at each iteraction - the return value of this function isn't used (now the conditionCallback tells whether the task should keep running)
* exitCallback: called when the task ends

Example - shows a list of numbers as hex values:
```actionscript
var hexTask:AsyncLoop = new AsyncLoop(
	// run
	function(p:Object):Boolean
	{
		var value:uint = p.values.pop();
		trace(value.toString(16));
	},

	// condition
	function (p:Object):Boolean
	{
		return p.values.length > 0
	},

	// enter
	function (p:Object):void
	{
		trace("#######");
		trace("Converting to hex");

		var l:uint = 20;

		for (var i:uint = 0; i < l; i++)
			p.values.push(Math.round(Math.random() * 0xffffff));
	},

	// exit
	function (p:Object):void
	{
		trace("Done!");
	},

	// param
	{values: []}
);

var job:AsyncJob = new AsyncJob(hexTask);
job.go();
```

## AsyncFor
A AsyncFor uses five callbacks:
* conditionCallback: called before runCallback - the task keeps running until this method returns false
* incrementCallback: called after runCallback - it should be used to increment (or decrement) the counter variable
* enterCallback: called when the task starts
* runCallback: called at each iteraction - the return value of this function isn't used (now the conditionCallback tells whether the task should keep running)
* exitCallback: called when the task ends

Example - find the 10th prime number:
```actionscript
var primeTask:AsyncFor = new AsyncFor(
	// run
	function(p:Object):Boolean
	{
		var isPrime:Boolean = true;

		for (var i:uint = 2; i < p.i; i++)
		{
			if (p.i % i == 0)
			{
				isPrime = false;
				break;
			}
		}

		if (isPrime)
		{
			p.primeCount++;
			trace("Prime found! " + p.i + " (" + p.primeCount + ")");

			if (p.primeCount == p.targetPrime)
				p.value = p.i;
		}

		return true;
	},

	// condition
	function (p:Object):Boolean
	{
		return p.primeCount < p.targetPrime;
	},

	// increment
	function (p:Object):void
	{
		p.i++;
	},

	// enter
	function (p:Object):void
	{
		trace("#######");
		trace("Tring to find the " + p.targetPrime + "th prime number");
	},

	// exit
	function (p:Object):void
	{
		trace("The " + p.targetPrime + "th prime number is " + p.value);
	},

	// param
	{i: 1, primeCount: 0, targetPrime: 10, value: -1}
);

var job:AsyncJob = new AsyncJob(primeTask);
job.go();
```