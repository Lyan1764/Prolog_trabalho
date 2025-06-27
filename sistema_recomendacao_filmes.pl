% Fatos: filme(Titulo, Genero, Diretor, Elenco, Ano, Duracao, Idioma, Pais, IMDb, Classificacao)
filme('Matrix', ficcao, 'Wachowski', ['Keanu Reeves', 'Laurence Fishburne'], 1999, 141, frances, eua, 9.4, 18).
filme('Interestelar', ficcao, 'Christopher Nolan', ['Matthew McConaughey', 'Anne Hathaway'], 2014, 171, japones, eua, 9.2, 14).
filme('Gladiador', acao, 'Ridley Scott', ['Russell Crowe', 'Joaquin Phoenix'], 2000, 179, frances, eua, 6.7, 16).
filme('Titanic', romance, 'James Cameron', ['Leonardo DiCaprio', 'Kate Winslet'], 1997, 89, ingles, eua, 8.2, 18).
filme('Coringa', drama, 'Todd Phillips', ['Joaquin Phoenix', 'Robert De Niro'], 2019, 163, ingles, eua, 9.0, 18).
filme('Vingadores: Ultimato', acao, 'Anthony e Joe Russo', ['Robert Downey Jr.', 'Chris Evans'], 2019, 138, coreano, eua, 8.5, 10).
filme('La La Land', romance, 'Damien Chazelle', ['Ryan Gosling', 'Emma Stone'], 2016, 177, espanhol, eua, 7.0, 18).
filme('John Wick', acao, 'Chad Stahelski', ['Keanu Reeves'], 2014, 101, ingles, eua, 7.4, 18).
filme('Gente Grande 1', comedia, 'Dennis Dugan',['Adam Sandler', 'Kevin James', 'Chris Rock', 'David Spade', 'Rob Schneider'],2010, 102, ingles, eua, 6.0, 14).
filme('Gente Grande 2', comedia, 'Dennis Dugan',['Adam Sandler', 'Kevin James', 'Chris Rock', 'David Spade', 'Rob Schneider'],2013, 101, ingles, eua, 5.4, 12).


:- dynamic assistido/2.

assistido(usuario1, 'Matrix').
assistido(usuario1, 'Titanic').

% Regra principal
recomendar_filme(Usuario, FilmeBase, NotaMinima, ClassifMax, Recomendacao, Score) :-
    filme(FilmeBase, Genero, Diretor, ElencoBase, _, _, _, _, _, _),
    filme(Recomendacao, G, D, E, _, _, _, _, IMDb, Classif),
    not(assistido(Usuario, Recomendacao)),
    Classif =< ClassifMax,
    IMDb >= NotaMinima,
    score_filme(Genero, G, Diretor, D, ElencoBase, E, IMDb, Score).

% Sistema de pontuação completo
score_filme(GeneroDesejado, GeneroFilme, DiretorDesejado, DiretorFilme, ElencoBase, ElencoFilme, IMDb, Score) :-
    genero_score(GeneroDesejado, GeneroFilme, ScoreGenero),
    diretor_score(DiretorDesejado, DiretorFilme, ScoreDiretor),
    ator_score(ElencoBase, ElencoFilme, ScoreAtor),
    imdb_score(IMDb, ScoreIMDb),
    Score is ScoreGenero + ScoreDiretor + ScoreAtor + ScoreIMDb.

% Critérios de pontuação
genero_score(G, G, 2) :- !.
genero_score(_, _, 0).

diretor_score(D, D, 1) :- !.
diretor_score(_, _, 0).

ator_score(ElencoBase, ElencoFilme, Score) :-
    intersection(ElencoBase, ElencoFilme, AtoresComuns),
    length(AtoresComuns, Score).

imdb_score(IMDb, Score) :-
    (IMDb >= 8.0 -> Score = 1 ; Score = 0).

% Recomendações ordenadas
recomendacoes_ordenadas(Usuario, FilmeBase, NotaMinima, ClassifMax, Recomendacoes) :-
    findall(Score-Filme, 
            recomendar_filme(Usuario, FilmeBase, NotaMinima, ClassifMax, Filme, Score),
            Lista),
    keysort(Lista, Ordenada),
    reverse(Ordenada, OrdenadaDesc),
    pairs_values(OrdenadaDesc, Recomendacoes).

% Explicação textual
explica_recomendacao(Filme, FilmeBase, Explicacao) :-
    filme(FilmeBase, Genero, Diretor, ElencoBase, _, _, _, _, _, _),
    filme(Filme, GeneroFilme, DiretorFilme, ElencoFilme, _, _, _, _, IMDb, _),
    genero_score(Genero, GeneroFilme, P1),
    diretor_score(Diretor, DiretorFilme, P2),
    ator_score(ElencoBase, ElencoFilme, P3),
    imdb_score(IMDb, P4),
    Total is P1 + P2 + P3 + P4,
    format(atom(Explicacao), 
           'Recomendacao (~w pts): ~w por genero, ~w por diretor, ~w por atores, ~w por IMDb > 8.0',
           [Total, P1, P2, P3, P4]).