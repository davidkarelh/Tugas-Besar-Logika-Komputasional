:- include('map.pl').
:- include('Inventory.pl').

/* TO DO : */
% Preventing noncallable rules from being called.
% Habis gugling, nemu pake module gitu, keyword: logtalk
% Tapi belum nyoba juga gann.
% Oiya, ini buat semua file sih, cuma aku bingung harus nulis di mana, jadi ya... hehe :D

/* Deklarasi Fakta */
% TO DO : Tambahin Items dan Equipment di file lain (?)
item(1, egg, 100).
item(2, carrot, 50).
item(3, corn, 30).
equipment(4, 2, shovel, 300).

/* Deklarasi Rules */

market :-
    % TO DO : Validasi posisi
    write('\nWhat do you want to do?'),
    write('\n1. Buy'),
    write('\n2. Sell\n> '),
    read(_X),
    (_X == buy ->
        buy;
        (_X == sell ->
            sell;
            false
        )
    ).

buy :-
    write('\nHere are the list of items and equipments available to buy\n'),
    forall(item(_X, _Y, _Z), (
        write(_X),
        write('. '),
        write(_Y),
        write(' ('),
        write(_Z),
        write(' golds)'),
        write('\n'))),
    forall(equipment(_X, _Y, _Z, _W), (
        write(_X),
        write('. Level '),
        write(_Y),
        write(' '),
        write(_Z),
        write(' ('),
        write(_W),
        write(' golds)'),
        write('\n'))),
    write('\nWhat do you want to buy?\n> '),
    read(_A),
    (_A > 3 -> % TO DO : Edit sesuai banyak item dan equipment
        equipment(_A, _B, _C, _D),
        write('\nHow many do you want to buy?\n> '),
        read(_E),
        % TO DO: Validasi uang dan charged uang
        _F is _E * _D,
        insertItem([_E, _B, _C]),
        write('\nYou have bought '),
        write(_E),
        write(' Level '),
        write(_B),
        write(' '),
        write(_C),
        write('.\n'),
        write('You are charged '),
        write(_F),
        write(' golds.\n');
        item(_A, _B, _C),
        write('\nHow many do you want to buy?\n> '),
        read(_E),
        % TO DO: Validasi uang dan charged uang
        _F is _E * _C,
        insertItem([_E, _B]),
        write('\nYou have bought '),
        write(_E),
        write(' '),
        write(_B),
        write('.\n'),
        write('You are charged '),
        write(_F),
        write(' golds.\n')
    ).

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
            item(_, _Y, _W),
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
    