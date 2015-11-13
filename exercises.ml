open Async.Std

(* It first prints "starting <name>" immediately when called.  After [t]
 * seconds, it should print "finished <name>" and return its name*)
let job name t =
  let _ = printf "starting %s\n" name in
  after (Core.Std.sec t) >>= fun () ->
  let _ = printf "finished %s\n" name in
  return name

(**[both d1 d2] becomes determined with value (a,b) after d1 becomes determined
 * with value a and d2 becomes determined with value b.

 * taken from lecture 17 slides *)
let both (d1:'a Deferred.t) (d2: 'b Deferred.t) : ('a * 'b) Deferred.t =
  d1 >>= fun a ->
  d2 >>= fun b ->
  return (a,b)

(**[fork d f g] runs [f] and [g] concurrently when d becomes determined.  The
 * results returned by [f] and [g] are ignored.*)
let fork (d:'a Deferred.t) (f1: 'a -> 'b Deferred.t) (f2:'a -> 'c Deferred.t):
  unit =
  let _ = Deferred.bind d f1 in
  let _ = Deferred.bind d f2 in
  ()

let fork_test (d:'a Deferred.t) (f1: 'a -> 'b Deferred.t) (f2:'a -> 'c Deferred.t) =
  let _ = Deferred.bind d f1 in
  let _ = Deferred.bind d f2 in
  Deferred.peek d

(**[parallel_map f xs] is similar to [List.map f xs]: it should apply [f] to
 * every element of [xs], and return the list of results.
 *
 * It should call f on every element of xs immediately; it should not wait
 * until one call completes before starting the next.*)
let rec parallel_map (f:'a -> 'b Deferred.t) (l: 'a list) : 'b list Deferred.t =
  let mapped = List.map f l in
  (*returns an 'a list deferred.t from 'b deferred.t list xs*)
  let rec helper xs =
    match xs with
    | [] -> return []
    | hd :: tl  -> Deferred.bind hd ((fun x -> Deferred.bind (helper tl)
      (fun y -> return (x :: y ))))
  in
  helper mapped

(**[sequential_map f xs] is similar to [List.map f xs]: it should apply [f] to
 * every element of [xs], and return the list of results.
 *
 * It should wait for each call to f to return
 * before proceeding to the next call.*)
let sequential_map (f:'a -> 'b Deferred.t) (l:'a list) : 'b list Deferred.t =
  match l with
  | [] -> return []
  | hd :: tl -> Deferred.bind (f hd) (fun x ->
    Deferred.bind (parallel_map f tl) (fun y -> return (x :: y )))

(**[any xs] becomes determined with value [v] if any of the elements of xs
 * become determined with value [v].

 * fill taken from lecture 17 slides*)
let any (ds: 'a Deferred.t list) : 'a Deferred.t =
    let result = Ivar.create () in
    let fill = fun x ->
      if Ivar.is_empty result
      then Ivar.fill result x
      else ()
    in
    let do_upon e =
      upon e fill
    in
    let _ = List.map do_upon ds in
    Ivar.read result


(* let _ = job "this" 5.0
let _ = job "that" 2.0
let _ = Scheduler.go () *)

