module SeatSaver exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Http
import Json.Decode exposing (..)

main = Html.program
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

init : (Model, Cmd Msg)
init = 
  ([], fetchSeats)

fetchSeats : Cmd Msg
fetchSeats = 
  let
    url = "http://localhost:4000/api/seats"
    request = Http.get url decodeResponse
  in
    Http.send FetchedSeats request 

decodeResponse : Decoder Model 
decodeResponse =
  let 
    seat = 
      map2 Seat (field "seatNumber" int) (field "occupied" bool)    
  in
    at ["data"] (list seat) 

-- UPDATE
type Msg = Toggle Seat | FetchedSeats (Result Http.Error Model)

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
    FetchedSeats (Ok new_model) ->
      (new_model, Cmd.none)
    FetchedSeats (Err _) ->
      (model, Cmd.none)

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
