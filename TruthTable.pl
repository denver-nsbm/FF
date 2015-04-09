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

      
initial_assign([],[]).
initial_assign([X|R],[0|S]) :- initial_assign(R,S).

successor(A,S) :- reverse(A,R),
                  next(R,N),
                  reverse(N,S).

next([0|R],[1|R]).
next([1|R],[0|S]) :- next(R,S).                   
true_value(N,_,_,N) :- member(N,[0,1]).
true_value(X,Vars,A,Val) :- atom(X),
                             lookup(X,Vars,A,Val).
true_value(X and Y,Vars,A,Val) :- true_value(X,Vars,A,VX),
                                   true_value(Y,Vars,A,VY),
                                   b_and(VX,VY,Val).
true_value(X or Y,Vars,A,Val) :-  true_value(X,Vars,A,VX),
                                   true_value(Y,Vars,A,VY),
                                   b_or(VX,VY,Val).
true_value(not X,Vars,A,Val) :-   true_value(X,Vars,A,VX),
                                   b_not(VX,Val).

lookup(X,[X|_],[V|_],V).
lookup(X,[_|Vars],[_|A],V) :- lookup(X,Vars,A,V).  
                         
                         
                         
                         
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

