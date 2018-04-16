module Child exposing (InternalMsg, Model, Msg, Translator, init, translator, update, view)

import Html exposing (Html, div, p, text)
import Material
import Material.Button as Button
import Material.Options as Options exposing (cs, css, when)
import Task


type alias Mdl =
    Material.Model


type OutMsg
    = ValueSelected Int


type InternalMsg
    = Mdl (Material.Msg InternalMsg)
    | Increment
    | Decrement
    | SelectValue Int


type Msg
    = ForSelf InternalMsg
    | ForParent OutMsg


type alias TranslationDictionary msg =
    { onInternalMessage : InternalMsg -> msg
    , onValueSelected : Int -> msg
    }


type alias Translator msg =
    Msg -> msg


type alias Model =
    { mdl : Material.Model
    , value : Int
    }


init : Model
init =
    { mdl = Material.model
    , value = 0
    }


translator : TranslationDictionary msg -> Translator msg
translator dictionary msg =
    let
        { onInternalMessage, onValueSelected } =
            dictionary
    in
    case msg of
        ForSelf internal ->
            onInternalMessage internal

        ForParent (ValueSelected x) ->
            onValueSelected x


internalView : Model -> Html InternalMsg
internalView model =
    Options.div
        [ css "margin" "1em" ]
        [ text "Child component"
        , Options.div
            []
            [ button model.mdl 0 "-" Decrement
            , text (toString model.value)
            , button model.mdl 1 "+" Increment
            , button model.mdl 2 "Accept" (SelectValue model.value)
            ]
        ]


view : Model -> Html Msg
view model =
    Html.map (\x -> ForSelf x) (internalView model)


button : Mdl -> Int -> String -> InternalMsg -> Html InternalMsg
button mdl id txt msg =
    Button.render Mdl
        [ id ]
        mdl
        [ css "margin" "1em"
        , Options.onClick msg
        , Button.colored
        , Button.raised
        ]
        [ text txt ]


updateMaterialComponents : Material.Msg InternalMsg -> Material.Container c -> ( Material.Container c, Cmd Msg )
updateMaterialComponents msg model =
    let
        ( newModel, newCmd ) =
            Material.update Mdl msg model
    in
    ( newModel, Cmd.map ForSelf newCmd )


never : Never -> a
never n =
    never n


generateParentMsg : OutMsg -> Cmd Msg
generateParentMsg outMsg =
    Task.perform ForParent (Task.succeed outMsg)


update : InternalMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            updateMaterialComponents msg_ model

        Increment ->
            { model | value = model.value + 1 } ! []

        Decrement ->
            { model | value = model.value - 1 } ! []

        SelectValue x ->
            model ! [ generateParentMsg (ValueSelected x) ]
