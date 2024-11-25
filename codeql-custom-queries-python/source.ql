/**
 * @name Source
 * @kind problem
 * @problem.severity warning
 * @id source
 */

import python
import semmle.python.ApiGraphs


from Attribute a
where a.getObject().toString() = "request"
select a, "request." + a.getName()

// select "Access of an attribute of request", API::moduleImport("flask").getMember("request").getAMember()