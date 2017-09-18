module Updates exposing (..)

import Models exposing (Presentation)
import Time exposing (Time)
import Keyboard exposing (KeyCode)
import Array exposing (empty)


type Msg
    = TimeUpdate Time
    | KeyDown KeyCode
    | StartGame


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TimeUpdate dt ->
            ( model, Cmd.none )

        KeyDown keyCode ->
            ( keyDown keyCode model, Cmd.none )

        StartGame ->
            ( { model | state = Game }, Cmd.none )


initialModel : Presentation
initialModel =
    { position = At 0
    , viewState = Hidden
    , slides = empty
    }


keyDown : KeyCode -> Model -> Model
keyDown keyCode model =
    case keyCode of
        -- Up
        38 ->
            model

        -- Down
        40 ->
            model

        -- Left
        37 ->
            model

        -- Right
        39 ->
            model

        -- Esc
        27 ->
            model

        _ ->
            model
