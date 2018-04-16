module Parent exposing (Model, Msg, init, subscriptions, update, view)

import Child
import Html exposing (Html, div, text)
import Material
import Material.Options as Options exposing (cs, css, when)


-- Types


type Msg
    = Mdl (Material.Msg Msg)
    | ChildMsg Child.InternalMsg
    | DisplayValue Int


type alias Model =
    { mdl : Material.Model
    , child : Child.Model
    , message : String
    }


initialModel : Model
initialModel =
    { mdl = Material.model
    , child = Child.init
    , message = ""
    }



-- Update


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        ChildMsg internal ->
            let
                ( child_, cmd ) =
                    Child.update internal model.child
            in
            { model | child = child_ } ! [ Cmd.map childTranslator cmd ]

        DisplayValue x ->
            { model | message = "Value selected in the child was " ++ toString x } ! []


childTranslator : Child.Translator Msg
childTranslator =
    Child.translator
        { onInternalMessage = ChildMsg
        , onValueSelected = DisplayValue
        }



-- View


view : Model -> Html Msg
view model =
    Options.div
        [ css "margin" "1em"
        , css "border" "2px solid black"
        ]
        [ text "Parent component"
        , Options.div
            [ css "margin" "1em"
            , css "border" "2px solid black"
            ]
            [ Html.map childTranslator (Child.view model.child) ]
        , text model.message
        ]
