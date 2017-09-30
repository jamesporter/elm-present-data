module Views exposing (..)

import Html exposing (Html, div, h1, h2, h3, pre, text)
import Html.Attributes exposing (class, style, id)
import Html.Events exposing (onClick)
import Models exposing (Presentation, Slide(..), slides, progress, getCodeForSlideIfAt)
import Messages exposing (Msg(..))


view : Presentation -> Html Msg
view presentation =
    let
        currentSlides =
            slides presentation
    in
        div []
            ((List.map (\( s, p ) -> viewSlide s p) currentSlides)
                ++ [ progressView presentation, codeView presentation, prev, next, codeControl ]
            )


prev : Html Msg
prev =
    div [ id "prev", onClick Previous ] []


next : Html Msg
next =
    div [ id "next", onClick Next ] []


codeControl : Html Msg
codeControl =
    div [ id "codeControl", onClick ToggleCode ] []


viewSlide : Slide -> Float -> Html Msg
viewSlide slide position =
    let
        containerStyle =
            [ ( "transform", transformSpec position ), ( "opacity", opacitySpec position ) ]

        content =
            case slide of
                Simple c ->
                    c

                WithCode c _ ->
                    c
    in
        div [ class "slide", style containerStyle ] [ content ]


transformSpec : Float -> String
transformSpec amount =
    let
        scale =
            toString <| 0.8 + 0.2 * (1.0 - (abs amount))

        translate =
            toString (amount * 100)
    in
        "translate(" ++ translate ++ "vw, 0%) scale(" ++ scale ++ ")"


opacitySpec : Float -> String
opacitySpec amount =
    toString <| 1.0 - (abs amount)


progressView : Presentation -> Html Msg
progressView presentation =
    let
        width =
            widthSpec <| progress presentation
    in
        div [ class "progress-bar", style [ ( "width", width ) ] ] []


codeView : Presentation -> Html Msg
codeView presentation =
    let
        code =
            getCodeForSlideIfAt presentation
    in
        case code of
            Just code ->
                div [ id "code" ] [ pre [] [ text code ] ]

            Nothing ->
                text ""


widthSpec : Float -> String
widthSpec progress =
    (toString (progress * 100)) ++ "%"
