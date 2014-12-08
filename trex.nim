{.compile: "T-Rex/libtrex.c".}
{.push importc.}
when not(defined(TREX_H)): 
  const 
    TREX_H* = true
  #**************************************************************
  # T-Rex a tiny regular expression library
  #
  # Copyright (C) 2003-2006 Alberto Demichelis
  #
  # This software is provided 'as-is', without any express 
  # or implied warranty. In no event will the authors be held 
  # liable for any damages arising from the use of this software.
  #
  # Permission is granted to anyone to use this software for 
  # any purpose, including commercial applications, and to alter
  # it and redistribute it freely, subject to the following restrictions:
  #
  #  1. The origin of this software must not be misrepresented;
  #  you must not claim that you wrote the original software.
  #  If you use this software in a product, an acknowledgment
  #  in the product documentation would be appreciated but
  #  is not required.
  #
  #  2. Altered source versions must be plainly marked as such,
  #  and must not be misrepresented as being the original software.
  #
  #  3. This notice may not be removed or altered from any
  #  source distribution.
  #
  #**************************************************************
  ##ifdef _UNICODE
  ##define TRexChar unsigned short
  ##define MAX_CHAR 0xFFFF
  ##define _TREXC(c) L##c 
  ##define trex_strlen wcslen
  ##define trex_printf wprintf
  ##else
  type
    TRex* = object
  const 
    MAX_CHAR* = 0x000000FF

  ##endif
  const 
    TRex_True* = 1
    TRex_False* = 0
  type 
    TRexBool* = cuint
    TRexMatch* = object 
      begin*: cstring
      len*: cint

  proc compile*(pattern: cstring; error: ptr cstring): ptr TRex
  proc free*(exp: ptr TRex)
  proc match*(exp: ptr TRex; text: cstring): TRexBool
  proc search*(exp: ptr TRex; text: cstring; 
                    out_begin: ptr cstring; out_end: ptr cstring): TRexBool
  proc searchrange*(exp: ptr TRex; text_begin: cstring; 
                         text_end: cstring; out_begin: ptr cstring; 
                         out_end: ptr cstring): TRexBool
  proc getsubexpcount*(exp: ptr TRex): cint
  proc getsubexp*(exp: ptr TRex; n: cint; subexp: ptr TRexMatch): TRexBool

  # High level API
  proc regex(expr: string): ptr TRex =
    var error = "INVALID_REGEX"
    return compile(expre, error)