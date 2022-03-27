A ponylang binding to libblake3

# libblake3

The C library that this pony library uses can be found on [github](https://github.com/BLAKE3-team/BLAKE3/). The C library can be found in the [/c](https://github.com/BLAKE3-team/BLAKE3/tree/master/c) subdirectory with the instructions on how to build it in the provided [README.md](https://github.com/BLAKE3-team/BLAKE3/blob/master/c/README.md)

# How to use

Manage via corral:

```
red@ub0:~/pony-blake-test$ corral init
red@ub0:~/pony-blake-test$ corral add github.com/redvers/pony-blake3.git 
red@ub0:~/pony-blake-test$ corral fetch
git cloning github.com/redvers/pony-blake3.git into /home/red/pony-blake-test/_repos/github_com_redvers_pony_blake3_git
git checking out @main into /home/red/pony-blake-test/_corral/github_com_redvers_pony_blake3
```

# Simple Example:

```pony
use "pony-blake3"

actor Main
  new create(env: Env) =>
    // Create an initialize a Blake3 Hasher
    let blake3: Blake3 = Blake3

    // Pass the data you wish to hash in as an Array[U8]
    blake3.update("Hello World".array())

    // Result can be retrieved as a binary Array[U8] iso^
    let result: Array[U8] iso = blake3.finalize()

    // … or as a lower-cased hex string:
    env.out.print("Hello World: " + blake3.finalize_string())

    // A hasher can be reused which is useful if you're doing
    // multiple hashes in a loop.
    blake3.reset()

    // Perform the same hash, but as a series of three updates
    blake3.update("Hello".array())
    blake3.update(" ".array())
    blake3.update("World".array())

    // … and the results will be the same
    env.out.print("Hello World: " + blake3.finalize_string())
```
