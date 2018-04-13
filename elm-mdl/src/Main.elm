module Main exposing (..)

import Html exposing (Html, program, text)
import Material
import Material.Button as Button
import Material.Options as Options exposing (cs, css, when)
import Material.Textfield as Textfield


-- Types


{-| Type alias to remove some of the boilerplate with the elm-mdl library
-}
type alias Mdl =
    Material.Model


{-| This is an enumeration of all the messages that the update function is expected to handle
-}
type Msg
    = Mdl (Material.Msg Msg)
    | Increment
    | Decrement
    | Reset


{-| This is the model. It's a record that just contains a single value, and the state of the material components.
-}
type alias Model =
    { mdl : Material.Model
    , value : Int
    }



-- Update


{-| This is the initial state of the system
-}
initialModel : Model
initialModel =
    { mdl = Material.model
    , value = 0
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


{-| This is the update function that mutates the state of the system
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        _ =
            Debug.log "Message: " (toString msg)

        _ =
            Debug.log "State: " (toString model)
    in
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        Increment ->
            { model | value = model.value + 1 } ! []

        Decrement ->
            { model | value = model.value - 1 } ! []

        Reset ->
            { model | value = 0 } ! []



-- View


{-| This is view function that renders the model as HTML
-}
view : Model -> Html Msg
view model =
    Options.div
        [ css "margin-left" "1em" ]
        [ textfield model.mdl 0 (toString model.value)
        , Options.div
            []
            [ button model.mdl 0 "-" Decrement
            , button model.mdl 1 "Reset" Reset
            , button model.mdl 2 "+" Increment
            ]
        ]


{-| This renders a material button
-}
button : Mdl -> Int -> String -> Msg -> Html Msg
button mdl id txt msg =
    Button.render Mdl
        [ id ]
        mdl
        [ css "margin-right" "1em"
        , Options.onClick msg
        , Button.colored
        , Button.raised
        ]
        [ text txt ]


{-| This renders a material textfield
-}
textfield : Mdl -> Int -> String -> Html Msg
textfield mdl id value =
    Textfield.render Mdl
        [ id ]
        mdl
        [ Textfield.value value ]
        []



-- Main


{-| This is the entry point which binds the functions to the Elm runtime
-}
main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
