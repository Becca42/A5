open Async.Std

(* It first prints "starting <name>" immediately when called.  After [t]
 * seconds, it should print "finished <name>" and return its name*)
let job name t =
  let _ = printf "starting %s\n" name in
  after (Core.Std.sec t) >>= fun () ->
  let _ = printf "finished %s\n" name in
  return name

(**[both d1 d2] becomes determined with value (a,b) after d1 becomes determined
 * with value a and d2 becomes determined with value b.*)
let both (d1:'a Deferred.t) (d2: 'b Deferred.t) : ('a * 'b) Deferred.t =
  d1 >>= fun a ->
  d2 >>= fun b ->
  return (a,b)

(**[fork d f g] runs [f] and [g] concurrently when d becomes determined.  The
 * results returned by [f] and [g] are ignored.*)
let fork (d:'a Deferred.t) (f1: 'a -> 'b Deferred.t) (f2:'a -> 'c Deferred.t):
  unit =



let parallel_map f l =
  failwith "TODO"

let sequential_map f l =
  failwith "TODO"

let any ds =
  failwith "TODO"


(* let _ = job "this" 5.0
let _ = job "that" 2.0
let _ = Scheduler.go () *)

