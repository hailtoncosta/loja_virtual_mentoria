--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Ubuntu 14.5-2.pgdg22.04+2)
-- Dumped by pg_dump version 15.0 (Ubuntu 15.0-1.pgdg22.04+1)

-- Started on 2022-10-26 23:29:31 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3582 (class 1262 OID 16838)
-- Name: lojavirtual; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE lojavirtual WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'pt_BR.UTF-8';


ALTER DATABASE lojavirtual OWNER TO postgres;

\connect lojavirtual

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 17096)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;

BEGIN
			existe = (select count(1) from pessoafisica where id = NEW.pessoa_id);
		if (existe <= 0) then
			existe = (select count(1) from pessoajuridica where id = NEW.pessoa_id);
		if (existe <= 0) then
			RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
		end if;
	end if;
   return new;
END;
$$;


ALTER FUNCTION public.validachavepessoa() OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 17103)
-- Name: validachavepessoa2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;

BEGIN
			existe = (select count(1) from pessoafisica where id = NEW.pessoa_fornecedor_id);
		if (existe <= 0) then
			existe = (select count(1) from pessoajuridica where id = NEW.pessoa_fornecedor_id);
		if (existe <= 0) then
			RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
		end if;
	end if;
   return new;
END;
$$;


ALTER FUNCTION public.validachavepessoa2() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 16857)
-- Name: acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17078)
-- Name: avalicaoproduto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avalicaoproduto (
    id bigint NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    nota integer NOT NULL
);


ALTER TABLE public.avalicaoproduto OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16851)
-- Name: categoriaproduto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoriaproduto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.categoriaproduto OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16934)
-- Name: contapagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contapagar (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status_conta_pagar character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_total numeric(19,2) NOT NULL,
    pessoa_id bigint NOT NULL,
    pessoa_fornecedor_id bigint NOT NULL
);


ALTER TABLE public.contapagar OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17089)
-- Name: contareceber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contareceber (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status_conta_receber character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_total numeric(19,2) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.contareceber OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16942)
-- Name: cupomdesconto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cupomdesconto (
    id bigint NOT NULL,
    codigo_descricao character varying(255) NOT NULL,
    validade_cupom date NOT NULL,
    valor_porcentagem_desconto numeric(19,2),
    valor_real_desconto numeric(19,2)
);


ALTER TABLE public.cupomdesconto OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16885)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logradouro character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL,
    tipo_endereco character varying(255) NOT NULL
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16928)
-- Name: formapagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.formapagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.formapagamento OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16844)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16957)
-- Name: imagemproduto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imagemproduto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.imagemproduto OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17062)
-- Name: itemvendaloja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itemvendaloja (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    produto_id bigint NOT NULL,
    vendacompralojavirtual_id bigint NOT NULL
);


ALTER TABLE public.itemvendaloja OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16846)
-- Name: marcaproduto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marcaproduto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.marcaproduto OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16970)
-- Name: notafiscalcompra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notafiscalcompra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs character varying(255),
    numero_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_icms numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    contapagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.notafiscalcompra OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 17013)
-- Name: notafiscalvenda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notafiscalvenda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_compra_loja_virtual_id bigint NOT NULL
);


ALTER TABLE public.notafiscalvenda OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16983)
-- Name: notaitemproduto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notaitemproduto (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    notafiscalcompra_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.notaitemproduto OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16863)
-- Name: pessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL
);


ALTER TABLE public.pessoa OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16870)
-- Name: pessoafisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoafisica (
    id bigint NOT NULL,
    email character varying(255),
    nome character varying(255),
    telefone character varying(255),
    cpf character varying(255) NOT NULL,
    data_nascimento date
);


ALTER TABLE public.pessoafisica OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16878)
-- Name: pessoajuridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoajuridica (
    id bigint NOT NULL,
    email character varying(255),
    nome character varying(255),
    telefone character varying(255),
    categoria character varying(255),
    cnpj character varying(255) NOT NULL,
    insc_estadual character varying(255) NOT NULL,
    insc_municipal character varying(255),
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL
);


ALTER TABLE public.pessoajuridica OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16949)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id bigint NOT NULL,
    qtde_alerta_estoque integer,
    qtde_clique integer,
    qtde_estoque integer NOT NULL,
    alerta_qtde_estoque boolean,
    altura double precision NOT NULL,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_youtube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(19,2) NOT NULL,
    ativo boolean NOT NULL
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16862)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_acesso OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 17083)
-- Name: seq_avalicaoproduto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_avalicaoproduto
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_avalicaoproduto OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16856)
-- Name: seq_categoriaproduto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categoriaproduto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_categoriaproduto OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16941)
-- Name: seq_contapagar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_contapagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_contapagar OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16927)
-- Name: seq_contareceber; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_contareceber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_contareceber OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16947)
-- Name: seq_cupomdesconto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_cupomdesconto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cupomdesconto OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16892)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_endereco OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16933)
-- Name: seq_formapagamento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_formapagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_formapagamento OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16964)
-- Name: seq_imagemproduto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_imagemproduto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_imagemproduto OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17067)
-- Name: seq_itemvendaloja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_itemvendaloja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_itemvendaloja OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16845)
-- Name: seq_marcaproduto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_marcaproduto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_marcaproduto OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16977)
-- Name: seq_notafiscalcompra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_notafiscalcompra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_notafiscalcompra OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17018)
-- Name: seq_notafiscalvenda; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_notafiscalvenda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_notafiscalvenda OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17012)
-- Name: seq_notafiscalvendas; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_notafiscalvendas
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_notafiscalvendas OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16988)
-- Name: seq_notaitemproduto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_notaitemproduto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_notaitemproduto OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16877)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_pessoa OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16956)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_produto OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17006)
-- Name: seq_statustrastreio; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_statustrastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_statustrastreio OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16907)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 17026)
-- Name: seq_vendacompralojavirtual; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_vendacompralojavirtual
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vendacompralojavirtual OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16999)
-- Name: statusrastreio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statusrastreio (
    id bigint NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_loja_virtual_id bigint NOT NULL
);


ALTER TABLE public.statusrastreio OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16893)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    data_atual_senha date,
    login character varying(255),
    senha character varying(255),
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16900)
-- Name: usuarios_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE public.usuarios_acesso OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17021)
-- Name: vendacompralojavirtual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendacompralojavirtual (
    id bigint NOT NULL,
    pessoa_id bigint NOT NULL,
    enderecocobranca_id bigint NOT NULL,
    enderecoentrega_id bigint NOT NULL,
    valor_desconto numeric(19,2),
    valor_total numeric(19,2) NOT NULL,
    formapagamento_id bigint NOT NULL,
    notafiscalvenda_id bigint NOT NULL,
    cupomdesconto_id bigint,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_frete numeric(19,2)
);


ALTER TABLE public.vendacompralojavirtual OWNER TO postgres;

--
-- TOC entry 3539 (class 0 OID 16857)
-- Dependencies: 214
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3574 (class 0 OID 17078)
-- Dependencies: 249
-- Data for Name: avalicaoproduto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.avalicaoproduto (id, pessoa_id, produto_id, descricao, nota) VALUES (1, 1, 1, 'teste avaliação produto trigger', 1);


--
-- TOC entry 3537 (class 0 OID 16851)
-- Dependencies: 212
-- Data for Name: categoriaproduto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3553 (class 0 OID 16934)
-- Dependencies: 228
-- Data for Name: contapagar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3576 (class 0 OID 17089)
-- Dependencies: 251
-- Data for Name: contareceber; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3555 (class 0 OID 16942)
-- Dependencies: 230
-- Data for Name: cupomdesconto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3545 (class 0 OID 16885)
-- Dependencies: 220
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3551 (class 0 OID 16928)
-- Dependencies: 226
-- Data for Name: formapagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3559 (class 0 OID 16957)
-- Dependencies: 234
-- Data for Name: imagemproduto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3572 (class 0 OID 17062)
-- Dependencies: 247
-- Data for Name: itemvendaloja; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3536 (class 0 OID 16846)
-- Dependencies: 211
-- Data for Name: marcaproduto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3561 (class 0 OID 16970)
-- Dependencies: 236
-- Data for Name: notafiscalcompra; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3568 (class 0 OID 17013)
-- Dependencies: 243
-- Data for Name: notafiscalvenda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3563 (class 0 OID 16983)
-- Dependencies: 238
-- Data for Name: notaitemproduto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3541 (class 0 OID 16863)
-- Dependencies: 216
-- Data for Name: pessoa; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3542 (class 0 OID 16870)
-- Dependencies: 217
-- Data for Name: pessoafisica; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pessoafisica (id, email, nome, telefone, cpf, data_nascimento) VALUES (1, 'jhailtoncosta@gmail.com', 'Jose Hailton da Costa', '98701-8764', '74587048372', '1976-12-31');


--
-- TOC entry 3544 (class 0 OID 16878)
-- Dependencies: 219
-- Data for Name: pessoajuridica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3557 (class 0 OID 16949)
-- Dependencies: 232
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produto (id, qtde_alerta_estoque, qtde_clique, qtde_estoque, alerta_qtde_estoque, altura, descricao, largura, link_youtube, nome, peso, profundidade, tipo_unidade, valor_venda, ativo) VALUES (1, 1, 1, 10, true, 20, 'produto teste', 50.2, 'dsdsdsdsd', 'nome produto texte', 50, 80.8, '50', 5.00, true);


--
-- TOC entry 3565 (class 0 OID 16999)
-- Dependencies: 240
-- Data for Name: statusrastreio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3547 (class 0 OID 16893)
-- Dependencies: 222
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3548 (class 0 OID 16900)
-- Dependencies: 223
-- Data for Name: usuarios_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3570 (class 0 OID 17021)
-- Dependencies: 245
-- Data for Name: vendacompralojavirtual; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 209
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 215
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_acesso', 1, false);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 250
-- Name: seq_avalicaoproduto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_avalicaoproduto', 1, false);


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 213
-- Name: seq_categoriaproduto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_categoriaproduto', 1, false);


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 229
-- Name: seq_contapagar; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_contapagar', 1, false);


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 225
-- Name: seq_contareceber; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_contareceber', 1, false);


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 231
-- Name: seq_cupomdesconto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_cupomdesconto', 1, false);


--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 221
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_endereco', 1, false);


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 227
-- Name: seq_formapagamento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_formapagamento', 1, false);


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 235
-- Name: seq_imagemproduto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_imagemproduto', 1, false);


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 248
-- Name: seq_itemvendaloja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_itemvendaloja', 1, false);


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 210
-- Name: seq_marcaproduto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_marcaproduto', 1, false);


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 237
-- Name: seq_notafiscalcompra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_notafiscalcompra', 1, false);


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 244
-- Name: seq_notafiscalvenda; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_notafiscalvenda', 1, false);


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 242
-- Name: seq_notafiscalvendas; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_notafiscalvendas', 1, false);


--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 239
-- Name: seq_notaitemproduto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_notaitemproduto', 1, false);


--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 218
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_pessoa', 1, false);


--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 233
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_produto', 1, false);


--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 241
-- Name: seq_statustrastreio; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_statustrastreio', 1, false);


--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 224
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_usuario', 1, false);


--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 246
-- Name: seq_vendacompralojavirtual; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_vendacompralojavirtual', 1, false);


--
-- TOC entry 3320 (class 2606 OID 16861)
-- Name: acesso acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 17082)
-- Name: avalicaoproduto avalicaoproduto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avalicaoproduto
    ADD CONSTRAINT avalicaoproduto_pkey PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 16855)
-- Name: categoriaproduto categoriaproduto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriaproduto
    ADD CONSTRAINT categoriaproduto_pkey PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 16940)
-- Name: contapagar contapagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contapagar
    ADD CONSTRAINT contapagar_pkey PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 17095)
-- Name: contareceber contareceber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contareceber
    ADD CONSTRAINT contareceber_pkey PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 16946)
-- Name: cupomdesconto cupomdesconto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupomdesconto
    ADD CONSTRAINT cupomdesconto_pkey PRIMARY KEY (id);


--
-- TOC entry 3328 (class 2606 OID 16891)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 3336 (class 2606 OID 16932)
-- Name: formapagamento formapagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formapagamento
    ADD CONSTRAINT formapagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 3344 (class 2606 OID 16963)
-- Name: imagemproduto imagemproduto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagemproduto
    ADD CONSTRAINT imagemproduto_pkey PRIMARY KEY (id);


--
-- TOC entry 3356 (class 2606 OID 17066)
-- Name: itemvendaloja itemvendaloja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itemvendaloja
    ADD CONSTRAINT itemvendaloja_pkey PRIMARY KEY (id);


--
-- TOC entry 3316 (class 2606 OID 16850)
-- Name: marcaproduto marcaproduto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marcaproduto
    ADD CONSTRAINT marcaproduto_pkey PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 16976)
-- Name: notafiscalcompra notafiscalcompra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notafiscalcompra
    ADD CONSTRAINT notafiscalcompra_pkey PRIMARY KEY (id);


--
-- TOC entry 3352 (class 2606 OID 17017)
-- Name: notafiscalvenda notafiscalvenda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notafiscalvenda
    ADD CONSTRAINT notafiscalvenda_pkey PRIMARY KEY (id);


--
-- TOC entry 3348 (class 2606 OID 16987)
-- Name: notaitemproduto notaitemproduto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notaitemproduto
    ADD CONSTRAINT notaitemproduto_pkey PRIMARY KEY (id);


--
-- TOC entry 3322 (class 2606 OID 16869)
-- Name: pessoa pessoa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa
    ADD CONSTRAINT pessoa_pkey PRIMARY KEY (id);


--
-- TOC entry 3324 (class 2606 OID 16876)
-- Name: pessoafisica pessoafisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoafisica
    ADD CONSTRAINT pessoafisica_pkey PRIMARY KEY (id);


--
-- TOC entry 3326 (class 2606 OID 16884)
-- Name: pessoajuridica pessoajuridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoajuridica
    ADD CONSTRAINT pessoajuridica_pkey PRIMARY KEY (id);


--
-- TOC entry 3342 (class 2606 OID 16955)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2606 OID 17005)
-- Name: statusrastreio statusrastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statusrastreio
    ADD CONSTRAINT statusrastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 3332 (class 2606 OID 16926)
-- Name: usuarios_acesso uk_8bak9jswon2id2jbunuqlfl9e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT uk_8bak9jswon2id2jbunuqlfl9e UNIQUE (acesso_id);


--
-- TOC entry 3334 (class 2606 OID 16906)
-- Name: usuarios_acesso unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 3330 (class 2606 OID 16899)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 17025)
-- Name: vendacompralojavirtual vendacompralojavirtual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendacompralojavirtual
    ADD CONSTRAINT vendacompralojavirtual_pkey PRIMARY KEY (id);


--
-- TOC entry 3393 (class 2620 OID 17106)
-- Name: contareceber validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.contareceber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3377 (class 2620 OID 17108)
-- Name: endereco validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3385 (class 2620 OID 17110)
-- Name: notafiscalcompra validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.notafiscalcompra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3379 (class 2620 OID 17112)
-- Name: usuario validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3387 (class 2620 OID 17114)
-- Name: vendacompralojavirtual validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.vendacompralojavirtual FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3394 (class 2620 OID 17107)
-- Name: contareceber validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.contareceber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3378 (class 2620 OID 17109)
-- Name: endereco validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3386 (class 2620 OID 17111)
-- Name: notafiscalcompra validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.notafiscalcompra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3380 (class 2620 OID 17113)
-- Name: usuario validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3388 (class 2620 OID 17115)
-- Name: vendacompralojavirtual validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.vendacompralojavirtual FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3389 (class 2620 OID 17097)
-- Name: avalicaoproduto validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.avalicaoproduto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3390 (class 2620 OID 17098)
-- Name: avalicaoproduto validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON public.avalicaoproduto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3391 (class 2620 OID 17099)
-- Name: avalicaoproduto validachavepessoacontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar BEFORE UPDATE ON public.avalicaoproduto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3381 (class 2620 OID 17101)
-- Name: contapagar validachavepessoacontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar BEFORE UPDATE ON public.contapagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3392 (class 2620 OID 17100)
-- Name: avalicaoproduto validachavepessoacontapagar2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar2 BEFORE INSERT ON public.avalicaoproduto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3382 (class 2620 OID 17102)
-- Name: contapagar validachavepessoacontapagar2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar2 BEFORE INSERT ON public.contapagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3383 (class 2620 OID 17104)
-- Name: contapagar validachavepessoacontapagarpessoa_fornecedor_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarpessoa_fornecedor_id BEFORE UPDATE ON public.contapagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 3384 (class 2620 OID 17105)
-- Name: contapagar validachavepessoacontapagarpessoa_fornecedor_id2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarpessoa_fornecedor_id2 BEFORE INSERT ON public.contapagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 3361 (class 2606 OID 16908)
-- Name: usuarios_acesso acesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT acesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acesso(id);


--
-- TOC entry 3364 (class 2606 OID 16978)
-- Name: notafiscalcompra contapagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notafiscalcompra
    ADD CONSTRAINT contapagar_fk FOREIGN KEY (contapagar_id) REFERENCES public.contapagar(id);


--
-- TOC entry 3369 (class 2606 OID 17052)
-- Name: vendacompralojavirtual cupomdesconto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendacompralojavirtual
    ADD CONSTRAINT cupomdesconto_fk FOREIGN KEY (cupomdesconto_id) REFERENCES public.cupomdesconto(id);


--
-- TOC entry 3370 (class 2606 OID 17027)
-- Name: vendacompralojavirtual enderecocobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendacompralojavirtual
    ADD CONSTRAINT enderecocobranca_fk FOREIGN KEY (enderecocobranca_id) REFERENCES public.endereco(id);


--
-- TOC entry 3371 (class 2606 OID 17032)
-- Name: vendacompralojavirtual enderecoentrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendacompralojavirtual
    ADD CONSTRAINT enderecoentrega_fk FOREIGN KEY (enderecoentrega_id) REFERENCES public.endereco(id);


--
-- TOC entry 3372 (class 2606 OID 17037)
-- Name: vendacompralojavirtual formapagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendacompralojavirtual
    ADD CONSTRAINT formapagamento_fk FOREIGN KEY (formapagamento_id) REFERENCES public.formapagamento(id);


--
-- TOC entry 3365 (class 2606 OID 16989)
-- Name: notaitemproduto notafiscalcompra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notaitemproduto
    ADD CONSTRAINT notafiscalcompra_fk FOREIGN KEY (notafiscalcompra_id) REFERENCES public.notafiscalcompra(id);


--
-- TOC entry 3373 (class 2606 OID 17042)
-- Name: vendacompralojavirtual notafiscalvenda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendacompralojavirtual
    ADD CONSTRAINT notafiscalvenda_fk FOREIGN KEY (notafiscalvenda_id) REFERENCES public.notafiscalvenda(id);


--
-- TOC entry 3363 (class 2606 OID 16965)
-- Name: imagemproduto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagemproduto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3366 (class 2606 OID 16994)
-- Name: notaitemproduto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notaitemproduto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3374 (class 2606 OID 17068)
-- Name: itemvendaloja produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itemvendaloja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3376 (class 2606 OID 17084)
-- Name: avalicaoproduto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avalicaoproduto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3362 (class 2606 OID 16913)
-- Name: usuarios_acesso usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 3368 (class 2606 OID 17047)
-- Name: notafiscalvenda vendacompralojavirtual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notafiscalvenda
    ADD CONSTRAINT vendacompralojavirtual_fk FOREIGN KEY (venda_compra_loja_virtual_id) REFERENCES public.vendacompralojavirtual(id);


--
-- TOC entry 3367 (class 2606 OID 17057)
-- Name: statusrastreio vendacompralojavirtual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statusrastreio
    ADD CONSTRAINT vendacompralojavirtual_fk FOREIGN KEY (venda_compra_loja_virtual_id) REFERENCES public.vendacompralojavirtual(id);


--
-- TOC entry 3375 (class 2606 OID 17073)
-- Name: itemvendaloja vendacompralojavirtual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itemvendaloja
    ADD CONSTRAINT vendacompralojavirtual_fk FOREIGN KEY (vendacompralojavirtual_id) REFERENCES public.vendacompralojavirtual(id);


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2022-10-26 23:29:32 -03

--
-- PostgreSQL database dump complete
--

