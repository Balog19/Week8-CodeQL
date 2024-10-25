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
    callee.getCalleeName() = "pressActionKey"
  )
}

predicate isTest(Function test) {
  exists(CallExpr describe, CallExpr it |
    describe.getCalleeName() = "describe" and
    it.getCalleeName() = "it" and
    it.getParent*() = describe and
    test = it.getArgument(1)
  )
}

// Main query to find tests calling "pressActionKey"
from Function test, CallExpr call
where isTest(test) and isPressActionKeyCall(call) and call.getEnclosingFunction() = test
select call, "This test calls the 'pressActionKey' function."
