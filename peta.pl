/* Map Info */
:- dynamic(player_position/2).
:- dynamic(quest_position/2).
:- dynamic(ranch_position/2).
:- dynamic(house_position/2).
:- dynamic(market_position/2).

:-dynamic(map_display/1).

/* Divisor write */
writeline :-
    write('============================================================================\n').
writeline2 :-
    write('----------------------------------------------------------------------------\n').
writeclearspace :-
    write('\n\n\n\n\n\n\n\n\n\n\n\n').
writeclearspacemore :-
    write('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n').
writeclearspacemorenline :-
    write('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n============================================================================\n').

/* Relation positioning in the matrix */
matrix(Matrix, I, J, Value) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Value).

/* Rules to display the matrix*/
writeMatrix(Matrix) :-
    between(0, 18, I),
    findall(Value, matrix(Matrix, I, _, Value), Row),
    writeRow(Row), nl,
    fail.
writeMatrix(_).

writeRow( [] ) :- !.
writeRow( [Head | Tail] ) :- write(Head), write(' '), writeRow(Tail).

/* Set the initial map */
initMap :-
    asserta(map_display(
      [ 
        ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', 'Q', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', 'R', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', 'H', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', 'P', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', 'o', 'o', 'o', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', 'o', 'o', 'o', 'o', 'o', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', 'o', 'o', 'o', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', 'M', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '#'],
        ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#']
      ] ) ),

    asserta(player_position(8, 7) ),
    asserta(quest_position(7, 3) ),
    asserta(ranch_position(10,5) ),
    asserta(house_position(7, 6) ),
    asserta(market_position(10, 12) ). 

/* Map function */
onlyshowmap:-
    writeclearspacemore,
    show_map.

show_map :-
    (map_display(MapNow)
        -> (checkPosition,
            writeline,
            writeMatrix(MapNow),nl,
            writeline,
            writeline2)
    ; map_none_msg).

map_none_msg :-
    write('its in void').

/* Check Player is where */
checkPosition :-
    /* Global Variables */
    player_position(XPlayer, YPlayer),
    quest_position(XQuest, YQuest),
    ranch_position(XRanch, YRanch),
    house_position(XHouse, YHouse),
    market_position(XMarket, YMarket).

encounterInMap :-
    /* Global Variables */
    player_position(XPlayer, YPlayer),
    quest_position(XQuest, YQuest),
    ranch_position(XRanch, YRanch),
    house_position(XHouse, YHouse),
    market_position(XMarket, YMarket).

/* Player movement */
w :- 
    ( (map_display(Map) )
        ->
        (   player_position(Xnow, Ynow),

            Ytemp is Ynow - 1,

            ( (matrix(Map, Ytemp, Xnow, '#'))
                -> (Ymove is Ynow), write('Tidak bisa keluar dari perkebunan\n')
                ; Ymove is Ynow - 1),

            ( (matrix(Map, Ytemp, Xnow, 'o'))
                -> (Ymove is Ynow), write('Tidak ada waktu untuk bermain-main dengan air\n')
                ; Ymove is Ynow - 1),

            retract(player_position(_, _) ),
            asserta(player_position(Xnow, Ymove) ),

            updateMap
        )
        ; map_none_msg), !. 

a :- 
    ( (map_display(Map) )
        ->
        (   player_position(Xnow, Ynow),

            Xtemp is Xnow - 1,

            ( (matrix(Map, Ynow, Xtemp, '#'))
                -> (Xmove is Xnow), write('Tidak bisa keluar dari perkebunan\n')
                ; Xmove is Xnow - 1),

            ( (matrix(Map, Ynow, Xtemp, 'o'))
                -> (Xmove is Xnow), write('Tidak ada waktu untuk bermain-main dengan air\n')
                ; Xmove is Xnow - 1),

            retract(player_position(_, _) ),
            asserta(player_position(Xmove, Ynow) ),

            updateMap
        )
        ; map_none_msg), !. 

s :- 
    ( (map_display(Map) )
        ->
        (   player_position(Xnow, Ynow),

            Ytemp is Ynow + 1,

            ( (matrix(Map, Ytemp, Xnow, '#') )
                -> (Ymove is Ynow), write('Tidak bisa keluar dari perkebunan\n')
                ; Ymove is Ynow + 1),

            ( (matrix(Map, Ytemp, Xnow, 'o') )
                -> (Ymove is Ynow), write('Tidak ada waktu untuk bermain-main dengan air\n')
                ; Ymove is Ynow + 1),

            retract(player_position(_, _) ),
            asserta(player_position(Xnow, Ymove) ),

            updateMap
            
        )
        ; map_none_msg), !.

d :- 
    ( (map_display(Map) )
        ->
        (   player_position(Xnow, Ynow),

            Xtemp is Xnow + 1,

            ( (matrix(Map, Ynow, Xtemp, '#') )
                -> (Xmove is Xnow), write('Tidak bisa keluar dari perkebunan\n')
                ; Xmove is Xnow + 1
            ),

            ( (matrix(Map, Ynow, Xtemp, 'o') )
                -> (Xmove is Xnow), write('Tidak ada waktu untuk bermain-main dengan air\n')
                ; Xmove is Xnow + 1
            ),

            retract(player_position(_, _) ),
            asserta(player_position(Xmove, Ynow) ),

            updateMap
            
        )
        ; map_none_msg), !. 
    
/* Update Map */
updateMap :-
    /* Getting the global variables */
    map_display(MapNow),
    player_position(XPlayer, YPlayer),
    quest_position(XQuest, YQuest),
    ranch_position(XRanch, YRanch),
    house_position(XHouse, YHouse),
    market_position(XMarket, YMarket),
    
    checkPosition,

    matrix(MapNow, I, J, 'P'),
    replaceMatrix(MapNow, I, J, '-', MapChanged),
    replaceMatrix(MapChanged, YQuest, XQuest, 'Q', Matrix1),
    replaceMatrix(Matrix1, YRanch, XRanch, 'R', Matrix2),
    replaceMatrix(Matrix2, YHouse, XHouse, 'H', Matrix3),
    replaceMatrix(Matrix3, YMarket, XMarket, 'M', Matrix4),
    replaceMatrix(Matrix4, YPlayer, XPlayer, 'P', NewerMatrix),
    
    retract(map_display(_) ),
    asserta(map_display(NewerMatrix) ).

replaceList( [_ | Tail], 0, X, [X | Tail] ).
replaceList( [Head | Tail], J, X, [Head | Replaced] ):- J > -1, NewJ is J-1, replaceList(Tail, NewJ, X, Replaced), !.
replaceList(Row, _, _, Row).

replaceMatrix(Matrix, I, J, NewValue, Result) :-
    findall(Value, matrix(Matrix, I, _, Value), Row),
    replaceList(Row, J, NewValue, ResRow),
    replaceList(Matrix, I, ResRow, Result), !.
