module Messages exposing (Msg(..))

import Time exposing (Time)
import Keyboard exposing (KeyCode)


type Msg
    = TimeUpdate Time
    | KeyDown KeyCode
    | Next
    | Previous
    | ToggleCode
