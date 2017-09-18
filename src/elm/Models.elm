module Models exposing (..)

import Array exposing (Array, get)


type Slide
    = Simple String String


type Position
    = At Int
    | Forward Int Int Float
    | Backward Int Int Float


type ViewState
    = Visible
    | Hidden
    | Intro Float
    | Outro Float


type alias Presentation =
    { position : Position
    , viewState : ViewState
    , slides : Array Slide
    }



-- slides : Presentation -> List ( Slide, Float )
-- slides { position, slides } =
--     case position of
--         At n ->
--             List.filterMap identity [ get n slides ]
--             |> List.map ()
