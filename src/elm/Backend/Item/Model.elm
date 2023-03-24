module Backend.Item.Model exposing
    ( Item
    , ItemDict
    , ItemsDict
    , Msg(..)
    )

import AssocList exposing (Dict)
import Backend.Entities exposing (ItemId, ItemUuid)
import Editable.WebData exposing (EditableWebData)
import PaginatedData exposing (ContainerDict)
import RemoteData exposing (WebData)


type alias Item =
    { id : ItemId
    , uuid : ItemUuid
    , name : String
    }


type alias ItemDict =
    Dict ItemId Item


{-| We key by a tuple where the User Uuid is a `Maybe`, allowing us to re-use
this data structure for a general view over all the Sale's Bids.
-}
type alias ItemsDict =
    ContainerDict String ItemUuid (EditableWebData Item)


type alias PageNumber =
    Int


type alias TotalCount =
    Int


type Msg
    = Fetch String PageNumber
    | HandleFetch String PageNumber (WebData ( Dict ItemId Item, TotalCount ))
