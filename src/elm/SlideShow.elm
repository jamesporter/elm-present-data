module SlideShow exposing (..)

import Models exposing (Slide(..))
import Array exposing (fromList)


slideShow =
    fromList
        [ Simple "Elm Data" "James Porter"
        , Simple "Follow Me" "@complexview"
        , Simple "About that" "@complexview"
        ]
