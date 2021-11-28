:- dynamic((fishingCap/1)).
fishingCap(100).

start :-
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    write('Setelah mendapat berita Bitkowin auto cuan'), nl,
    write('Brianaldo pun langsung gaskan menjual semua asetnya'), nl,
    write('untuk membeli Bitkowin. Ia bahkan juga meminjam uang'), nl,
    write('dari rentenir sebesar 2.000.000 gold'), nl,
    write('Keesokan harinya, ternyata harga Bitkowin turun'), nl,
    write('secara drastis sehingga Brianaldo menjadi terjerat'), nl,
    write('utang sebesar 200.000 gold'), nl,
    write('Hal ini pun membuat Brianaldo berpikir keras'), nl,
    write('bagaimana cara untuk mengembalikan uang tersebut'), nl,
    write('Setelah beberapa jam berpikir keras, Brianaldo'), nl,
    write('tiba-tiba terpikirkan bahwa Ia memiliki ladang di'), nl,
    write('kampung halamannya. Oleh karena itu, Ia memutuskan'), nl,
    write('untuk balik ke kampung halamannya untuk bekerja'), nl,
    chooseJob(Job, Lvfarming, Lvfishing, Lvranching), nl,
    initiate_true_map,
    /* mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc), */
    /*Count:  1       2          3           4          5           6           7            8        9      10    11   12    13        14     15      15   16   */
    mainLoop(Job,     1, Lvfarming,          0, Lvfishing,          0, Lvranching,           0,       0,    100,  500,   1,    0,        1,     1,      1,   3), !.

mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc) :-
    (Day < 365) ->
        (
            (Gold < 200000) ->
                read(Input),
                (
                    Input == 'status',
                        status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'quest',
                        player_position(XQuest, YQuest),
                        (
                            (XQuest =:=7, YQuest =:= 3) ->
                                quest(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc),
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);
                            write('Anda sedang tidak berada pada Q'), nl,
                            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'alc',
                        player_position(XAlc, YAlc),
                        (
                            (XAlc =:= 1, YAlc =:= 1) ->
                                alc_intro(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);
                            write('???'), nl,
                            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'market',
                        player_position(XMarket, YMarket),
                        (
                            (XMarket =:= 10, YMarket =:= 12) ->
                                market(Gold, GoldOut),
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldOut, Day, Hour, Qharvest, Qfish, Qranch, Alc);
                            write('Anda sedang tidak berada pada M'), nl,
                            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input  == 'house',
                        player_position(XRumah, YRumah),
                        (
                            (XRumah =:= 7, YRumah =:= 6) ->
                                house(Hour, Day, NewHour, NewDay),
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, NewDay, NewHour, Qharvest, Qfish, Qranch, Alc);
                            write('Anda sedang tidak berada pada H'), nl,
                            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );
                        

                    Input == 'map',
                        true_map,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'inventory',
                        inventory,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'fish',
                        fish(Lvfishing, ExpOut),
                        ExpfishingX is Expfishing + ExpOut,
                        (
                            (ExpfishingX >= fishingCap) ->
                                write('Level Up Fishing!\n'),
                                addlvfishingv(Lvfishing, LvfishingX),
                                fishingCap(Cap),
                                NCap is Cap * 1.1,
                                retract(fishingCap(_)),
                                asserta(fishingCap(NCap))
                            ; (LvfishingX is Lvfishing)
                        ),
                        addexpcurrv(Expcurr, ExpcurrX),
                        write('Kamu mendapat 30 exp!\n'),
                        (
                            (ExpcurrX >= Expcap) ->
                                write('Level Up!\n'),
                                addlv(Lv, LvX),
                                addexpcapv(Expcap, ExpcapX),
                                mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishingx, ExpfishingX, Lvranching, Expranching, ExpcurrX, ExpcapX, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                            ; mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishingx, ExpfishingX, Lvranching, Expranching, ExpcurrX, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );     
               
                    Input == 'ranch',
                        ranch(Day, Lvranching),
                        %fungsi naikin lv Lvfishing
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'dig',
                        dig,
                        %fungsi naikin lv Lvfishing
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'plant',
                        plant(Day, Hour),
                        %fungsi naikin lv Lvfishing
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'harvest',
                        harvest(Day, Hour),
                        %fungsi naikin lv Lvfishing
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'w',
                        w,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'a',
                        a,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 's',
                        s,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'd',
                        d,
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'exit',
                        write('Apakah anda ingin keluar dari game? Apabila iya, akan otomatis dianggap kalah'), nl,
                        write('1. Iya, saya sudah lelah'), nl,
                        write('0. Tidak, tadi hanya salah tekan saja'), nl,
                        read(Confirm),
                        (
                            (Confirm =:= 1) ->
                                exitGame;
                            (Confirm =:= 0) ->
                                write('Silahkan melanjutkan permainan'), nl,
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);
                            write('Input invalid'), nl,
                            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );

                    /* Bagian bawah cuman testing add aspek aja */
                    Input == 'addlv',
                        addlv(Lv, LvX),
                        mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addlvfarming',
                        addlvfarmingv(Lvfarming, LvfarmingX),
                        mainLoop(Job, Lv, LvfarmingX, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addexpfarming',
                        addexpfarmingv(Expfarming, ExpfarmingX),
                        mainLoop(Job, Lv, Lvfarming, ExpfarmingX, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addlvfishing',
                        addlvfishingv(Lvfishing, LvfishingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, LvfishingX, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addexpfishing',
                        addexpfishingv(Expfishing, ExpfishingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, ExpfishingX, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addlvranching',
                        addlvranchingv(Lvranching, LvranchingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, LvranchingX, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addexpranching',
                        addexpranchingv(Expranching, ExpranchingX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, ExpranchingX, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    /* Sistem penambahan exp di bawah sudah menghandle kasus level up */
                    Input == 'addexpcurr',
                        addexpcurrv(Expcurr, ExpcurrX),
                        (
                            (ExpcurrX >= Expcap) ->
                                write('Level Up!\n'),
                                addlv(Lv, LvX),
                                addexpcapv(Expcap, ExpcapX),
                                mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, ExpcapX, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'addexpcap',
                        addexpcapv(Expcap, ExpcapX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, ExpcapX, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'addgold',
                        addgoldv(Gold, GoldX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    /* Fungsi addHour telah menghandle kasus apabila melewati 1 hari */
                    Input == 'addHour',
                        add_hourv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('Its a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is 0,
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch, Alc)
                        );

                    Input == 'addDay',
                        add_dayv(Day, DayX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, Hour, Qharvest, Qfish, Qranch, Alc);

                    /* Testing Debug Chear */
                    Input == 'rich',
                        add_goldcheatv(Gold, GoldX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Day, Hour, Qharvest, Qfish, Qranch, Alc);

                    Input == 'daypp',
                        add_daycheatv(Day, DayX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, Hour, Qharvest, Qfish, Qranch, Alc);

                    /* Fungsi hourpp telah menghandle kasus apabila melewati 1 hari */
                    Input == 'hourpp',
                        add_hourcheatv(Hour, HourX),
                        (
                            (HourX >= 24) ->
                                write('Its a New Day!\n'),
                                add_dayv(Day, DayX),
                                HourY is (HourX-24),
                                mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, DayX, HourY, Qharvest, Qfish, Qranch, Alc)
                            ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, HourX, Qharvest, Qfish, Qranch, Alc)
                        );

                    /* Bagian bawah cuman testing reduce aspek aja */
                    Input == 'redQharvest',
                        redQharvest(Qharvest, QharvestX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, QharvestX, Qfish, Qranch, Alc);

                    Input == 'redQfish',
                        redQfish(Qfish, QfishX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, QfishX, Qranch, Alc);

                    Input == 'redQranch',
                        redQranch(Qranch, QranchX),
                        mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, QranchX, Alc);

                    mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc)
                )
            ;write('Penagih hutang tiba di kebun anda dan anda langsung melunasi hutang anda \nCONGRATULATION YOU WIN!\n')
        )
    ;write('Penagih hutang tiba di kebun dan mengambil alih kebun \nGAME OVER\n').

startGame :-
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
    nl, nl, nl, nl, nl,
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

exitGame :-
    nl,nl,
    write('>> GAME OVER <<'), nl.

chooseJob(Job, Lvfarming, Lvfishing, Lvranching) :-
    nl,
    write('Welcome to Harvest Star, Choose your job'), nl,
    write('1. Fisherman'), nl,
    write('2. Farmer'), nl,
    write('3. Rancher'), nl,
    read(JobX),
    (
        (JobX =:= 1) ->
            Job is JobX,
            Lvfarming is 0,
            Lvfishing is 5,
            Lvranching is 0,
            write('You choose Fisherman, let\'s go');

        (JobX =:= 2) ->
            Job is JobX,
            Lvfarming is 5,
            Lvfishing is 0,
            Lvranching is 0,
            write('You choose Farmer, let\'s go');

        (JobX =:= 3) ->
            Job is JobX,
            Lvfarming is 0,
            Lvfishing is 0,
            Lvranching is 5,
            write('You choose Rancher, let\'s go');

        write('Invalid Input'),
        chooseJob(Job, Lvfarming, Lvfishing, Lvranching)
    ).

status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Day, Hour, Qharvest, Qfish, Qranch, Alc) :-
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
    (
        (Qharvest=:=0, Qfish=:=0, Qranch=:=0) ->
            write('You have done your quest, you can now clam the reward');
        write('You have ongoing quest')
    ),
    nl,
    nl.