module Main exposing (main)

import Browser
import Html
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


type alias HBModel =
    { message : String
    , firstname : String
    , age : Int
    }


initModel : HBModel
initModel =
    { message = "Welcome"
    , firstname = ""
    , age = 42
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
        , Html.input [ onInput MsgNewName, value model.firstname ] []
        , Html.input [ onInput MsgNewAgeAsString, value (String.fromInt model.age) ] []
        , Html.button [ onClick MsgSurprise ] [ Html.text "Surprise btn" ]
        , Html.button [ onClick MsgReset ] [ Html.text "Reset btn" ]
        , Html.text (String.fromInt (String.length model.firstname))
        ]


update : Msg -> HBModel -> HBModel
update msg model =
    case msg of
        MsgSurprise ->
            { model
                | message = "Happy " ++ String.fromInt model.age ++ " birthday " ++ model.firstname
            }

        MsgReset ->
            initModel

        MsgNewName newName ->
            { model
                | firstname = newName
            }

        MsgNewAgeAsString newVal ->
            case String.toInt newVal of
                Just anInt ->
                    { model
                        | age = anInt
                    }

                Nothing ->
                    { model
                        | message = "Age is wrong"
                        , age = 0
                    }
