module Tests exposing (..)

import Expect exposing ( Expectation )
import Maybe.Applicator exposing ( apply )
import Test exposing (..)

dummyFunc : String -> String
dummyFunc string = string

all : Test
all =
  describe
    "Maybe.Applicator"
      [ test "should apply and return if argument exists" <|
        \() ->
          apply ( Just "x" ) dummyFunc
            |> Expect.equal ( Just "x" )
      , test "should return nothing if argument doesn't exist" <|
        \() ->
          apply Nothing dummyFunc
            |> Expect.equal Nothing
      ]
