module Model exposing (Model)

import Geolocation exposing (Location)
import Components.MainMap as MainMap
import Types exposing (Item, UiState)


-- MODEL


type alias Model =
    { mainMap : MainMap.Model
    , visibleItems : List Item
    , currentLocation : Maybe Location
    , uiState : UiState
    }
