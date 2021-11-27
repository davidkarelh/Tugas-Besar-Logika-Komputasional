:- dynamic((rng/1)).

% implementasi randomizer seperti ini bisa dimodifikasi sesuai exp dan rarity ikan
% Belum implementasi jika inventori penuh apa yang terjadi
% Belum mengimplementasikan exp
% Belum mengimplementasikan menyimpan ikan ke inventori
% Masih harus memmikirkan berbagai jenis ikan, rarity, dan harganya

rng(50).

generateRandom(A) :-
    rng(N),
    retract(rng(N)),
    real_time(TimeStamp),
    A is (mod(TimeStamp, 99) + 1),
    asserta(rng(A)). 


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
cek_air_sekeliling(M, X, Y, Out) :-
    find_matrix(M, X + 1, Y - 1, L),
    (L == 'o'),
    Out is 1, !.
cek_air_sekeliling(M, X, Y, Out) :-
    find_matrix(M, X - 1, Y + 1, L),
    (L == 'o'),
    Out is 1, !.
cek_air_sekeliling(_, _, _, 0).

validasi_fishing_rod :-
    (
        searchEquipment(37, _, _)
        -> !
        ; write('Anda tidak mempunyai fishing rod untuk memancing.\n'), !, fail
    ).

validasi_fish :-
    scan_player(_, X, Y),
    map_init(M),
    cek_air_sekeliling(M, X, Y, V),
    (
        (V =:= 1)
        -> !
        ; write('Anda tidak bisa memancing di tile ini!'), !, fail
    ).

fish(Lvfishing) :-
    validasi_fish,
    validasi_fishing_rod,
    searchEquipment(37, _, LvRod),
    generateRandom(N),
    (
        Lvfishing < 5
        ->  tier1(N, LvRod), !
        ; Lvfishing < 10
        -> tier2(N, LvRod), !
        ; Lvfishing < 15
        -> tier3(N, LvRod), !
        ; Lvfishing < 20
        -> tier4(N, LvRod), !
        ; Lvfishing < 25
        -> tier5(N, LvRod), !
        ; Lvfishing < 30
        -> tier6(N, LvRod), !
        ; tier7(N, LvRod), !
    ).

tier1(N, LvRod) :-
    (
        (LvRod > 20)
        -> NN is ((LvRod - (mod(LvRod, 20))) / 4), !
        ; NN is 0, !
    ),
    (
        (N < (50 - NN))
        -> write('Yah, kamu kurang beruntung sekarang, kamu gak dapet ikan!\n'), !
        ; insertItem(15, 1), write('Wah, kamu dapet 1 ikan lele!\n'), !
    ).

tier2(N, LvRod) :-
    (
        (LvRod > 20)
        -> NN is ((LvRod - (mod(LvRod, 20))) / 4), !
        ; NN is 0, !
    ),
    (
        (N < (33 - NN))
        -> write('Yah, kamu kurang beruntung sekarang, kamu gak dapet ikan!\n'), !
        ; (N < 67 - NN)
        -> insertItem(15, 1), write('Wah, kamu dapet 1 ikan lele!\n'), !
        ; insertItem(16, 1), write('Wah, kamu dapet 1 ikan mujair!\n'), !
    ).

tier3(N, LvRod) :-
    (
        (LvRod > 20)
        -> NN is ((LvRod - (mod(LvRod, 20))) / 4), !
        ; NN is 0, !
    ),
    (
        (N < (25 - NN))
        -> write('Yah, kamu kurang beruntung sekarang, kamu gak dapet ikan!\n'), !
        ; (N < 50)
        -> insertItem(15, 1), write('Wah, kamu dapet 1 ikan lele!\n'), !
        ; (N < (75 - NN))
        -> insertItem(16, 1), write('Wah, kamu dapet 1 ikan mujair!\n'), !
        ; insertItem(17, 1), write('Wah, kamu dapet 1 ikan mas!\n'), !
    ).


tier4(N, LvRod) :-
    (
        (LvRod > 20)
        -> NN is ((LvRod - (mod(LvRod, 20))) / 4), !
        ; NN is 0, !
    ),
    (
        (N < (20 - NN))
        -> write('Yah, kamu kurang beruntung sekarang, kamu gak dapet ikan!\n'), !
        ; (N < 40)
        -> insertItem(15, 1), write('Wah, kamu dapet 1 ikan lele!\n'), !
        ; (N < 60)
        -> insertItem(16, 1), write('Wah, kamu dapet 1 ikan mujair!\n'), !
        ; (N < (80 - NN))
        -> insertItem(17, 1), write('Wah, kamu dapet 1 ikan mas!\n'), !
        ; insertItem(18, 1), write('Wah, kamu dapet 1 lumba-lumba!\n'), !
    ).

tier5(N, LvRod) :-
    (
        (LvRod > 20)
        -> NN is ((LvRod - (mod(LvRod, 20))) / 4), !
        ; NN is 0, !
    ),
    (
        (N < (17 - NN))
        -> write('Yah, kamu kurang beruntung sekarang, kamu gak dapet ikan!\n'), !
        ; (N < 34)
        -> insertItem(15, 1), write('Wah, kamu dapet 1 ikan lele!\n'), !
        ; (N < 51)
        -> insertItem(16, 1), write('Wah, kamu dapet 1 ikan mujair!\n'), !
        ; (N < 68)
        -> insertItem(17, 1), write('Wah, kamu dapet 1 ikan mas!\n'), !
        ; (N < (85 - NN))
        -> insertItem(18, 1), write('Wah, kamu dapet 1 lumba-lumba!\n'), !
        ; insertItem(19, 1), write('Wah, kamu dapet 1 great white shark!\n'), !
    ).

% Setelah pemain mencapai Tier6, tidak mungkin untuk tidak mendapat ikan lagi
tier6(N, LvRod) :-
    (
        (LvRod > 20)
        -> NN is ((LvRod - (mod(LvRod, 20))) / 4), !
        ; NN is 0, !
    ),
    (
        (N < (17 - NN))
        -> insertItem(15, 1), write('Wah, kamu dapet 1 ikan lele!\n'), !
        ; (N < 34)
        -> insertItem(16, 1), write('Wah, kamu dapet 1 ikan mujair!\n'), !
        ; (N < 51)
        -> insertItem(17, 1), write('Wah, kamu dapet 1 ikan mas!\n'), !
        ; (N < 68)
        -> insertItem(18, 1), write('Wah, kamu dapet 1 lumba-lumba!\n'), !
        ; (N < (85 - NN))
        -> insertItem(19, 1), write('Wah, kamu dapet 1 great white shark!\n'), !
        ; insertItem(20, 1), write('Wah, kamu dapet 1 orca!\n'), !
    ).

% Tier tertinggi, kemampuan spesialnya jika level fishing rodnya cukup tinggi ada kemungkinan dia dapet megalodon terus
tier7(N, LvRod) :-
    (
        (LvRod > 20)
        -> NN is ((LvRod - (mod(LvRod, 20))) / 4), !
        ; NN is 0, !
    ),
    (
        (N < (17 - NN))
        -> insertItem(16, 1), write('Wah, kamu dapet 1 ikan mujair!\n'), !
        ; (N < (34 - NN))
        -> insertItem(17, 1), write('Wah, kamu dapet 1 ikan mas!\n'), !
        ; (N < (51 - NN))
        -> insertItem(18, 1), write('Wah, kamu dapet 1 lumba-lumba!\n'), !
        ; (N < (68 - NN))
        -> insertItem(19, 1), write('Wah, kamu dapet 1 great white shark!\n'), !
        ; (N < (85 - NN))
        -> insertItem(20, 1), write('Wah, kamu dapet 1 orca!\n'), !
        ; insertItem(21, 1), write('Wah, kamu dapet 1 megalodon!\n'), !
    ).

