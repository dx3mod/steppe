(lang dune 3.6)

(source
 (github dx3mod/steppe))

(authors "Mikhail Lopatin <dx3mod@bk.ru>")

(maintainers "Mikhail Lopatin <dx3mod@bk.ru>")

(license MIT)

(package
 (name steppe)
 (synopsis "A declarative build system for C/C++ projects")
 (description
  "A declarative build system for C/C++ projects that doesn't bore developers covers typical structured projects with an intuitive developer experience")
 (depends
  (ocaml
   (>= 5.1))))
