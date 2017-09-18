module Updates exposing (..)

import Models exposing (Presentation, Position(..), ViewState(..), Slide(..))
import Time exposing (Time)
import Keyboard exposing (KeyCode)
import Array exposing (fromList)


type Msg
    = TimeUpdate Time
    | KeyDown KeyCode


update : Msg -> Presentation -> ( Presentation, Cmd Msg )
update msg presentation =
    case msg of
        TimeUpdate dt ->
            ( presentation, Cmd.none )

        KeyDown keyCode ->
            ( keyDown keyCode presentation, Cmd.none )


initialModel : Presentation
initialModel =
    { position = At 0
    , viewState = Hidden
    , slides = fromList [ Simple "Elm Data" "James Porter" ]
    }


keyDown : KeyCode -> Presentation -> Presentation
keyDown keyCode presentation =
    case keyCode of
        -- Up
        38 ->
            presentation

        -- Down
        40 ->
            presentation

        -- Left
        37 ->
            presentation

        -- Right
        39 ->
            presentation

        -- Esc
        27 ->
            presentation

        _ ->
            presentation
