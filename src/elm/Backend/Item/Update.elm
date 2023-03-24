module Backend.Item.Update exposing (update)

import AssocList as Dict exposing (Dict)
import Backend.Item.Model exposing (Msg(..))
import Backend.Model exposing (ModelBackend)
import Backend.Types exposing (BackendReturn)
import Backend.Utils exposing (dictInsertAfter)
import Editable.WebData
import Error.Utils exposing (maybeHttpError, noError)
import PaginatedData
import RemoteData exposing (RemoteData(..))
import Restful.Endpoint exposing (toEntityUuid)


update : String -> Msg -> ModelBackend -> BackendReturn Msg
update searchUrl msg model =
    let
        noChange =
            BackendReturn model Cmd.none noError []
    in
    case msg of
        Fetch searchString pageNumber ->
            let
                existingFetched =
                    Dict.get searchString model.items
                        |> Maybe.withDefault RemoteData.Loading

                updatedFetched =
                    Dict.insert searchString existingFetched model.items

                modelSetLoading modelFunc =
                    modelFunc model updatedFetched

                modelUpdated =
                    modelSetLoading (\model_ dict -> { model_ | items = PaginatedData.setPageAsLoading searchString pageNumber dict })

                cmd =
                    Cmd.none

                --HttpBuilder.get (searchUrl)
                --    |> withQueryParams [ ( "include", includes ) ]
                --    |> withExpectJson decode
                --    |> HttpBuilder.send (RemoteData.fromResult >> HandleFetchStory uuid)
            in
            BackendReturn
                modelUpdated
                cmd
                noError
                []

        HandleFetch searchString pageNumber webData ->
            let
                updated =
                    PaginatedData.insertMultiple
                        searchString
                        pageNumber
                        webData
                        (toEntityUuid << String.fromInt)
                        (\( _, item ) -> Just item.uuid)
                        -- Insert first.
                        (\_ item accum -> Dict.insert item.uuid (Editable.WebData.create item) accum)
                        -- Insert after.
                        (\_ item ( previousItemLastId, accum ) -> ( previousItemLastId, dictInsertAfter previousItemLastId item.uuid (Editable.WebData.create item) accum ))
                        model.items
            in
            BackendReturn
                { model | items = updated }
                Cmd.none
                (maybeHttpError webData "Backend.Update" "HandleFetchItems")
                []
