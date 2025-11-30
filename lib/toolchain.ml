type t = { cc : string }

let capture_from_system () =
  if Sys.unix then begin
    { cc = "/bin/gcc" }
  end
  else failwith "not supported platform yet"

let spawn ?cwd ~args t =
  Spawn.spawn ?cwd ~prog:t.cc ~argv:(t.cc :: args) () |> Unix.waitpid [] |> ignore

let compile ?cwd ~source_files ?(c = []) ~output t =
  let args = c @ [ "-o"; output ] @ source_files in
  spawn ?cwd t ~args
