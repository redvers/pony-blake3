

/*
  Source: blake3.h:41
  Original Name: blake3_versionblake3.h:41

  Return Value: [PointerType size=64]->[FundamentalType(char) size=8]

  Arguments:
*/
use @blake3_version[Pointer[U8]]()



/*
  Source: blake3.h:42
  Original Name: blake3_hasher_initblake3.h:42

  Return Value: [FundamentalType(void) size=0]

  Arguments:
    [PointerType size=64]->[Struct size=15296,fid: f7]
*/
use @blake3_hasher_init[None](self: NullablePointer[Blake3Hasher] tag)



/*
  Source: blake3.h:43
  Original Name: blake3_hasher_init_keyedblake3.h:43

  Return Value: [FundamentalType(void) size=0]

  Arguments:
    [PointerType size=64]->[Struct size=15296,fid: f7]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
*/
use @blake3_hasher_init_keyed[None](self: NullablePointer[Blake3Hasher] tag, key: Pointer[U8] tag)



/*
  Source: blake3.h:45
  Original Name: blake3_hasher_init_derive_keyblake3.h:45

  Return Value: [FundamentalType(void) size=0]

  Arguments:
    [PointerType size=64]->[Struct size=15296,fid: f7]
    [PointerType size=64]->[FundamentalType(char) size=8]
*/
use @blake3_hasher_init_derive_key[None](self: NullablePointer[Blake3Hasher] tag, context: Pointer[U8] tag)



/*
  Source: blake3.h:46
  Original Name: blake3_hasher_init_derive_key_rawblake3.h:46

  Return Value: [FundamentalType(void) size=0]

  Arguments:
    [PointerType size=64]->[Struct size=15296,fid: f7]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long unsigned int) size=64]
*/
use @blake3_hasher_init_derive_key_raw[None](self: NullablePointer[Blake3Hasher] tag, context: Pointer[None] tag, contextlen: U64)



/*
  Source: blake3.h:48
  Original Name: blake3_hasher_updateblake3.h:48

  Return Value: [FundamentalType(void) size=0]

  Arguments:
    [PointerType size=64]->[Struct size=15296,fid: f7]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long unsigned int) size=64]
*/
use @blake3_hasher_update[None](self: NullablePointer[Blake3Hasher] tag, input: Pointer[None] tag, inputlen: U64)



/*
  Source: blake3.h:50
  Original Name: blake3_hasher_finalizeblake3.h:50

  Return Value: [FundamentalType(void) size=0]

  Arguments:
    [PointerType size=64]->[Struct size=15296,fid: f7]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(long unsigned int) size=64]
*/
use @blake3_hasher_finalize[None](self: NullablePointer[Blake3Hasher] tag, out: Pointer[U8] tag, outlen: U64)



/*
  Source: blake3.h:52
  Original Name: blake3_hasher_finalize_seekblake3.h:52

  Return Value: [FundamentalType(void) size=0]

  Arguments:
    [PointerType size=64]->[Struct size=15296,fid: f7]
    [FundamentalType(long unsigned int) size=64]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(long unsigned int) size=64]
*/
use @blake3_hasher_finalize_seek[None](self: NullablePointer[Blake3Hasher] tag, seek: U64, out: Pointer[U8] tag, outlen: U64)



/*
  Source: blake3.h:54
  Original Name: blake3_hasher_resetblake3.h:54

  Return Value: [FundamentalType(void) size=0]

  Arguments:
    [PointerType size=64]->[Struct size=15296,fid: f7]
*/
use @blake3_hasher_reset[None](self: NullablePointer[Blake3Hasher] tag)

