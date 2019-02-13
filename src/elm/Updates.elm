module Updates exposing (fastForward, keyDown, next, prev, timeUpdate, update)

import Array exposing (length)
import Keyboard exposing (Key(..))
import Messages exposing (Msg(..))
import Models exposing (Position(..), Presentation, Slide(..))
import Platform.Cmd
import Time exposing (Posix)


update : Msg -> Presentation -> ( Presentation, Cmd Msg )
update msg presentation =
    case msg of
        TimeUpdate dt ->
            ( timeUpdate dt presentation, Cmd.none )

        KeyDown key ->
            ( keyDown key presentation, Cmd.none )

        Next ->
            ( next presentation, Cmd.none )

        Previous ->
            ( prev presentation, Cmd.none )

        ToggleCode ->
            ( toggleCode presentation, Cmd.none )


prev : Presentation -> Presentation
prev presentation =
    case presentation.position of
        At n ->
            if n > 0 then
                { presentation | position = Backward n (n - 1) 0.0, showCode = False }

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
                { presentation | position = Forward n (n + 1) 0.0, showCode = False }

            else
                presentation

        Forward _ _ _ ->
            presentation

        Backward from to progress ->
            { presentation | position = Forward to from (1.0 - progress) }


fastForward : Presentation -> Presentation
fastForward presentation =
    case presentation.position of
        At n ->
            if n + 5 < length presentation.slides then
                { presentation | position = At (n + 5) }

            else
                { presentation | position = At (length presentation.slides - 1) }

        _ ->
            presentation


toggleCode : Presentation -> Presentation
toggleCode presentation =
    { presentation | showCode = not presentation.showCode }


timeUpdate : Float -> Presentation -> Presentation
timeUpdate time presentation =
    let
        ds =
            2.0 * time
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


keyDown : Key -> Presentation -> Presentation
keyDown key presentation =
    case key of
        -- Left
        ArrowLeft ->
            prev presentation

        -- Right
        ArrowRight ->
            next presentation

        -- Esc
        Escape ->
            { presentation | position = At 0 }

        _ ->
            presentation
