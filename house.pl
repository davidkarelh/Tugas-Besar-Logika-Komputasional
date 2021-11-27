:- include('map.pl').
:- dynamic(diary/1).

house(Hour, Day, NewHour, NewDay):-
    (
        scan_player(_, X, Y),
        X == 6,
        Y == 7,
        write('What do you want to do?\n'),
        write('-  sleep\n'),
        write('-  writeDiary\n'),
        write('-  readDiary\n'),
        write('-  exit\n'),
        read(INPUT),
        (
            INPUT == 'sleep',
                NewHour is 7, NewDay is Day + 1,
                write('You went to sleep\n\n'),
                write('Day '), write(NewDay), write('\n');
            INPUT == 'writeDiary',
                write('Write your diary for Day '), write(Day), write('\n'),
                writeDiary(Day),
                write('Day '), write(Day), write(' entry saved');
            INPUT == 'readDiary',
                write('Which entry do you want to read?\n'),
                read(Entry),
                readDiary(Entry);
            INPUT == 'exit',
                true
        )
    );
    write('Kamu tidak di rumah').

writeDiary(Day):-
    read(InputDiary),
    assertz(diary(Day, InputDiary)).

readDiary(Entry):-
    diary(Entry, X),
    write(X).