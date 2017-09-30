module SlideShow exposing (..)

import Models exposing (Slide(..))
import Array exposing (fromList)
import Html exposing (Html, div, h1, h2, text)
import Markdown exposing (toHtml)
import Messages exposing (Msg)


asHtml : String -> Html Msg
asHtml content =
    toHtml [] content


slideShow =
    fromList
        [ Simple "Elm Data" "James Porter"
        , Simple "Follow Me" "@complexview"
        , Simple "About that" "@complexview"
        , Complex (asHtml """
# Hi there

## ho ho

* you
* are
        """) (Just """
        Some example
        source code
        text...
        let's see
        """)
        ]
