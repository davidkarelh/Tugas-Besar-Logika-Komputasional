start :-
    write('Setelah mendapat berita Bitkowin auto cuan'), nl,
    write('Brianaldo pun langsung gaskan menjual semua asetnya'), nl,
    write('untuk membeli Bitkowin. Ia bahkan juga meminjam uang'), nl,
    write('kepada rentenir sebesar 2.000.000 gold'), nl,
    write('Keesokan harinya, ternyata harga Bitkowin turun'), nl,
    write('secara drastis sehingga Brianaldo menjadi terjerat'), nl,
    write('utang sebesar 200.000 gold'), nl,
    write('Hal ini pun membuat Brianaldo berpikir keras'), nl,
    write('Setelah beberapa jam berpikir keras, Brianaldo'), nl,
    write('tiba-tiba terpikirkan bahwa Ia memiliki ladang di'), nl,
    write('kampung halamannya. Oleh karena itu, Ia memutuskan'), nl,
    write('untuk balik ke kampung halamannya untuk bekerja'), nl,
    chooseJob(Job), nl,
    /* mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch), */
    /*Count:  1       2          3           4          5           6           7            8        9      10    11    12        13     14      15*/
    mainLoop(Job,     1,         0,          0,         0,          0,          0,           0,       0,    100,  500,    1,        1,     1,      1), !.

/* Time dan Gold belum di adjust dengan nilai yang seharusnya */
mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch) :-
    (Time < 10) ->
        (
            (Gold < 3000) ->
                read(Input),
                (
                    Input == 'status',
                        status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch);
                    Input == 'quest',
                        quest(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch);

                    /* Bagian bawah cuman testing add aspek aja */
                    Input == 'addlv',
                        addlv(Lv, LvX),
                        mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch);

                    Input == 'addlvfarming',
                        addlvfarmingv(Lvfarming, LvfarmingX),
                        mainLoop(Job, Lv, LvfarmingX, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch);

                    Input == 'addexpfarming',
                        addexpfarmingv(Expfarming, ExpfarmingX),
                        mainLoop(Job, Lv, Lvfarming, ExpfarmingX, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch);

                    Input == 'addlvfishing',
                        addlvfishingv(Lvfishing, LvfishingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, LvfishingX, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch);

                    Input == 'addexpfishing',
                        addexpfishingv(Expfishing, ExpfishingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, ExpfishingX, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch);

                    Input == 'addlvranching',
                        addlvranchingv(Lvranching, LvranchingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, LvranchingX, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch);

                    Input == 'addexpranching',
                        addexpranchingv(Expranching, ExpranchingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, ExpranchingX, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch);

                    /* Sistem penambahan exp di bawah sudah menghandle kasus level up */
                    Input == 'addexpcurr',
                        addexpcurrv(Expcurr, ExpcurrX),
                        (
                            (ExpcurrX >= Expcap) ->
                                write('Level Up!\n'),
                                addlv(Lv, LvX),
                                addexpcapv(Expcap, ExpcapX),
                                mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, ExpcapX, Gold, Time, Qharvest, Qfish, Qranch)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, Expcap, Gold, Time, Qharvest, Qfish, Qranch)
                        );

                    Input == 'addexpcap',
                        addexpcapv(Expcap, ExpcapX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, ExpcapX, Gold, Time, Qharvest, Qfish, Qranch);

                    Input == 'addgold',
                        addgoldv(Gold, GoldX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Time, Qharvest, Qfish, Qranch);

                    Input == 'addtime',
                        addtimev(Time, TimeX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, TimeX, Qharvest, Qfish, Qranch);

                    /* Bagian bawah cuman testing reduce aspek aja */
                    Input == 'redQharvest',
                        redQharvest(Qharvest, QharvestX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, QharvestX, Qfish, Qranch);

                    Input == 'redQfish',
                        redQfish(Qfish, QfishX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, QfishX, Qranch);

                    Input == 'redQranch',
                        redQranch(Qranch, QranchX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, QranchX)
                )
            ;write('Penagih hutang tiba di kebun anda dan anda langsung melunasi hutang anda \nCONGRATULATION YOU WIN!')
        )
    ;write('Penagih hutang tiba di kebun dan mengambil alih kebun \nGAME OVER').

startGame :-
    write('Welcome To Harvest Star'), nl,
    nl, nl, 
    write('>>> HARVEST STAR <<<'), nl,
    write('1. start     : memulai permainan'), nl,
    write('2. map       : menampilkan peta'), nl,
    write('3. status    : menampilkan kondisi terkini'), nl,
    write('4. w         : bergerak 1 langkah ke utara'), nl,
    write('5. s         : bergerak 1 langkah ke selatan'), nl,
    write('6. d         : bergerak 1 langkah ke timur'), nl,
    write('7. a         : bergerak 1 langkah ke barat'), nl,
    write('8. help      : menampilkan segala bantuan'), nl,
    nl, !.

chooseJob(Job) :-
    write('Welcome to Harvest Star, Choose your job'), nl,
    write('1. Fisherman'), nl,
    write('2. Farmer'), nl,
    write('3. Rancher'), nl,
    read(Job),
    (
        Job =:= 1,
            write('You choose Fisherman, let\'s go'),nl, !;
        Job =:= 2,
            write('You choose Farmer, let\'s go'), nl, !;
        Job =:= 3,
            write('You choose Rancher, let\'s go');
        chooseJob(Job)
    ).

status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time, Qharvest, Qfish, Qranch) :-
    write('Job: '),
    (
        Job =:= 1,
            write('Fisherman\n');
        Job =:= 2,
            write('Farmer\n');
        Job =:= 3,
            write('Rancher\n')
    ),
    write('Level: '), write(Lv), nl,
    write('Level farming: '), write(Lvfarming), nl,
    write('Exp farming: '), write(Expfarming), nl,
    write('Level fishing: '), write(Lvfishing), nl,
    write('Exp fishing: '), write(Expfishing), nl,
    write('Level ranching: '), write(Lvranching), nl,
    write('Exp ranching: '), write(Expranching), nl,
    write('Exp: '), write(Expcurr), write('/'), write(Expcap), nl,
    write('Gold: '), write(Gold), nl,
    write('Time: '), write(Time), nl,
    nl.