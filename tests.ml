(******************************************************************************)
(** Unit tests for Exercises **************************************************)
(******************************************************************************)
open Async.Std
open Exercises

(*Taken from Lab 18*)
let test_async_eq (d : 'a Deferred.t) (v : 'a) : bool =
  Thread_safe.block_on_async (fun () -> d) = Core.Std.Result.Ok v

let sec = Core.Std.sec

(** Note: you do not need to write unit tests for job. *)

TEST "both 1" = test_async_eq (both (return 1) (return 2)) (1, 2)

TEST "both 2" = test_async_eq (both (job "job1"  2.0) (job "job2"  1.0))
  ("job1", "job2")

TEST "fork returns unit" = fork (return 1) return return = ()

let num = ref 2
let for_test = fork (return (num := 3)) return return
TEST "fork using side effects" = !num = 3

let num = ref 2
let for_test = fork (return num) (fun n -> return (n := !n + 1)) return
let _ = return num
TEST "fork using side effects 2" = !num = 3



(*TEST "parallel_map has unit tests" = failwith "TODO"

TEST "sequential_map has unit tests" = failwith "TODO"

TEST "any has unit tests" = failwith "TODO"

(******************************************************************************)
(** Unit tests for AQueue *****************************************************)
(******************************************************************************)

(** Note: you do not have to write tests for create *)

TEST "push has unit tests" = failwith "TODO"

TEST "pop has unit tests" = failwith "TODO"

TEST "is_empty has unit tests" = failwith "TODO"*)


