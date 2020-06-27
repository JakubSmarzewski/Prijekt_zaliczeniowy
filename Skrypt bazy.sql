
--Tabela stanowiska(
--            id_stanowiska 		liczba, Klucz G³ówny
--           nazwa_stanowiska(20) 	pole tekstowe do 20 znaków, pole nie mo¿e byæ puste
--                          )
CREATE TABLE stanowiska(
            id_stanowiska NUMBER,
            nazwa_stanowiska VARCHAR2(20) NOT NULL
                          );
ALTER TABLE stanowiska ADD CONSTRAINT pk_stanowiska  PRIMARY KEY(id_stanowiska);     
                     


--Tabela pracownicy(
--                        id_pracownik		liczba, Klucz g³ówny
--                        imie(20) 		pole tekstowe do 20 znaków, pole nie mo¿e byæ puste
--                        nazwisko(40)		pole tekstowe do 40 znaków, pole nie mo¿e byæ puste
--                        plec(1) 		pole tekstowe 1 znak, mo¿liwe opcje do wyboru 'K' - kobieta, 'M' - mê¿czyzna, pole nie mo¿e byæ puste
--                        telefon(9) 		liczba 9 znaków, pole nie mo¿e byæ puste, pole musi byæ unikatowe
--                        narodowosc(30)		pole tekstowe do 30 znaków, pole nie mo¿e byæ puste
--                        stanowisko 		liczba, która odpowiada danemu stanowisku, Klucz obcy(stanowiska.id_stanowiska)
--                        wyplata 		liczba, pole nie mo¿e byæ puste
--                            )
CREATE TABLE pracownicy(
                        id_pracownik NUMBER,
                        imie VARCHAR2(20) NOT NULL,
                        nazwisko VARCHAR2(40) NOT NULL,
                        plec VARCHAR2(1) NOT NULL CHECK(plec IN ('M','K')),
                        telefon Number(9) NOT NULL UNIQUE,
                        narodowosc VARCHAR2(30) NOT NULL,
                        stanowisko NUMBER NOT NULL,
                        wyplata NUMBER NOT NULL
                            );
                            
                            
                            
ALTER TABLE pracownicy ADD CONSTRAINT pk_pracownicy  PRIMARY KEY(id_pracownik);
ALTER TABLE pracownicy ADD CONSTRAINT fk_pracownicy  FOREIGN KEY (stanowisko) REFERENCES stanowiska(id_stanowiska);
                            
   
   
--   Tabela grafik_pracownikow(
--                                id 	 		liczba, Klucz g³ówny
--                                id_pracownik		liczba, Klucz obcy(pracownicy.id_pracownik)
--                                dzien_tygodnia(12)	pole tekstowe do 12 znaków, pole nie mo¿e byæ puste
--                                );     

CREATE TABLE grafik_pracownikow(
                                id NUMBER ,
                                id_pracownik NUMBER NOT NULL ,
                                dzien_tygodnia VARCHAR2(12) NOT NULL
                                );
                                                                
ALTER TABLE grafik_pracownikow ADD CONSTRAINT pk_grafik PRIMARY KEY(id);
ALTER TABLE grafik_pracownikow ADD CONSTRAINT fk_grafik  FOREIGN KEY (id_pracownik) REFERENCES pracownicy(id_pracownik);

--Tabela klienci(
--                    id_klient 		liczba, Klucz g³ówny
--                    imie(20)		pole tekstowe do 20 znaków, pole nie mo¿e byæ puste
--                    nazwisko(40) 	pole tekstowe do 40 znaków, pole nie mo¿e byc puste
--                    plec(1)		pole tekstowe 1 znak, mo¿liwe opcje do wyboru 'K' - kobieta, 'M' - mê¿czyzna, pole nie mo¿e byæ puste
--                    telefon(9)	 	liczba 9 znaków, pole nie mo¿e byæ puste, pole musi byæ unikatowe
--                    pesel(20)	 	pole tekstowe do 20 znaków, pole nie mo¿e byæ puste, pole musi byæ unikatowe, pesel zosta³ zapisany jako pole tekstowe poniewa¿ obywatele innych pañstw mog¹ posiadaæ pesele, które nie sk³adaj¹ siê wy³¹cznie z liczb
--                    narodowosc(30) 	pole tekstowe do 30 znaków, pole nie mo¿e byæ puste                                                                                 
--                    );
                    
CREATE TABLE klienci(
                    id_klient NUMBER,
                    imie VARCHAR2(20) NOT NULL,
                    nazwisko VARCHAR2(40) NOT NULL,
                    plec VARCHAR2(1) NOT NULL CHECK(plec IN ('M','K')),
                    telefon NUMBER(9) NOT NULL UNIQUE,
                    pesel VARCHAR2(20) NOT NULL UNIQUE,
                    narodowosc VARCHAR2(30) NOT NULL                                                                                    
                    );
                    
ALTER TABLE klienci ADD CONSTRAINT pk_klienci PRIMARY KEY (id_klient);   

--Tabela pokoje(
--                    id_pokoj 		liczba, Klucz g³ówny
--                    max_osob(1) 	liczba, mo¿liwe opcje do wyboru 1, 2, 3, 4, 5 - s¹ to liczby oznaczaj¹ce iloœæ miejsc w danym pokoju, pole nie mo¿e byæ puste
--                    id_pracownik	liczba, która odpowiada identyfikatorowi danego pracownika, który jest odpowiedzialny za danyc pokój, pole nie mo¿e byæ puste
--                    cena(3) 		liczba do 3 cyfr, pole nie mo¿e byæ puste
--                    );

CREATE TABLE pokoje(
                    id_pokoj NUMBER,
                    max_osob NUMBER(1) NOT NULL  CHECK(max_osob IN (1,2,3,4,5)),
                    id_pracownik NUMBER NOT NULL,
                    cena NUMBER(3) NOT NULL
                    );
                    
ALTER TABLE pokoje ADD CONSTRAINT pk_pokoje PRIMARY KEY (id_pokoj);
ALTER TABLE pokoje ADD CONSTRAINT fk_pokoje FOREIGN KEY (id_pracownik) REFERENCES pracownicy(id_pracownik);


--Tabela pobyt(
--                    id_pobyt 				liczba, Klucz g³ówny
--                    id_klient 			liczba, pole nie mo¿e byæ puste, Klucz obcy(klienci.id_klient)
--                    id_pokoj 				liczba, pole nie mo¿e byæ puste, Klucz obcy(pokoje.id_pokoj)
--                    data_zameldowania 		data, pole nie mo¿e byæ puste
--                    data_wymeldowania 		data, pole nie mo¿e byæ puste
                    
CREATE TABLE pobyt(
                    id_pobyt NUMBER,
                    id_klient NUMBER NOT NULL,
                    id_pokoj NUMBER NOT NULL,
                    data_zameldowania DATE NOT NULL,
                    data_wymeldowania DATE NOT NULL
                    );               
                   
ALTER TABLE pobyt ADD CONSTRAINT pk_pobyt PRIMARY KEY(id_pobyt);
ALTER TABLE pobyt ADD CONSTRAINT fk_pobyt FOREIGN KEY (id_klient) REFERENCES klienci(id_klient);
ALTER TABLE pobyt ADD CONSTRAINT fk_pobyt2 FOREIGN KEY (id_pokoj) REFERENCES pokoje(id_pokoj);                                               



--Tabela spis_atrakcji(
--                            id_atrakcja 			liczba, Klucz g³ówny
--                            nazwa_atrakcji(30)	 	pole tekstowe do 30 znaków, pole nie mo¿e byæ puste
--                            cena number(3) 			liczba do 3 cyfr, pole nie mo¿e byc puste                 
--                            );

                            
CREATE TABLE spis_atrakcji(
                            id_atrakcja NUMBER,
                            nazwa_atrakcji VARCHAR2(30) NOT NULL,
                            cena NUMBER(3) NOT NULL                    
                            );
                            
ALTER TABLE spis_atrakcji ADD CONSTRAINT pk_atrakcje PRIMARY KEY(id_atrakcja);


--Tabela atrakcje_klienta(
--                                id 		liczba, Klucz g³ówny
--                                id_klient 	liczba, Klucz Obcy(klienci.id_klient)
--                                atrakcja 	liczba, Klucz Obcy(spis_atrakcji.id_atrakcja)                                      
--                                            ); 
                                                      
                            
CREATE TABLE atrakcje_klienta(
                                id NUMBER,
                                id_klient NUMBER NOT NULL,
                                atrakcja NUMBER NOT NULL                                      
                                            ); 
ALTER TABLE atrakcje_klienta ADD CONSTRAINT pk_a_k PRIMARY KEY (id);
ALTER TABLE atrakcje_klienta ADD CONSTRAINT fk_a_k FOREIGN KEY(atrakcja) REFERENCES spis_atrakcji(id_atrakcja);
ALTER TABLE atrakcje_klienta ADD CONSTRAINT fk_a_k2 FOREIGN KEY(id_klient) REFERENCES klienci(id_klient);
                                                                                        
                                                                                        
--Tabela menu_restauracji(
--                            id_posilek 		liczba, Klucz g³ówny
--                            nazwa(30)		pole tekstowe do 30 znaków, pole nie mo¿e byæ puste
--                            cena(2)		liczba, pole nie mo¿e byæ puste
--                            );                                                                                             
                                                                                        
                                            
CREATE TABLE menu_restauracji(
                            id_posilek NUMBER,
                            nazwa VARCHAR2(30) NOT NULL,
                            cena NUMBER(2) NOT NULL
                            );     
                            
ALTER TABLE menu_restauracji ADD CONSTRAINT pk_id PRIMARY KEY(id_posilek);                            
                    
                    
-- Tabela restauracja(
--                        id_zamowienie 		liczba, Klucz g³ówny
--                        posilek 			liczba, Klucz obcy(menu_restauracji.id_posilek)
--                        id_klient 			liczba, Klucz obcy(klienci.id_klient)
--                        data_zamowienia 		data, pole nie mo¿e byæ puste
--                            );                          
                    
CREATE TABLE restauracja(
                        id_zamowienie NUMBER,
                        posilek NUMBER  NOT NULL,
                        id_klient NUMBER NOT NULL,
                        data_zamowienia DATE NOT NULL
                            );       
                            
ALTER TABLE restauracja ADD CONSTRAINT pk_restauracja PRIMARY KEY(id_zamowienie);
ALTER TABLE restauracja ADD CONSTRAINT fk_restauracja FOREIGN KEY(posilek) REFERENCES menu_restauracji(id_posilek);
ALTER TABLE restauracja ADD CONSTRAINT fk_restauracja2 FOREIGN KEY(id_klient) REFERENCES klienci(id_klient);

                                            
                                            
                                            
----------------------------                

---Wpisywanie wartoœci do tabel---

                                                           
                                            
                                            
                                            
 INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                                1,
                                                                'Pokojowka'
                                                                );
                                                                
 INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                                2,
                                                                'Recepcjonista'
                                                                );  
                                                                
  INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                                3,
                                                                'Kucharz'
                                                                );
                                                                
 INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                                4,
                                                                'Pomocnik_kucharza'
                                                                );                                            
                 
 INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                                5,
                                                                'Kelner'
                                                                );                       
 INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                               6,
                                                                'Staz'
                                                                );                                                            
                                                                
  INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                                7,
                                                                'Praktyka'
                                                                );
                                                                
  INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                                8,
                                                                'Ochroniarz'
                                                                );
                                                                
  INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                                9,
                                                                'Portier'
                                                                );
                                                                
  INSERT INTO stanowiska (id_stanowiska,nazwa_stanowiska) VALUES(
                                                                10,
                                                                'Manager'
                                                                ); 

                                                              
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             1,
                                                                                             'Jan',
                                                                                             'Kowalksi',
                                                                                             'M',
                                                                                             251437258,
                                                                                             'Polska',
                                                                                             2,
                                                                                             2000
                                                                                             ); 
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             2,
                                                                                             'Katarzyna',
                                                                                             'Kowalczyk',
                                                                                             'K',
                                                                                             711212513,
                                                                                             'Polska',
                                                                                             1,
                                                                                             3500
                                                                                             );
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             3,
                                                                                             'Angelika',
                                                                                             'Krupa',
                                                                                             'K',
                                                                                             645143531,
                                                                                             'Polska',
                                                                                             5,
                                                                                             2000
                                                                                             
                                                                                             );                                                                                          
 INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             4,
                                                                                             'Mariusz',
                                                                                             'Kowalczyk',
                                                                                             'M',
                                                                                             688284319,
                                                                                             'Polska',
                                                                                             8,
                                                                                             4000
                                                                                             );
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             5,
                                                                                             'Janusz',
                                                                                             'Szewczyk',
                                                                                             'M',
                                                                                             836630926,
                                                                                             'Polska',
                                                                                             1,
                                                                                             2500
                                                                                             ); 
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             6,
                                                                                             'Fryderyk',
                                                                                             'Szulc',
                                                                                             'M',
                                                                                             786273643,
                                                                                             'Polska',
                                                                                             7,
                                                                                             1000
                                                                                             
                                                                                             );
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             7,
                                                                                             'Eleonora',
                                                                                             'Sobczak',
                                                                                             'K',
                                                                                             713712513,
                                                                                             'Polska',
                                                                                             1,
                                                                                             2300
                                                                                             );  
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             8,
                                                                                             'Aneta',
                                                                                             'Sikora',
                                                                                             'K',
                                                                                             718882743,
                                                                                             'Polska',
                                                                                             4,
                                                                                             3000
                                                                                             );
 INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             9,
                                                                                             'Magdalena',
                                                                                             'Rutkowska',
                                                                                             'K',
                                                                                             111299513,
                                                                                             'Polska',
                                                                                             5,
                                                                                             3000
                                                                                             );
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             10,
                                                                                             'Ola',
                                                                                             'Jaworska',
                                                                                             'K',
                                                                                             513767283,
                                                                                             'Polska',
                                                                                             10,
                                                                                             5000
                                                                                             );
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             11,
                                                                                             'Gabriel',
                                                                                             'Stal',
                                                                                             'M',
                                                                                             878276357,
                                                                                             'Polska',
                                                                                             3,
                                                                                             6000
                                                                                             );
                                                                                             
INSERT INTO pracownicy (id_pracownik,imie,nazwisko,plec,telefon,narodowosc,stanowisko,wyplata) VALUES(
                                                                                             12,
                                                                                             'Dorota',
                                                                                             'Kras',
                                                                                             'K',
                                                                                             728372654,
                                                                                             'Polska',
                                                                                             1,
                                                                                             2500
                                                                                             );                                                                                                
                                                                                             
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     1,
                                                                     1,
                                                                     'Poniedzialek'
                                                                     );
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     2,
                                                                     1,
                                                                     'Wtorek'
                                                                     );
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     3,
                                                                     2,
                                                                     'Poniedzialek'
                                                                     );                                                                     
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     4,
                                                                     1,
                                                                     'Sroda'
                                                                     );
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     5,
                                                                     1,
                                                                     'Piatek'
                                                                     );
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     6,
                                                                     4,
                                                                     'Czwartek'
                                                                     );
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     7,
                                                                     5,
                                                                     'Sroda'
                                                                     );
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     8,
                                                                     6,
                                                                     'Poniedzialek'
                                                                     ); 
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     9,
                                                                     7,
                                                                     'Wtorek'
                                                                     );
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     10,
                                                                     10,
                                                                     'Poniedzialek'
                                                                     );
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     11,
                                                                     4,
                                                                     'Poniedzialek'
                                                                     ); 
 INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     12,
                                                                     7,
                                                                     'Sroda'
                                                                     ); 
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     13,
                                                                     5,
                                                                     'Czwartek'
                                                                     ); 
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     14,
                                                                     8,
                                                                     'Piatek'
                                                                     ); 
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     15,
                                                                     6,
                                                                     'Czwartek'
                                                                     );
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     16,
                                                                     3,
                                                                     'Sroda'
                                                                     );
                                                                     
INSERT INTO grafik_pracownikow(id,id_pracownik,dzien_tygodnia) VALUES(
                                                                     17,
                                                                     12,
                                                                     'Czwartek'
                                                                     );                                                                     
                                                                     
                                                                     
INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            1,
                                                                            'Jacek',
                                                                            'Stanczyk',
                                                                            'M',
                                                                            872637456,
                                                                            00283746271,
                                                                            'Polska'
                                                                            );
INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            2,
                                                                            'Marzena',
                                                                            'Lisc',
                                                                            'K',
                                                                            925162734,
                                                                            10278276271,
                                                                            'Polska'
                                                                            );                                                                            
                                                                            
INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            3,
                                                                            'Jaroslaw',
                                                                            'Szawa',
                                                                            'M',
                                                                            665253847,
                                                                            00283872262,
                                                                            'Polska'
                                                                            );
                                                                            
INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            4,
                                                                            'Janusz',
                                                                            'Sadlo',
                                                                            'M',
                                                                            726354821,
                                                                            18293746266,
                                                                            'Polska'
                                                                            );
INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            5,
                                                                            'Karol',
                                                                            'Mazurek',
                                                                            'M',
                                                                            462537469,
                                                                            00726354628,
                                                                            'Polska'
                                                                            );                                                                            
 INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            6,
                                                                            'Aleksandra',
                                                                            'Malta',
                                                                            'K',
                                                                            827636471,
                                                                            72645289170,
                                                                            'Polska'
                                                                            );
                                                                            
INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            7,
                                                                            'Mariusz',
                                                                            'Dorsz',
                                                                            'M',
                                                                            555726545,
                                                                            18273645177,
                                                                            'Polska'
                                                                            );                                                                            
                                                                            
 INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            8,
                                                                            'Magdalena',
                                                                            'Szafa',
                                                                            'K',
                                                                            728374625,
                                                                            00283786201,
                                                                            'Polska'
                                                                            );                                                                           
                                                                            
INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            9,
                                                                            'Cezary',
                                                                            'Drut',
                                                                            'M',
                                                                            482736177,
                                                                            01728937481,
                                                                            'Polska'
                                                                            );                                                                            
                                                                            
INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            10,
                                                                            'Antoni',
                                                                            'Tak',
                                                                            'M',
                                                                            928376452,
                                                                            00281816211,
                                                                            'Polska'
                                                                            );
   
INSERT INTO klienci(id_klient,imie,nazwisko,plec,telefon,pesel,narodowosc) VALUES(
                                                                            11,
                                                                            'Kinga',
                                                                            'Kowadlo',
                                                                            'K',
                                                                            972635454,
                                                                            28472635171,
                                                                            'Polska'
                                                                            ); 
                                                                                                                                                        
                                                                            
INSERT INTO pokoje (id_pokoj, max_osob, id_pracownik,cena) VALUES(
                                                            1,
                                                            3,
                                                            2,
                                                            200
                                                            );
                                                            
INSERT INTO pokoje (id_pokoj, max_osob, id_pracownik,cena) VALUES(
                                                            2,
                                                            2,
                                                            2,
                                                            150
                                                            );
INSERT INTO pokoje (id_pokoj, max_osob, id_pracownik,cena) VALUES(
                                                            3,
                                                            4,
                                                            12,
                                                            250
                                                            ); 
                                                            
INSERT INTO pokoje (id_pokoj, max_osob, id_pracownik,cena) VALUES(
                                                            4,
                                                            3,
                                                            12,
                                                            200
                                                            );  
                                                            
INSERT INTO pokoje (id_pokoj, max_osob, id_pracownik,cena) VALUES(
                                                            5,
                                                            4,
                                                            7,
                                                            250
                                                            ); 
                                                            
 INSERT INTO pokoje (id_pokoj, max_osob,id_pracownik,cena) VALUES(
                                                            6,
                                                            2,
                                                            2,
                                                            140
                                                            ); 
                                                            
INSERT INTO pokoje (id_pokoj, max_osob, id_pracownik,cena) VALUES(
                                                            7,
                                                            1,
                                                            12,
                                                            65
                                                            );
                                                            
 INSERT INTO pokoje (id_pokoj, max_osob, id_pracownik,cena) VALUES(
                                                            8,
                                                            2,
                                                            7,
                                                            150
                                                            );
                                                            
INSERT INTO pokoje (id_pokoj, max_osob, id_pracownik,cena) VALUES(
                                                            9,
                                                            1,
                                                            12,
                                                            70
                                                            );
                                                            
 INSERT INTO pokoje (id_pokoj, max_osob, id_pracownik,cena) VALUES(
                                                            10,
                                                            3,
                                                            7,
                                                            150
                                                            ); 
                                                            
                                                            
                                                                                                              
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                1,
                                                                                                1,
                                                                                                1,
                                                                                                '2019/08/08',
                                                                                                '2019/08/20'
                                                                                                ); 
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                2,
                                                                                                2,
                                                                                                1,
                                                                                                '2019/08/21',
                                                                                                '2019/08/30'
                                                                                                );
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                3,
                                                                                                3,
                                                                                                2,
                                                                                                '2019/07/21',
                                                                                                '2019/07/30'
                                                                                                );
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                4,
                                                                                                4,
                                                                                                3,
                                                                                                '2019/09/21',
                                                                                                '2019/09/30'
                                                                                                );                                                                                              
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                5,
                                                                                                5,
                                                                                                4,
                                                                                                '2019/07/11',
                                                                                                '2019/07/20'
                                                                                                );
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                6,
                                                                                                6,
                                                                                                5,
                                                                                                '2019/08/21',
                                                                                                '2019/08/30'
                                                                                                );                                                                                             
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                7,
                                                                                                7,
                                                                                                6,
                                                                                                '2019/06/21',
                                                                                                '2019/06/30'
                                                                                                );
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                8,
                                                                                                8,
                                                                                                7,
                                                                                                '2019/06/01',
                                                                                                '2019/06/10'
                                                                                                );
                                                                                                
                                                                                                
 INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                9,
                                                                                                9,
                                                                                                8,
                                                                                                '2019/05/22',
                                                                                                '2019/05/30'
                                                                                                );
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                10,
                                                                                                10,
                                                                                                9,
                                                                                                '2019/09/01',
                                                                                                '2019/09/10'
                                                                                                );
                                                                                                
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                11,
                                                                                                11,
                                                                                                10,
                                                                                                '2019/06/15',
                                                                                                '2019/06/25'
                                                                                                );
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                12,
                                                                                                1,
                                                                                                2,
                                                                                                '2020/02/15',
                                                                                                '2020/02/25'
                                                                                                ); 
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                13,
                                                                                                2,
                                                                                                5,
                                                                                                '2020/06/20',
                                                                                                '2020/06/25'
                                                                                                );                                                                                                                           
INSERT INTO pobyt (id_pobyt, id_klient, id_pokoj, data_zameldowania,data_wymeldowania) VALUES(
                                                                                                14,
                                                                                                3,
                                                                                                7,
                                                                                                '2020/06/30',
                                                                                                '2020/07/10'
                                                                                                );                                                                                                                           
                                                                                                                                                                                                  
 
--CREATE TABLE spis_atrakcji(
--                            id_atrakcja number,
--                            nazwa_atrakcji varchar2(30) NOT NULL,
--                            cena number(3) NOT NULL                    
--                            ); 
                                                                                                
INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(1,'Park wspinaczkowy',50);

INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(2,'Wycieczka rowerowa',30);

INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(3,'Spa',80);

INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(4,'Areobik',30);

INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(5,'Warsztat kulinarny',100);

INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(6,'Zwiedzanie miasta',60);

INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(7,'Silownia',40);

INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(8,'Kurs nurkowania',100);


INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(9,'Wypozyczenie rowerow',20);

INSERT INTO spis_atrakcji (id_atrakcja, nazwa_atrakcji, cena)
VALUES(10,'Pakiet wszystkich atrakcji',290);


INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(1,1,1);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(2,2,10);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(3,3,7);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(4,4,6);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(5,5,1);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(6,6,10);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(7,7,10);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(8,8,8);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(9,9,9);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(10,10,3);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(11,11,4);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(12,1,5);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(13,5,2);

INSERT INTO atrakcje_klienta(id,id_klient,atrakcja)
VALUES(14,1,6);


INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(1,'Zestaw obiadowy 1',30);

INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(2,'Zestaw obiadowy 2',28);

INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(3,'Pizza',30);

INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(4,'Zestaw œniadaniowy 1',20);

INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(5,'Zestaw œniadaniowy 2',21);

INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(6,'Hamburger zestaw',20);

INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(7,'Lazania',25);

INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(8,'Zestaw obiadowy dla dzieci 1',25);

INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(9,'Zestaw obiadowy dla dzieci 2',27);

INSERT INTO menu_restauracji(id_posilek,nazwa,cena)
VALUES(10,'Zupa dnia',10);


INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(1,1,1,'2019/08/10');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(2,2,1,'2019/08/11');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(3,2,4,'2019/09/21');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(4,5,7,'2019/06/22');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(5,10,1,'2019/08/19');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(6,1,5,'2019/07/14');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(7,5,10,'2019/09/09');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(8,9,7,'2019/06/27');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(9,7,4,'2019/09/26');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(10,1,6,'2019/08/22');

INSERT INTO restauracja(id_zamowienie,posilek,id_klient,data_zamowienia)
VALUES(11,6,3,'2019/07/29');


