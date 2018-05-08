port module Main exposing (..)

import Geolocation
import Html exposing (Html, div, text, h1, h2, p)
import Html.Attributes exposing (id, class)
import Html.Events exposing (onClick)
import Task
import Types exposing (CoordsWithZoom, MapInfo)
import Components.MainMap as MainMap
import Ports exposing (sendInitValues)
import Layout
import Messages exposing (Msg(..))
import Model exposing (Model)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    let
        mainMapModel =
            MainMap.init
    in
        { mainMap = mainMapModel
        , visibleItems = []
        , currentLocation = Nothing
        , uiState = { menuOpened = False }
        }
            ! [ sendInitValues
                    { cssId = mainMapModel.cssId
                    , coordsWithZoom = { c = mainMapModel.position, zoom = mainMapModel.zoom }
                    }
              , askCurrentLocation
              ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MMap msg ->
            let
                ( aMap, aMapCmds ) =
                    MainMap.update msg model.mainMap
            in
                ( { model | mainMap = aMap }
                , Cmd.map MMap aMapCmds
                )

        MapFromJs mapInfo ->
            let
                ( aMap, aMapCmds ) =
                    MainMap.update (MainMap.MapInfoMsg mapInfo) model.mainMap
            in
                ( { model | mainMap = aMap }
                , Cmd.map MMap aMapCmds
                )

        ToggleMenu ->
            let
                {- Hack for https://github.com/elm-lang/elm-compiler/issues/1325 -}
                oldUiState =
                    model.uiState

                newMenuOpened =
                    if oldUiState.menuOpened then
                        False
                    else
                        True
            in
                ( { model | uiState = { oldUiState | menuOpened = newMenuOpened } }, Cmd.none )

        LogoClicked ->
            if model.uiState.menuOpened then
                ( model, Task.perform identity (Task.succeed ToggleMenu) )
            else
                ( model, Cmd.none )

        GetLocation (Ok location) ->
            { model | currentLocation = Just location }
                ! [ Ports.sendCurrentLocation
                        { latitude = location.latitude
                        , longitude = location.longitude
                        , accuracy = location.accuracy
                        }
                  ]

        GetLocation (Err error) ->
            let
                test =
                    Debug.log "location failed" error
            in
                ( { model | currentLocation = Nothing }, Cmd.none )

        _ ->
            ( model, Cmd.none )


askCurrentLocation : Cmd Msg
askCurrentLocation =
    Task.attempt GetLocation (Geolocation.now)



--subscriptions : Model -> Sub Msg
--subscriptions model =
--    mapInfo MapInfoMsg
-- For multiple ports
-- subscriptions = Sub.batch [ portthing1 Msg1, portthing2 Msg2 ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map MMap (MainMap.subscriptions model.mainMap)
        , Ports.getMapInfo MapFromJs
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ id "main"
        , class
            (if model.uiState.menuOpened then
                "modal-open"
             else
                ""
            )
        ]
        [ div [ class "app", id "app" ]
            [ Layout.asideView model
            , Layout.contentView model
            ]
        ]
