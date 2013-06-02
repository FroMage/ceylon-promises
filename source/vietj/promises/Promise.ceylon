/*
 * Copyright 2013 Julien Viet
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
doc "A promise represents a value that may not be available yet. The primary method for
      interacting with a promise is its `then` method. A promise is a [[Thenable]] element
     restricted to a single value."
by "Julien Viet"
license "ASL2"
shared interface Promise<Value> satisfies Term<Value, [Value]> {

  doc "Combine the current promise with a provided promise and return an [[And]] object that
        provides a promise that:
        - resolves when both the current and the other promise are resolved
        - rejects when the current or the other promise is rejected
        
        The [[And] promise will be
        - resolved with a tuple of values of the original promises. It is important to notice that
          tuple elements are in reverse order of the and chain
        - rejected with the reason of the rejected promise
        
        The returned [[And]] object allows for promise chaining as a fluent API:
            Promise<String> p1 = ...
            Promise<Integer> p2 = ...
            Promise<Boolean> p3 = ...
            p1.and(p2, p3).then_(([Boolean, Integer, String] args) => print(args));
        "
  shared actual Term<Value|Other, Tuple<Value|Other, Other, [Value]>> and<Other>(Promise<Other> other) {
    Promise<[]> p = bilto.deferred.promise;
    return Conjonction(this, p).and(other);
  }
}

object bilto {
  shared Deferred<[]> deferred = Deferred<[]>().resolve([]);
}

