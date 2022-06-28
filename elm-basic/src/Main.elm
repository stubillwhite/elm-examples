module Main exposing (..)

import Browser exposing (sandbox)
import Debug exposing (..)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)



-- Types


{-| This is the model. It's a record that just contains a single value.
-}
type alias Model =
    { value : Int
    }


{-| This is an enumeration of all the messages that the update function is expected to handle
-}
type Msg
    = Increment
    | Decrement
    | Reset



-- Update


{-| This is the initial state of the system
-}
initialModel : Model
initialModel =
    { value = 0 }


{-| This is the update function that mutates the state of the system
-}
update : Msg -> Model -> Model
update msg model =
    let
        _ =
            Debug.log "Message: " (toString msg)

        _ =
            Debug.log "State: " (toString model)
    in
    case msg of
        Increment ->
            { model | value = model.value + 1 }

        Decrement ->
            { model | value = model.value - 1 }

        Reset ->
            { model | value = 0 }



-- View


{-| This is view function that renders the model as HTML
-}
view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (toString model.value) ]
        , button [ onClick Decrement ] [ text "-" ]
        , button [ onClick Reset ] [ text "Reset" ]
        , button [ onClick Increment ] [ text "+" ]
        ]



-- Main


{-| This is the entry point which binds the functions to the Elm runtime
-}
main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
