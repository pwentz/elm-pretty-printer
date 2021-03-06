module ListCombinatorsTest exposing (..)

import Console
import Doc exposing (..)
import Expect exposing (Expectation)
import Test exposing (..)


suite : Test
suite =
    describe "List Combinators"
        [ describe "hsep"
            [ test "it concatenates documents horizontally with a space" <|
                \_ ->
                    let
                        words =
                            [ "how", "now", "brown", "cow?" ]
                    in
                    join space (List.map string words)
                        |> Doc.toString
                        |> Expect.equal "how now brown cow?"
            ]
        , describe "fillSep"
            [ test "it concatenates documents horizontally with softline" <|
                \_ ->
                    let
                        words =
                            [ "where", "in", "the", "world", "is", "Carmen", "Sandiego?" ]
                    in
                    join softline (List.map string words)
                        |> Doc.toString
                        |> Expect.equal "where in the world is Carmen\nSandiego?"
            ]
        , describe "vsep"
            [ test "it concats doc elements vertically with line" <|
                \_ ->
                    let
                        someText =
                            "string to lay out"
                                |> String.words
                                |> List.map string
                    in
                    string "some"
                        |+ space
                        |+ join line someText
                        |> Doc.toString
                        |> Expect.equal "some string\nto\nlay\nout"
            ]
        , describe "sep"
            [ test "it puts elements on same line, separated by space" <|
                \_ ->
                    let
                        elements =
                            [ "how", "now", "brown", "cow?" ]
                                |> List.map string
                    in
                    join line elements
                        |> group
                        |> Doc.toString
                        |> Expect.equal "how now brown cow?"
            , test "if it cannot put them all on same line, it puts them on separate lines" <|
                \_ ->
                    let
                        words =
                            [ "where", "in", "the", "world", "is", "Carmen", "Sandiego?" ]
                    in
                    join line (List.map string words)
                        |> group
                        |> Doc.toString
                        |> Expect.equal (String.join "\n" words)
            ]
        , describe "hcat"
            [ test "it concats elements horizontally with no space" <|
                \_ ->
                    let
                        words =
                            [ "hello", "world" ]
                    in
                    Doc.concat (List.map string words)
                        |> Doc.toString
                        |> Expect.equal "helloworld"
            ]
        , describe "vcat"
            [ test "it concats elements with linebreak" <|
                \_ ->
                    let
                        words =
                            [ "how", "now", "brown", "cow?" ]
                    in
                    join linebreak (List.map string words)
                        |> Doc.toString
                        |> Expect.equal (String.join "\n" words)
            ]
        , describe "fillCat"
            [ test "it concatenates with a softbreak (directly next to each other)" <|
                \_ ->
                    let
                        words =
                            [ "hello", "world" ]
                    in
                    join softbreak (List.map string words)
                        |> Doc.toString
                        |> Expect.equal "helloworld"
            , test "it fits as many as it can on one line " <|
                \_ ->
                    let
                        words =
                            [ "this is a long string", "another string", "third string", "banana" ]
                    in
                    join softbreak (List.map string words)
                        |> Doc.toString
                        |> Expect.equal "this is a long string\nanother stringthird stringbanana"
            ]
        , describe "cat"
            [ test "concats horizontally if fits page" <|
                \_ ->
                    let
                        words =
                            [ "hello", "world" ]
                    in
                    join linebreak (List.map string words)
                        |> group
                        |> Doc.toString
                        |> Expect.equal "helloworld"
            , test "concats vertically if it does not" <|
                \_ ->
                    let
                        words =
                            [ "what", "would", "you", "do", "if", "your", "son", "was", "at", "home?" ]
                    in
                    join linebreak (List.map string words)
                        |> group
                        |> Doc.toString
                        |> Expect.equal "what\nwould\nyou\ndo\nif\nyour\nson\nwas\nat\nhome?"
            ]
        , describe "punctuate"
            [ test "it concats all intersperses given document between elements" <|
                \_ ->
                    let
                        words =
                            [ "how", "now", "brown", "cow?" ]
                    in
                    join (char ',') (List.map string words)
                        |> Doc.toString
                        |> Expect.equal "how,now,brown,cow?"
            ]
        ]
