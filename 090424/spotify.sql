DROP DATABASE IF EXISTS spotify;

CREATE DATABASE spotify;

\c spotify;

CREATE SCHEMA externo;

SET search_path TO public, externo;

CREATE TABLE externo.usuario (
    id serial primary key,
    nome text not null,
    email text not null unique,
    senha text not null
);
INSERT INTO externo.usuario (nome, email, senha) VALUES
('Tobias', 'tobias@gmail.com', md5('123')),
('Teobaldo', 'teobaldo@hotmail.com', md5('321')),
('Jordana', 'jordana@vetorial.net', md5('432'));

CREATE TABLE externo.playlist (
    id serial primary key,
    nome text not null,
    data_hora timestamp default current_timestamp,
    usuario_id integer references usuario (id)
);  
INSERT INTO externo.playlist (nome, usuario_id) VALUES
('Melhores segundo Tobias', 1),
('As que eu curto by Teobaldo', 2);

CREATE TABLE artista (
    id serial primary key,
    nome text not null,
    nome_artistico character varying (60)
);
INSERT INTO artista (nome_artistico, nome) VALUES
('Adele', 'Adelaine Freitas'),
('Ed Sheeran', 'Eduardo Pereira');

INSERT INTO artista (nome) VALUES
('Roberto Carlos');

CREATE TABLE album (
    id serial primary key,
    titulo text,
    data_lancamento date,
    artista_id integer references artista (id)
);

INSERT INTO album (titulo, data_lancamento, artista_id) VALUES
('19', '2021-03-03', 1),
('X', '2022-12-12', 2),
('Acústico - Roberto Carlos', '2000-02-10', 3);

CREATE TABLE musica (
    id serial primary key,
    titulo text not null,
    duracao integer check(duracao > 0),
    album_id integer references album (id)
);
INSERT INTO musica (titulo, duracao, album_id) VALUES
('Chasing Pavements', 240, 1),
('photografy', 120, 2),
('detalhes', 150, 3),
('emoções', 200, 3);

CREATE TABLE playlist_musica (
    playlist_id integer references playlist (id),
    musica_id integer references musica (id),
    primary key (playlist_id, musica_id)
);
INSERT INTO playlist_musica (playlist_id, musica_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4);

-- Adicione a coluna data_nascimento na tabela de usuários. Além disso, coloque uma cláusula CHECK permitindo somente anos de nascimento >= 1900
ALTER TABLE usuario ADD COLUMN data_nascimento DATE check (extract(year from data_nascimento) >= 1900);


-- Retorne os nomes dos usuários e suas datas de nascimento formatadas em dia/mes/ano. Para testar será preciso inserir ou atualizar as datas de nascimento de alguns usuários

UPDATE usuario SET data_nascimento = '2000-01-01' where id = 1;
UPDATE usuario SET data_nascimento =  '2010-12-03' where id = 2;
UPDATE usuario SET data_nascimento = '2024-04-01' where id = 3;

select nome, to_char(data_nascimento, 'dd/mm/yyyy') as data_formatada from externo.usuario;

--Delete usuários sem nome
-- resolvido com adição de NOT NULL

-- Torne a coluna nome da tabela usuários obrigatória
-- resolvido com adição de NOT NULL

--Retorne os títulos de todos os álbuns em maiúsculo
Select upper(titulo) from album;

--Retorne somente os títulos dos 2 primeiros álbuns cadastrados
select * from album order by id limit 2;

-- Retorne o nome e o email de todos os usuários separados por ponto-e-vírgula
select nome || ';' || email as nome_email_csv from externo.usuario;
select concat(nome, ';' , email) as nome_email_csv from externo.usuario;

--Retorne músicas com duração entre 100 e 200 segundos
SELECT * FROM musica where duracao between 100 and 200;
SELECT * FROM musica where duracao >= 100 and duracao <= 200;

-- Retorne músicas que não possuem duração entre 100 e 200 segundos
SELECT * FROM musica where duracao < 100 or duracao > 200;
SELECT * FROM musica where duracao not between 100 and 200;
select * from musica except SELECT * FROM musica where duracao between 100 and 200;

-- Retorne artistas que possuem nome e nome artístico
SELECT * FROM artista where nome is not null and nome_artistico is not null;
SELECT nome, nome_artistico from artista where nome is not null intersect select nome, nome_artistico from artista where nome_artistico is not null; 

-- Retorne, preferencialmente, o nome artistico de todos os artistas. Caso um determinado artista não tenha cadastrado seu nome artistico, retorne na mesma consulta seu nome 
SELECT coalesce(nome_artistico, nome) FROM artista;
SELECT case when nome_artistico is not null then nome_artistico else nome end from artista;

-- Retorne o título dos álbuns lançados em 2023
 SELECT * FROM album where extract(year from data_lancamento) = 2023;
-- se fosse generico
SELECT * FROM album where extract(year from data_lancamento) = extract(year from current_date);
SELECT * FROM album where data_lancamento between '2023-01-01' and '2023-12-31';

--Retorne o nome das playlists que foram criadas hoje
select * from externo.playlist where cast(data_hora as date) = CURRENT_DATE;

-- Atualize todos os nomes dos artistas (nome e nome_artistico) para maiúsculo

update artista set nome = upper(nome), nome_artistico = upper(nome_artistico);

-- Coloque uma verificação para a coluna duracao (tabela musica) para que toda duração tenha mais de 0 segundos
-- resolvido com adição de check

-- Adicione uma restrição UNIQUE para a coluna email da tabela usuario
-- resolvido 

-- Retorne somente os artistas que o nome artístico começa com "Leo" (Ex: Leo Santana, Leonardo e etc.)
SELECT * FROM artista where nome_artistico ILIKE 'e%';
SELECT * FROM artista where nome_artistico LIKE 'E%';
SELECT * FROM artista where lower(nome_artistico) LIKE 'e%';
SELECT * FROM artista where upper(nome_artistico) LIKE 'E%';

-- Retorne o título dos álbuns que estão fazendo aniversário neste mês
select * from album where extract(month from data_lancamento) = extract(month from current_date);

--Retorne o título dos álbuns lançados no segundo semestre do ano passado 
 SELECT * FROM album where (extract(month from data_lancamento) >= 7 and extract(month from data_lancamento) <= 12) and extract(year from data_lancamento) = extract(year from current_date) - 1;


-- Retorne o título dos álbuns lançados nos últimos 30 dias
SELECT titulo from album where data_lancamento between CURRENT_DATE - INTERVAL '30 days' and CURRENT_DATE;

-- Retorne o título e o dia de lançamento (por extenso) de todos os álbuns
-- Retorne o título e o mês de lançamento (por extenso) de todos os álbuns
SELECT 
    titulo,
    CASE 
        WHEN extract(dow from data_lancamento) = 0 THEN 'Domingo' 
        WHEN extract(dow from data_lancamento) = 1 THEN 'Segunda' 
        WHEN extract(dow from data_lancamento) = 2 THEN 'Terça' 
        WHEN extract(dow from data_lancamento) = 3 THEN 'Quarta' 
        WHEN extract(dow from data_lancamento) = 4 THEN 'Quinta' 
        WHEN extract(dow from data_lancamento) = 5 THEN 'Sexta' 
        WHEN extract(dow from data_lancamento) = 6 THEN 'Sábado'
    END || ', ' ||
    EXTRACT (day from data_lancamento) ||  ' de ' ||   
     CASE 
        WHEN extract(month from data_lancamento) = 1 THEN 'Janeiro'
        WHEN extract(month from data_lancamento) = 2 THEN 'Fevereiro'
        WHEN extract(month from data_lancamento) = 3 THEN 'Março'
        WHEN extract(month from data_lancamento) = 4 THEN 'Abril'
        WHEN extract(month from data_lancamento) = 5 THEN 'Maio'
        WHEN extract(month from data_lancamento) = 6 THEN 'Junho'
        WHEN extract(month from data_lancamento) = 7 THEN 'Julho'
        WHEN extract(month from data_lancamento) = 8 THEN 'Agosto'
        WHEN extract(month from data_lancamento) = 9 THEN 'Setembro'
        WHEN extract(month from data_lancamento) = 10 THEN 'Outubro'
        WHEN extract(month from data_lancamento) = 11 THEN 'Novembro'
        WHEN extract(month from data_lancamento) = 12 THEN 'Dezembro'
    END || ' de ' || 
    EXTRACT(year from data_lancamento) as data_por_extenso FROM album;

-- Retorne pelo menos um dos álbuns mais antigos
select * from album order by data_lancamento asc limit 1;

-- todos lancados no mesmo dia do album mais antigo 
select * from album where data_lancamento = (SELECT min(data_lancamento) from album);


-- Retorne pelo menos um dos álbuns mais recentes
select * from album order by data_lancamento desc limit 1;

-- Liste os títulos das músicas de todos os álbuns de um determinado artista
-- sem string_Agg
SELECT album.titulo, musica.titulo from album inner join musica on (album.id = musica.album_id) where artista_id = 3; 
-- com string agg
SELECT album.titulo, STRING_AGG(musica.titulo, ',') AS musicas from album inner join musica on (album.id = musica.album_id) where artista_id = 3
GROUP by album.id;

-- Liste somente os nomes de usuários que possuem alguma playlist (cuidado! com a repetição)
INSERT INTO externo.playlist (nome, usuario_id) VALUES
('Melhores segundo Tobias - versão 2', 1);
SELECT DISTINCT externo.usuario.id, externo.usuario.nome from externo.usuario inner join externo.playlist on (externo.usuario.id = externo.playlist.usuario_id) order by externo.usuario.id;

SELECT externo.usuario.id, externo.usuario.nome from externo.usuario inner join externo.playlist on (externo.usuario.id = externo.playlist.usuario_id)  GROUP BY externo.usuario.id order by externo.usuario.id;


SELECT externo.usuario.id, externo.usuario.nome from externo.usuario intersect select externo.usuario.id, externo.usuario.nome from externo.usuario inner join externo.playlist on (externo.usuario.id = externo.playlist.usuario_id);

 SELECT externo.usuario.id, externo.usuario.nome from externo.usuario where id in (select usuario_id from externo.playlist);

-- Liste artistas que ainda não possuem álbuns cadastrados
INSERT INTO artista (nome) VALUES
('Hanson');

SELECT artista.nome from artista where id not in (Select album.artista_id from album);

SELECT artista.id, artista.nome from artista except Select artista.id, artista.nome from artista inner join album on (artista.id = album.artista_id);

SELECT artista.id, artista.nome from artista left join album on (artista.id = album.artista_id) where album.artista_id is null;

-- Liste usuários que ainda não possuem playlists cadastradas
SELECT * FROM externo.usuario where id not in (select usuario_id from externo.playlist);

-- Retorne a quantidade de álbuns por artista
select artista.id, artista.nome, count(*) as qtde from artista inner join album on (artista.id = album.artista_id) group by artista.id order by artista.id;

-- Retorne a quantidade de músicas por artista
select artista.id, artista.nome, count(*) as qtde from artista inner join album on (artista.id = album.artista_id) inner join musica on (album.id = musica.album_id) group by artista.id, album.id order by artista.id;


-- Retorne o título das músicas de uma playlist de um determinado usuário

SELECT playlist.id, playlist.nome, STRING_AGG(musica.titulo, ',') from externo.usuario inner join externo.playlist on (externo.usuario.id = externo.playlist.usuario_id) inner join playlist_musica on (externo.playlist.id = playlist_musica.playlist_id) inner join musica on (musica.id = playlist_musica.musica_id) group by playlist.id;


-- Retorne a quantidade de playlist de um determinado usuário
SELECT externo.usuario.id, externo.usuario.nome, count(*) from externo.usuario inner join externo.playlist on (externo.usuario.id = externo.playlist.usuario_id) group by externo.usuario.id order by externo.usuario.id;

-- Retone a quantidade de músicas por artista (de artistas que possuem pelo menos 2 músicas)
select artista.id, artista.nome, count(*) from artista inner join album on (artista.id = album.artista_id) inner join musica on (album.id = musica.album_id) group by artista.id, artista.nome having count(*) >= 2;

-- Retorne os títulos de todos os álbuns lançados no mesmo ano em que o álbum mais antigo foi lançado
select * from album where extract(year from data_lancamento) = (SELECT extract(year from MIN(data_lancamento)) from album);

-- Retorne os títulos de todos os álbuns lançados no mesmo ano em que o álbum mais novo foi lançado
select * from album where extract(year from data_lancamento) = (SELECT extract(year from max(data_lancamento)) from album);


-- Retorne na mesma consulta os nomes de todos os artistas e de todos os usuários. Caso um determinado artista não tenha cadastrado seu nome, retorne seu nome artístico

SELECT coalesce(artista.nome_artistico, artista.nome) from artista
UNION
SELECT externo.usuario.nome from externo.usuario;

-- Retorne nomes das playlists com e sem músicas
select * from externo.playlist;

-- Retorne a média da quantidade de músicas de todas as playlists
-- by Annie feat. Igor
SELECT cast(cast((SELECT count(DISTINCT musica_id) from playlist_musica) as numeric(8,2))/cast((SELECT count(*) from externo.playlist) as numeric(8,2)) as numeric(8,2)) AS resultado;

-- Retorne somente playlists que possuem quantidade de músicas maior ou igual a média
SELECT externo.playlist.id, externo.playlist.nome, count(*) FROM externo.playlist inner join playlist_musica on (externo.playlist.id = playlist_musica.playlist_id) group by externo.playlist.id having count(*) >= (SELECT cast(cast((SELECT count(DISTINCT musica_id) from playlist_musica) as numeric(8,2))/cast((SELECT count(*) from externo.playlist) as numeric(8,2)) as numeric(8,2)));

