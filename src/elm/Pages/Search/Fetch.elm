module Pages.Search.Fetch exposing (fetch)

import AssocList as Dict exposing (Dict)
import Backend.Model
import Pages.Search.Model exposing (Model)
import PaginatedData
import Time


fetch : String -> Backend.Model.ModelBackend -> Model -> List Backend.Model.Msg
fetch searchUrl modelBackend model =
    []
