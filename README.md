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

## AsyncThread
A AsyncThread uses three callbacks:
* enterCallback: called when the task starts
* runCallback: called at each iteraction - the task will run until this method returns false
* exitCallback: called when the task ends

Example:
```actionscript
function runJob(tasks:Array):void
{
	var job:AsyncJob = new AsyncJob(tasks);
	job.addEventListener(Event.COMPLETE, jobComplete);
	job.go();
}
```

## AsyncFor
A AsyncFor uses three callbacks:
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
				cpln("Prime found! " + p.i + " (" + p.primeCount + ")");

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
			cpln("#######");
			cpln("Tring to find the " + p.targetPrime + "th prime number");
		},

		// exit
		function (p:Object):void
		{
			cpln("The " + p.targetPrime + "th prime number is " + p.value);
		},

		// param
		{i: 1, primeCount: 0, targetPrime: 10, value: -1}
	);

	var job:AsyncJob = new AsyncJob(primeTask);
	job.go();
```