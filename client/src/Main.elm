module Main exposing (main)

import Book exposing (Book)
import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Html
import Url exposing (Url)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


type alias Model =
    { books : List Book
    , navKey : Nav.Key
    }


type Msg
    = BooksReceived Book.Response
    | LinkClicked UrlRequest
    | UrlChanged Url


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    ( { books = []
      , navKey = navKey
      }
    , Book.requestBook BooksReceived
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BooksReceived { books } ->
            ( { model | books = books }, Cmd.none )

        LinkClicked (External url) ->
            ( model, Cmd.none )

        LinkClicked (Internal url) ->
            ( model, Cmd.none )

        UrlChanged url ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view _ =
    { title = "Hello - Graphql"
    , body =
        [ Html.text "Hello!"
        ]
    }
