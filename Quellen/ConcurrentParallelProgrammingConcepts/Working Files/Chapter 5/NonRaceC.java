/** To compile: javac RaceC.java
    To run:     java Main

    Flow of control for Threads referenced by t1 and t2 (for convenience,
    call the Threads referenced by t1 and t2 simply 't1' and 't2'):

    The 'main thread' is the thread that executes the method 'main', in
    this case in class Main (see below).

                 creates
    main thread----------->t1 and t2

                  starts
    main thread----------->t1 and t2

                 calls run()
    Java runtime------------->on started Threads t1 and t2

    At this point, three threads in the app are executing: main, t1, and t2.

    An instance of a Java Thread represents the sequence of instructions in the
    body of the encapsulated 'run' method (and any other instructions in methods
    that 'run' invokes).

    A thread that exits run() terminates, and cannot be restarted.
*/
public class NonRaceC {
    static int n;
    static Object lock = new Object(); 
    static void race() {
	n = 0;                               // initialize to zero before threads alter its value
	long limit = 100000L;     // Integer.MAX_VALUE * 2L; four billion and change
        Thread t1 = new Thread() {           // incrementing thread
                public void run() { 
                    for (long i = 0; i < limit; i++)
                        synchronized(lock) {n = n + 1;}; // increment limit times
                }
            };
	Thread t2 = new Thread() {           // decrementing thread
		public void run() {
		    for (long i = 0; i < limit; i++)
                        synchronized(lock) {n = n - 1;};// decrement limit times
                }
	    };
	t1.start();  // start t1's execution
	t2.start();  // start t2's execution
	try {
	    t1.join();  // wait here until t1 terminates
	    t2.join();  // wait here until t2 terminates
	} catch(Exception e) { }
	System.out.println("n's value is: " + n);
    }
}

class Main {
    public static void main(String[ ] args) {         //*** main thread executes method main
	final long startTime = System.currentTimeMillis();
        for (int i = 0; i < 8; i++) NonRaceC.race();
        final long stopTime = System.currentTimeMillis();
        final long latency = stopTime - startTime;
        System.out.println("latency is: " + latency);

    }
}
/** Output from a sample run:

    n's value is: -265936
    n's value is: -7317
    n's value is: 47128
    n's value is: -219153
    n's value is: 82805
    n's value is: -7944
    n's value is: 87322
    n's value is: -2
*/
