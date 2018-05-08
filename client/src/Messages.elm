module Messages exposing (Msg(..))

import Geolocation exposing (Location)
import Components.MainMap as MainMap
import Types exposing (MapInfo)


type Msg
    = NoOp
    | MMap MainMap.Msg
    | MapFromJs MapInfo
    | GetLocation (Result Geolocation.Error Location)
    | ToggleMenu
    | LogoClicked
