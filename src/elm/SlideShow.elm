module SlideShow exposing (..)

import Models exposing (Slide(..))
import Array exposing (fromList)
import Html exposing (Html, div, h1, h2, text)


slideShow =
    fromList
        [ Simple "Elm Data" "James Porter"
        , Simple "Follow Me" "@complexview"
        , Simple "About that" "@complexview"
        , Complex (div [] [ h1 [] [ text "testing" ] ]) (Just """
        Some example
        source code
        text...
        let's see
        """)
        ]
