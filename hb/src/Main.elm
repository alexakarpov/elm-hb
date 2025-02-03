module Main exposing (main)

import Browser
import Html
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


type alias HBModel =
    { message : String
    , firstname : Maybe String
    , age : Maybe Int
    }


initModel : HBModel
initModel =
    { message = "Welcome"
    , firstname = Nothing
    , age = Nothing
    }


main : Program () HBModel Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }


type Msg
    = MsgSurprise
    | MsgReset
    | MsgNewName String
    | MsgNewAgeAsString String


view : HBModel -> Html.Html Msg
view model =
    Html.div []
        [ Html.text model.message
        , Html.input [ onInput MsgNewName, value (Maybe.withDefault "" model.firstname) ] []
        , Html.input [ onInput MsgNewAgeAsString, value (String.fromInt (Maybe.withDefault 0 model.age)) ] []
        , Html.button [ onClick MsgSurprise ] [ Html.text "Surprise btn" ]
        , Html.button [ onClick MsgReset ] [ Html.text "Reset btn" ]
        , Html.text (String.fromInt (String.length (Maybe.withDefault "" model.firstname)))
        ]


update : Msg -> HBModel -> HBModel
update msg model =
    case msg of
        MsgSurprise ->
            case model.age of
                Just anAge ->
                    case model.firstname of
                        Just aName ->
                            { model
                                | message = "Happy " ++ String.fromInt anAge ++ " birthday " ++ aName
                            }

                        Nothing ->
                            { model
                                | message = "The first name is required"
                            }

                Nothing ->
                    { model
                        | message = "The age is required"
                    }

        MsgReset ->
            initModel

        MsgNewName newName ->
            if String.trim newName == "" then
                { model
                    | firstname = Nothing
                }

            else
                { model
                    | firstname = Just newName
                }

        MsgNewAgeAsString newVal ->
            case String.toInt newVal of
                Just anInt ->
                    { model
                        | age = Just anInt
                    }

                Nothing ->
                    { model
                        | message = "Age is wrong"
                        , age = Nothing
                    }
