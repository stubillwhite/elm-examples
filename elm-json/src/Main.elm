module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Debug
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Http
import Rest exposing (..)
import Url



-- Types


type alias Model =
    { newsItems : Maybe (List NewsItem)
    }


type Msg
    = ReadNewsItems
    | ReadNewsItemsSuccess (List NewsItem)
    | ReadNewsItemsFailure Http.Error



-- Init


init : () -> ( Model, Cmd Msg )
init _ =
    ( { newsItems = Nothing }, Cmd.none )



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReadNewsItems ->
            ( model, Cmd.batch [ getNewsItems handleGetNewsItemsResponse ] )

        ReadNewsItemsSuccess newsItems ->
            ( { model | newsItems = Just newsItems }, Cmd.none )

        ReadNewsItemsFailure err ->
            let
                _ =
                    Debug.log "Error reading news items" (Debug.toString err)
            in
            ( model, Cmd.none )


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


view : Model -> Browser.Document Msg
view model =
    { title = "elm-json"
    , body =
        [ div []
            [ button [ onClick ReadNewsItems ] [ text "Read news items" ]
            , displayNewsItems model
            ]
        ]
    }


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



-- Main


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , subscriptions = \x -> Sub.none
        , update = update
        }
