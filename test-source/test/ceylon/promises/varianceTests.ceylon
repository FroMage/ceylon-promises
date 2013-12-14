import ceylon.promises { ... }
import ceylon.test { ... }

class Foo() {}
class Bar() extends Foo() {}
class Juu() extends Bar() {}

test void testConjunction() {
    Deferred<Bar> d1 = Deferred<Bar>();
    Deferred<Bar> d2 = Deferred<Bar>();
    Promise<Bar> p1 = d1.promise;
    Promise<Bar> p2 = d2.promise;
    
    // The tuple is able to contain parent classes
    p1.and(p2).then_((Foo b1, Bar b2) => print("OK"));
    
    //
    d1.resolve(Juu());
    d2.resolve(Bar());
}

test void testInheritance() {
    
    Deferred<Bar> barDeferred = Deferred<Bar>();
    
    // Can fulfull with a parent class
    Promised<Foo> juuPromised = barDeferred;
    juuPromised.promise.then_((Foo foo) => print("got foo"));
    
    // Resolve with a sub class
    Transitionnable<Juu> juuTransitionnable = barDeferred;
    juuTransitionnable.resolve(Juu());
}