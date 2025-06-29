# Prolog_trabalho

        ________________CINEMA_____________

comando para encontrar o arquivo .pl lyan :
['C:/Users/LYAN/Documents/GitHub/Prolog_trabalho/sistema_recomendacao_filmes.pl'].


                COMANDOS  DE   EXECUÇãO NO PROLOG

% 1. Listar todos os filmes disponíveis

?- filme(Titulo, _, _, _, _, _, _).
-----------------------------------------------------------------------------
% 2. Ver detalhes de um filme específico

?- filme('Matrix', Genero, Elenco, Ano, IMDb, Classificacao, Pais).
-----------------------------------------------------------------------------
% 3. Buscar filmes por gênero

?- filme(Titulo, ficcao, _, _, _, _, _).
-----------------------------------------------------------------------------

% 4. Buscar filmes por ator no elenco

?- filme(Titulo, _, Elenco, _, _, _, _), member('Keanu Reeves', Elenco).
-----------------------------------------------------------------------------

% 5. Buscar filmes com nota IMDb acima de 8.0

?- filme(Titulo, _, _, _, IMDb, _, _), IMDb > 8.0.
-----------------------------------------------------------------------------

% 6. Ver filmes com determinada classificação indicativa

?- filme(Titulo, _, _, _, _, 14, _).
-----------------------------------------------------------------------------

% 7. Ver filmes de determinado país

?- filme(Titulo, _, _, _, _, _, 'Estados Unidos').
-----------------------------------------------------------------------------

% 8. Recomendar filmes para um usuário (baseado em um filme já assistido)

?- recomendar_filmes(usuario1, 'Matrix', Lista).
-----------------------------------------------------------------------------

% 9. Cadastrar usuário com um filme assistido (modo dinâmico)

?- assertz(assistido(usuario_novo, 'Matrix')).
-----------------------------------------------------------------------------

% 10. Ver todos os filmes assistidos por um usuário

?- assistido(usuario1, Filme).
-----------------------------------------------------------------------------