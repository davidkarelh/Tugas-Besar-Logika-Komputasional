/* Asumsi:  */
/* Baris pertama pasti harvest item */
/* Baris kedua pasti fish */
/* Baris ketiga pasti ranch item */

quest(Lv) :-
    write('Welcome To Quest'),
    Lvl is Lv+1,
    random(1, Lvl, Quest_harvest_item),
    random(1, Lvl, Quest_fish),
    random(1, Lvl, Quest_ranch),

    write('You need to collect:'), nl,
    write('- '), write(Quest_harvest_item), write(' harvest item'), nl,
    write('- '), write(Quest_fish), write(' fish'), nl,
    write('- '), write(Quest_ranch), write(' ranch item'), nl,
    nl.