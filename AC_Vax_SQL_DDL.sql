CREATE TABLE anagrafico (
	CF char(16) NOT NULL,
	Nome varchar(255) NOT NULL,
	Cognome varchar(255) NOT NULL,
	Data_Nascità date NOT NULL,
	CONSTRAINT anagrafico_pk PRIMARY KEY (CF)
);

CREATE TABLE cittadino ( 
	CF char(16) NOT NULL,
	Età smallint,	--Derivabile da anagrafico.Data_nascità
	Occupazione varchar(255),
	Fragilità varchar(255),
	Retro_Positività boolean,
	Prenotazione boolean NOT NULL default FALSE,
	CONSTRAINT cittadino_pk PRIMARY KEY (CF),
	CONSTRAINT cittadino_fk_anagrafico FOREIGN KEY (CF) REFERENCES anagrafico  ON DELETE RESTRICT ON UPDATE RESTRICT 
);


CREATE TABLE residenza (
	CF char(16) NOT NULL,
	comune varchar(255) NOT NULL,
	Indirizzo varchar(255) NOT NULL,
	CONSTRAINT residenza_pk PRIMARY KEY (CF),
	CONSTRAINT residenza_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE reperibilità(
	CF char(16) NOT NULL,
	Email varchar(255),
	Telefono varchar(255),
	CONSTRAINT reperibilità_pk PRIMARY KEY (CF),
	CONSTRAINT reperibilità_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino  ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE tampone (
	CF char(16) NOT NULL,
	Data_tampone date NOT NULL, 
	Ora time NOT NULL, 
	Risultato varchar(255),
	CONSTRAINT sintassi_risultato CHECK (risultato LIKE 'POSITIVO' OR
							 risultato LIKE 'NEGATIVO' OR
							 risultato LIKE 'INCONCLUDENTE'),
	CONSTRAINT tampone_pk PRIMARY KEY (CF,Data_tampone),
	CONSTRAINT tampone_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino(CF)  ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE ricovero (
	CF char(16) NOT NULL,
	Data_inizio date NOT NULL,
	Data_fine date,
	CONSTRAINT ricovero_pk PRIMARY KEY (CF,Data_inizio),
	CONSTRAINT ricovero_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino(CF)  ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE allergia (
	CF char(16) NOT NULL,
	allergene varchar(255) NOT NULL,	--Scelto di non creare una tabella apposta per Allergia
	CONSTRAINT allergia_pk PRIMARY KEY (CF,allergene),
	CONSTRAINT allergia_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino (CF)  ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE patologia (			--Le patologie debbono comprendere anche informazioni generiche
	CF char(16) NOT NULL,			
	Nome_Patologia varchar(255) NOT NULL,
	Presente boolean NOT NULL,
	CONSTRAINT patologia_pk PRIMARY KEY (CF,Nome_Patologia),
	CONSTRAINT patologia_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino (CF) ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE operazione (
	CF char(16) NOT NULL, 
	Nome_Operazione varchar(255) NOT NULL,
	CONSTRAINT operazione_pk PRIMARY KEY (CF,Nome_Operazione),
	CONSTRAINT operazione_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino (CF)  ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE condizione (
	CF char(16) NOT NULL, 
	Nome_Condizione varchar(255) NOT NULL,
	CONSTRAINT condizione_pk PRIMARY KEY (CF,Nome_condizione),
	CONSTRAINT condizione_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino (CF)  ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE greenpass (
	Id_greenpass SERIAL NOT NULL,
	CF char(16) NOT NULL,
	Data_Scadenza date NOT NULL,
	CONSTRAINT greenpass_pk PRIMARY KEY (Id_greenpass),
	CONSTRAINT greenpass_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino (CF)  ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE sospensione_Greenpass (
	CF char(16) NOT NULL,
	Data_Inizio date NOT NULL,
	Data_Fine date,
	CONSTRAINT sospensione_Greenpass_pk PRIMARY KEY (CF, Data_inizio),
	CONSTRAINT sospensione_Greenpass_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino (CF)  ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE operatore_Sanitario (
	CF char(16) NOT NULL,
	tipologia varchar(255) NOT NULL, 
	CONSTRAINT operatore_Sanitario_pk PRIMARY KEY (CF),
	CONSTRAINT operatore_Sanitario_fk_cittadino FOREIGN KEY (CF) REFERENCES cittadino (CF)  ON DELETE RESTRICT ON UPDATE RESTRICT 
);

CREATE TABLE vaccino (
	Nome_vaccino varchar(255) NOT NULL,
	Età_Min smallint NOT NULL,
	Età_Max smallint NOT NULL, 
	Efficacia smallint NOT NULL, 
	Dosi smallint NOT NULL,
	Intervallo_Min_Giorni smallint,
	CONSTRAINT vaccino_pk PRIMARY KEY (Nome_vaccino),
	CONSTRAINT Sintassi_efficacia CHECK (Efficacia >= 0 AND
										 Efficacia <= 100)
);

CREATE TABLE lotto (
	Id_lotto SERIAL NOT NULL,
	Nome_Vaccino varchar(255) NOT NULL,
	Data_Scadenza date NOT NULL,
	Data_Produzione date NOT NULL,
	CONSTRAINT lotto_pk PRIMARY KEY (Id_lotto),
	CONSTRAINT lotto_fk_vaccino FOREIGN KEY (Nome_Vaccino) REFERENCES vaccino ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE centro_Vaccinale (
	Id_centro SERIAL NOT NULL,
	comune varchar(255) NOT NULL,
	Indirizzo varchar(255) NOT NULL,
	CONSTRAINT centroVaccinale_pk PRIMARY KEY (Id_centro)
);

CREATE TABLE distribuzione (
	Id_lotto int NOT NULL,
	Id_centro int NOT NULL,
	Fiale_Ricevute int NOT NULL,
	Fiale_Disponibili int NOT NULL,
	CONSTRAINT distribuzione_pk PRIMARY KEY (Id_lotto, Id_centro),
	CONSTRAINT distribuzione_fk_centro_Vaccinale FOREIGN KEY (Id_centro) REFERENCES centro_Vaccinale ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT distribuzione_fk_lotto FOREIGN KEY (Id_lotto) REFERENCES lotto ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT distribuzione_check_fiale_ricevute CHECK (Fiale_Ricevute > 0)
);

CREATE TABLE afferenza_passata (
	CF char(16) NOT NULL, 
	Id_centro int NOT NULL,
	Data_Inizio date NOT NULL,
	Data_Fine date NOT NULL,
	CONSTRAINT afferenza_Passata_pk PRIMARY KEY (CF,Id_centro),
	CONSTRAINT afferenza_Passata_fk_operatore_Sanitario FOREIGN KEY (CF) REFERENCES operatore_Sanitario  ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT afferenza_Passata_fk_centro_Vaccinale FOREIGN KEY (Id_centro) REFERENCES centro_Vaccinale ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE afferenza_presente (
	CF char(16) NOT NULL, 
	Id_centro int NOT NULL,
	Data_Inizio date NOT NULL,
	CONSTRAINT afferenza_Presente_pk PRIMARY KEY (CF,Id_centro),
	CONSTRAINT afferenza_Presente_fk_operatore_Sanitario FOREIGN KEY (CF) REFERENCES operatore_Sanitario  ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT afferenza_Presente_fk_centro_Vaccinale FOREIGN KEY (Id_centro) REFERENCES centro_Vaccinale ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE appuntamento (
	Id_appuntamento SERIAL NOT NULL,
	Cittadino char(16) NOT NULL, 
	Data_Appuntamento date NOT NULL,
	Ora time NOT NULL, 
	Id_Centro int NOT NULL,
	Vaccinazione boolean NOT NULL, 
	Id_lotto int NOT NULL,
	Operatore char(16),
	CONSTRAINT appuntamento_pk PRIMARY KEY (Id_appuntamento),
	CONSTRAINT appuntamento_fk_cittadino FOREIGN KEY (Cittadino) REFERENCES cittadino ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT appuntamento_fk_centro_vaccinale FOREIGN KEY (Id_Centro) REFERENCES centro_vaccinale ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT appuntamento_fk_lotto FOREIGN KEY (Id_lotto) REFERENCES lotto ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT appuntamento_fk_operatore_sanitario FOREIGN KEY (Operatore) REFERENCES operatore_sanitario  ON DELETE RESTRICT ON UPDATE RESTRICT 
);


CREATE TABLE effetto_Collaterale (
	Id_appuntamento int NOT NULL,
	Nome_effetto_Collaterale varchar(255) NOT NULL, 
	CONSTRAINT effetto_Collaterale_pk PRIMARY KEY (Id_appuntamento, Nome_effetto_Collaterale),
	CONSTRAINT effetto_Collaterale_fk_appuntamento FOREIGN KEY (Id_appuntamento) REFERENCES Appuntamento ON DELETE CASCADE ON UPDATE CASCADE
);
