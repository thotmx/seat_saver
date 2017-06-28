port module SeatSaver exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import WebSocket
import Debug exposing (log)

main = Html.programWithFlags
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

-- MODEL 

type alias Seat = 
  { seatNumber : Int
  , occupied : Bool
  }

type alias Model =
  List Seat

init : { seatLists: Model } -> (Model, Cmd Msg)
init flags = 
  (flags.seatLists, Cmd.none)

-- SIGNALS
port seatLists: (Model -> msg) -> Sub msg 

port seatRequests : Seat -> Cmd msg

port seatUpdates: (Seat -> msg) -> Sub msg

-- UPDATE
type Msg = Toggle Seat | UpdateAll Model | ToggleSeat Seat

update : Msg -> Model -> (Model, Cmd Msg)

update msg model =
  case msg of
    Toggle seatToToggle ->
      let
        updateSeat seatFromModel = 
          if seatFromModel.seatNumber == seatToToggle.seatNumber then
             { seatFromModel | occupied = seatToToggle.occupied } 
          else seatFromModel 
      in
         (List.map updateSeat model, Cmd.none)
    UpdateAll new_model -> 
      (new_model, Cmd.none)
    ToggleSeat seat ->
      (model, seatRequests(seat))

-- VIEW
view : Model -> Html Msg 
view model  = 
  ul [ class "seats" ] (List.map seatItem model) 

seatItem : Seat -> Html Msg 
seatItem seat = 
  let 
      occupiedClass = 
        if seat.occupied then "occupied" else "available"
  in
     li [ class ("seat " ++ occupiedClass)
        , onClick (ToggleSeat seat)  
        ] [ text (toString seat.seatNumber) ] 

updateSeat : Seat -> Msg
updateSeat seat =
  Toggle seat

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ seatLists UpdateAll
            , seatUpdates Toggle ] 
