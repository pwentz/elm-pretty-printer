module HtmlExample exposing (..)

import Doc exposing ((|+), Doc)
import Html exposing (..)
import Html.Attributes exposing (..)
import Task
import Window


type alias Model =
    { content : Maybe (Html Msg)
    , errorMsg : Maybe String
    , width : Maybe Int
    }


type Msg
    = WindowResize { width : Int, height : Int }


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes WindowResize


init : ( Model, Cmd Msg )
init =
    ( Model Nothing Nothing Nothing
    , Task.perform WindowResize Window.size
    )


view : Model -> Html Msg
view model =
    Maybe.withDefault (div [] []) model.content


update : Msg -> Model -> ( Model, Cmd Msg )
update (WindowResize { width, height }) model =
    ( { model
        | content =
            jsonSample
                |> Doc.renderPretty 1.0 (round (toFloat width / pixelsPerChar))
                |> Doc.toHtml
                |> Just
        , width = Just width
      }
    , Cmd.none
    )


sample : Doc
sample =
    Doc.string "nice"
        |+ Doc.line
        |+ Doc.string "world"
        |> Doc.align
        |> Doc.bold
        |> Doc.green
        |> (|+) (Doc.red (Doc.string "hi "))


complexSample : Doc
complexSample =
    let
        types =
            [ ( "empty", "Doc" )
            , ( "nest", "Int -> Doc -> Doc" )
            , ( "linebreak", "Doc" )
            ]

        ptype ( name, typeOf ) =
            Doc.fill 6 (Doc.red (Doc.string name))
                |+ Doc.string " : "
                |+ Doc.string typeOf
    in
    List.map ptype types
        |> Doc.join Doc.linebreak
        |> Doc.align
        |> (|+) (Doc.string "let ")


listSample : Doc
listSample =
    let
        listToRender =
            [ "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
            , "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
            , "ccccccccccccccccccccccccccccccccc"
            , "ddddddddddddddddddddddddddddddddd"
            ]
    in
    List.map Doc.string listToRender
        |> Doc.surroundJoin (Doc.char '[') (Doc.char ']') (Doc.char ',')


treeSample : Doc
treeSample =
    let
        root =
            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

        child =
            "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"

        nestedChild =
            "cccccccccccccccccccccccccccccccc"
    in
    Doc.hang 4 (Doc.string root |+ Doc.softline |+ Doc.string child)
        |+ Doc.softline
        |+ Doc.string nestedChild
        |> Doc.nest 8


prettyHtml : Html a
prettyHtml =
    Doc.toHtml (Doc.renderPretty 0.4 80 sample)


prettyString : Result String String
prettyString =
    Doc.display (Doc.renderPretty 0.4 80 sample)


pixelsPerChar : Float
pixelsPerChar =
    8


prettyKeyVal : ( String, String ) -> Doc
prettyKeyVal ( attr, value ) =
    let
        prettyAttr =
            Doc.string attr
                |> Doc.red
                |> Doc.bold
                |> Doc.dquotes
    in
    Doc.fill 12 prettyAttr
        |+ Doc.fill 4 (Doc.char ':')
        |+ Doc.dquotes (Doc.green (Doc.string value))


prettyJson : List ( String, String ) -> Doc
prettyJson data =
    List.map prettyKeyVal data
        |> Doc.join (Doc.char ',' |+ Doc.line)
        |> Doc.align
        |> Doc.indent 4
        |> wrapLines
        |> Doc.braces


jsonSample : Doc
jsonSample =
    [ sampleData1, sampleData2 ]
        |> List.map prettyJson
        |> Doc.join (wrapLines (Doc.char ','))
        |> Doc.indent 4
        |> wrapLines
        |> Doc.brackets


sampleData1 : List ( String, String )
sampleData1 =
    [ ( "full_name", "Bill Johnson" )
    , ( "address", "123 Fake St" )
    , ( "role", "guest" )
    ]


sampleData2 : List ( String, String )
sampleData2 =
    [ ( "full_name", "Jane Doe" )
    , ( "address", "1432 Westgreen Terrace" )
    , ( "role", "admin" )
    ]


wrapLines : Doc -> Doc
wrapLines =
    Doc.surround Doc.line Doc.line
