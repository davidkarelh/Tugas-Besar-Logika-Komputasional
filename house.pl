/* Deklarasi Fakta */
:- dynamic(diary/2).
:- include('season.pl').
/* Deklarasi Rules */
house(Hour, Day, NewHour, NewDay, EXIT):-
    (
        write('Apa yang mau kamu lakukan?\n'),
        write('-  tidur\n'),
        write('-  tulisDiary\n'),
        write('-  bacaDiary\n'),
        write('-  exit\n'),
        read(INPUT),
        (
            INPUT == 'tidur',
                NewHour is 7, NewDay is Day + 1,
                write('Kamu tidur\n\n'),
                write('Hari: '), write(NewDay), write('\n');
            INPUT == 'tulisDiary',
                writeDiary(Day),
                NewDay is Day, NewHour is Hour;
            INPUT == 'bacaDiary',
                write('Diary pada hari apa yang ingin kamu baca?\n'),
                read(Entry),
                readDiary(Entry),
                NewDay is Day, NewHour is Hour;
            INPUT == 'exit',
                write('Apakah anda ingin keluar dari game? Apabila iya, akan otomatis dianggap kalah'), nl,
                write('1. Iya, saya sudah lelah'), nl,
                write('0. Tidak, tadi hanya salah tekan saja'), nl,
                read(Confirm),
                (
                    (Confirm =:= 1) ->
                        EXIT is true;
                    (Confirm =:= 0) ->
                        write('Silahkan melanjutkan permainan'), nl;
                    write('Input invalid'), nl
                )
        )
    ).

/* Menuliskan diary menjadi fakta */
writeDiary(Day):-
    (diary(Day, X) ->
        write('Kamu sudah menulis diary pada hari ini\n'),
        write(X);
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