:- include('map.pl').

:- dynamic((trueMap/1)).

% trueMap([[]])

initiate_true_map :-
    map_init(M),
    scan_player(_, X, Y),
    replace(M, X, Y, '-', MOut),
    asserta(trueMap(MOut)), !
    % print_matrix(MOut)
    .

update_true_matrix(New) :-
    trueMap(M),
    retract(trueMap(M)),
    asserta(trueMap(New)).

elmt_in_true_matrix(X,Y,L) :-    
    trueMap(M),
    find_matrix(M,X,Y,L).

validasi_dig(Out) :- 
    scan_player(_,X,Y),
    elmt_in_true_matrix(X, Y, P),
    (
        (P == 'M'; P == 'R'; P == 'H'; p == 'Q'; P == 'o'; P = ('=')) 
       -> Out is 0, !
       ; Out is 1, !
    ).

dig :-
    scan_player(_, X, Y),
    validasi_dig(V),
    (
        (V =:= 1)
        -> trueMap(M), replace(M, X, Y, ('='), MOut), update_true_matrix(MOut), write('Anda berhasil menggali di tile ini!\n'), !
        ; write('Anda tidak bisa menggali di tile ini!\n'), !, fail
    ),
    trueMap(T),
    print_matrix(T).
    
% Dari pengecekkan sepertinya ada error pada find_matrix
cekCur :-
    scan_player(_, X, Y),
    write(X), write('\n'), write(Y),
    map_init(M),
    find_matrix(M, X, Y + 2, L),
    write('\n'), write(L). 

validasi_plant(Out) :-
    scan_player(_,X,Y),
    elmt_in_true_matrix(X, Y, P),
    (
        (P == "=") 
       -> Out is 1, !
       ; Out is 0, !
    ).

plant :-
    validasi_plant(V),
    write(V),
    scan_player(_, X, Y),
    elmt_in_true_matrix(X, Y, L),
    trueMap(M),
    print_matrix(M),
    write(L)
    
    .