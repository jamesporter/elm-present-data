module Views exposing (..)

import Html exposing (Html, div, h1, h2, text)
import Html.Attributes exposing (class)
import Models exposing (Presentation, Slide(..))
import Updates exposing (Msg)


view : Presentation -> Html Msg
view presentation =
    -- let
    --     currentSlide =
    --         Array.get prespresentation.slides
    -- in
    viewSlide (Simple "Test" "Hi") 0.0


viewSlide : Slide -> Float -> Html Msg
viewSlide slide position =
    case slide of
        Simple title secondary ->
            div [ class "slide" ] [ h1 [] [ text title ], h2 [] [ text secondary ] ]
