module SlideShow exposing (..)

import Models exposing (Slide(..))
import Array exposing (fromList)
import Html exposing (Html, div, h1, h2, text)
import Markdown exposing (toHtml)
import Messages exposing (Msg)
import Visuals exposing (..)


asHtml : String -> Html Msg
asHtml content =
    toHtml [] content


simple : String -> Slide
simple md =
    Simple (asHtml md)


withCode : String -> String -> Slide
withCode md code =
    WithCode (asHtml md) code


slideShow : Array.Array Slide
slideShow =
    fromList
        [ simple """
# Elm Data

## James Porter

Follow me *@complexview*
"""
        , withCode """
# This is Elm

All the slides are in Elm (most with Markdown)

[elm-data.amimetic.co.uk](http://elm-data.amimetic.co.uk)
""" """
type Slide
    = Simple (Html Msg)
    | WithCode (Html Msg) String
"""
        , withCode """
# Transitions

Usually this is the hard bit

(or the bit with unstructured magical messiness)
""" """
type Position
    = At Int
    | Forward Int Int Float
    | Backward Int Int Float
"""
        , simple """
# SVG Primatives

* g group
* rect rectangle
* circle
* ellipse
* polygon
* text_ (text tag, use text for content)
        """
        , WithCode (container "SVG" [])
            """
container : List (Html Msg) -> Html Msg
container content =
    div [ class "example" ]
        [ svg [ viewBox "0 0 100 100" ] content
        ]
"""
        , WithCode (container "Lines" [ background ]) """
g [ strokeWidth "0.4", stroke "white" ]

((oneToNine |> List.map (
 -> line [  x1 (toString (10 * n)),
            x2 (toString (10 * n)),
            y1 "0",
            y2 "100" ] []))
"""
        , WithCode (container "Circles" [ background, circles ]) """
let
    specs =
        [ ( "45", "white" ), ( "35", "blue" ), ( "25", "red" )]
in
    g [ opacity "0.8" ] <|
        List.map
            ( n ->
                circle
                    [ cx "50"
                    , cy "50"
                    , r (first n)
                    , fill (second n)
                    ]
                    []
            )
            specs
"""
        ]
