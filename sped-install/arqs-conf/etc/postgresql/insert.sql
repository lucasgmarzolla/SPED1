-- Parâmetros padrões do sistema para qq OM
INSERT INTO PARAMETRO (id_parametro,  nm_om, qt_dias_oficio, qt_dias_parte,
qt_dias_radiograma, qt_dias_encaminhamento, qt_dias_fax, qt_dias_nota_bi,
qt_dias_memorando, qt_dias_mdo, qt_dias_relatorio, qt_dias_requerimento,
qt_dias_remessa, qt_dias_restituicao, qt_dias_outro, qt_dias_guia,
ds_cabecalho1, ds_cabecalho2, in_migracao_feita, dia_mes_backup, hora_backup)

VALUES (1, 'Departamento de Ciencia e Tecnologia', 365, 365, 365, 365, 365, 365,
365, 365, 365, 365, 365, 365, 365, 365, 'MINISTERIO DA DEFESA',  
'EXERCITO BRASILEIRO', 'n', 1, '10:00');


-- Insere o Administrador na tabela USUARIO

INSERT INTO USUARIO ("id_usuario", "nm_usuario", "in_excluido", "cd_perfil") 
VALUES  (0, 'admin_sped', 'n', 1);

INSERT INTO PESSOA ("id_pessoa", "nm_login", "nm_completo", "cd_patente", "cd_especialidade",
	"cd_quadro", "dt_cadastro", "in_excluido", "in_aprova", "in_arquiva", "in_assina", "in_despacha", 
	"in_imprime", "in_doc_confidencial", "in_doc_reservado", "in_doc_secreto", "in_doc_ultra_secreto", "nm_guerra", "id_usuario_padrao")
VALUES  (0, 'admin_sped', 'Administrador', 9, 1, 1, null, 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'Nome Guerra Padrao', 0);

INSERT INTO USUARIO_PESSOA ("id_usuario_pessoa", "id_usuario", "id_pessoa", "cd_tipo", "dt_inicio", "dt_cadastro", "dt_fim")
VALUES (0, 0, 0, 1, '01/01/2000', NULL, NULL);
