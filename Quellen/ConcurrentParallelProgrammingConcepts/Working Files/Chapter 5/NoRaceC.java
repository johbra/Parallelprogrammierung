/** Java example **/
class Test {
    static int n; // a single, shared storage location          /** line 6 **/
    static Object lock = new Object(); // can't be null         /** line 7 **/
    void incrementN() {
	synchronized(lock) {                                    /** line 8 **/
	    n = n + 1; /* critical section code */              /** line 9 **/
	}                                                       /** line 10 **/
    }
}
