# Maybe.Applicator

## Update:
I've since found that this exact function exists in Maybe.Extra
along with a bunch of other useful functions. Go check out that
package. I don't know how to unpublish consider this package
more or less a gist of how to use Maybe.Extra.andMap to chain
apply Maybe values to a Record.

A helper function for partially applying "Maybe" values to a function.

I made this because I found myself using a pattern where I was creating
temporary potential records (for forms, usually) like this:

    ```elm
      type alias Record =
        { x : String
        , y : String
        , z : String
        }
      
      type alias NewRecord =
        { x : Maybe String
        , y : Maybe String
        , z : Maybe String
        }
    ```

And then when it came time to submit I'd have a helper function like this:
    ```elm
      createRecordOrNothing : NewRecord -> Maybe Record
      createRecordOrNothing newRecord =
        case
          ( x = newRecord.x
          , y = newRecord.y
          , z = newRecord.z
          )
        of
          ( Just x
          , Just y
          , Just z
          ) -> Just Record x y z
          _ -> Nothing
    ```

Which needless to say is ugly. And fails with records larger than 10 fields.
(`_tuple10 is not defined`)

I figured there had to be a way to do this neatly partially applying arguments
to the record constructors and returning `Nothing` if an invalid parameter
popped up. This is what I came up with, there may be a better solution out there,
I'm new to both Functional Programming and Elm, but I couldn't find a package
or pattern out there like this one so I'm publishing my first ever pacakge for
anything. I'd love some feedback if you stumble across it. Anyway, here's how I
use it, I'm hoping that it comes in handy in this or other circumstances:

    ```elm
      createRecordOrNothing : NewRecord -> Maybe Record
      createRecordOrNothing newRecord =
        ( Just Record )
          |> Maybe.Applicator.apply newRecord.x
          |> Maybe.Applicator.apply newRecord.y
          |> Maybe.Applicator.apply newRecord.z
    ```

I know this could have better tests. If anyone is willing to guide me on that
front I'd be incredibly grateful!
