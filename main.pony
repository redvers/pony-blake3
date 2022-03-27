use "format"
use "lib:blake3"
use "pony-blake3"

actor Main
  new create(env: Env) =>
    let blake3: Blake3 = Blake3
    env.out.print("Blake3 Library Version: " + blake3.version())

    blake3.update("hello".array())
    let result: Array[U8] val = blake3.finalize()
//    let result: Array[U8] val = blake3.finalize_seek(0,32)

		for f in result.values() do
			env.out.print(Format.int[U8](f where fmt = FormatHex))
		end
