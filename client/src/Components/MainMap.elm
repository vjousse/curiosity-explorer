module Components.MainMap exposing (Model, Msg(MapInfoMsg), init, update, view, subscriptions)

import Html exposing (Html, div, text, h1, h2, p)
import Html.Attributes exposing (id, style)
import Html.Events exposing (onClick)
import Types exposing (Coords, CoordsWithZoom, MapBounds, MapInfo)


-- MODEL


type alias Model =
    { position : Coords
    , zoom : Int
    , title : String
    , info : MapInfo
    , cssId : String
    }


type Msg
    = NoOp
    | MapInfoMsg MapInfo


init : Model
init =
    let
        initialPosition =
            { lat = 48.00917, lng = 0.19462 }

        initialZoom =
            16
    in
        { position = initialPosition
        , zoom = initialZoom
        , title = "test"
        , info =
            { southWest = Coords 0.0 0.0
            , northEast = Coords 0.0 0.0
            }
        , cssId = "main-map"
        }



--            ! [ positionAndZoom { c = initialPosition, zoom = initialZoom } ]
-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapInfoMsg newInfo ->
            ( { model | info = newInfo }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ id "map-wrapper" ]
        [ div [ id model.cssId ] []
        , h2 [] [ text "South west" ]
        , p [] [ text (toString model.info.southWest.lat) ]
        , p [] [ text (toString model.info.southWest.lng) ]
        , h2 [] [ text "North east" ]
        , p [] [ text (toString model.info.northEast.lat) ]
        , p [] [ text (toString model.info.northEast.lng) ]
        ]
