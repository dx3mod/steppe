type t = { context : Build_context.t; rules : Rule.t list }

let make context = { context; rules = [] }
let add_rule rule t = { t with rules = rule :: t.rules }

let create_build_dir build_dir =
  if not @@ Sys.file_exists build_dir then Sys.mkdir build_dir 0o755

(** [is_was_modified dependency target] *)
let is_was_modified (`File dep) (`File target) =
  try
    let target_stat = Unix.stat target and dep_stat = Unix.stat dep in
    target_stat.st_ctime < dep_stat.st_ctime
  with _ -> true

let run { context; rules } =
  create_build_dir context.project_build_dir;

  let get_modified_time filename =
    if Sys.file_exists filename then (Unix.stat filename).st_mtime else 0.
  in

  let run_rule rule =
    let deps_was_modified =
      let last_targets_modified_time =
        List.fold_left
          (fun acc (`File target) ->
            get_modified_time Filename.(concat context.project_build_dir target)
            |> max acc)
          0. rule.Rule.targets
      and last_deps_modified_time =
        List.fold_left
          (fun acc (`File dep) -> get_modified_time dep |> max acc)
          0. rule.Rule.deps
      in

      last_targets_modified_time < last_deps_modified_time
    in

    if deps_was_modified then rule.Rule.action context
  in

  List.iter run_rule rules
