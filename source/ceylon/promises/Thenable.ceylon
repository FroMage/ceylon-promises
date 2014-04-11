"Thenable provides the base support for promises. This interface satisfies the
 [[Promised]] interface, to be used when a promise is needed instead of a thenable"
by("Julien Viet")
shared interface Thenable<out Value>
        satisfies Promised<Value>
            given Value satisfies Anything[] {

    M rethrow<M>(Throwable e) {
        throw e;
    }

    "The then method from the Promise/A+ specification."
    shared Promise<Result> then_<Result>(
            <Callable<Result, Value>> onFulfilled,
            <Result(Throwable)> onRejected = rethrow<Result>) {

        <Callable<Promise<Result>, Value>> onFulfilled2 = adaptResult<Result, Value>(onFulfilled);
        Promise<Result>(Throwable) onRejected2 = adaptResult<Result, [Throwable]>(onRejected);
        return then__(onFulfilled2, onRejected2);
    }

    Promise<M> rethrow2<M>(Throwable e) {
        Deferred<M> deferred = Deferred<M>();
        deferred.reject(e);
        return deferred.promise;
    }

    "The then method from the Promise/A+ specification."
    shared formal Promise<Result> then__<Result>(
            <Callable<Promise<Result>, Value>> onFulfilled,
            <Promise<Result>(Throwable)> onRejected = rethrow2<Result>);

    "Analog to Q finally (except that it does not consider the callback might return a promise"
    shared void always(Callable<Anything, Value|[Throwable]> callback) {
        then_(callback, callback);
    }

}
