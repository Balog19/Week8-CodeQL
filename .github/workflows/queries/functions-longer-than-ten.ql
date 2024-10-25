/**
 * @description Find all functions over 10 lines
 * @kind problem
 * @id javascript/functions-longer-than-ten
 * @problem.severity recommendation
 */
import javascript

// Predicate to check if a function is over 10 lines
predicate isFunctionOverTenLines(Function f) {
  f.getNumLines() > 10
}

from Function f
where isFunctionOverTenLines(f)
select f, "This function is over 10 lines long."
