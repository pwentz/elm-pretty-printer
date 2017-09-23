module Example exposing (..)

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


{-| TODO:

      - Background color!
      - Find way to remove text-decoration from child elements
      - Add extra color elements for DarkYellow, DarkRed, etc.
      - Remove subtle bug with Bold
        - replace Doc.red in complexSample with Doc.bold

-}
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
            complexSample
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
    Doc.list (List.map Doc.string listToRender)


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


prettyString : Maybe String
prettyString =
    Doc.display (Doc.renderPretty 0.4 80 sample)


pixelsPerChar : Float
pixelsPerChar =
    8
