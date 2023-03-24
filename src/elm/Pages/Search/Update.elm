module Pages.Search.Update exposing (update)

import App.Model exposing (PagesReturn)
import Backend.Item.Model
import Backend.Model
import Error.Utils exposing (noError)
import Pages.Search.Model exposing (Model, Msg(..))


update : Msg -> Model -> PagesReturn Model Msg
update msg model =
    let
        noChange =
            PagesReturn
                model
                Cmd.none
                noError
                []
    in
    case msg of
        Fetch ->
            PagesReturn model
                Cmd.none
                noError
                [ Backend.Item.Model.Fetch model.searchString 1
                    |> Backend.Model.MsgItem
                    |> App.Model.MsgBackend
                ]
