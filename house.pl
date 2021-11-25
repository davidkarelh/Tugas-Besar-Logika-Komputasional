:- include('map.pl').

house:-
    write('What do you want to do?\n'),
    write('-  sleep\n'),
    write('-  exit\n'),
    read(INPUT),
    (
        INPUT == 'sleep',
            
        INPUT == 'exit',

    )