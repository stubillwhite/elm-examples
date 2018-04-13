module Main exposing (..)

import Html exposing (Html, button, div, label, program, text)
import Html.Attributes exposing (attribute, style)
import Html.Events exposing (onClick)
import PaperDropdown exposing (..)


-- Types


type alias Model =
    { value : Maybe String
    }


type Msg
    = Select String



-- Update


initialModel : ( Model, Cmd Msg )
initialModel =
    { value = Nothing } ! []


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        _ =
            Debug.log "Message: " (toString msg)

        _ =
            Debug.log "State: " (toString model)
    in
    case msg of
        Select value ->
            { model | value = Just ("You selected '" ++ value ++ "'") } ! []



-- View


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ paperDropdown [ attribute "label" "Elm dropdown" ]
                [ paperItem [ onClick (Select "White") ] [ text "White" ]
                , paperItem [ onClick (Select "Black") ] [ text "Black" ]
                ]
            ]
        , text (Maybe.withDefault "" <| model.value)
        ]



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
