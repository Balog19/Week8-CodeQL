/**
 * @description Find all files with extension "ts" or "tsx" that do not have any comments
 * @kind problem
 * @id javascript/files-without-comments
 * @problem.severity recommendation
 */
import javascript

from FunctionDecl f
where f.getNumLines() > 10
select f
