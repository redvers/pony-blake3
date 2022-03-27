class Blake3
  let hasher: NullablePointer[Blake3Hasher]

  new create() =>
    let rawhasher: Blake3Hasher = Blake3Hasher
    hasher = NullablePointer[Blake3Hasher](rawhasher)
    @blake3_hasher_init(hasher)

  new init_keyed(key: Array[U8]) ? =>
    if (key.size() != 32) then error end
    let rawhasher: Blake3Hasher = Blake3Hasher
    hasher = NullablePointer[Blake3Hasher](rawhasher)
    @blake3_hasher_init_keyed(hasher, key.cpointer())

  new init_derive_key(context: String) =>
    let rawhasher: Blake3Hasher = Blake3Hasher
    hasher = NullablePointer[Blake3Hasher](rawhasher)
    @blake3_hasher_init_derive_key(hasher, context.cstring())

  fun version(): String iso^ =>
    var pcstring: Pointer[U8] = @blake3_version()
    let p: String iso = String.from_cstring(pcstring).clone()
    consume p

  fun update(input: Array[U8] box) =>
    @blake3_hasher_update(hasher, input.cpointer(), input.size().u64())

  fun update_with_size(input: Array[U8] box, size: USize) =>
    @blake3_hasher_update(hasher, input.cpointer(), size.u64())

  fun finalize(outlen: USize = USize(32)): Array[U8] iso^ =>
    let outarray: Array[U8] iso = recover iso Array[U8].init(0, outlen) end
    @blake3_hasher_finalize(hasher, outarray.cpointer(), outlen.u64())
    consume outarray

  fun finalize_seek(seek: USize, outlen: USize = USize(32)): Array[U8] iso^ =>
    let outarray: Array[U8] iso = recover iso Array[U8].init(0, outlen) end
    @blake3_hasher_finalize_seek(hasher, seek.u64(), outarray.cpointer(), outlen.u64())
    consume outarray

  fun reset() =>
    @blake3_hasher_reset(hasher)

