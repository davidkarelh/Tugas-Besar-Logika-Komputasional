/* Deklarasi Fakta */
:- dynamic(diary/2).

/* Deklarasi Rules */
house(Hour, Day, NewHour, NewDay):-
    (
        /* Mengecek apakah player ada di house */
        scan_player(_, X, Y),
        X == 7,
        Y == 6,
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
                writeDiary(Day),
                NewDay is Day, NewHour is Hour;
            INPUT == 'readDiary',
                write('Which entry do you want to read?\n'),
                read(Entry),
                readDiary(Entry),
                NewDay is Day, NewHour is Hour;
            INPUT == 'exit',
                true,
                NewDay is Day, NewHour is Hour
        )
    );
    write('Kamu tidak di rumah'),
    NewDay is Day, NewHour is Hour.

/* Menuliskan diary menjadi fakta */
writeDiary(Day):-
    (diary(Entry, X) ->
        write('Kamu sudah menulis diary pada hari ini');
        /* Kalau tidak ada barulah akan menulis */
        write('Write your diary for Day '), write(Day), write('\n'),
        read(InputDiary),
        assertz(diary(Day, InputDiary)),
        write('Day '), write(Day), write(' entry saved')
    ).

/* Membaca diary pada hari tertentu */
readDiary(Entry):-
    (diary(Entry, X) ->
        write(X);
        write('Tidak ada tulisan apapun hari itu')
    ).

% periTidur:-