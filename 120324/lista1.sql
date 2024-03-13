1)
instapoble=# select usuario.nome, conta.nome_usuario FROM usuario inner join conta on (usuario.id = conta.usuario_id) ORDER BY usuario.nome;

1) 
instapoble=# SELECT usuario.nome, STRING_AGG(conta.nome_usuario, ',') AS contas FROM usuario inner join conta on (usuario.id = conta.usuario_id) GROUP by USUARIO.nome;

2) instapoble=# SELECT publicacao.id, publicacao.texto, arquivo_principal, arquivo.arquivo FROM publicacao left join arquivo on (publicacao.id = arquivo.publicacao_id);

3) 
instapoble=# SELECT publicacao.id, publicacao.texto, STRING_AGG(comentario.texto, ',') FROM publicacao left join comentario on (publicacao.id = comentario.publicacao_id) group by publicacao.id, publicacao.texto;

4) SELECT publicacao.id, publicacao.texto, STRING_AGG(comentario.texto, ',') FROM publicacao inner join comentario on (publicacao.id = comentario.publicacao_id) group by publicacao.id, publicacao.texto;

5) instapoble=# SELECT usuario.nome, count(*) as qtde FROM usuario INNER JOIN conta on (usuario.id = conta.usuario_id) GROUP BY usuario.id, usuario.nome;

6) instapoble=# SELECT usuario.id, usuario.nome, count(*) as qtde from usuario inner join conta on (usuario.id = conta.usuario_id) inner join conta_publicacao on (conta.id = conta_publicacao.conta_id) group by usuario.id, usuario.nome;


7) instapoble=# select publicacao.id, publicacao.texto, count(*) from publicacao inner join comentario on (publicacao.id = comentario.publicacao_id) group by publicacao.id having count(*) = (select count(*) from publicacao inner join comentario on (publicacao.id = comentario.publicacao_id) group by publicacao.id ORDER BY count(*) DESC LIMIT 1);

8) instapoble=# SELECT publicacao.id, publicacao.texto from publicacao left join comentario on (publicacao.id = comentario.publicacao_id) where comentario.id is null;

instapoble=# SELECT publicacao.id, publicacao.texto from publicacao where publicacao.id not in (select comentario.publicacao_id from comentario);

9) instapoble=# select usuario.id, usuario.nome, count(*) from usuario inner join conta on (usuario.id = conta.usuario_id) group by usuario.id, usuario.nome having count(*) = 1;

10) instapoble=# select usuario.id, usuario.nome, count(*) from usuario inner join conta on (usuario.id = conta.usuario_id) group by usuario.id, usuario.nome having count(*) > 1;


11)instapoble=# SELECT publicacao.id, publicacao.texto from publicacao left join arquivo on (publicacao.id = arquivo.publicacao_id) where arquivo.publicacao_id is null; 

instapoble=# SELECT publicacao.id, publicacao.texto from publicacao where id not in (select arquivo.publicacao_id from arquivo);


instapoble=# SELECT publicacao.id, publicacao.texto from publicacao
EXCEPT
SELECT publicacao.id, publicacao.texto from publicacao inner join arquivo on (publicacao.id = arquivo.publicacao_id);


/*
https://pgexercises.com/questions/basic/selectall.html

https://www.hackerrank.com/challenges/revising-the-select-query/problem?isFullScreen=true

https://judge.beecrowd.com/pt/login?redirect=%2Fpt
*/

12) SELECT conta_publicacao.publicacao_id, count(*) from conta inner join conta_publicacao on (conta.id = conta_publicacao.conta_id) group by conta_publicacao.publicacao_id having count(*) > 1;


13) 



