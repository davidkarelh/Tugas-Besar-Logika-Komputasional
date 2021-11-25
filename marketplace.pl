:- include('map.pl').
:- include('Inventory.pl').

/* TO DO : */
% Preventing noncallable rules from being called.
% Habis gugling, nemu pake module gitu, keyword: logtalk
% Tapi belum nyoba juga gann.
% Oiya, ini buat semua file sih, cuma aku bingung harus nulis di mana, jadi ya... hehe :D

/* Deklarasi Fakta */
% TO DO : Tambahin Items dan Equipment di file lain (?)
item(egg, 100).
item(carrot, 50).
item(corn, 30).

/* Deklarasi Rules */

market.

buy.

sell :-
    inventory_list(_X),
    lenItemOnly(_X, _N),
    (_N == 0 -> 
        write('\nYou don\'t have any items to sell!\n');
        write('\nHere are the items in your inventory\n'),
        displayListItemOnly(_X),
        write('\nWhat do you want to sell?\n> '),
        read(_Y),
        write('\n'),
        searchInventory(_X, [_, _Y], _Element, _Index),
        write('How many do you want to sell?\n> '),
        read(_Z),
        write('\n'),
        _Element = [_A, _],
        (_Z > _A -> 
            write('You don\'t have enough items to sell!\n');
            deleteAt(_X, _Index, _O),
            (_A == _Z ->
                Output = _O;
                _Temp is _A - _Z,
                _El = [_Temp, _Y],
                insertAt(_O, _El, _Index, Output)),
            write('You sold '),
            write(_Z),
            write(' '),
            write(_Y),
            write('.\n'),
            write('You received '),
            item(_Y, _W),
            _V is _W * _Z,
            % TO DO : Tambahin uang player
            write(_V),
            write(' golds.'),
            retractall(inventory_list(_)),
            asserta(inventory_list(Output))
        ),
        write('\n'),
        sell
    ).

displayListItemOnly([]).
displayListItemOnly([_X | _Y]) :-
    len(_X, _N),
    (_N == 3 ->
        true;
        _X = [_A, _B],
        write('- '),
        write(_A),
        write(' '),
        write(_B),
        write('\n')),
    displayListItemOnly(_Y).

lenItemOnly([], N) :- N is 0.
lenItemOnly([_X | _Y], N) :- 
    len(_X, _NX),
    (_NX == 3 ->
        lenItemOnly(_Y, _Nn), 
        N is _Nn;
        lenItemOnly(_Y, _Nn), 
        N is _Nn + 1
    ).
    