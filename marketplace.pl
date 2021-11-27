:- include('map.pl').
:- include('Inventory.pl').
:- include('ranching.pl').

/* Deklarasi Fakta */


/* Deklarasi Rules */

market(Gold, GoldOut) :-
    % TO DO : Validasi posisi
    write('\nWhat do you want to do?'),
    write('\n1. Buy'),
    write('\n2. Sell\n> '),
    read(_X),
    (_X == buy ->
        buy(Gold, GoldOut);
    _X == sell ->
        sell(Gold, GoldOut)
    ).

buy(Gold, GoldOut) :-
    write('\nHere are the list of items and equipments available to buy\n'),
    write(' 1. Carrot seed         |    50 golds\n'),
    write(' 2. Potato seed         |    75 golds\n'),
    write(' 3. Wheat seed          |   100 golds\n'),
    write(' 4. Melon seed          |   150 golds\n'),
    write(' 5. Pumpukin seed       |   250 golds\n'),
    write(' 6. Beet root seed      |   500 golds\n'),
    write(' 7. Golden apple seed   |  2500 golds\n'),
    write(' 8. Chicken             |   500 golds\n'),
    write(' 9. Cow                 |  1000 golds\n'),
    write('10. Sheep               |  1000 golds\n'),
    write('11. Pig                 |  2000 golds\n'),
    write('12. Ostrich             |  5000 golds\n'),
    write('13. Tiger               | 10000 golds\n'),
    write('14. Level '), 
        (searchEquipment(36, _ElementShovel, _) ->
            !, _ElementShovel = [_, _, _CurrLevelShovel],
            _LevelShovel is _CurrLevelShovel + 1;
            !, _LevelShovel is 1
        ), _HargaShovel is _LevelShovel * 1500,
        write(_LevelShovel), write(' shovel      |  '), (_LevelShovel > 5 -> write('   -'); write(_HargaShovel)), write(' golds\n'),
    write('15. Level '), 
        (searchEquipment(37, _ElementFishingRod, _) ->
            !, _ElementFishingRod = [_, _, _CurrLevelFishingRod],
            _LevelFishingRod is _CurrLevelFishingRod + 1;
            !, _LevelFishingRod is 1
        ), _HargaFishingRod is _LevelFishingRod * 1500,
        write(_LevelFishingRod), write(' fishing rod |  '), (_LevelFishingRod > 5 -> write('   -'); write(_HargaFishingRod)), write(' golds\n'),
    write('16. Level '), 
        (searchEquipment(37, _ElementSamurai, _) ->
            !, _ElementSamurai = [_, _, _CurrLevelSamurai],
            _LevelSamurai is _CurrLevelSamurai + 1;
            !, _LevelSamurai is 1
        ), _HargaSamurai is _LevelSamurai * 1500,
        write(_LevelSamurai), write(' samurai     |  '), (_LevelSamurai > 5 -> write('   -'); write(_HargaSamurai)), write(' golds\n'),
    write('\nWhat do you want to buy?\n> '),
    read(_Buy),
    (_Buy == 'exitShop' ->
        GoldOut is Gold,
        write('\nThanks for coming.\n');
        (_Buy >= 1, _Buy =< 7 ->
            _ID is _Buy + 7,
            write('\nHow many do you want to buy?\n> '),
            read(_Quantity),
            item(_ID, _Name, _Price),
            _Pay is _Price * _Quantity,
            (_Pay > Gold ->
                GoldOut is Gold,
                write('\nYou don\'t have enough money. Cancelling...\n');
                (insertItem(_ID, _Quantity) ->
                    write('\nYou have bought '), write(_Quantity), write(' '), write(_Name), write('.\n'),
                    GoldOut is Gold - _Pay,
                    write('You are charged '), write(_Pay), write(' golds.\n');
                    GoldOut is Gold,
                    write('\nYou don\'t have enough inventory capacity. Cancelling...\n')
                )
            );
        _Buy >= 8, _Buy =< 13 ->
            (_ID is _Buy + 14,
             write('\nHow many do you want to buy?\n> '),
             read(_Quantity),
             item(_ID, _Name, _Price),
             _Pay is _Price * _Quantity,
                (_Pay > Gold ->
                    GoldOut is Gold,
                    write('\nYou don\'t have enough money. Cancelling...\n');
                    (_ID == 22 ->
                        chicken(_PrevQuantity),
                        _NewQuantity is _PrevQuantity + _Quantity,
                        retractall(chicken(_)),
                        asserta(chicken(_NewQuantity));
                    _ID == 23 ->
                        cow(_PrevQuantity),
                        _NewQuantity is _PrevQuantity + _Quantity,
                        retractall(cow(_)),
                        asserta(cow(_NewQuantity));
                    _ID == 24 ->
                        sheep(_PrevQuantity),
                        _NewQuantity is _PrevQuantity + _Quantity,
                        retractall(sheep(_)),
                        asserta(sheep(_NewQuantity));
                    _ID == 25 ->
                        pig(_PrevQuantity),
                        _NewQuantity is _PrevQuantity + _Quantity,
                        retractall(pig(_)),
                        asserta(pig(_NewQuantity));
                    _ID == 26 ->
                        ostrich(_PrevQuantity),
                        _NewQuantity is _PrevQuantity + _Quantity,
                        retractall(ostrich(_)),
                        asserta(ostrich(_NewQuantity));
                    _ID == 27 ->
                        tiger(_PrevQuantity),
                        _NewQuantity is _PrevQuantity + _Quantity,
                        retractall(tiger(_)),
                        asserta(tiger(_NewQuantity))
                    ),
                    write('\nYou have bought '), write(_Quantity), write(' '), write(_Name), write('.\n'),
                    GoldOut is Gold - _Pay,
                    write('You are charged '), write(_Pay), write(' golds.\n')
                )
            );
        % (22 - 27)
        _Buy >= 14, _Buy =< 16 ->
            _ID is _Buy + 22,
            (_ID == 36 ->
                (_LevelShovel > 5 ->
                    GoldOut is Gold,
                    write('\nYou can\'t upgrade this anymore\n');
                    _Pay is _HargaShovel,
                    (_Pay > Gold ->
                        GoldOut is Gold,
                        write('\nYou don\'t have enough money. Cancelling...\n');
                        insertEquipment(36, 1),
                        write('\nYou have bought Level '), write(_LevelShovel), write(' shovel.\n'),
                        GoldOut is Gold - _Pay,
                        write('You are charged '), write(_Pay), write(' golds.\n')
                    )
                );
            ID == 37 ->
                (_LevelFishingRod > 5 ->
                    GoldOut is Gold,
                    write('\nYou can\'t upgrade this anymore\n');
                    _Pay is _HargaFishingRod,
                    (_Pay > Gold ->
                        GoldOut is Gold,
                        write('\nYou don\'t have enough money. Cancelling...\n');
                        insertEquipment(37, 1),
                        write('\nYou have bought Level '), write(_LevelFishingRod), write(' fishing rod.\n'),
                        GoldOut is Gold - _Pay,
                        write('You are charged '), write(_Pay), write(' golds.\n')
                    )
                );
            ID == 38 ->
                (_LevelSamurai > 5 ->
                    GoldOut is Gold,
                    write('\nYou can\'t upgrade this anymore\n');
                    _Pay is _HargaSamurai,
                    (_Pay > Gold ->
                        GoldOut is Gold,
                        write('\nYou don\'t have enough money. Cancelling...\n');
                        insertEquipment(36, 1),
                        write('\nYou have bought Level '), write(_LevelSamurai), write(' samurai.\n'),
                        GoldOut is Gold - _Pay,
                        write('You are charged '), write(_Pay), write(' golds.\n')
                    )
                )
            );
        GoldOut is Gold,
        write('\nInvalid purchase. Cancelling...\n')
        )
    ).

sell(Gold, GoldOut) :-
    write('\nHere are the items in your inventory\n'),
    displaySell,
    write('\nWhat do you want to sell?\n> '),
    read(_Sell),
    (item(_ID, _Sell, _Price) ->
        (searchItem(_ID, _Element, _) ->
            write('\nHow many do you want to sell?\n> '),
            read(_Quantity),
            _Element = [_, _, _InventoryQuantity],
            (_InventoryQuantity < _Quantity ->
                GoldOut is Gold,
                write('\nYou don\'t have enough item. Cancelling...');
                decreaseItem(_ID, _Quantity),
                _GetGold is _Quantity * _Price,
                GoldOut is Gold + _GetGold,
                write('\nYou sold '), write(_Quantity), write(' '), write(_Sell), write('.\n'),
                write('You received '), write(_GetGold), write(' golds.')
            )
            ;
            GoldOut is Gold,
            write('\nYou don\'t have that item. Cancelling...')
        );
        GoldOut is Gold,
        write('\nItem is not registered. Cancelling...\n')
    ).

% displaySell.
% I.S. -
% F.S. Menampilkan seluruh sellable item (Item ID 1 - 7, 15 - 21, 29 - 35) yang ada di inventory pada layar
displaySell :-
    inventory_item_list(_X),
    displaySell(_X).
displaySell([]).
displaySell([_X | _Y]) :-
    _X = [_A, _B, _C],
    ((_A >= 1, _A =< 7) -> 
        write('- '), write(_C), write(' '), write(_B), write('\n');
    (_A >= 15, _A =< 21) ->
        write('- '), write(_C), write(' '), write(_B), write('\n');
    (_A >= 29, _A =< 35) ->
        write('- '), write(_C), write(' '), write(_B), write('\n');
        true
    ),
    displaySell(_Y).