/* Group Name : Denver 

    Group Members
    - 14208984 N B Iresha Madusanka
    - 14208554 R A Chathura D Rupasinghe
    - 14208981 M Dilrukshi Madagoda
    - 14209238 N H M W Charuni Uthpala Ekanayake

*/

:- op(1000,xfy,'and').
:- op(1000,xfy,'or').
:- op(900,fy,'not').

find_vars(N,V,V) :- member(N,[0,1]),!.   
find_vars(X,Vin,Vout) :- atom(X), 
                         (member(X,Vin) -> Vout = Vin ;  
                                 Vout = [X|Vin]).                
find_vars(X and Y,Vin,Vout) :- find_vars(X,Vin,Vtemp),
                               find_vars(Y,Vtemp,Vout).
find_vars(X or Y,Vin,Vout) :-  find_vars(X,Vin,Vtemp),
                               find_vars(Y,Vtemp,Vout).
find_vars(not X,Vin,Vout) :-   find_vars(X,Vin,Vout).

                         
                         
                         
tt(E) :- find_vars(E,[],V),
         reverse(V,Vars),
         initial_assign(Vars,A),
         write('  '), write(Vars), write('    '), write(E), nl,
         write('-----------------------------------------'), nl,
         write_row(E,Vars,A),
         write('-----------------------------------------'), nl.

write_row(E,Vars,A) :- write('  '), write(A), write('        '), 
                       true_value(E,Vars,A,V), write(V), nl,
                       (successor(A,N) -> write_row(E,Vars,N) ; true).

