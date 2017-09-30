module Updates exposing (..)

import Models exposing (Presentation, Position(..), Slide(..))
import Time exposing (Time)
import Keyboard exposing (KeyCode)
import Messages exposing (Msg(..))


update : Msg -> Presentation -> ( Presentation, Cmd Msg )
update msg presentation =
    case msg of
        TimeUpdate dt ->
            ( timeUpdate dt presentation, Cmd.none )

        KeyDown keyCode ->
            ( keyDown keyCode presentation, Cmd.none )


timeUpdate : Time -> Presentation -> Presentation
timeUpdate time presentation =
    let
        ds =
            2.0 * Time.inSeconds time
    in
        case presentation.position of
            At n ->
                presentation

            Forward from to progress ->
                let
                    newProgress =
                        progress + ds
                in
                    if newProgress > 1.0 then
                        { presentation | position = At to }
                    else
                        { presentation | position = Forward from to newProgress }

            Backward from to progress ->
                let
                    newProgress =
                        progress + ds
                in
                    if newProgress > 1.0 then
                        { presentation | position = At to }
                    else
                        { presentation | position = Backward from to newProgress }


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
            case presentation.position of
                At n ->
                    if n > 0 then
                        { presentation | position = Backward n (n - 1) 0.0 }
                    else
                        presentation

                Backward _ _ _ ->
                    presentation

                Forward from to progress ->
                    { presentation | position = Backward to from (1.0 - progress) }

        -- Right
        39 ->
            case presentation.position of
                At n ->
                    { presentation | position = Forward n (n + 1) 0.0 }

                Forward _ _ _ ->
                    presentation

                Backward from to progress ->
                    { presentation | position = Forward to from (1.0 - progress) }

        -- Esc
        27 ->
            { presentation | position = At 0 }

        67 ->
            { presentation | showCode = not presentation.showCode }

        _ ->
            presentation
