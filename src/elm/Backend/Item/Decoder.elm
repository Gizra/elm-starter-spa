module Backend.Item.Decoder exposing (decodeItem)

import Backend.Item.Model exposing (Item)
import Json.Decode exposing (Decoder, string, succeed)
import Json.Decode.Pipeline exposing (required)
import Restful.Endpoint exposing (decodeEntityId, decodeEntityUuid)


decodeItem : Decoder Item
decodeItem =
    succeed Item
        |> required "id" decodeEntityId
        |> required "uuid" decodeEntityUuid
        |> required "label" string
