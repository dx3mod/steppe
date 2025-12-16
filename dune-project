(lang dune 3.20)

(source
 (github dx3mod/steppe))

(authors "Mikhail Lopatin <dx3mod@bk.ru>")

(maintainers "Mikhail Lopatin <dx3mod@bk.ru>")

(license MIT)

(package
 (name steppe)
 (synopsis " A tidy and tiny build tool for C/C++")
 (description
  "A tidy and tiny build tool for C/C++ projects that doesn't bore developers covers typical structured projects")
 (depends
  (ocaml
   (>= 5.4))))
