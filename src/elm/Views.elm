module Views exposing (..)

import Html exposing (Html, div, h1, h2, text)
import Html.Attributes exposing (class, style)
import Models exposing (Presentation, Slide(..), slides, progress)
import Updates exposing (Msg)


view : Presentation -> Html Msg
view presentation =
    let
        currentSlides =
            slides presentation
    in
        div []
            ((List.map (\( s, p ) -> viewSlide s p) currentSlides)
                ++ [ progressView presentation ]
            )


viewSlide : Slide -> Float -> Html Msg
viewSlide slide position =
    case slide of
        Simple title secondary ->
            div [ class "slide", style [ ( "transform", transformSpec position ), ( "opacity", opacitySpec position ) ] ] [ h1 [] [ text title ], h2 [] [ text secondary ] ]


transformSpec : Float -> String
transformSpec amount =
    "translate(" ++ (toString (amount * 100)) ++ "vw, 0%)"


opacitySpec : Float -> String
opacitySpec amount =
    let
        aba =
            1.0 - (abs amount)

        abat =
            clamp 0.0 1.0 (2.0 * (aba - 0.5))
    in
        toString abat


progressView : Presentation -> Html Msg
progressView presentation =
    let
        width =
            widthSpec <| progress presentation
    in
        div [ class "progress-bar", style [ ( "width", width ) ] ] []


widthSpec : Float -> String
widthSpec progress =
    (toString (progress * 100)) ++ "%"
