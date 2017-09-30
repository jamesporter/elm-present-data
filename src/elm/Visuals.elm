module Visuals exposing (..)

import Html exposing (Html, div, h1)
import Html.Attributes exposing (class)
import Svg exposing (circle, line, path, rect, svg, text, text_, g)
import Svg.Attributes exposing (d, dy, fill, fontSize, height, opacity, stroke, strokeWidth, textAnchor, viewBox, width, x, x1, x2, y, y1, y2, cx, cy, r)
import Messages exposing (Msg)
import Tuple exposing (first, second)


container : String -> List (Html Msg) -> Html Msg
container title content =
    div []
        [ h1 [] [ text title ]
        , div [ class "example" ]
            [ svg [ viewBox "0 0 100 100" ] content
            ]
        ]


background : Html Msg
background =
    let
        oneToNine =
            List.range 1 9
    in
        g [ strokeWidth "0.4", stroke "white", opacity "0.6" ]
            ((oneToNine |> List.map (\n -> line [ x1 (toString (10 * n)), x2 (toString (10 * n)), y1 "0", y2 "100" ] []))
                ++ (oneToNine |> List.map (\n -> line [ y1 (toString (10 * n)), y2 (toString (10 * n)), x1 "0", x2 "100" ] []))
            )


circles : Html Msg
circles =
    let
        specs =
            [ ( "45", "white" )
            , ( "30", "blue" )
            , ( "15", "red" )
            ]
    in
        g [ opacity "0.8" ] <|
            List.map
                (\n ->
                    circle
                        [ cx "50"
                        , cy "50"
                        , r (first n)
                        , fill (second n)
                        ]
                        []
                )
                specs

data : Html Msg
data =
  let 
    calories = [349, 370, 488, 641, 672, 518, 832]
    len = List.length calories
    dx =  90.0  / (toFloat len)
    sx = 5.0
  in

