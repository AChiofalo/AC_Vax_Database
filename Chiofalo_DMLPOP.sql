INSERT INTO anagrafico (CF, Nome, Cognome, Data_Nascità)		
			VALUES  ('XNBLVV74L07A572R', 'Simone', 'Varano', '1951-06-21'),
					('SHKGYC43E09F669M', 'Ruggiero', 'Grossi', '1989-01-01'),
					('PRJPYG63L15L059E', 'Giosuè', 'Cociarelli','1976-05-11'),
					('FSNLTG74R44G229C', 'Bettina', 'Gonzaga','1971-10-24'),
					('YFRDGS51S14D218H', 'Maurizio', 'Montalcini','2003-11-04'),
					('CPMNNG53M43L887V', 'Carla', 'Grassi','1963-03-17'),
					('JGYRCO60P59A430O', 'Marta', 'Bianchi','1983-01-10'),
					('TPTSHF89R54L880Q', 'Bruna', 'Neri','1965-03-17');
					

INSERT INTO cittadino (CF, Età, Occupazione, Fragilità, Retro_Positività, Prenotazione) 
			VALUES  ('XNBLVV74L07A572R', 71,'Pensionato','IMMUNO DEPRESSO', FALSE, FALSE), 
					('SHKGYC43E09F669M', 34,'Personale Scolastisco/Universitario',NULL, FALSE, TRUE),
					('PRJPYG63L15L059E', 46,'Personale Sanitario',NULL, TRUE, TRUE), 
					('FSNLTG74R44G229C', 51,'Personale Sanitario',NULL, TRUE, TRUE),
					('YFRDGS51S14D218H', 19,'Studente',NULL, TRUE, FALSE ), 
					('CPMNNG53M43L887V', 59,'Libero Professionista',NULL, FALSE, FALSE);

INSERT INTO residenza (CF,comune,Indirizzo)
			VALUES ('XNBLVV74L07A572R','Milano','Piazza Carlo 2' ),
				('SHKGYC43E09F669M','Torino','Via Roma 31'),
				('PRJPYG63L15L059E','Torino','Via Roma 121'),
				('FSNLTG74R44G229C','Milano','Piazza Carlo 5'),
				('YFRDGS51S14D218H','Torino','Corso Nuovo 54'),
				('CPMNNG53M43L887V','Milano','Piazza Carlo 29');

INSERT INTO reperibilità (CF,Email,Telefono)
			VALUES ('XNBLVV74L07A572R','nikgera@texasaol.com',NULL ),
				('SHKGYC43E09F669M','sharon@live.com',NULL),
				('PRJPYG63L15L059E',NULL,'3330001110'),
				('FSNLTG74R44G229C',NULL,'4440001110'),
				('YFRDGS51S14D218H',NULL,'5550001110'),
				('CPMNNG53M43L887V',NULL,'6660001110');
	

INSERT INTO tampone (CF, Data_Tampone, Ora, Risultato)
			VALUES ('YFRDGS51S14D218H','2022-02-04','12:40','NEGATIVO'),
			 		('YFRDGS51S14D218H','2022-02-03','8:00','NEGATIVO'),
					 ('XNBLVV74L07A572R','2022-01-24','10:00','POSITIVO');
			
INSERT INTO ricovero (CF, Data_Inizio, Data_Fine)
			VALUES ('CPMNNG53M43L887V','2021-07-01','2021-07-15');
	
INSERT INTO allergia (CF, allergene)
			VALUES ('XNBLVV74L07A572R','AMOXICILLINA'),
					('SHKGYC43E09F669M','ACIDO ACETILSALICILICO');	--Anche i non fragili possono avere allergie.
			
INSERT INTO patologia (CF, Nome_Patologia, Presente)
			VALUES ('XNBLVV74L07A572R','BETA-TALASEMMIA',TRUE);

INSERT INTO operazione (CF, Nome_Operazione)
			VALUES ('XNBLVV74L07A572R','CORREZIONE FRATTURA FEMORE');
			
INSERT INTO condizione (CF, nome_condizione)
			VALUES ('XNBLVV74L07A572R','INTOLLERANZA AL GLUTINE');
			
INSERT INTO greenpass (CF, Data_Scadenza)
			VALUES ('XNBLVV74L07A572R','2022-01-16');
			
INSERT INTO sospensione_Greenpass(CF, Data_Inizio, Data_Fine)
			VALUES ('XNBLVV74L07A572R','2022-01-24','2022-02-04');
			
INSERT INTO operatore_Sanitario(CF, Tipologia)
			VALUES ('PRJPYG63L15L059E','Medico di Base'),
					('FSNLTG74R44G229C','Altro Medico');
					
INSERT INTO vaccino(Nome_vaccino, Età_Min, Età_Max, Efficacia, Dosi, Intervallo_Min_Giorni)
			VALUES ('COVIDIN',12,85,85,2,15),
					('CORONAX',21,92,82,2,15),
					('FLUSTOP',12,95,79,1,NULL);
					

INSERT INTO lotto (Nome_Vaccino, Data_Scadenza, Data_Produzione)
			VALUES ('COVIDIN','2022-03-21','2022-01-21'),
					('COVIDIN','2022-03-21','2022-01-02'),
					('CORONAX','2022-03-12','2022-01-12'),
					('FLUSTOP','2022-04-18','2022-01-18');
					
INSERT INTO centro_Vaccinale(Comune, Indirizzo)
			VALUES ('Milano','Via De Carli 23'),
					('Torino','Via Roma 123');

INSERT INTO distribuzione(id_lotto, id_centro, Fiale_Ricevute, Fiale_Disponibili)
			VALUES (1,1,35,35),
					(2,1,20,20),
					(3,1,35,33),
					(1,2,20,20),
					(2,2,40,40),
					(3,2,40,40),
					(4,2,10,9),
					(4,1,10,9);
				
INSERT INTO afferenza_Passata(CF,id_centro,Data_Inizio,Data_Fine)
			VALUES ('PRJPYG63L15L059E',1,'2021-09-01','2021-10-20');
			
INSERT INTO afferenza_Presente(CF,id_centro,Data_Inizio)
			VALUES ('PRJPYG63L15L059E',2,'2021-11-01'),
					('FSNLTG74R44G229C',1,'2021-11-01');

INSERT INTO appuntamento (Cittadino, Data_Appuntamento, Ora, id_centro,
							Vaccinazione, id_lotto, Operatore)
			VALUES ('YFRDGS51S14D218H','2022-03-03','10:00',2,FALSE,4,'PRJPYG63L15L059E'),
					('XNBLVV74L07A572R','2022-01-01','12:30',1,TRUE,3,'FSNLTG74R44G229C'),
					('XNBLVV74L07A572R','2022-01-16','14:30',1,TRUE,3,'FSNLTG74R44G229C'),
					('CPMNNG53M43L887V','2022-02-01','12:30',1,FALSE,3,'FSNLTG74R44G229C');
					
INSERT INTO effetto_Collaterale (id_appuntamento, nome_effetto_collaterale)
			VALUES (3,'Cefalea');