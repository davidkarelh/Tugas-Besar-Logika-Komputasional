start :-
    write('Setelah mendapat berita Bitkowin auto cuan'), nl,
    write('Brianaldo pun langsung gaskan menjual semua asetnya'), nl,
    write('untuk membeli Bitkowin. Ia bahkan juga meminjam uang'), nl,
    write('kepada rentenir sebesar 2.000.000 gold'), nl,
    write('Keesokan harinya, ternyata harga Bitkowin turun'), nl,
    write('secara drastis sehingga Brianaldo menjadi terjerat'), nl,
    write('utang sebesar 200.00 gold'), nl,
    write('Hal ini pun membuat Brianaldo berpikir keras'), nl,
    write('Setelah beberapa jam berpikir keras, Brianaldo'), nl,
    write('tiba-tiba terpikirkan bahwa Ia memiliki ladang di'), nl,
    write('kampung halamannya. Oleh karena itu, Ia memutuskan'), nl,
    write('untuk balik ke kampung halamannya untuk bekerja'), nl,
    chooseJob(Job), nl,
    /* mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time), */
    /*Count:  1       2          3           4          5           6           7            8        9      10    11    12 */
    mainLoop(Job,1,0,0,0,0,0,0,0,100,500,1), !.


mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time) :-
    read(Input),
    (
        Input == 'status',
            status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time),
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time);
        Input == 'quest',
            quest(Lv),
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time);

        /* Bagian bawah cuman testing add aspek aja */
        Input == 'addlv',
            addlv(Lv, LvX),
            mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time);

        Input == 'addlvfarming',
            addlvfarmingv(Lvfarming, LvfarmingX),
            mainLoop(Job, Lv, LvfarmingX, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time);

        Input == 'addexpfarming',
            addexpfarmingv(Expfarming, ExpfarmingX),
            mainLoop(Job, Lv, Lvfarming, ExpfarmingX, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time);

        Input == 'addlvfishing',
            addlvfishingv(Lvfishing, LvfishingX),
            mainLoop(Job, Lv, Lvfarming, Expfarming, LvfishingX, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time);

        Input == 'addexpfishing',
            addexpfishingv(Expfishing, ExpfishingX),
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, ExpfishingX, Lvranching, Expranching, Expcurr, Expcap, Gold, Time);

        Input == 'addlvranching',
            addlvranchingv(Lvranching, LvranchingX),
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, LvranchingX, Expranching, Expcurr, Expcap, Gold, Time);

        Input == 'addexpranching',
            addexpranchingv(Expranching, ExpranchingX),
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, ExpranchingX, Expcurr, Expcap, Gold, Time);

        /* Sistem penambahan exp di bawah sudah menghandle kasus level up */
        Input == 'addexpcurr',
            addexpcurrv(Expcurr, ExpcurrX),
            (
                (ExpcurrX >= Expcap) ->
                    write('Level Up!\n'),
                    addlv(Lv, LvX),
                    addexpcapv(Expcap, ExpcapX),
                    mainLoop(Job, LvX, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, ExpcapX, Gold, Time)
                ;mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, ExpcurrX, Expcap, Gold, Time)
            );

        Input == 'addexpcap',
            addexpcapv(Expcap, ExpcapX),
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, ExpcapX, Gold, Time);

        Input == 'addgold',
            addgoldv(Gold, GoldX),
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, GoldX, Time);

        Input == 'addtime',
            addtimev(Time, TimeX),
            mainLoop(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, TimeX)
    ).


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

status(Job, Lv, Lvfarming, Expfarming, Lvfishing, Expfishing, Lvranching, Expranching, Expcurr, Expcap, Gold, Time) :-
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
    nl.