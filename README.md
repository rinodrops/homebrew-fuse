 # homebrew-fuse

Homebrew refuses installation of formula which requires macFUSE after April 8, 2021.
It is done by checking if the following lines are written in the formula:
 
```
on_macos do
  disable! date: "2021-04-08", because: "requires closed-source macFUSE"
end
```
 
This repository stores such formula but the above lines are removed (or, change the date to 3021-04-08 if `on_macos` contains more than one line).

Typically this repository is updated automatically every midnight JST.
