% Base de dados dos filmes: filme(Nome, Genero, Elenco, NotaIMDb, ClassificacaoIndicativa).
filme(a, acao, [ator1, ator2], 8.5, 16).
filme(b, comedia, [ator3, ator4], 7.9, 10).
filme(c, acao, [ator1, ator5], 9.0, 14).
filme(d, drama, [ator6, ator7], 6.5, 12).
filme(e, acao, [ator2, ator3], 8.0, 16).

% Filmes assistidos pelo usuário
assistido(usuario1, a).
assistido(usuario1, d).

% Regra para calcular score de similaridade
score(FilmeBase, OutroFilme, Score) :-
    filme(FilmeBase, Genero1, Elenco1, Nota1, Classif1),
    filme(OutroFilme, Genero2, Elenco2, Nota2, Classif2),
    FilmeBase \= OutroFilme,
    GeneroScore is (Genero1 = Genero2 -> 2 ; 0),
    ator_em_comum(Elenco1, Elenco2, AtorScore),
    NotaScore is (Nota2 >= Nota1 -> 1 ; 0),
    ClassifScore is (Classif2 =< Classif1 -> 1 ; 0),
    Score is GeneroScore + AtorScore + NotaScore + ClassifScore.

% Conta pontos para atores em comum
ator_em_comum([], _, 0).
ator_em_comum([H|T], Elenco2, P) :-
    (member(H, Elenco2) -> P1 = 1 ; P1 = 0),
    ator_em_comum(T, Elenco2, P2),
    P is P1 + P2.

% Recomendação de filmes baseada em um filme e usuário
recomendar_filmes(Usuario, FilmeBase, Recomendados) :-
    findall(
        Score-F,
        (filme(F, _, _, _, _), \+ assistido(Usuario, F), score(FilmeBase, F, Score)),
        ListaPontuada
    ),
    sort(0, @>=, ListaPontuada, Ordenada),
    pairs_values(Ordenada, Recomendados).
