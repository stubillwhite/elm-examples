module Rest exposing (NewsItem, ResponseHandler, getNewsItems)

import Http
import HttpBuilder exposing (..)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (hardcoded, optional, required)
import Json.Encode as Encode


{-| Response handler type, which handles either an HTTP error or a response
-}
type alias ResponseHandler resp msg =
    Result Http.Error resp -> msg


serverEndpoint : String -> String
serverEndpoint resource =
    "http://localhost:8080/stub-server-files" ++ resource


{-| The NewsItem data type returned by the API
-}
type alias NewsItem =
    { userId : Int
    , id : Int
    , title : String
    , body : String
    }


{-| A decoder for a NewsItem
-}
decodeNewsItem : Decoder NewsItem
decodeNewsItem =
    Decode.succeed NewsItem
        |> required "userId" Decode.int
        |> required "id" Decode.int
        |> required "title" Decode.string
        |> required "body" Decode.string


decodeNewsItems : Decode.Decoder (List NewsItem)
decodeNewsItems =
    Decode.list decodeNewsItem


{-| A GET operation to retrieve the news items
-}
getNewsItems : ResponseHandler (List NewsItem) msg -> Cmd msg
getNewsItems handler =
    let
        url =
            serverEndpoint "/news-items"
    in
    HttpBuilder.get url
        |> withExpect (Http.expectJson handler decodeNewsItems)
        |> request
