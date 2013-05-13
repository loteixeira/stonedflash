# async version 0.1.0
Async is a set of tools to perform asynchronous tasks in Actionscript3 without too much pain.

**Download the latest tag:** link

---

### basic
Every async task must implements the interface IAsyncTask. Also, it needs to throw two events:
* Event.OPEN at start
* Event.COMPLETE at end

The interface IAsyncTask defines the following methods:
* start: run the task (throws Event.OPEN)
* run: iteration callback - the task runs until this method returns true
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