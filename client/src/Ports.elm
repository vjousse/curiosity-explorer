port module Ports exposing (..)

import Types exposing (Coords, CoordsWithZoom, InitValues, MapInfo)


port sendPositionAndZoom : CoordsWithZoom -> Cmd msg


port sendCurrentLocation : { latitude : Float, longitude : Float, accuracy : Float } -> Cmd msg


port sendInitValues : InitValues -> Cmd msg


port sendZoom : Int -> Cmd msg



-- SUBSCRIPTIONS


port getMapInfo : (MapInfo -> msg) -> Sub msg
