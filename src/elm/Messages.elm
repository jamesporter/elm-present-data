module Messages exposing (Msg(..))

import Keyboard exposing (Key)


type Msg
    = TimeUpdate Float
    | KeyDown Key
    | Next
    | Previous
    | ToggleCode
