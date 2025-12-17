open Cmdliner

let build_cmd =
  let info = Cmd.info "build" ~doc:"Build the current project" in
  Cmd.make info @@ Term.const ()

and dev_intf_cmd =
  let info =
    Cmd.info "dev-intf" ~doc:"Internal command for the tool's developers"
  in
  Cmd.make info @@ Term.const ()

let run _ = ()

let cmd =
  let info = Cmd.info "steppe" ~doc:" A tidy build system for C/C++ projects" in
  Cmd.group info [ build_cmd; dev_intf_cmd ]
