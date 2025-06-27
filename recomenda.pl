
% Fatos sobre filmes
filme(interstellar, [ficcao, drama], [matthew_mcconaughey, anne_hathaway], 8.6, 12, eua).
filme(interestelar, [ficcao, drama], [matthew_mcconaughey, anne_hathaway], 8.6, 12, eua).
filme(vingadores, [acao, aventura], [robert_downey_jr, chris_evans], 8.0, 12, eua).
filme(vingadores_ultimato, [acao, ficcao], [robert_downey_jr, chris_evans], 8.4, 12, eua).
filme(vingadores_guerra_infinita, [acao, ficcao], [robert_downey_jr, chris_evans], 8.5, 12, eua).
filme(parasita, [drama, suspense], [song_kang_ho], 8.6, 16, coreia).
filme(coraline, [animacao, fantasia], [dakos    length(GeneroComum, G), GScore is G * 2,
    length(AtorComum, A), AScore is A * 1,
    NotaScore is (Nota2 >= Nota1 -> 1 ; 0),
    PaisScore is (Pais1 = Pais2 -> 1 ; 0),
    Score is GScore + AScore + NotaScore + PaisScore.

% Função para calcular a intersecção de duas listas
intersecao([], _, []).
intersecao([H|T], L2, [H|R]) :- member(H, L2), intersecao(T, L2, R).
intersecao([H|T], L2, R) :- \+ member(H, L2), intersecao(T, L2, R).

% Recomendação principal
recomendar_filmes(Usuario, FilmeBase, Recomendados) :-
    findall(F, (filme(F, _, _, _, _, _), \+ assistido(Usuario, F), F \= FilmeBase), Filmes),
    findall(Score-F,
        (member(F, Filmes), score_similaridade(FilmeBase, F, Score)),
        Pares),
    sort(0, @>=, Pares, Ordenados),
    pares_para_lista(Ordenados, Recomendados).

% Transformar pares Score-Filme em lista somente de filmes
pares_para_lista([], []).
pares_para_lista([_-F|T], [F|R]) :- pares_para_lista(T, R).
