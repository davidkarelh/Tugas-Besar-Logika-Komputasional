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
    chooseJob(Job, Lvfarming, Lvfishing, Lvranching), nl,
    /* mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch), */
    /*Count:  1       2          3           4          5           6           7            8        9      10    11   12    13        14     15      15*/
    mainLoop(Job,     1, Lvfarming,          0, Lvfishing,          0, Lvranching,           0,       0,    100,  500,   1,    0,        1,     1,      1), !.

mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch) :-
    (Day < 365) ->
        (
            (Gold < 200000) ->
                read(Input),
                (
                    Input == 'status',
                        status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch);
                    Input == 'quest',
                        quest(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch);

                    /* Bagian bawah cuman testing add aspek aja */
                    Input == 'addlv',
                        addlv(Lv, LvX),
                        mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch);

                    Input == 'addlvfarming',
                        addlvfarmingv(Lvfarming, LvfarmingX),
                        mainLoop(Job, Lv, LvfarmingX, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch);

                    Input == 'addexpfarming',
                        addexpfarmingv(Expfarming, ExpfarmingX),
                        mainLoop(Job, Lv, Lvfarming, ExpfarmingX, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch);

                    Input == 'addlvfishing',
                        addlvfishingv(Lvfishing, LvfishingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, LvfishingX, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch);

                    Input == 'addexpfishing',
                        addexpfishingv(Expfishing, ExpfishingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, ExpfishingX, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch);

                    Input == 'addlvranching',
                        addlvranchingv(Lvranching, LvranchingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, LvranchingX, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch);

                    Input == 'addexpranching',
                        addexpranchingv(Expranching, ExpranchingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, ExpranchingX, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch);

                    /* Sistem penambahan exp di bawah sudah menghandle kasus level up */
                    Input == 'addexpcurr',
                        addexpcurrv(Expcurr, ExpcurrX),
                        (
                            (ExpcurrX >= Expcap) ->
                                write('Level Up!\n'),
                                addlv(Lv, LvX),
                                addexpcapv(Expcap, ExpcapX),
                                mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, ExpcapX, Gold, Day, Hour, Qharvest, Qfish, Qranch)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch)
                        );

                    Input == 'addexpcap',
                        addexpcapv(Expcap, ExpcapX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, ExpcapX, Gold, Day, Hour, Qharvest, Qfish, Qranch);

                    Input == 'addgold',
                        addgoldv(Gold, GoldX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Day, Hour, Qharvest, Qfish, Qranch);

                    Input == 'addHour',
                        add_hourv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('Its a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is 0,
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch)
                        );

                    Input == 'addDay',
                        add_dayv(Day, DayX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, Hour, Qharvest, Qfish, Qranch);

                    /* Testing Debug Chear */
                    Input == 'rich',
                        add_goldcheatv(Gold, GoldX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Day, Hour, Qharvest, Qfish, Qranch);

                    Input == 'daypp',
                        add_daycheatv(Day, DayX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, Hour, Qharvest, Qfish, Qranch);

                    Input == 'hourpp',
                        add_hourcheatv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('Its a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is (HourX-24),
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch)
                        );

                    /* Bagian bawah cuman testing reduce aspek aja */
                    Input == 'redQharvest',
                        redQharvest(Qharvest, QharvestX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, QharvestX, Qfish, Qranch);

                    Input == 'redQfish',
                        redQfish(Qfish, QfishX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, QfishX, Qranch);

                    Input == 'redQranch',
                        redQranch(Qranch, QranchX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, QranchX)
                )
            ;write('Penagih hutang tiba di kebun anda dan anda langsung melunasi hutang anda \nCONGRATULATION YOU WIN!\n')
        )
    ;write('Penagih hutang tiba di kebun dan mengambil alih kebun \nGAME OVER\n').

startGame :-
    nl,nl,
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

chooseJob(Job, Lvfarming, Lvfishing, Lvranching) :-
    nl,
    write('Welcome to Harvest Star, Choose your job'), nl,
    write('1. Fisherman'), nl,
    write('2. Farmer'), nl,
    write('3. Rancher'), nl,
    read(Job),
    (
        Job =:= 1,
            Lvfarming is 0,
            Lvfishing is 5,
            Lvranching is 0,
            write('You choose Fisherman, let\'s go'),nl, !;
        Job =:= 2,
            Lvfarming is 5,
            Lvfishing is 0,
            Lvranching is 0,
            write('You choose Farmer, let\'s go'), nl, !;
        Job =:= 3,
            Lvfarming is 0,
            Lvfishing is 0,
            Lvranching is 5,
            write('You choose Rancher, let\'s go');
        write('Pilihan tidak valid\n')
    ).

status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch) :-
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
    write('Time Details:'), nl,
    write('Day: '), write(Day), nl,
    write('Hour: '), write(Hour), nl,
    nl.