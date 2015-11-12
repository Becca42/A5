open Async.Std

type 'a t  = 'a list ref

(** Create a new queue. *)
let create () =
  ref []

(** Add an element to the queue. *)
let push (q: 'a t) (x: 'a) : unit =
  q := List.append (!q) [x]

(** Wait until an element becomes available, and then remove and return it. *)
let pop  q =
  failwith "TODO"

(** Return true if the queue is empty *)
let is_empty (q: 'a t) : bool =
  match !q with
  | [] -> true
  | _ -> false

