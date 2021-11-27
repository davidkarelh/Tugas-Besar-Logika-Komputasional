
season(DAY, SEASON):-
    (
        DAY < 331,
            SEASON is 'kemarau';
        SEASON is 'hujan'
    ).