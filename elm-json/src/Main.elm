module Main exposing (..)

import Debug
import Html exposing (Html, button, div, program, text)
import Html.Events exposing (onClick)
import Http
import Rest exposing (..)


-- Types


type alias Model =
    { newsItems : Maybe (List NewsItem)
    }


type Msg
    = ReadNewsItems
    | ReadNewsItemsSuccess (List NewsItem)
    | ReadNewsItemsFailure Http.Error



-- Update


initialModel : Model
initialModel =
    { newsItems = Nothing }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReadNewsItems ->
            model ! [ getNewsItems handleGetNewsItemsResponse ]

        ReadNewsItemsSuccess newsItems ->
            { model | newsItems = Just newsItems } ! []

        ReadNewsItemsFailure err ->
            let
                _ =
                    Debug.log "Error reading news items" (toString err)
            in
            model ! []


{-| The handler which is called when the server response is received
-}
handleGetNewsItemsResponse : ResponseHandler (List NewsItem) Msg
handleGetNewsItemsResponse response =
    case response of
        Ok newsItems ->
            ReadNewsItemsSuccess newsItems

        Err error ->
            ReadNewsItemsFailure error



-- View


displayNewsItems : Model -> Html Msg
displayNewsItems model =
    case model.newsItems of
        Nothing ->
            div [] [ text "Click the button to retrieve some news items" ]

        Just newsItems ->
            div []
                (newsItems
                    |> List.map (\x -> div [] [ text x.title ])
                )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick ReadNewsItems ] [ text "Read news items" ]
        , displayNewsItems model
        ]



-- Main


main : Program Never Model Msg
main =
    program
        { init = ( initialModel, Cmd.none )
        , view = view
        , subscriptions = \x -> Sub.none
        , update = update
        }
