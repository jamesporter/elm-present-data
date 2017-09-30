module Models exposing (..)

import Array exposing (Array, get)
import Html exposing (Html)
import Messages exposing (Msg)


type Slide
    = Simple String String
    | Complex (Html Msg) (Maybe String)


type Position
    = At Int
    | Forward Int Int Float
    | Backward Int Int Float


type alias Presentation =
    { position : Position
    , slides : Array Slide
    , showCode : Bool
    }


slides : Presentation -> List ( Slide, Float )
slides { position, slides } =
    case position of
        At n ->
            let
                slide =
                    get n slides
            in
                cleanSlides [ ( slide, 0.0 ) ]

        Forward from to progress ->
            cleanSlides
                [ ( get from slides, -progress )
                , ( get to slides, 1.0 - progress )
                ]

        Backward from to progress ->
            cleanSlides
                [ ( get from slides, progress )
                , ( get to slides, progress - 1.0 )
                ]


cleanSlides : List ( Maybe Slide, Float ) -> List ( Slide, Float )
cleanSlides rawSlides =
    List.filterMap
        (\( rs, f ) ->
            case rs of
                Just s ->
                    Just ( s, f )

                Nothing ->
                    Nothing
        )
        rawSlides


progress : Presentation -> Float
progress { position, slides } =
    let
        total =
            (toFloat <| Array.length slides)

        current =
            case position of
                At n ->
                    toFloat <| n + 1

                Forward from _ progress ->
                    (toFloat from) + 1.0 + progress

                Backward from _ progress ->
                    (toFloat from) + 1.0 - progress
    in
        current / total
