/* Group Name : Denver 

    Group Members
    - 14208984 N B Iresha Madusanka
    - 14208554 R A Chathura D Rupasinghe
    - 14208981 M Dilrukshi Madagoda
    - 14209238 N H M W Charuni Uthpala Ekanayake

*/

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

