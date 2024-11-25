/**
 * @kind path-problem
 * @problem.severity error
 * @id taint-tracking-request-subprocess
 */

 import python
 import semmle.python.dataflow.new.DataFlow
 import semmle.python.dataflow.new.TaintTracking
 import semmle.python.ApiGraphs
 import semmle.python.dataflow.new.RemoteFlowSources
 import MyFlow::PathGraph


class RequestAttribute extends Attribute {
    RequestAttribute() {
       this.getObject().toString() = "request"
    }
 }

class SubprocessAttribute extends Attribute {
   SubprocessAttribute() {
      this.getObject().toString() = "subprocess"
   }
}

predicate isSubprocessCall(Call c) {
   exists (SubprocessAttribute sa | c.getFunc() = sa)
}


 class SubprocessCall extends Call {
    SubprocessCall() {
      isSubprocessCall(this)
    }
 }

 private module MyConfig implements DataFlow::ConfigSig {
   predicate isSource(DataFlow::Node source) {
     exists (RequestAttribute a | source.asExpr() = a)
   }

   predicate isSink(DataFlow::Node sink) {
     exists(SubprocessCall sc | sink.asExpr() = sc.getAnArg())
   }
 }

 module MyFlow = TaintTracking::Global<MyConfig>; 

 from MyFlow::PathNode source, MyFlow::PathNode sink
 where MyFlow::flowPath(source, sink)
 select sink.getNode(), source, sink, "subprocess sink called with untrusted data from request"