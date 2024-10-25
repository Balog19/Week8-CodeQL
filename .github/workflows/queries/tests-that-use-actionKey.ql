/**
 * @description Find tests that call a function called "pressActionKey"
 * @kind problem
 * @id javascript/tests-calling-pressActionKey
 * @problem.severity recommendation
 */
import javascript

// Predicate to identify if an expression is a call to "pressActionKey"
predicate isPressActionKeyCall(CallExpr call) {
  exists(Expr callee |
    callee = call.getCallee() and
    callee instanceof Identifier and
    callee.getName() = "pressActionKey"
  )
}

// Predicate to identify if a function is a test
predicate isTest(Function f) {
  f.getName().matches("%test%") or
  f.getName().matches("test%") or
  exists(CallExpr call |
    call.getCallee() instanceof Identifier and
    call.getCallee().getName() = "describe" and
    call.getEnclosingFunction() = f
  )
}

// Main query to find tests calling "pressActionKey"
from Function test, CallExpr call
where isTest(test) and isPressActionKeyCall(call) and call.getEnclosingFunction() = test
select call, "This test calls the 'pressActionKey' function."
