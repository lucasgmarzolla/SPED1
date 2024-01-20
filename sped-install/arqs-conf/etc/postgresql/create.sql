--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: anexo; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE anexo (
    id_anexo integer NOT NULL,
    id_documento integer NOT NULL,
    nm_anexo character varying(100) NOT NULL,
    nm_extensao character varying(15),
    ob_anexo_zip bytea NOT NULL,
    qt_bytes_zip integer NOT NULL,
    in_assinado character varying(1) DEFAULT 'n'::character varying NOT NULL
);


ALTER TABLE public.anexo OWNER TO sped;

--
-- Name: anexo_temp; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE anexo_temp (
    id_anexo_temp integer NOT NULL,
    nm_anexo character varying(100) NOT NULL,
    nm_extensao character varying(15),
    ob_anexo_zip bytea NOT NULL,
    qt_bytes_zip integer NOT NULL
);


ALTER TABLE public.anexo_temp OWNER TO sped;

--
-- Name: anotacao_documento; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE anotacao_documento (
    id_anotacao integer NOT NULL,
    id_documento integer NOT NULL,
    id_usuario integer NOT NULL,
    ds_anotacao text NOT NULL,
    dt_entrada timestamp without time zone NOT NULL,
    id_pessoa integer NOT NULL
);


ALTER TABLE public.anotacao_documento OWNER TO sped;

--
-- Name: anotacao_providencia; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE anotacao_providencia (
    id_anotacao integer NOT NULL,
    id_usuario integer NOT NULL,
    id_providencia integer NOT NULL,
    ds_anotacao text NOT NULL,
    dt_entrada timestamp without time zone NOT NULL,
    id_pessoa integer NOT NULL
);


ALTER TABLE public.anotacao_providencia OWNER TO sped;

--
-- Name: arquivamento; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE arquivamento (
    id_arquivamento integer NOT NULL,
    dt_arquivamento timestamp without time zone NOT NULL,
    id_autor_acao integer NOT NULL,
    qt_documentos integer NOT NULL,
    qt_total_bytes character varying(30) NOT NULL,
    ds_local_destino character varying(100) NOT NULL,
    ds_rotulo_midia character varying(100) NOT NULL,
    cd_tipo_midia integer NOT NULL,
    id_proximo_arquivamento integer,
    in_concluido character varying(1)
);


ALTER TABLE public.arquivamento OWNER TO sped;

--
-- Name: documento; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE documento (
    id_documento integer NOT NULL,
    id_protocolo integer,
    id_tipo integer NOT NULL,
    cd_documento character varying(40) NOT NULL,
    dt_elaboracao timestamp without time zone NOT NULL,
    ds_assunto character varying(300),
    ds_palavra_chave character varying(350),
    ds_referencias character varying(300),
    cd_estado integer NOT NULL,
    ds_armazenado_em character varying(50),
    ds_om_origem character varying(100),
    in_arquivado character varying(1) NOT NULL,
    cd_prioridade integer NOT NULL,
    cd_categoria integer
);


ALTER TABLE public.documento OWNER TO sped;

--
-- Name: documento_arquivamento; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE documento_arquivamento (
    id_documento integer NOT NULL,
    id_arquivamento integer NOT NULL,
    cd_arquive integer,
    nm_arquivo_midia character varying(150)
);


ALTER TABLE public.documento_arquivamento OWNER TO sped;

--
-- Name: documento_elaborado; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE documento_elaborado (
    id_documento integer NOT NULL,
    id_aprovador integer,
    id_autor integer NOT NULL,
    ob_xml_conteudo_zip bytea NOT NULL,
    ob_html_conteudo_zip bytea,
    qt_bytes_zip integer NOT NULL,
    qt_bytes_html_zip integer,
    in_assinado character varying(1) DEFAULT 'n'::character varying NOT NULL,
    id_pessoa_autor integer NOT NULL,
    id_secao integer NOT NULL
);


ALTER TABLE public.documento_elaborado OWNER TO sped;

--
-- Name: documento_vinculo; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE documento_vinculo (
    id_doc_vinculador integer NOT NULL,
    id_doc_vinculado integer NOT NULL,
    tipo_relacionamento integer NOT NULL
);


ALTER TABLE public.documento_vinculo OWNER TO sped;

--
-- Name: email; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE email (
    id_email integer NOT NULL,
    id_pessoa integer NOT NULL,
    ds_email character varying(100) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.email OWNER TO sped;

--
-- Name: encaminhamento; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE encaminhamento (
    id_encaminhamento integer NOT NULL,
    id_autor integer NOT NULL,
    id_documento integer NOT NULL,
    dt_entrada timestamp without time zone NOT NULL,
    id_pessoa_autor integer NOT NULL
);


ALTER TABLE public.encaminhamento OWNER TO sped;

--
-- Name: expedicao; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE expedicao (
    id_expedicao integer NOT NULL,
    id_autor integer NOT NULL,
    id_documento integer NOT NULL,
    nm_om_destino character varying(100) NOT NULL,
    dt_expedicao timestamp without time zone NOT NULL,
    nr_protocolo_correio character varying(20),
    cd_tipo_expedicao integer NOT NULL
);


ALTER TABLE public.expedicao OWNER TO sped;

--
-- Name: historico_acao; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE historico_acao (
    id_historico_acao integer NOT NULL,
    id_usuario integer NOT NULL,
    id_documento integer NOT NULL,
    cd_acao integer NOT NULL,
    dt_acao timestamp without time zone NOT NULL,
    cd_estado integer NOT NULL,
    id_entidade integer,
    id_pessoa integer
);


ALTER TABLE public.historico_acao OWNER TO sped;

--
-- Name: marcador; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE marcador (
    id_marcador integer NOT NULL,
    id_usuario integer NOT NULL,
    nm_marcador character varying(35) NOT NULL
);


ALTER TABLE public.marcador OWNER TO sped;

--
-- Name: marcador_documento; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE marcador_documento (
    id_documento integer NOT NULL,
    id_marcador integer NOT NULL
);


ALTER TABLE public.marcador_documento OWNER TO sped;

--
-- Name: numeracao_secao; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE numeracao_secao (
    id_secao integer NOT NULL,
    cd_tipo_doc integer NOT NULL,
    cd_categoria integer NOT NULL,
    qtd_atual integer,
    ano_contagem date NOT NULL
);


ALTER TABLE public.numeracao_secao OWNER TO sped;

--
-- Name: parametro; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE parametro (
    id_parametro integer NOT NULL,
    nm_om character varying(100) NOT NULL,
    qt_dias_oficio integer,
    qt_dias_parte integer,
    qt_dias_radiograma integer,
    qt_dias_encaminhamento integer,
    qt_dias_fax integer,
    qt_dias_nota_bi integer,
    qt_dias_memorando integer,
    qt_dias_mdo integer,
    qt_dias_relatorio integer,
    qt_dias_requerimento integer,
    qt_dias_remessa integer,
    qt_dias_restituicao integer,
    qt_dias_guia integer,
    qt_dias_outro integer,
    ds_cabecalho1 character varying(100) NOT NULL,
    ds_cabecalho2 character varying(100) NOT NULL,
    ds_cabecalho3 character varying(100),
    ds_cabecalho4 character varying(100),
    ds_cabecalho5 character varying(100),
    in_migracao_feita character varying(1) NOT NULL,
    dia_mes_backup integer NOT NULL,
    hora_backup character varying(5) NOT NULL,
    dispositivo_backup character varying(5),
    nup_contador integer,
    nup_om integer,
    nup_ano integer,
    endereco_om character varying(100),
    cidade_om character varying(100),
    uf_om character varying(10),
    cep_om character varying(100),
    telefone_om character varying(100),
    fax_om character varying(100),
    email_om character varying(100),
    nm_parametro character varying,
    valor_parametro character varying,
    contador_documento integer DEFAULT 0,
    sigla_om character varying(50)
);


ALTER TABLE public.parametro OWNER TO sped;

--
-- Name: pessoa; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE pessoa (
    id_pessoa integer NOT NULL,
    nm_login character varying(20) NOT NULL,
    nm_completo character varying(80) NOT NULL,
    cd_patente integer NOT NULL,
    cd_especialidade integer,
    cd_quadro integer,
    id_usuario_padrao integer,
    dt_cadastro timestamp without time zone,
    in_excluido character varying(1) NOT NULL,
    in_aprova character varying(1) DEFAULT 'n'::character varying NOT NULL,
    in_arquiva character varying(1) DEFAULT 'n'::character varying NOT NULL,
    in_assina character varying(1) DEFAULT 'n'::character varying NOT NULL,
    in_despacha character varying(1) DEFAULT 'n'::character varying NOT NULL,
    in_imprime character varying(1) DEFAULT 'n'::character varying NOT NULL,
    in_doc_confidencial character varying(1) DEFAULT 'n'::character varying NOT NULL,
    in_doc_reservado character varying(1) DEFAULT 'n'::character varying NOT NULL,
    in_doc_secreto character varying(1) DEFAULT 'n'::character varying NOT NULL,
    in_doc_ultra_secreto character varying(1) DEFAULT 'n'::character varying NOT NULL,
    nm_guerra character varying NOT NULL,
    in_encaminha_protocolado character varying(1) DEFAULT 'n'::character varying NOT NULL,
    ob_img_assinatura_zip bytea,
    in_docs_aprova character varying(100) DEFAULT ''::character varying,
    in_docs_arquiva character varying(100) DEFAULT ''::character varying
);


ALTER TABLE public.pessoa OWNER TO sped;

--
-- Name: protocolo; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE protocolo (
    id_protocolo integer NOT NULL,
    id_documento integer NOT NULL,
    dt_entrada timestamp without time zone NOT NULL,
    nup_protocolo character varying(20),
    numero_documento integer
);


ALTER TABLE public.protocolo OWNER TO sped;

--
-- Name: providencia_despacho; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE providencia_despacho (
    id_providencia integer NOT NULL,
    id_documento integer NOT NULL,
    id_autor integer NOT NULL,
    id_destinatario integer NOT NULL,
    dt_entrada timestamp without time zone NOT NULL,
    dt_prazo timestamp without time zone,
    ds_providencia text NOT NULL,
    cd_situacao integer NOT NULL,
    in_lido character varying(1) NOT NULL,
    dt_leitura timestamp without time zone,
    dt_resolucao timestamp without time zone,
    id_pessoa_autor integer NOT NULL,
    id_pessoa_destinatario integer NOT NULL
);


ALTER TABLE public.providencia_despacho OWNER TO sped;

--
-- Name: seq_secao; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_secao
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_secao OWNER TO sped;

--
-- Name: secao; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE secao (
    id_secao integer DEFAULT nextval('seq_secao'::regclass) NOT NULL,
    id_pai integer NOT NULL,
    nm_sigla character varying(10) NOT NULL,
    ds_nome character varying(50) NOT NULL,
    telefone character varying(15),
    fax character varying(15),
    email character varying(50),
    in_excluido character(1) DEFAULT 'n'::bpchar NOT NULL,
    tipo_numeracao integer NOT NULL
);


ALTER TABLE public.secao OWNER TO sped;

--
-- Name: subcaixa; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE subcaixa (
    id_subcaixa integer NOT NULL,
    id_usuario integer NOT NULL,
    id_caixa integer NOT NULL,
    nm_subcaixa character varying(255) NOT NULL
);


ALTER TABLE public.subcaixa OWNER TO sped;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE usuario (
    id_usuario integer NOT NULL,
    nm_usuario character varying(20) NOT NULL,
    in_excluido character varying(1) NOT NULL,
    cd_perfil integer NOT NULL,
    ds_funcao character varying(40),
    dt_cadastro timestamp without time zone,
    cd_cor integer DEFAULT 1
);


ALTER TABLE public.usuario OWNER TO sped;

--
-- Name: usuario_documento; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE usuario_documento (
    id_usuario integer NOT NULL,
    id_documento integer NOT NULL,
    id_caixa integer,
    id_subcaixa integer,
    in_lido character varying(1) DEFAULT 'n'::character varying
);


ALTER TABLE public.usuario_documento OWNER TO sped;

--
-- Name: usuario_encaminhamento; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE usuario_encaminhamento (
    id_usuario integer NOT NULL,
    id_encaminhamento integer NOT NULL,
    dt_leitura timestamp without time zone,
    id_pessoa integer NOT NULL
);


ALTER TABLE public.usuario_encaminhamento OWNER TO sped;

--
-- Name: usuario_pessoa; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE usuario_pessoa (
    id_usuario_pessoa integer NOT NULL,
    id_usuario integer NOT NULL,
    id_pessoa integer NOT NULL,
    cd_tipo integer NOT NULL,
    dt_inicio timestamp without time zone,
    dt_cadastro timestamp without time zone,
    dt_fim timestamp without time zone
);


ALTER TABLE public.usuario_pessoa OWNER TO sped;

--
-- Name: usuario_secao; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE usuario_secao (
    id_usuario integer NOT NULL,
    id_secao integer NOT NULL
);


ALTER TABLE public.usuario_secao OWNER TO sped;

--
-- Name: workflow_secao; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE workflow_secao (
    id_remetente integer NOT NULL,
    id_secao integer NOT NULL
);


ALTER TABLE public.workflow_secao OWNER TO sped;

--
-- Name: workflow_usuario; Type: TABLE; Schema: public; Owner: sped; Tablespace: 
--

CREATE TABLE workflow_usuario (
    id_remetente integer NOT NULL,
    id_destinatario integer NOT NULL
);


ALTER TABLE public.workflow_usuario OWNER TO sped;

--
-- Name: seq_anexo; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_anexo
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_anexo OWNER TO sped;

--
-- Name: seq_anexo_temp; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_anexo_temp
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_anexo_temp OWNER TO sped;

--
-- Name: seq_anotacao_documento; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_anotacao_documento
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_anotacao_documento OWNER TO sped;

--
-- Name: seq_anotacao_providencia; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_anotacao_providencia
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_anotacao_providencia OWNER TO sped;

--
-- Name: seq_arquivamento; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_arquivamento
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_arquivamento OWNER TO sped;

--
-- Name: seq_documento; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_documento
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_documento OWNER TO sped;

--
-- Name: seq_documento_arquivamento; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_documento_arquivamento
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_documento_arquivamento OWNER TO sped;

--
-- Name: seq_documento_elaborado; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_documento_elaborado
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_documento_elaborado OWNER TO sped;

--
-- Name: seq_documento_vinculo; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_documento_vinculo
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_documento_vinculo OWNER TO sped;

--
-- Name: seq_email; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_email
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_email OWNER TO sped;

--
-- Name: seq_encaminhamento; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_encaminhamento
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_encaminhamento OWNER TO sped;

--
-- Name: seq_expedicao; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_expedicao
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_expedicao OWNER TO sped;

--
-- Name: seq_historico_acao; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_historico_acao
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_historico_acao OWNER TO sped;

--
-- Name: seq_marcador; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_marcador
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_marcador OWNER TO sped;

--
-- Name: seq_marcador; Type: SEQUENCE OWNED BY; Schema: public; Owner: sped
--

ALTER SEQUENCE seq_marcador OWNED BY marcador.id_marcador;


--
-- Name: seq_parametro; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_parametro
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_parametro OWNER TO sped;

--
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_pessoa
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_pessoa OWNER TO sped;

--
-- Name: seq_protocolo; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_protocolo
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_protocolo OWNER TO sped;

--
-- Name: seq_providencia_despacho; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_providencia_despacho
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_providencia_despacho OWNER TO sped;

--
-- Name: seq_subcaixa; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_subcaixa
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_subcaixa OWNER TO sped;

--
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_usuario
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO sped;

--
-- Name: seq_usuario_documento; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_usuario_documento
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario_documento OWNER TO sped;

--
-- Name: seq_usuario_encaminhamento; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_usuario_encaminhamento
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario_encaminhamento OWNER TO sped;

--
-- Name: seq_usuario_pessoa; Type: SEQUENCE; Schema: public; Owner: sped
--

CREATE SEQUENCE seq_usuario_pessoa
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario_pessoa OWNER TO sped;

--
-- Name: anexo_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY anexo
    ADD CONSTRAINT anexo_pk PRIMARY KEY (id_anexo);


--
-- Name: anexo_temp_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY anexo_temp
    ADD CONSTRAINT anexo_temp_pk PRIMARY KEY (id_anexo_temp);


--
-- Name: anotacao_documento_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY anotacao_documento
    ADD CONSTRAINT anotacao_documento_pk PRIMARY KEY (id_anotacao);


--
-- Name: anotacao_providencia_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY anotacao_providencia
    ADD CONSTRAINT anotacao_providencia_pk PRIMARY KEY (id_anotacao);


--
-- Name: arquivamento_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY arquivamento
    ADD CONSTRAINT arquivamento_pk PRIMARY KEY (id_arquivamento);


--
-- Name: documento_arquivamento_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY documento_arquivamento
    ADD CONSTRAINT documento_arquivamento_pk PRIMARY KEY (id_documento, id_arquivamento);


--
-- Name: documento_elaborado_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY documento_elaborado
    ADD CONSTRAINT documento_elaborado_pk PRIMARY KEY (id_documento);


--
-- Name: documento_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_pk PRIMARY KEY (id_documento);


--
-- Name: documento_vinculo_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY documento_vinculo
    ADD CONSTRAINT documento_vinculo_pk PRIMARY KEY (id_doc_vinculador, id_doc_vinculado, tipo_relacionamento);


--
-- Name: email_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY email
    ADD CONSTRAINT email_pk PRIMARY KEY (id_email);


--
-- Name: encaminhamento_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY encaminhamento
    ADD CONSTRAINT encaminhamento_pk PRIMARY KEY (id_encaminhamento);


--
-- Name: expedicao_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY expedicao
    ADD CONSTRAINT expedicao_pk PRIMARY KEY (id_expedicao);


--
-- Name: historico_acao_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY historico_acao
    ADD CONSTRAINT historico_acao_pk PRIMARY KEY (id_historico_acao);


--
-- Name: marcador_pkey; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY marcador
    ADD CONSTRAINT marcador_pkey PRIMARY KEY (id_marcador);


--
-- Name: numeracao_secao_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY numeracao_secao
    ADD CONSTRAINT numeracao_secao_pk PRIMARY KEY (id_secao, cd_tipo_doc, cd_categoria, ano_contagem);


--
-- Name: parametro_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY parametro
    ADD CONSTRAINT parametro_pk PRIMARY KEY (id_parametro);


--
-- Name: pessoa_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY pessoa
    ADD CONSTRAINT pessoa_pk PRIMARY KEY (id_pessoa);


--
-- Name: protocolo_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY protocolo
    ADD CONSTRAINT protocolo_pk PRIMARY KEY (id_protocolo);


--
-- Name: providencia_despacho_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY providencia_despacho
    ADD CONSTRAINT providencia_despacho_pk PRIMARY KEY (id_providencia);


--
-- Name: secao_pkey; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY secao
    ADD CONSTRAINT secao_pkey PRIMARY KEY (id_secao);


--
-- Name: subcaixa_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY subcaixa
    ADD CONSTRAINT subcaixa_pk PRIMARY KEY (id_subcaixa);


--
-- Name: usuario_documento_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY usuario_documento
    ADD CONSTRAINT usuario_documento_pk PRIMARY KEY (id_usuario, id_documento);


--
-- Name: usuario_encaminhamento_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY usuario_encaminhamento
    ADD CONSTRAINT usuario_encaminhamento_pk PRIMARY KEY (id_usuario, id_encaminhamento);


--
-- Name: usuario_pessoa_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY usuario_pessoa
    ADD CONSTRAINT usuario_pessoa_pk PRIMARY KEY (id_usuario_pessoa);


--
-- Name: usuario_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (id_usuario);


--
-- Name: usuario_secao_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY usuario_secao
    ADD CONSTRAINT usuario_secao_pk PRIMARY KEY (id_usuario, id_secao);


--
-- Name: workflow_secao_pkey; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY workflow_secao
    ADD CONSTRAINT workflow_secao_pkey PRIMARY KEY (id_remetente, id_secao);


--
-- Name: workflow_usuario_pk; Type: CONSTRAINT; Schema: public; Owner: sped; Tablespace: 
--

ALTER TABLE ONLY workflow_usuario
    ADD CONSTRAINT workflow_usuario_pk PRIMARY KEY (id_remetente, id_destinatario);


--
-- Name: anexo_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX anexo_fkindex1 ON anexo USING btree (id_documento);


--
-- Name: anotacao_documento_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX anotacao_documento_fkindex1 ON anotacao_documento USING btree (id_documento);


--
-- Name: anotacao_documento_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX anotacao_documento_fkindex2 ON anotacao_documento USING btree (id_usuario);


--
-- Name: anotacao_providencia_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX anotacao_providencia_fkindex1 ON anotacao_providencia USING btree (id_providencia);


--
-- Name: anotacao_providencia_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX anotacao_providencia_fkindex2 ON anotacao_providencia USING btree (id_usuario);


--
-- Name: documento_arquivamento_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX documento_arquivamento_fkindex1 ON documento_arquivamento USING btree (id_arquivamento);


--
-- Name: documento_arquivamento_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX documento_arquivamento_fkindex2 ON documento_arquivamento USING btree (id_documento);


--
-- Name: documento_elaborado_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX documento_elaborado_fkindex1 ON documento_elaborado USING btree (id_documento);


--
-- Name: documento_elaborado_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX documento_elaborado_fkindex2 ON documento_elaborado USING btree (id_autor);


--
-- Name: documento_elaborado_fkindex3; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX documento_elaborado_fkindex3 ON documento_elaborado USING btree (id_aprovador);


--
-- Name: documento_elaborado_ukiddocumento; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE UNIQUE INDEX documento_elaborado_ukiddocumento ON documento_elaborado USING btree (id_documento);


--
-- Name: documento_fkindex4; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX documento_fkindex4 ON documento USING btree (id_protocolo);


--
-- Name: documento_ukcod; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE UNIQUE INDEX documento_ukcod ON documento USING btree (cd_documento, ds_om_origem, dt_elaboracao);


--
-- Name: documento_vinculo_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX documento_vinculo_fkindex1 ON documento_vinculo USING btree (id_doc_vinculador);


--
-- Name: documento_vinculo_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX documento_vinculo_fkindex2 ON documento_vinculo USING btree (id_doc_vinculado);


--
-- Name: encaminhamento_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX encaminhamento_fkindex1 ON encaminhamento USING btree (id_documento);


--
-- Name: encaminhamento_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX encaminhamento_fkindex2 ON encaminhamento USING btree (id_autor);


--
-- Name: expedicao_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX expedicao_fkindex1 ON expedicao USING btree (id_documento);


--
-- Name: expedicao_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX expedicao_fkindex2 ON expedicao USING btree (id_autor);


--
-- Name: historico_acao_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX historico_acao_fkindex1 ON historico_acao USING btree (id_documento);


--
-- Name: historico_acao_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX historico_acao_fkindex2 ON historico_acao USING btree (id_usuario);


--
-- Name: numeracao_has_secao_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX numeracao_has_secao_fkindex1 ON secao USING btree (id_secao);


--
-- Name: pessoa_uk; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE UNIQUE INDEX pessoa_uk ON pessoa USING btree (nm_login);


--
-- Name: protocolo_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX protocolo_fkindex1 ON protocolo USING btree (id_documento);


--
-- Name: protocolo_ukdoc; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE UNIQUE INDEX protocolo_ukdoc ON protocolo USING btree (id_documento);


--
-- Name: providencia_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX providencia_fkindex1 ON providencia_despacho USING btree (id_destinatario);


--
-- Name: providencia_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX providencia_fkindex2 ON providencia_despacho USING btree (id_autor);


--
-- Name: providencia_fkindex3; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX providencia_fkindex3 ON providencia_despacho USING btree (id_documento);


--
-- Name: subcaixa_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX subcaixa_fkindex1 ON subcaixa USING btree (id_usuario);


--
-- Name: usuario_has_documento_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX usuario_has_documento_fkindex1 ON usuario_documento USING btree (id_usuario);


--
-- Name: usuario_has_documento_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX usuario_has_documento_fkindex2 ON usuario_documento USING btree (id_documento);


--
-- Name: usuario_has_encaminhamento_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX usuario_has_encaminhamento_fkindex1 ON usuario_encaminhamento USING btree (id_usuario);


--
-- Name: usuario_has_encaminhamento_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX usuario_has_encaminhamento_fkindex2 ON usuario_encaminhamento USING btree (id_encaminhamento);


--
-- Name: usuario_has_pessoa_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX usuario_has_pessoa_fkindex1 ON usuario_pessoa USING btree (id_usuario);


--
-- Name: usuario_has_pessoa_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX usuario_has_pessoa_fkindex2 ON usuario_pessoa USING btree (id_pessoa);


--
-- Name: usuario_has_secao_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX usuario_has_secao_fkindex1 ON usuario USING btree (id_usuario);


--
-- Name: usuario_has_secao_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX usuario_has_secao_fkindex2 ON secao USING btree (id_secao);


--
-- Name: usuario_uk; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE UNIQUE INDEX usuario_uk ON usuario USING btree (nm_usuario);


--
-- Name: workflow_has_usuario_fkindex1; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX workflow_has_usuario_fkindex1 ON usuario USING btree (id_usuario);


--
-- Name: workflow_has_usuario_fkindex2; Type: INDEX; Schema: public; Owner: sped; Tablespace: 
--

CREATE INDEX workflow_has_usuario_fkindex2 ON usuario USING btree (id_usuario);


--
-- Name: rel_14; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY anexo
    ADD CONSTRAINT rel_14 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_15; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY historico_acao
    ADD CONSTRAINT rel_15 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_16; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY documento_elaborado
    ADD CONSTRAINT rel_16 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_17; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY documento_arquivamento
    ADD CONSTRAINT rel_17 FOREIGN KEY (id_arquivamento) REFERENCES arquivamento(id_arquivamento);


--
-- Name: rel_18; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY protocolo
    ADD CONSTRAINT rel_18 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_18; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY documento_arquivamento
    ADD CONSTRAINT rel_18 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_23; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY usuario_encaminhamento
    ADD CONSTRAINT rel_23 FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- Name: rel_24; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY usuario_encaminhamento
    ADD CONSTRAINT rel_24 FOREIGN KEY (id_encaminhamento) REFERENCES encaminhamento(id_encaminhamento);


--
-- Name: rel_24; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT rel_24 FOREIGN KEY (id_protocolo) REFERENCES protocolo(id_protocolo);


--
-- Name: rel_25; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY encaminhamento
    ADD CONSTRAINT rel_25 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_25; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY anotacao_providencia
    ADD CONSTRAINT rel_25 FOREIGN KEY (id_providencia) REFERENCES providencia_despacho(id_providencia);


--
-- Name: rel_25; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY providencia_despacho
    ADD CONSTRAINT rel_25 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_26; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY historico_acao
    ADD CONSTRAINT rel_26 FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- Name: rel_26; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY providencia_despacho
    ADD CONSTRAINT rel_26 FOREIGN KEY (id_destinatario) REFERENCES usuario(id_usuario);


--
-- Name: rel_26; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY encaminhamento
    ADD CONSTRAINT rel_26 FOREIGN KEY (id_autor) REFERENCES usuario(id_usuario);


--
-- Name: rel_26; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY anotacao_documento
    ADD CONSTRAINT rel_26 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_26; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY anotacao_providencia
    ADD CONSTRAINT rel_26 FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- Name: rel_27; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY documento_elaborado
    ADD CONSTRAINT rel_27 FOREIGN KEY (id_autor) REFERENCES usuario(id_usuario);


--
-- Name: rel_27; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY providencia_despacho
    ADD CONSTRAINT rel_27 FOREIGN KEY (id_autor) REFERENCES usuario(id_usuario);


--
-- Name: rel_27; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY expedicao
    ADD CONSTRAINT rel_27 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_28; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY expedicao
    ADD CONSTRAINT rel_28 FOREIGN KEY (id_autor) REFERENCES usuario(id_usuario);


--
-- Name: rel_29; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY anotacao_documento
    ADD CONSTRAINT rel_29 FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- Name: rel_30; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY documento_vinculo
    ADD CONSTRAINT rel_30 FOREIGN KEY (id_doc_vinculador) REFERENCES documento(id_documento);


--
-- Name: rel_31; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY documento_elaborado
    ADD CONSTRAINT rel_31 FOREIGN KEY (id_aprovador) REFERENCES usuario(id_usuario);


--
-- Name: rel_31; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY documento_vinculo
    ADD CONSTRAINT rel_31 FOREIGN KEY (id_doc_vinculado) REFERENCES documento(id_documento);


--
-- Name: rel_31; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY usuario_documento
    ADD CONSTRAINT rel_31 FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- Name: rel_32; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY usuario_documento
    ADD CONSTRAINT rel_32 FOREIGN KEY (id_documento) REFERENCES documento(id_documento);


--
-- Name: rel_34; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY subcaixa
    ADD CONSTRAINT rel_34 FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- Name: rel_35; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY email
    ADD CONSTRAINT rel_35 FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa);


--
-- Name: rel_36; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY usuario_pessoa
    ADD CONSTRAINT rel_36 FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- Name: rel_37; Type: FK CONSTRAINT; Schema: public; Owner: sped
--

ALTER TABLE ONLY usuario_pessoa
    ADD CONSTRAINT rel_37 FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

