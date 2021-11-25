/* Deklarasi Fakta */
:-dynamic(inventory_list/1).
inventory_list([]).

/* Deklarasi Rules */
inventory :- 
    inventory_list(_X),
    totalItem(_X, _Y),
    write('\nYour inventory ('),
    write(_Y),
    write(' / 100)\n'), !,
    displayList(_X).

throwItem :-
    inventory_list(_X),
    len(_X, _CHECKEMPTY),
    (_CHECKEMPTY == 0 ->
        write('\nYou don\'t have any items to throw!\n');
        write('\nYour inventory\n'),
        displayList(_X),
        write('\nWhat do you want to throw?\n> '),
        read(_Z),
        _Item2 = [_, _Z],
        _Item3 = [_, _, _Z],
        ((searchInventory(_X, _Item2, _, _)); searchInventoryName(_X, _Item3, _, _)),
        (searchInventory(_X, _Item2, _Element, _Index) -> 
            write('\nYou have '),
            _Element = [_C, _D],
            displayItem(_Element),    
            write('. How many do you want to throw?\n> '),
            read(_W),
            (_W > _C -> 
                !, write('\nYou don’t have enough '),
                write(_Z),
                write('. Cancelling…\n'),
                Output = _X;
                deleteAt(_X, _Index, _Y),
                (_W == _C ->
                    Output = _Y;
                    _Temp is _C - _W,
                    _El = [_Temp, _D],
                    insertAt(_Y, _El, _Index, Output)),
                write('\nYou threw away '),
                write(_W),
                write(' '),
                write(_Z),
                write('.\n'));
            write('\nLevel?\n> '),
            read(_Level),
            _Item3N = [_, _Level, _Z],
            searchInventory(_X, _Item3N, _ElementN, _IndexN),
            _ElementN = [_C, _, _],
            write('\nYou have '),
            displayItem(_ElementN),
            write('. How many do you want to throw?\n> '),
            read(_W),
            (_W > _C -> 
                write('\nYou don’t have enough Level'),
                write(_Level),
                write(' '),
                write(_Z),
                write('. Cancelling…\n'),
                Output = _X;
                deleteAt(_X, _Index, _Y),
                (_W == _C ->
                    Output = _Y;
                    _Temp is _C - _W,
                    _El = [_Temp, _D],
                    insertAt(_Y, _El, _Index, Output)),
                write('\nYou threw away '),
                write(_W),
                write(' Level '),
                write(_Level),
                write(' '),
                write(_Z),
                write('.\n'))),
        retractall(inventory_list(_)),
        asserta(inventory_list(Output))
    ).

insertItem(_Item) :-
    inventory_list(_X),
    len(_Item, _N),
    (_N == 3 ->
        _Item = [_Plus, _, _];
        _Item = [_Plus, _]),
    totalItem(_X, _Total),
    _Total + _Plus < 100,
    (searchInventory(_X, _Item, _Element, _Index) -> 
        deleteAt(_X, _Index, _Temp),
        (_N == 3 -> 
            _Element = [_A, _C, _B],
            _D is _A + _Plus,
            _New = [_D, _C, _B];
            _Element = [_A, _B],
            _D is _A + _Plus,
            _New = [_D, _B]),
        insertAt(_Temp, _New, _Index, Output);
        (_N == 3 -> 
            insertEquipment(_X, _Item, Output);
            insertLast(_X, _Item, Output))),
    retractall(inventory_list(_)),
    asserta(inventory_list(Output)).

deleteItem(_Item) :-
    inventory_list(_X),
    searchInventory(_X, _Item, _Element, _Index),
    deleteAt(_X, _Index, Output),
    retractall(inventory_list(_)),
    asserta(inventory_list(Output)).

totalItem([], N) :- N is 0.
totalItem([_X | _Y], N) :-
    totalItem(_Y, Nn),
    _X = [_Z | _],
    N is Nn + _Z.

len([], N) :- N is 0.
len([_ | _Y], N) :- 
    len(_Y, _Nn), 
    N is _Nn + 1.

displayList([]).
displayList([_X | _Y]) :-
    displayItem(_X),
    write('\n'),
    displayList(_Y).

displayItem(_X) :-
    len(_X, _N),
    (_N == 3 ->
        _X = [_A, _B, _C], 
        write(_A),
        write(' Level '),
        write(_B),
        write(' '),
        write(_C);
        _X = [_A, _B],
        write(_A),
        write(' '),
        write(_B)).

searchInventory([_X | _Y], _Item, Element, Index) :-
    len(_X, _NInventory),
    len(_X, _NItem),
    _NItem == _NInventory,
    (_NItem == 3 -> 
        _X = [_, _InvenLevel, _InvenName],
        _Item = [_, _ItemLevel, _ItemName],
        _InvenLevel == _ItemLevel;
        _X = [_, _InvenName],
        _Item = [_, _ItemName]),
    _ItemName == _InvenName, !,
    Element = _X,
    Index is 1.
searchInventory([_X | _Y], _Item, Element, Index) :- 
    searchInventory(_Y, _Item, Element, IndexN),
    Index is IndexN + 1.

searchInventoryName([_X | _Y], _Item, Element, Index) :-
    len(_X, _NInventory),
    len(_X, _NItem),
    _NItem == _NInventory,
    (_NItem == 3 -> 
        _X = [_, _InvenLevel, _InvenName],
        _Item = [_, _ItemLevel, _ItemName];
        _X = [_, _InvenName],
        _Item = [_, _ItemName]),
    _ItemName == _InvenName, !,
    Element = _X,
    Index is 1.
searchInventoryName([_X | _Y], _Item, Element, Index) :- 
    searchInventory(_Y, _Item, Element, IndexN),
    Index is IndexN + 1.

insertAt(Xs, Element, 1, [Element | Xs]) :- !.
insertAt([X | Xs], Element, Position, [X | Result]) :- 
    PositionN is Position - 1, 
    insertAt(Xs, Element, PositionN, Result).

deleteAt([_ | Xs], 1, Xs) :- !.
deleteAt([X | Xs], Position, [X | Result]) :- 
    PositionN is Position - 1, 
    deleteAt(Xs, PositionN, Result).


insertLast([], Item, [Item]).
insertLast([_X | _Y], Item, [_X | L]) :- insertLast(_Y, Item, L).

indexInsertEquipment([], Count) :-
    Count is 1.
indexInsertEquipment([_X | _Y], Count) :-
    len(_X, _N),
    _N == 2, 
    !, Count is 1.
indexInsertEquipment([_X | _Y], Count) :- 
    indexInsertEquipment(_Y, CountN),
    Count is CountN + 1.

insertEquipment(_X, Equipment, A)   :-
    indexInsertEquipment(_X, _Count),
    insertAt(_X, Equipment, _Count, A).