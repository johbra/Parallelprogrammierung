class HelloThread extends Thread {
  override def run() {
    println("Hello world!")
  }
}
val t = new HelloThread
t.start()
t.join()
