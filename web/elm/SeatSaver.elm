port module SeatSaver exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import WebSocket

main = Html.programWithFlags
    { init = init
    , update = update
    , view = view
    , subscriptions = always (seatLists UpdateAll) 
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
port seatLists: ( Model -> msg) -> Sub msg 

-- UPDATE
type Msg = Toggle Seat | UpdateAll Model

update : Msg -> Model -> (Model, Cmd Msg)

update msg model =
  case msg of
    Toggle seatToToggle ->
      let
          updateSeat seatFromModel =  
            if seatFromModel.seatNumber == seatToToggle.seatNumber then
               { seatFromModel | occupied = not seatFromModel.occupied } 
               else
               seatFromModel
      in
         (List.map updateSeat model, Cmd.none)
    UpdateAll new_model -> 
      (new_model, Cmd.none)
     

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
        , onClick (Toggle seat)  
        ] [ text (toString seat.seatNumber) ] 

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
   Sub.none
