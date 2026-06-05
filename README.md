# [WORK IN PROGRESS] im tired of js, so

I'm creating a string.repeat implementation in Linux GNU x86_64 Assembly.

<br>

## How to compile
use bundled script `asmc`:
```sh
./asmc test.g.s -o ./out/testg # <- compile w/ script
./testg # <- then run
```

<br>

## **/out**
contains precompiled executable/s.
### Usage:
```sh
./out/testg <str> <count>
```
<hr>
<br>

## **/util/charc**
is a utility that returns the char code of the 1st letter of the 1st argument as exit code.
### Usage: 
```sh
./util/charc <any character> ; echo $?
```

my twitter (formerly X): [@ahmdmoadi](https://x.com/ahmdmoadi)