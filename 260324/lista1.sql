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


13) instapoble=# select usuario.nome, conta.nome_usuario FROM usuario inner join conta on (usuario.id = conta.usuario_id) where conta.id not in (select conta_publicacao.conta_id from conta_publicacao);


instapoble=# SELECT usuario.nome, conta.nome_usuario FROM usuario INNER JOIN conta on (usuario.id = conta.usuario_id) LEFT JOIN conta_publicacao on (conta.id = conta_publicacao.conta_id) where conta_publicacao.publicacao_id is null order by usuario.nome;

instapoble=# SELECT usuario.nome, conta.nome_usuario FROM usuario INNER JOIN conta on (usuario.id = conta.usuario_id) EXCEPT SELECT usuario.nome, conta.nome_usuario FROM usuario INNER JOIN conta on (usuario.id = conta.usuario_id) inner join conta_publicacao on (conta.id = conta_publicacao.conta_id);


14) instapoble=# select usuario.nome, conta.nome_usuario FROM usuario INNER JOIN conta on (usuario.id = conta.usuario_id) INNER JOIN conta_publicacao ON (conta.id = conta_publicacao.conta_id) INNER JOIN publicacao ON (publicacao.id = conta_publicacao.publicacao_id) left join comentario on (comentario.publicacao_id = publicacao.id) where comentario.publicacao_id is null;

15) instapoble=# select conta.id, conta.nome_usuario, count(*) from conta inner join comentario on (conta.id = comentario.conta_id) group by conta.id, conta.nome_usuario having count(*) = (SELECT count(*) FROM conta inner join comentario on (conta.id = comentario.conta_id) group by conta.id ORDER BY count(*) desc limit 1); 

16) instapoble=# select usuario.nome, conta.nome_usuario from usuario inner join conta on (usuario.id = conta.usuario_id)  ORDER BY data_hora_criacao DESC LIMIT 1;

instapoble=# select usuario.nome, conta.nome_usuario from usuario inner join conta on (usuario.id = conta.usuario_id)  ORDER BY conta.id desc limit 1;

-- materia nova: instapoble=# select usuario.nome, conta.nome_usuario from usuario inner join conta on (usuario.id = conta.usuario_id) order by random() limit 1;

-- materia nova: instapoble=# select usuario.nome, conta.nome_usuario from usuario inner join conta on (usuario.id = conta.usuario_id) order by random() offset 1 limit 2;

-- materia nova: instapoble=# select usuario.nome, CASE WHEN usuario.nome ilike 'IGOR%' THEN 'OI igor' else 'voce n eh o igor' end as n_eh_igor from usuario;

17) instapoble=# select usuario.id, usuario.nome, count(*) as qtde from usuario inner join conta on (usuario.id = conta.usuario_id) group by  usuario.id, usuario.nome having count(*) = (select count(*) from usuario inner join conta on (usuario.id = conta.usuario_id) group by usuario.id order by count(*) desc limit 1) order by usuario.id ;


18)select usuario.id, usuario.nome, count(*) as qtde from usuario inner join conta on (usuario.id = conta.usuario_id) group by  usuario.id, usuario.nome having count(*) = (select count(*) from usuario inner join conta on (usuario.id = conta.usuario_id) group by usuario.id order by count(*) asc limit 1) order by usuario.id ;

19) instapoble=# SELECT * FROM comentario where data_hora between CURRENT_TIMESTAMP - INTERVAL '7 days' and CURRENT_TIMESTAMP;

20) instapoble=# select usuario.id, usuario.nome, STRING_AGG(conta.nome_usuario, ',') AS contas from usuario inner join conta on (usuario.id = conta.usuario_id) where data_nascimento = (select data_nascimento from usuario order by data_nascimento asc limit 1)  GROUP by usuario.id, usuario.nome;

-- by Erick : muito melhor!!
21) instapoble=# SELECT usuario.id, usuario.nome from usuario left join conta on (usuario.id = conta.usuario_id) group by usuario.id, usuario.nome, conta.usuario_id order by conta.usuario_id desc;


22) instapoble=# select count(*) as qtde_comentario from comentario where data_hora between '2024-01-03' and '2024-03-31';

23) já tá feita

24/25) instapoble=# SELECT publicacao.id, publicacao.texto, LENGTH(publicacao.texto) as qtde_caracteres from publicacao where length(publicacao.texto) = (Select length(publicacao.texto) from publicacao order by length(publicacao.texto) desc limit 1);

26) jump

27) instapoble=# select conta.id, conta.nome_usuario, count(*) from conta inner join conta_publicacao on (conta.id = conta_publicacao.conta_id) group by conta.id having count(*) = (select count(*) from conta inner join conta_publicacao on (conta.id = conta_publicacao.conta_id) group by conta.id order by count(*) desc limit 1);

28) já fiz

29) já fiz

30) instapoble=# ALTER TABLE conta_publicacao ADD COLUMN data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

31) já fiz

32) já fiz

33) instapoble=# select usuario.id, usuario.nome, to_char(data_nascimento, 'DD/MM/YYYY') as data_nascimento_formatada from usuario;

--materia nova: 
instapoble=# SELECT usuario.id, usuario.nome, coalesce(conta.nome_usuario, 'n tem') as conta from usuario left join conta on (usuario.id = conta.usuario_id);


instapoble=# SELECT usuario.id, usuario.nome, 
    case 
        when conta.nome_usuario is null then 'n tem' 
     else conta.nome_usuario 
     end as conta from usuario left join conta on (usuario.id = conta.usuario_id);

select
    usuario.id,
    usuario.nome,
	case extract(dow from data_nascimento)
		when 0 then 'domingo'
		when 1 then 'segunda'
		when 2 then 'terca'
		when 3 then 'quarta'
		when 4 then 'quinta'
		when 5 then 'sexta'
		when 6 then 'sabado'
	end from usuario;



