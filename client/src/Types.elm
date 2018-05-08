module Types exposing (..)

import Geolocation


type alias Coords =
    { lat : Float, lng : Float }


type alias CoordsWithZoom =
    { c : Coords, zoom : Int }


type alias MapBounds =
    { southWest : Coords, northEast : Coords }


type alias MapInfo =
    { southWest : Coords
    , northEast : Coords
    }


type alias InitValues =
    { coordsWithZoom : CoordsWithZoom
    , cssId : String
    }


type alias Item =
    { coords : Coords
    , title : String
    , description : String
    }


type alias UiState =
    { menuOpened : Bool }


locationToCoords : Geolocation.Location -> Coords
locationToCoords location =
    { lat = location.latitude, lng = location.longitude }
