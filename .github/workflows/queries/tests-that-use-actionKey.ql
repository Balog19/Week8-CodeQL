/**
 * @description Find tests that call a function called "pressActionKey"
 * @kind problem
 * @id javascript/tests-calling-pressActionKey
 * @problem.severity recommendation
 */
import javascript

// Predicate to identify if a function call is to "pressActionKey"
predicate isPressActionKeyCall(CallExpression call) {
  exists(Function f | f.getName() = "pressActionKey" and call.getCallee() = f)
}

// Predicate to identify if a function is a test
predicate isTest(Function f) {
  f.getName().matches("%test%") or
  f.getName().matches("test%") or
  exists(CallExpression call | call.getCallee().getName() = "describe" and call.getEnclosingFunction() = f)
}

// Main query to find tests calling "pressActionKey"
from Function test, CallExpression call
where isTest(test) and isPressActionKeyCall(call) and call.getEnclosingFunction() = test
select call, "This test calls the 'pressActionKey' function."
