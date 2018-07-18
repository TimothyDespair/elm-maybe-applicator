module Maybe.Applicator exposing ( apply )

{-| A tool for mapping "maybes" over function arguments. Basically partially applies
values to a function if they exist or returns nothing if they don't. Can be chained.

Useful for creating records where values may not exist.
@docs apply
-}

{-| Partially apply values if they exist. Can be chained. Useful for creating records:

    type alias Record =
      { x: String
      , y: String
      , z: String
      }
    
    type alias NewRecord =
      { x: Maybe String
      , y: Maybe String
      , z: Maybe String
      }

    newRecord : MaybeRecord -> Maybe Record
    newRecord maybeRecord =
      ( Just maybeRecord )
        |> apply maybeRecord.x
        |> apply maybeRecord.y
        |> apply maybeRecord.z
        
-}
apply : Maybe a -> Maybe ( a -> b ) -> Maybe ( b )
apply arg func =
  case func of
    Just func ->
      case arg of
        Just arg -> Just ( func arg )
        Nothing -> Nothing
    Nothing -> Nothing
