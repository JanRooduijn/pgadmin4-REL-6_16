/**
 * @name Source
 * @kind problem
 * @problem.severity warning
 * @id source
 */

import python
import semmle.python.ApiGraphs

class SubprocessAttribute extends Attribute {
    SubprocessAttribute() {
       this.getObject().toString() = "subprocess"
    }
 }

from Call c where
exists (SubprocessAttribute a | c.getFunc() = a)
select c, "subprocess call"

// select API::moduleImport("subprocess").getAMember().getACall(), "subprocess call"