module Pages.Item.View exposing (view)

import App.Types exposing (Language)
import Backend.Model exposing (ModelBackend)
import Html exposing (..)
import Html.Attributes exposing (class)
import Pages.Item.Model exposing (Model, Msg(..))


view : Language -> ModelBackend -> Model -> Html Msg
view language modelBackend model =
    div [ class "bg-gray-200 max-w-3xl" ] [ text "Item page" ]
