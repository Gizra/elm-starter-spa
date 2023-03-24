module Pages.Search.Model exposing
    ( Model
    , Msg(..)
    , emptyModel
    )


type alias Model =
    { searchString : String
    }


emptyModel : Model
emptyModel =
    { searchString = ""
    }


type Msg
    = Fetch
