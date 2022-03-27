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

# Full Documentation
```pony
class ref Blake3
```

## Constructors

### create

Creates and initializes a Blake3 Hasher in the default hashing mode

```pony
new ref create()
: Blake3 ref^
```

#### Returns

* Blake3 ref^

---

### init_keyed

Creates and initializes a Blake3 Hasher in the keyed hashing mode.  The provided
key must be exactly 32 bytes.  If the key provided is not 32 Bytes in size then
this constructor will throw an error.

```pony
new ref init_keyed(
  key: Array[U8 val] ref)
: Blake3 ref^ ?
```
#### Parameters

*   key: Array\[U8\] ref

#### Returns

* Blake3 ref^ ?

---

### init_derive_key

Initialize a Blake3 Hasher in the key derivation mode.  The context string is
given as an initialization parameter.  Per the upstream documentation, this
string should be: "hardcoded, globally unique, and application-specific".

```pony
new ref init_derive_key(
  context: String val)
: Blake3 ref^
```
#### Parameters

*   context: String val

#### Returns

* Blake3 ref^

---

## Public Functions

### version

Returns the version of libblake3 which this pony program is linked against.
This library was authored against version 1.3.1.

```pony
fun box version()
: String iso^
```

#### Returns

* String iso^

---

### update

This adds input to the hasher.  This can be called any number of times.  The
size of the input is automatically derived from the size of the Array\[U8\].

NOTE: If you are reüsing an Array\[U8\] as a buffer, you need to be certain
that the size is what you expect.  If you want to be explict, you should
use update\_with\_size() instead.

```pony
fun box update(
  input: Array[U8 val] box)
: None val
```
#### Parameters

*   input: Array\[U8 val\] box

#### Returns

* None val

---

### update_with_size

This adds input to the hasher.  This can be called any number of times. The
number of bytes provided to the hasher is explicitly stated.

```pony
fun box update_with_size(
  input: Array[U8 val] box,
  size: USize val)
: None val
```
#### Parameters

*   input: Array\[U8 val\] box
*   size: USize val

#### Returns

* None val

---

### finalize

Finalize the hasher and return an output of any length, given in bytes. This
doesn't modify the hasher itself, and it's possible to finalize again after
adding more input. The default length is 32 Bytes.

```pony
fun box finalize(
  outlen: USize val = call)
: Array[U8 val] iso^
```
#### Parameters

*   outlen: USize val = (Default: USize(32))

#### Returns

* Array\[U8 val\] iso^

---

### finalize_string

Finalize the hasher and return an output of any length, given in bytes. This
doesn't modify the hasher itself, and it's possible to finalize again after
adding more input. The default length is 32 Bytes.

Output is returned as a Lower-cased Hex String.

```pony
fun box finalize_string(
  outlen: USize val = call)
: String iso^
```
#### Parameters

*   outlen: USize val = (Default: USize(32))

#### Returns

* String iso^

---

### finalize_seek

The same as finalize, but with an additional seek parameter for the starting
byte position in the output stream. To efficiently stream a large output
without allocating memory, call this function in a loop, incrementing seek
by the output length each time.

```pony
fun box finalize_seek(
  seek: USize val = call,
  outlen: USize val = call)
: Array[U8 val] iso^
```
#### Parameters

*   seek: USize val = (Default: USize(0))
*   outlen: USize val = (Default: USize(32))

#### Returns

* Array\[U8 val\] iso^

---

### finalize_seek_string

The same as finalize, but with an additional seek parameter for the starting
byte position in the output stream. To efficiently stream a large output
without allocating memory, call this function in a loop, incrementing seek
by the output length each time.

Output is returned as a Lower-cased Hex String.

```pony
fun box finalize_seek_string(
  seek: USize val = call,
  outlen: USize val = call)
: String iso^
```
#### Parameters

*   seek: USize val = (Default: USize(0))
*   outlen: USize val = (Default: USize(32))

#### Returns

* String iso^

---

### reset

Reset the hasher to its initial state, prior to any calls to ```update()```.
This is useful in the case of hashing many things in a loop.


```pony
fun box reset()
: None val
```

#### Returns

* None val

---

