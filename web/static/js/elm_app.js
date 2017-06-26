let elmDiv = document.getElementById('elm-main')
let initialState = { seatLists: [] } 
let elmapp = Elm.SeatSaver.embed(elmDiv, initialState)

export default elmapp


