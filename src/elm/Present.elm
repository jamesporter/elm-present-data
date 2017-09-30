module Present exposing (..)

import Html exposing (Html)
import Models exposing (..)
import Updates exposing (..)
import Messages exposing (Msg(..))
import Views exposing (view)
import AnimationFrame
import Keyboard
import SlideShow exposing (slideShow)


main : Program Never Presentation Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Presentation, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Presentation
initialModel =
    { position = At 0
    , slides = slideShow
    , showCode = False
    }



-- SUBSCRIPTIONS


subscriptions : Presentation -> Sub Msg
subscriptions presentation =
    Sub.batch <|
        [ Keyboard.downs KeyDown
        ]
            ++ (animationSubs presentation)


animationSubs : Presentation -> List (Sub Msg)
animationSubs presentation =
    case presentation.position of
        At _ ->
            []

        _ ->
            [ AnimationFrame.diffs TimeUpdate ]
