open Steppe

let ( // ) = Filename.concat

let rule_build_hello =
  let action build_context =
    print_endline "[DEBUG] start rule_build_HELLO action";

    Toolchain.capture_from_system ()
    |> Toolchain.compile
         ~cwd:
           (Spawn.Working_dir.Path build_context.Build_context.project_root_dir)
         ~c:[ "-c" ]
         ~source_files:[ build_context.project_root_dir // "hello.c" ]
         ~output:(build_context.project_build_dir // "hello.o")
  in

  Rule.{ targets = [ `File "hello.o" ]; deps = [ `File "hello.c" ]; action }

let rule_build_main =
  let action build_context =
    print_endline "[DEBUG] start rule_build_MAIN_action";

    Toolchain.capture_from_system ()
    |> Toolchain.compile
         ~cwd:
           (Spawn.Working_dir.Path build_context.Build_context.project_root_dir)
         ~source_files:
           [
             build_context.project_root_dir // "main.c";
             build_context.project_build_dir // "hello.o";
           ]
         ~output:(build_context.project_build_dir // "main.exe")
  in

  Rule.
    {
      targets = [ `File "main.exe" ];
      deps = [ `File "main.c"; `File "_build/hello.o" ];
      action;
    }

let () =
  let build_context = Build_context.make @@ Sys.getcwd () in
  let builder =
    Builder.make build_context
    |> Builder.add_rule rule_build_main
    |> Builder.add_rule rule_build_hello
  in

  Builder.run builder
