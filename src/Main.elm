module Main exposing (..)

import Doc exposing ((|+), Doc)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { content : Html Msg
    , errorMsg : Maybe String
    }


type Msg
    = NoOp


main =
    Html.beginnerProgram
        { model = Model prettyHtml Nothing
        , view = \model -> model.content
        , update = update
        }


view : Model -> Html Msg
view model =
    model.content


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


sample : Doc
sample =
    Doc.string "nice"
        |+ Doc.line
        |+ Doc.string "world"
        |> Doc.align
        |> (|+) (Doc.red (Doc.string "hi "))


prettyHtml : Html a
prettyHtml =
    Doc.toHtml (Doc.renderPretty 0.4 80 sample)


prettyString : Maybe String
prettyString =
    Doc.display (Doc.renderPretty 0.4 80 sample)
