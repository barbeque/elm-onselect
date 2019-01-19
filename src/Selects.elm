module Selects exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (value)

import Html.Events exposing (..)
import Json.Decode as JD

{-| Send an event in an Edge- and IE-compatible way
as soon as the selection on a 'select' element has changed.
Do not use onInput with selects, it doesn't work in IE/Edge.
    select
        [ onSelect (filterTextEvent "Status") ]
        [ option [ value "neutral" ] [ text "Neutral" ]
        , option [ value "ok" ] [ text "Okay" ]
        , option [ value "bad" ] [ text "Poor" ]
        ]
-}
onSelect : (String -> msg) -> Html.Attribute msg
onSelect msg =
  let
    targetValueParse = JD.at [ "target", "value" ] JD.string
  in
    on "change" (JD.map msg targetValueParse)

type alias Model =
  { selectedItem : String
  }

type Msg
  = ChangeSelection String

type alias Flags =
  {}

init : Flags -> (Model, Cmd Msg)
init _ = ({ selectedItem = "" }, Cmd.none)

view : Model -> Html Msg
view model =
  div
    []
    [ select
      [ onSelect (ChangeSelection) ]
      [ option [ value "karl" ] [ text "Karlos" ]
      , option [ value "elric" ] [ text "Elric" ]
      , option [ value "qbert" ] [ text "Q-Bert" ]
      ]
    , text ("Your choice is " ++ model.selectedItem)
    ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
      ChangeSelection q ->
        ({ model | selectedItem = q }, Cmd.none)

main = Browser.element
  { init = init
  , subscriptions = \_ -> Sub.none
  , view = view
  , update = update
  }
