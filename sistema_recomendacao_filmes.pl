
% Fatos: filme(Titulo, Genero, Diretor, Elenco, Ano, Duracao, Idioma, Pais, IMDb, Classificacao)
filme('Matrix', ficcao, 'Wachowski', ['Keanu Reeves', 'Laurence Fishburne'], 1999, 141, frances, eua, 9.4, 18).
filme('Interestelar', ficcao, 'Christopher Nolan', ['Matthew McConaughey', 'Anne Hathaway'], 2014, 171, japones, eua, 9.2, 14).
filme('Gladiador', acao, 'Ridley Scott', ['Russell Crowe', 'Joaquin Phoenix'], 2000, 179, frances, eua, 6.7, 16).
filme('Titanic', romance, 'James Cameron', ['Leonardo DiCaprio', 'Kate Winslet'], 1997, 89, ingles, eua, 8.2, 18).
filme('Coringa', drama, 'Todd Phillips', ['Joaquin Phoenix', 'Robert De Niro'], 2019, 163, ingles, eua, 9.0, 18).
filme('Vingadores: Ultimato', acao, 'Anthony e Joe Russo', ['Robert Downey Jr.', 'Chris Evans'], 2019, 138, coreano, eua, 8.5, 10).
filme('La La Land', romance, 'Damien Chazelle', ['Ryan Gosling', 'Emma Stone'], 2016, 177, espanhol, eua, 7.0, 18).

% Filmes assistidos
assistido(usuario1, 'Matrix').
assistido(usuario1, 'Titanic').

% Regra para recomendar com score
recomendar_filme(Usuario, Genero, NotaMinima, ClassifMax, Filme, Score) :-
    filme(Filme, GeneroF, _, Elenco, _, _, _, _, IMDb, Classificacao),
    not(assistido(Usuario, Filme)),
    Classificacao =< ClassifMax,
    IMDb >= NotaMinima,
    score_filme(Genero, GeneroF, Elenco, Score).

% Score com pesos: +2 para mesmo gênero, +1 para cada ator em comum
score_filme(GeneroDesejado, GeneroFilme, Elenco, Score) :-
    genero_score(GeneroDesejado, GeneroFilme, ScoreGenero),
    ator_score(Elenco, ScoreAtor),
    Score is ScoreGenero + ScoreAtor.

genero_score(G, G, 2).
genero_score(_, _, 0).

ator_score([], 0).
ator_score([_|T], Score) :-
    ator_score(T, Score).

% Explicação textual
explica_recomendacao(Filme, GeneroUsuario, Explicacao) :-
    filme(Filme, GeneroFilme, _, Elenco, _, _, _, _, _, _),
    genero_score(GeneroUsuario, GeneroFilme, P1),
    ator_score(Elenco, P2),
    Total is P1 + P2,
    format(atom(Explicacao), 'Filme recomendado por ter ~w pontos: ~w por gênero e ~w por elenco.', [Total, P1, P2]).
