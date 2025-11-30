type t = {
  targets : target list;
  deps : dependency list;
  action : Build_context.t -> unit;
}

and target = [ `File of string ]
and dependency = target
