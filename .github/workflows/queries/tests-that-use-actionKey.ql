/**
 * @description Find tests that call a function called "pressActionKey"
 * @kind problem
 * @id javascript/tests-calling-pressActionKey
 * @problem.severity recommendation
 */
import javascript

// Predicate to identify if an expression is a call to "pressActionKey"
predicate isPressActionKeyCall(Invocation i) {
  i.getCallee().getName() = "pressActionKey"
}

// Predicate to identify if a function is a test
predicate isTest(Function f) {
  f.getName().matches("%test%") or
  f.getName().matches("test%") or
  exists(Invocation i |
    i.getCallee().getName() = "describe" and
    i.getEnclosingFunction() = f
  )
}

// Main query to find tests calling "pressActionKey"
from Function test, Invocation i
where isTest(test) and isPressActionKeyCall(i) and i.getEnclosingFunction() = test
select i, "This test calls the 'pressActionKey' function."
