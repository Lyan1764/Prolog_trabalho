# Prolog_trabalho

________________CINEMA_____________

comando para encontrar o arquivo .pl:
['C:/Users/LYAN/Documents/GitHub/Prolog_trabalho/sistema_recomendacao_filmes.pl'].


                COMANDOS  DE   EXECUÇãO NO PROLOG

assert(assistido(lyan, 'Matrix')). %cadastrar filme ou usuario
------------------------------------------------------------------------------------

?- recomendar_filme(lyan, ficcao, 7.0, 18, Filme, Score). % recomendar os filmes

------------------------------------------------------------------------------------

?- retract(assistido(usuario1, 'Matrix')).       % Remove um registro

------------------------------------------------------------------------------------

retract(assistido(usuario1, 'Filme')).	Remove um filme da lista de assistidos.

------------------------------------------------------------------------------------

retractall(assistido(usuario1, _)).	Remove todos os filmes assistidos por usuario1.

------------------------------------------------------------------------------------