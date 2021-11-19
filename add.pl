addlv(Lv, LvX) :-
    LvX is Lv+1.

addlvfarmingv(Lvfarming, LvfarmingX) :-
    LvfarmingX is Lvfarmingo+1.

addexpfarmingv(Expfarming, ExpfarmingX) :-
    ExpfarmingX is Expfarming+20.

addlvfishingv(Lvfishing, LvfishingX) :-
    LvfishingX is Lvfishing+1.

addexpfishingv(Expfishing, ExpfishingX) :-
    ExpfishingX is Expfishing+20.

addlvranchingv(Lvranching, LvranchingX) :-
    LvranchingX is Lvranching+1.

addexpranchingv(Expranching, ExpranchingX) :-
    ExpranchingX is Expranching+1.

addexpcurrv(Expcurr, ExpcurrX) :-
    ExpcurrX is Expcurr+30.

addexpcapv(Expcap, ExpcapX) :-
    ExpcapX is 2*Expcap.

/* Note */
/* Untuk add gold boleh tambah fungsi sendiri mis addgoldquest, dll */
addgoldv(Gold, GoldX) :-
    GoldX is Gold+999.
/* End of Note */

addtimev(Time, TimeX) :-
    TimeX is Time+1.