module Layout exposing (..)

import Html exposing (Html, a, button, div, form, i, img, input, li, nav, small, span, text, ul)
import Html.Attributes exposing (alt, attribute, class, id, href, placeholder, src, type_, style)
import Html.Events exposing (onClick)
import Svg exposing (path, svg)
import Svg.Attributes exposing (d, fill, height, viewBox, width)
import Model exposing (Model)
import Messages exposing (Msg(..))
import Html exposing (Html)
import Components.MainMap as MainMap
import Icons


asideView : Model -> Html Msg
asideView model =
    div
        [ id "aside"
        , class
            ("app-aside modal fade md folded show-text nav-dropdown"
                ++ (if model.uiState.menuOpened then
                        " in"
                    else
                        ""
                   )
            )
        , style
            (if model.uiState.menuOpened then
                [ ( "display", "block" ) ]
             else
                []
            )
        ]
        [ div [ class "left navside black dk", onClick LogoClicked ]
            [ div [ class "navbar no-radius" ]
                [ a [ class "navbar-brand" ]
                    [ img [ src "assets/images/logo.png" ] []
                    , span [ class "hidden-folded inline" ] [ text "MapX" ]
                    ]
                ]
            , div [ class "hide-scroll", attribute "flex" "" ]
                [ nav [ class "scroll nav-light" ]
                    [ ul [ class "nav" ]
                        [ li [ class "nav-header hidden-folded" ] [ small [ class "text-muted" ] [ text "Sights" ] ]
                        , li []
                            [ a [ href "#" ]
                                [ span [ class "nav-icon" ] [ Icons.locationIcon ]
                                , span [ class "nav-text" ] [ text "Discover" ]
                                ]
                            ]
                        , li []
                            [ a [ href "#" ]
                                [ span [ class "nav-icon" ] [ Icons.mapIcon ]
                                , span [ class "nav-text" ] [ text "Prepare" ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


contentView : Model -> Html Msg
contentView model =
    div [ id "content", class "app-content box-shadow-z3" ]
        [ div [ class "app-header white box-shadow" ]
            [ div [ class "navbar" ]
                [ a [ class "navbar-item pull-left hidden-lg-up", onClick ToggleMenu ]
                    [ i [ class "material-icons" ] [ text "\xE5D2" ] ]
                , ul [ class "nav navbar-nav pull-right" ]
                    [ li [ class "nav-item dropdown pos-stc-xs" ]
                        [ a [ class "nav-link" ]
                            [ i [ class "material-icons" ] [ text "\xE7F5" ]
                            , span [ class "label label-sm up warn" ] [ text "3" ]
                            ]
                        ]
                    , li [ class "nav-item dropdown" ]
                        [ a [ class "nav-link clear", attribute "aria-expanded" "false" ]
                            [ span [ class "avatar w-32" ]
                                [ img [ src "assets/images/a0.jpg", alt "..." ] []
                                , i [ class "on b-white bottom" ] []
                                ]
                            ]
                        ]
                    ]
                , div [ class "collapse navbar-toggleable-sm" ]
                    [ form [ class "navbar-form form-inline pull-right pull-none-sm navbar-item v-m", attribute "role" "search" ]
                        [ div [ class "form-group l-h m-a-0" ]
                            [ div [ class "input-group input-group-sm" ]
                                [ input [ type_ "text", class "form-control p-x b-a rounded", placeholder "Search locations…" ] []
                                , span [ class "input-group-btn" ]
                                    [ button [ type_ "submit", class "btn white b-a rounded no-shadow" ]
                                        [ i [ class "fa fa-search" ] [] ]
                                    ]
                                ]
                            ]
                        ]
                    , ul [ class "nav navbar-nav" ]
                        [ li [ class "nav-item dropdown" ]
                            [ a [ class "nav-link", href "" ]
                                [ i [ class "fa fa-fw fa-plus text-muted" ] []
                                , span [] [ text " New" ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        , div [ class "app-body", id "view" ]
            [ Html.map MMap (MainMap.view model.mainMap)
            ]
        ]
