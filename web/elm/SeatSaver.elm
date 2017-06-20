module SeatSaver exposing (..)

import Html exposing (ul, li, text)
import Html.Attributes exposing (class)

main =  
  view init

-- MODEL 

type alias Seat = 
  { seatNumber : Int
  , occupied : Bool
  }

type alias Model =
  List Seat

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


-- VIEW
view model  = 
  ul [ class "seats" ] (List.map seatItem model) 

seatItem seat = 
  li [ class "seat available" ] [ text (toString seat.seatNumber) ] 
