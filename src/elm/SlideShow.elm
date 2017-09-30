module SlideShow exposing (..)

import Models exposing (Slide(..))
import Array exposing (fromList)
import Html exposing (Html, div, h1, h2, text)
import Markdown exposing (toHtml)
import Messages exposing (Msg)


asHtml : String -> Html Msg
asHtml content =
    toHtml [] content


slideShow : Array.Array Slide
slideShow =
    fromList
        [ Simple (asHtml """
# Elm Data

## James Porter

Follow me @complexview
""")
        , WithCode (asHtml """
# Hi there

## ho ho

* you
* are
        """) """
        Some example
        source code
        text...
        let's see
        """
        ]
