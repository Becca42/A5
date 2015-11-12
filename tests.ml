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

TEST "both 2" = test_async_eq (both (job "job1"  3.0) (job "job2"  2.0))
  ("job1", "job2")

(*TEST "fork has unit tests" = failwith "TODO"

TEST "parallel_map has unit tests" = failwith "TODO"

TEST "sequential_map has unit tests" = failwith "TODO"

TEST "any has unit tests" = failwith "TODO"

(******************************************************************************)
(** Unit tests for AQueue *****************************************************)
(******************************************************************************)

(** Note: you do not have to write tests for create *)

TEST "push has unit tests" = failwith "TODO"

TEST "pop has unit tests" = failwith "TODO"

TEST "is_empty has unit tests" = failwith "TODO"*)


