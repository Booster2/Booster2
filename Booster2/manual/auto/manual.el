(TeX-add-style-hook "manual"
 (lambda ()
    (LaTeX-add-bibliographies
     "refs")
    (TeX-run-style-hooks
     "fontenc"
     "T1"
     "cmbright"
     "color"
     "listings"
     "hyperref"
     ""
     "latex2e"
     "ociamthesis12"
     "ociamthesis"
     "12pt"
     "chapters/introduction"
     "chapters/language"
     "chapters/guardedcommands"
     "chapters/implangs"
     "chapters/transformations"
     "chapters/defaultsystem"
     "chapters/implementation"
     "chapters/howtos"
     "chapters/syntax"
     "chapters/reference")))

