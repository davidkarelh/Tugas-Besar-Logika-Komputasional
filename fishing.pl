:- include('map.pl').
:- include('Inventory.pl').

:- dynamic((rng/1)).

% implementasi randomizer seperti ini bisa dimodifikasi sesuai exp dan rarity ikan
% Belum implementasi jika inventori penuh apa yang terjadi
% Belum mengimplementasikan exp
% Belum mengimplementasikan menyimpan ikan ke inventori
% Masih harus memmikirkan berbagai jenis ikan, rarity, dan harganya

rng(50).

generateRandom :-
    rng(N),
    retract(rng(N)),
    get_time(TimeStamp),
    A is (mod(TimeStamp, 99) + 1),
    X is mod((A * N + N), 100),
    asserta(rng(X))
    . 


cek_air_sekeliling(M, X, Y, Out) :-
    find_matrix(M, X + 1, Y, L),
    (L == 'o'),
    Out is 1, !.
cek_air_sekeliling(M, X, Y, Out) :-
    find_matrix(M, X, Y + 1, L),
    (L == 'o'),
    Out is 1, !.
cek_air_sekeliling(M, X, Y, Out) :-
    find_matrix(M, X + 1, Y + 1, L),
    (L == 'o'),
    Out is 1, !.
cek_air_sekeliling(M, X, Y, Out) :-
    find_matrix(M, X - 1, Y, L),
    (L == 'o'),
    Out is 1, !.
cek_air_sekeliling(M, X, Y, Out) :-
    find_matrix(M, X, Y - 1, L),
    (L == 'o'),
    Out is 1, !.
cek_air_sekeliling(M, X, Y, Out) :-
    find_matrix(M, X - 1, Y - 1, L),
    (L == 'o'),
    Out is 1, !.
cek_air_sekeliling(M, X, Y, 0).

validasi_fish(Out) :-
    scan_player(_, X, Y),
    map_init(M),
    cek_air_sekeliling(M, X, Y, V),
    (
        (V =:= 1)
        -> Out is 0, !
        ; Out is 0, !
    ).

fish :-
    validasi_fish(V),
    (
        (V =:= 1)
        -> 
            generateRandom,
            rng(N),
            (
                (N < 10)
                -> write('Anda mendapatkan ikan jenis 1')
            ;   (N < 20)
                -> write('Anda mendapatkan ikan jenis 2')
            ;   (N < 30)
                -> write('Anda mendapatkan ikan jenis 3')
            ;   (N < 40)
                -> write('Anda mendapatkan ikan jenis 4')
            ;   (N < 50)
                -> write('Anda mendapatkan ikan jenis 5')
            ;   (N < 60)
                -> write('Anda mendapatkan ikan jenis 6')
            ;   (N < 70)
                -> write('Anda mendapatkan ikan jenis 7')
            ;   (N < 80)
                -> write('Anda mendapatkan ikan jenis 8')
            ;   (N < 90)
                -> write('Anda mendapatkan ikan jenis 9')
            ;   (N < 100)
                -> write('Anda mendapatkan ikan jenis 10')
            ), !
        ; write('Anda tidak bisa memancing di tile ini.'), !, fail
    ).
