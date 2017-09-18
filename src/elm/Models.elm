module Models exposing (..)

import Array exposing (Array, get)


type Slide
    = Simple String String


type Position
    = At Int
    | Forward Int Int Float
    | Backward Int Int Float


type alias Presentation =
    { position : Position
    , slides : Array Slide
    }


slides : Presentation -> List ( Slide, Float )
slides { position, slides } =
    case position of
        At n ->
            let
                slide =
                    get n slides
            in
                case slide of
                    Nothing ->
                        []

                    Just s ->
                        [ ( s, 0.0 ) ]

        Forward from to progress ->
            cleanSlides
                [ ( get from slides, -progress )
                , ( get to slides, 1.0 - progress )
                ]

        Backward from to progress ->
            cleanSlides
                [ ( get from slides, progress )
                , ( get to slides, 1.0 - progress )
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
