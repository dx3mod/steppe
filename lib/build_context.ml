type t = { project_root_dir : string; project_build_dir : string }

let make root_dir =
  {
    project_root_dir = root_dir;
    project_build_dir = Filename.concat root_dir "_build";
  }
