module Main exposing (..)

import Html exposing (program)
import Parent


main : Program Never Parent.Model Parent.Msg
main =
    program
        { init = Parent.init
        , update = Parent.update
        , subscriptions = Parent.subscriptions
        , view = Parent.view
        }
