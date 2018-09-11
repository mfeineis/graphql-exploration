module Book exposing (Book, Response, requestBook)

import Api.Generated.Object
import Api.Generated.Object.Book as BookObject
import Api.Generated.Query as Query
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet, with)


type alias Response =
    { books : List Book
    }


type alias Book =
    { author: Maybe String
    }


requestBook : (Response -> msg) -> Cmd msg
requestBook toMsg =
    query
        |> Graphql.Http.queryRequest "http://localhost:4000/graphql"
        |> Graphql.Http.send
            (\result ->
                 case result of
                     Ok response ->
                         case response.books of
                             Just books ->
                                 toMsg
                                    { books =
                                        List.filterMap identity books
                                    }
                             Nothing ->
                                toMsg
                                    { books = []
                                    }

                     Err _ ->
                         toMsg { books = [] }
            )


type alias InternalResponse =
    { books: Maybe (List (Maybe Book))
    }


query : SelectionSet InternalResponse RootQuery
query =
    Query.selection InternalResponse
        |> with (Query.books queryBook)


queryBook : SelectionSet Book Api.Generated.Object.Book
queryBook =
    BookObject.selection Book
        |> with BookObject.author

