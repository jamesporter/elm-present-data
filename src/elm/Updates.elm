module Updates exposing (..)

import Models exposing (Presentation, Position(..), Slide(..))
import Time exposing (Time)
import Keyboard exposing (KeyCode)
import Messages exposing (Msg(..))
import Array exposing (length)
import Platform.Cmd


update : Msg -> Presentation -> ( Presentation, Cmd Msg )
update msg presentation =
    case msg of
        TimeUpdate dt ->
            ( timeUpdate dt presentation, Cmd.none )

        KeyDown keyCode ->
            ( keyDown keyCode presentation, Cmd.none )

        Next ->
            ( next presentation, Cmd.none )

        Previous ->
            ( prev presentation, Cmd.none )


prev : Presentation -> Presentation
prev presentation =
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


next : Presentation -> Presentation
next presentation =
    case presentation.position of
        At n ->
            if n + 1 < length presentation.slides then
                { presentation | position = Forward n (n + 1) 0.0 }
            else
                presentation

        Forward _ _ _ ->
            presentation

        Backward from to progress ->
            { presentation | position = Forward to from (1.0 - progress) }


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
        -- Left
        37 ->
            prev presentation

        -- Right
        39 ->
            next presentation

        -- Esc
        27 ->
            { presentation | position = At 0 }

        -- C
        67 ->
            { presentation | showCode = not presentation.showCode }

        _ ->
            presentation
