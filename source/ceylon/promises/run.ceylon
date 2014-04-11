by("Julien Viet")
void run() {

  Deferred<String> d = Deferred<String>();
  d.promise.always((String|Throwable s) => print("done"));
  d.reject(Exception());
	
}
