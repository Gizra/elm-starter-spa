module Pages.Search.View exposing (view)

import App.Types exposing (Language(..))
import Backend.Model exposing (ModelBackend)
import Html exposing (..)
import Pages.Search.Model exposing (Model, Msg(..))


view : Language -> ModelBackend -> Model -> Html Msg
view language modelBackend model =
    div [] [ text "Pages.Search" ]
