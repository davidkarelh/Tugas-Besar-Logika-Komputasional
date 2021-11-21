%Bentuk map awal, beserta isinya
map_init([
[#,#,#,#,#,#,#,#,#,#,#,#,#,#,#,#],
[#,-,-,-,-,-,-,-,-,-,-,'P',-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,'Q',-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,'F',-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,'R',-,-,-,-,#],
[#,-,-,-,-,-,-,'H',-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,'o','o','o',-,-,-,-,-,-,-,#],
[#,-,-,-,'o','o','o','o','o',-,-,-,-,-,-,#],
[#,-,-,-,-,'o','o','o',-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,'M',-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,-,-,-,-,-,-,-,-,-,-,-,-,-,-,#],
[#,#,#,#,#,#,#,#,#,#,#,#,#,#,#,#]
]).
 
%Melakukan print matrix
print_row([]).
print_row([X|Y]) :- write(X),print_row(Y).
print_matrix([]).
print_matrix([Y|Z]) :- print_row(Y), nl, print_matrix(Z).

%Menhasilkan elem yang ada pada list pada hitungan tertentu
find_row([_|List],N,Out) :-
    N1 is N - 1,
    find_row(List,N1,Out).
find_row([Element|_],0,Element).

%Menhasilkan elem yang ada pada koordinat tertentu di matriks
% find_matrikx(M,X,Y,Out)
% M matriks
% X,Y koordinat
% Out karakter di koordinat itu
find_matrix([_|List],N1,N2,Out) :-
   N2_2 is N2 - 1,
   find_matrix(List,N1,N2_2,Out).
find_matrix([Row|_],N1,0,Out) :-
   find_row(Row, N1, Out).

%Menhasilkan elem yang ada pada koordinat tertentu di map
%X, Y koordinat
%L Hasil
elmt_in_matrix(X,Y,L) :-    
   map_init(M),
   find_matrix(M,X,Y,L).

%Mencari elemen tertentu pada list (hanya bisa jika elemen nya unik(hanya ada satu))
scan_row([],_,_,-1).
scan_row([Head|_],Head,N,N).
scan_row([Head|List],X,N,Out) :-
   (  Head == X 
      -> Out is N
      ; N1 is N+1,scan_row(List,X,N1,Out)
   ).

%Mencari elemen tertentu pada matriks (hanya bisa jika elemen nya unik(hanya ada satu))
% scan_matrix(M,C,N,Out1,Out2)
% M matriks
% C karakter yang ingin dicari
% N dibiarin 0
% Out1,Out2 koordinat
scan_matrix([],_,_,-1,-1).
scan_matrix([Head|List],X,N,Out1,Out2) :- 
   scan_row(Head,X,0,OutR),
   (
      OutR == -1
      -> N1 is N+1,scan_matrix(List,X,N1,Out1,Out2)
      ;Out1 is OutR, Out2 is N
   ).

%Mencari lokasi P(player) di matriks map
%input dummy(tidak dipakai)
%X, Y hasil koordinat
scan_player(_,X,Y) :-
   map_init(M),
   scan_matrix(M,'P',0,Out1,Out2),
   X is Out1, Y is Out2.

%Menggantikan elemen di koordinat tertentu dengan suatu elemen lain
%L matriks masukan
%X, Y koordinat
%Z elemen yg akan mengganitkan
%R matriks keluaran
replace(L, X, Y, Z, R) :-
   append(RowPfx,[Row|RowSfx],L),
   length(RowPfx,Y),               
   append(ColPfx,[_|ColSfx],Row),  
   length(ColPfx,X),         
   append(ColPfx,[Z|ColSfx],RowNew), 
   append(RowPfx,[RowNew|RowSfx],R).

%mengecek apakah karakter sama dengan border atau air
valid(Char,Out) :-
   (
      (Char == '#';Char == 'o')
      -> Out is 0
      ;Out is 1
   ).

%Mengecek apakah jika kita bergerak, valid atau tidak(West)
validW(X,Y,Out2) :-
   X1 is X - 1,
   elmt_in_matrix(X1,Y,Char),
   valid(Char,Out),
   Out2 is Out.

%Mengecek apakah jika kita bergerak, valid atau tidak(East)
validE(X,Y,Out2) :-
   X1 is X + 1,
   elmt_in_matrix(X1,Y,Char),
   valid(Char,Out),
   Out2 is Out.

%Mengecek apakah jika kita bergerak, valid atau tidak(North)
validN(X,Y,Out2) :-
   Y1 is Y - 1,
   elmt_in_matrix(X,Y1,Char),
   valid(Char,Out),
   Out2 is Out.

%Mengecek apakah jika kita bergerak, valid atau tidak(South)
validS(X,Y,Out2) :-
   Y1 is Y + 1,
   elmt_in_matrix(X,Y1,Char),
   valid(Char,Out),
   Out2 is Out.

%Melakukan perpindahan P(player) dengan arah yang ditentukan(West)
moveW(M, X, Y,Mout2) :-
   replace(M,X,Y,'-',Mout),
   X1 is X - 1,
   replace(Mout,X1,Y,'P',Mout2),
   write('You moved west.'),nl.

%Melakukan perpindahan P(player) dengan arah yang ditentukan(East)
moveE(M, X, Y,Mout2) :-
   replace(M,X,Y,'-',Mout),
   X1 is X + 1,
   replace(Mout,X1,Y,'P',Mout2),
   write('You moved east.'),nl.

%Melakukan perpindahan P(player) dengan arah yang ditentukan(North)
moveN(M, X, Y,Mout2) :-
   replace(M,X,Y,'-',Mout),
   Y1 is Y - 1,
   replace(Mout,X,Y1,'P',Mout2),
   write('You moved north.'),nl.

%Melakukan perpindahan P(player) dengan arah yang ditentukan(South)
moveS(M, X, Y,Mout2) :-
   replace(M,X,Y,'-',Mout),
   Y1 is Y + 1,
   replace(Mout,X,Y1,'P',Mout2),
   write('You moved south.'),nl.

%Melakukan move dan mengecek validitas
a :- 
   scan_player(_,X,Y),
   validW(X,Y,Out),
   (
      Out =\= 1
      -> write('Move invalid')
      ; map_init(M),moveW(M, X, Y, Mout), print_matrix(Mout)
   ).

%Memanggil fungsi map untuk langsung mengeprint matrix map
map :-    
   map_init(M),
   print_matrix(M).

%Melakukan move dan mengecek validitas
d :- 
   scan_player(_,X,Y),
   validE(X,Y,Out),
   (
      Out =\= 1
      -> write('Move invalid')
      ; map_init(M),moveE(M, X, Y, Mout), print_matrix(Mout)
   ).

%Melakukan move dan mengecek validitas
w :- 
   scan_player(_,X,Y),
   validN(X,Y,Out),
   (
      Out =\= 1
      -> write('Move invalid')
      ; map_init(M),moveN(M, X, Y, Mout), print_matrix(Mout)
   ).

%Melakukan move dan mengecek validitas
s :- 
   scan_player(_,X,Y),
   validS(X,Y,Out),
   (
      Out =\= 1
      -> write('Move invalid')
      ; map_init(M),moveS(M, X, Y, Mout), print_matrix(Mout)
   ). 

% tes :- 
%    map_init(M),
%    scan_player(_, X, Y),
%    find_matrix(M,X,Y,L),
%    write(L),nl,
%    scan_matrix(M,'P',0,Out1,Out2),
%    write(Out1),nl,
%    write(Out2),nl.