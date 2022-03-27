use "collections"
use "debug"
use "pony_test"
use "format"

actor \nodoc\ Main is TestList
  new create(env: Env) => PonyTest(env, this)
  new make() => None

  fun tag tests(test: PonyTest) =>
    test(_Empty)
    test(_SingleUpdate)
    test(_MultipleUpdates)


class \nodoc\ iso _Empty is UnitTest
  """
  Tests value of empty value to hash
  """
  fun name(): String => "blake3/empty"

  fun apply(h: TestHelper) =>
    let emptyhash: String = "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262"
    let blake3: Blake3 = Blake3
    h.assert_eq[String](emptyhash, blake3.finalize_string())
    h.assert_eq[String](emptyhash, blake3.finalize_string(32))
    h.assert_eq[String](emptyhash, blake3.finalize_seek_string(0, 32))
    h.assert_eq[String](emptyhash, blake3.finalize_seek_string(where outlen=32))
    h.assert_eq[String](emptyhash.substring(0,32), blake3.finalize_seek_string(where outlen=16))
    h.assert_eq[String](emptyhash.substring(32,64), blake3.finalize_seek_string(16,16))

class \nodoc\ iso _SingleUpdate is UnitTest
  """
  Tests values of various lengths of input
  """
  fun name(): String => "blake3/singleupdate"

  fun apply(h: TestHelper) =>
    let hash0: String = "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262"
    let hash10: String = "40772e14b7665a8e7f09de41da09c4191acac132a598e4e363d076e19077057a"
    let hash100: String = "ac6f86fff630a56a21f59d3a0c1c6907fe3f7cafd5fa916f9b722032f6059ed9"
    let hash1000000: String = "c211bb2e5afbd0efa21659d5578ea30217d5382734be1b494faf705d9aa202a1"

    let a0: Array[U8] = Array[U8]
    let a10: Array[U8] = Array[U8].init(0,10)
    let a100: Array[U8] = Array[U8].init(0,100)
    let a1000000: Array[U8] = Array[U8].init(0,1000000)

    let blake3: Blake3 = Blake3
    h.assert_eq[String](hash0, blake3.finalize_string())
    blake3.update(a0)
    h.assert_eq[String](hash0, blake3.finalize_string())

    blake3.reset()
    h.assert_eq[String](hash0, blake3.finalize_string())
    blake3.update(a10)
    h.assert_eq[String](hash10, blake3.finalize_string())

    blake3.reset()
    h.assert_eq[String](hash0, blake3.finalize_string())
    blake3.update(a100)
    h.assert_eq[String](hash100, blake3.finalize_string())

    blake3.reset()
    h.assert_eq[String](hash0, blake3.finalize_string())
    blake3.update(a1000000)
    h.assert_eq[String](hash1000000, blake3.finalize_string())

    blake3.reset()
    h.assert_eq[String](hash0, blake3.finalize_string())
    blake3.update_with_size(a1000000, 100)
    h.assert_eq[String](hash100, blake3.finalize_string())

class \nodoc\ iso _MultipleUpdates is UnitTest
  """
  Tests values of various lengths of input
  """
  fun name(): String => "blake3/multipleupdates"

  fun apply(h: TestHelper) =>
    /*
     * These strings were compared against the provided example.c
     * values as called on the command-line like this:
     *
     * red@ub0:~/blake3$ dd if=/dev/zero bs=1000 count=1000000 | ./example
     * 1000000+0 records in
     * 1000000+0 records out
     * 1000000000 bytes (1.0 GB, 954 MiB) copied, 0.615233 s, 1.6 GB/s
     * 55c6dac98fbc9a388f619f5f4ffc4c9fdd3eb37eab48afd68b65da90ef3070b1
     */
    let hash0: String = "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262"
    let hash10: String = "40772e14b7665a8e7f09de41da09c4191acac132a598e4e363d076e19077057a"
    let hash100: String = "ac6f86fff630a56a21f59d3a0c1c6907fe3f7cafd5fa916f9b722032f6059ed9"
    let hash1000000: String = "c211bb2e5afbd0efa21659d5578ea30217d5382734be1b494faf705d9aa202a1"
    let hash1000000000: String = "55c6dac98fbc9a388f619f5f4ffc4c9fdd3eb37eab48afd68b65da90ef3070b1"

    let a0: Array[U8] = Array[U8]
    let a10: Array[U8] = Array[U8].init(0,10)
    let a100: Array[U8] = Array[U8].init(0,100)
    let a1000000: Array[U8] = Array[U8].init(0,1000000)

    let blake3: Blake3 = Blake3
    h.assert_eq[String](hash0, blake3.finalize_string())

    // Applying 10 updates of 10 bytes should be the same as update
    // of 100 bytes.
    for cnt in Range(0,10) do
      blake3.update(a10)
    end
    h.assert_eq[String](hash100, blake3.finalize_string())

    blake3.reset()
    for cnt in Range(0,1000) do
      blake3.update(a1000000)
    end
    h.assert_eq[String](hash1000000000, blake3.finalize_string())

