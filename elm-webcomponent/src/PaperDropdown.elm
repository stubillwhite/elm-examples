module PaperDropdown exposing (paperDropdown, paperItem)

import Html exposing (Attribute, Html, node)


paperDropdown : List (Attribute msg) -> List (Html msg) -> Html msg
paperDropdown =
    node "paper-dropdown"


paperItem : List (Attribute msg) -> List (Html msg) -> Html msg
paperItem =
    node "paper-item"
