module SeatSaver exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

main =  
  Html.beginnerProgram 
    { model = init
    , update = update
    , view = view
    }

-- MODEL 

type alias Seat = 
  { seatNumber : Int
  , occupied : Bool
  }

type alias Model =
  List Seat

init : Model
init = 
  [ { seatNumber = 1, occupied = False }
  , { seatNumber = 2, occupied = False }
  , { seatNumber = 3, occupied = False }
  , { seatNumber = 4, occupied = False }
  , { seatNumber = 5, occupied = False }
  , { seatNumber = 6, occupied = False }
  , { seatNumber = 7, occupied = False }
  , { seatNumber = 8, occupied = False }
  , { seatNumber = 9, occupied = False }
  , { seatNumber = 10, occupied = False }
  , { seatNumber = 11, occupied = False }
  , { seatNumber = 12, occupied = False }
  ]

-- UPDATE
type Msg = Toggle Seat

update : Msg -> Model -> Model

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
         List.map updateSeat model

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
