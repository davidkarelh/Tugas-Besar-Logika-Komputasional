:- include('map.pl').
:- dynamic(diary/1).
diary([]).

house(Hour, Day, NewHour, NewDay, diary):-
    write('What do you want to do?\n'),
    write('-  sleep\n'),
    write('-  writeDiary\n'),
    write('-  readDiary\n'),
    write('-  exit\n'),
    read(INPUT),
    (
        INPUT == 'sleep',
            NewHour is 7, NewDay is Day + 1;
            write('You went to sleep\n\n');
            write('Day '), write(NewDay), write('\n');
        INPUT == 'writeDiary',
            read(Entry),
            write('Write you diary for Day '), write(Day), write('\n'),
            writeDiary(Day, Entry),
            write('Day '), write(Day), write(' entry saved');
        INPUT == 'readDiary',
            write('Which entry do you want to read?\n'),
            read(Entry)
            readDiary(Entry);
        INPUT == 'exit',
            /*kosongin semua*/;
    )

writeDiary(Day, Entry):-
    diary(X),
    read(InputDiary),
    assertz(diary()).

readDiary(Entry):-
    diary(X),
    write().