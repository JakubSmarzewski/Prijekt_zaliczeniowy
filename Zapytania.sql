--SELECT na 2 tabelach
-- 1 Pokazuje iloœæ osób na danym stanowisku
SELECT COUNT(pracownicy.id_pracownik), stanowiska.nazwa_stanowiska 
FROM pracownicy
RIGHT OUTER JOIN stanowiska ON pracownicy.stanowisko = stanowiska.id_stanowiska
GROUP BY stanowiska.nazwa_stanowiska;

-- 2 Wykaz pobytu w dniach danego klienta
SELECT klienci.imie, klienci.nazwisko,pobyt.data_zameldowania, pobyt.data_wymeldowania ,
(pobyt.data_wymeldowania - pobyt.data_zameldowania) as czas_wypoczynku FROM klienci
INNER JOIN pobyt ON pobyt.id_pobyt = klienci.id_klient
WHERE klienci.id_klient = 3;

-- 3 Wykaz osob na danym stanowisku
SELECT pracownicy.imie, pracownicy.nazwisko FROM pracownicy
INNER JOIN stanowiska ON pracownicy.stanowisko = stanowiska.id_stanowiska
WHERE stanowiska.nazwa_stanowiska  = 'Pokojowka';

-- 4 Ilosc pobytow danego klienta
SELECT klienci.id_klient, klienci.imie, klienci.nazwisko, count(pobyt.id_pobyt) as ilosc_razy FROM klienci
INNER JOIN pobyt ON klienci.id_klient = pobyt.id_klient
WHERE klienci.id_klient = 8
GROUP BY klienci.id_klient, klienci.nazwisko, klienci.imie;


-- 5 Wykaz pokoi, za które odpowiada dany pracownik
SELECT id_pokoj FROM pokoje
INNER JOIN pracownicy ON pracownicy.id_pracownik = pokoje.id_pracownik
WHERE pracownicy.imie = 'Dorota' AND pracownicy.nazwisko = 'Kras';

-- 6 Dane klientow, ktorzy dokonali zamowienia w restauracji o danej dacie
SELECT klienci.imie, klienci.nazwisko FROM klienci
INNER JOIN restauracja ON klienci.id_klient = restauracja.id_klient
WHERE restauracja.data_zamowienia = '2019/08/11';

-- 7 Historia osob w danym pokoju
SELECT klienci.id_klient, klienci.imie, klienci.nazwisko, pobyt.data_zameldowania, pobyt.data_wymeldowania from klienci
INNER JOIN pobyt on klienci.id_klient = pobyt.id_klient
WHERE pobyt.id_pokoj = 1;

-- 8 Sprawdzanie wyplaty w danym przedziale
SELECT pracownicy.imie, pracownicy.nazwisko, stanowiska.nazwa_stanowiska,pracownicy.wyplata from pracownicy
INNER JOIN stanowiska on pracownicy.stanowisko = stanowiska.id_stanowiska
WHERE pracownicy.wyplata <= 5000;

-- 9 Spis popularnosci dañ w hotelowej restauracji
SELECT COUNT(restauracja.posilek) as ilosc_zamowien, menu_restauracji.nazwa FROM  restauracja
INNER JOIN menu_restauracji ON restauracja.posilek = menu_restauracji.id_posilek
GROUP BY restauracja.posilek, menu_restauracji.nazwa
ORDER BY COUNT(restauracja.posilek) DESC;

-- 10 Spis popularnoœci atrakcji, oferowanych przez hotel
SELECT  spis_atrakcji.id_atrakcja,COUNT(atrakcje_klienta.atrakcja) AS ilosc_zamowien, spis_atrakcji.nazwa_atrakcji FROM atrakcje_klienta
INNER JOIN spis_atrakcji ON atrakcje_klienta.atrakcja = spis_atrakcji.id_atrakcja
GROUP BY spis_atrakcji.id_atrakcja,atrakcje_klienta.atrakcja, spis_atrakcji.nazwa_atrakcji
ORDER BY COUNT(atrakcje_klienta.atrakcja) DESC;
--------------------------------------------------------------
--SELECT na 3 tabelach

-- 1 Sprawdzanie ceny za pokoj danego klienta na czas wypoczynku.
SELECT klienci.imie,klienci.nazwisko,pobyt.data_zameldowania,pobyt.data_wymeldowania,pokoje.cena * (pobyt.data_wymeldowania - pobyt.data_zameldowania )AS CenaZaPobyt FROM pobyt
INNER JOIN pokoje ON pokoje.id_pokoj = pobyt.id_pokoj 
INNER JOIN klienci ON klienci.id_klient = pobyt.id_klient
WHERE klienci.id_klient = 1
ORDER BY pobyt.data_wymeldowania DESC;

-- 2 Zsumowana cena za atrakcje klienta
SELECT SUM(spis_atrakcji.cena) AS cena, klienci.imie, klienci.nazwisko FROM atrakcje_klienta
INNER JOIN spis_atrakcji ON spis_atrakcji.id_atrakcja = atrakcje_klienta.atrakcja
INNER JOIN klienci ON klienci.id_klient = atrakcje_klienta.id_klient
WHERE atrakcje_klienta.id_klient =1
GROUP BY klienci.imie,klienci.nazwisko;

-- 3 Sprawdzanie ceny za posilki klienta
SELECT SUM(menu_restauracji.cena) AS cena, klienci.imie, klienci.nazwisko FROM restauracja
INNER JOIN menu_restauracji ON menu_restauracji.id_posilek = restauracja.posilek
INNER JOIN klienci ON klienci.id_klient = restauracja.id_klient
where restauracja.id_klient = 1
GROUP BY klienci.imie, klienci.nazwisko;

-- 4 Wykaz pracownikow, pracujacych w okreslonym dniu tygodnia.
SELECT pracownicy.id_pracownik, pracownicy.imie, pracownicy.nazwisko,stanowiska.nazwa_stanowiska FROM pracownicy
INNER JOIN grafik_pracownikow ON grafik_pracownikow.id_pracownik = pracownicy.id_pracownik
INNER JOIN stanowiska ON stanowiska.id_stanowiska = pracownicy.id_pracownik
WHERE grafik_pracownikow.dzien_tygodnia = 'Poniedzialek'
ORDER BY pracownicy.id_pracownik ASC;

-- 5 Wykaz osób których pobyt trwa wiecej ni¿ tydzieñ oraz data wymeldowania jeszcze nie nadeszala, w celu posprzatania pokoju/zmiany poscieli.
SELECT pokoje.id_pokoj, pracownicy.imie,pracownicy.nazwisko,
(pobyt.data_wymeldowania - pobyt.data_zameldowania) AS czas,pobyt.data_wymeldowania AS koniec FROM POKOJE
INNER JOIN pobyt ON pokoje.id_pokoj = pobyt.id_pokoj
INNER JOIN pracownicy ON pokoje.id_pracownik = pracownicy.id_pracownik
WHERE pobyt.data_wymeldowania - pobyt.data_zameldowania > 7 AND pobyt.data_wymeldowania > CURRENT_DATE;

-- 6 Wykaz klientow w okreslonych ramach czasowych
SELECT klienci.imie, klienci.nazwisko, pokoje.id_pokoj,pobyt.data_zameldowania,pobyt.data_wymeldowania FROM klienci
INNER JOIN pobyt ON klienci.id_klient = pobyt.id_pobyt
INNER JOIN pokoje ON pobyt.id_pokoj = pokoje.id_pokoj
WHERE pobyt.data_zameldowania < '2019/07/01' AND pobyt.data_wymeldowania < '2019/09/01';

-- 7 Wykaz atrakcji danego klienta
SELECT spis_atrakcji.nazwa_atrakcji from spis_atrakcji
INNER JOIN atrakcje_klienta ON atrakcje_klienta.atrakcja = spis_atrakcji.id_atrakcja
INNER JOIN klienci ON klienci.id_klient = atrakcje_klienta.id_klient
WHERE klienci.imie = 'Janusz' AND klienci.nazwisko = 'Sadlo' OR klienci.id_klient = 4;


-- 8 Pokazuje podstawowe informacje o kliencie w oparciu o padany identyfikator
SELECT klienci.imie, klienci.nazwisko, pokoje.id_pokoj, pobyt.data_zameldowania, pobyt.data_wymeldowania FROM klienci
INNER JOIN pobyt ON klienci.id_klient = pobyt.id_klient
INNER JOIN pokoje ON pokoje.id_pokoj = pobyt.id_pokoj
WHERE klienci.id_klient = 5;

-- 9 Spis zamówien danego klienta
SELECT menu_restauracji.nazwa FROM menu_restauracji
INNER JOIN restauracja ON restauracja.posilek = menu_restauracji.id_posilek
INNER JOIN klienci ON klienci.id_klient = restauracja.id_klient
WHERE klienci.imie = 'Janusz' AND klienci.nazwisko = 'Sadlo' OR klienci.id_klient = 4;

-- 10 Grafik danego pracownika

SELECT grafik_pracownikow.dzien_tygodnia,stanowiska.nazwa_stanowiska FROM grafik_pracownikow
INNER JOIN pracownicy ON pracownicy.id_pracownik = grafik_pracownikow.id_pracownik
INNER JOIN stanowiska ON stanowiska.id_stanowiska = pracownicy.stanowisko
WHERE pracownicy.id_pracownik = 4;




--------------------------------------------------------------
--SELECT na 1 tabeli

-- 1 wykaz pokoi z dana iloscia osob
SELECT id_pokoj, cena FROM pokoje
WHERE max_osob = 4;

-- 2 Spis atrakcji w naym przedziale cenowym
SELECT nazwa_atrakcji, cena FROM spis_atrakcji
WHERE cena <= 100;

-- 3 Pokazuje popularnosc pokoi wybieranych przez kleintow
SELECT COUNT(id_pobyt) AS ilosc, id_pokoj FROM pobyt
GROUP BY id_pokoj
ORDER BY ilosc DESC;

-- 4 Wykaz pracownikow z danego kraju
SELECT ID_PRACOWNIK ,IMIE ,NAZWISKO ,PLEC ,TELEFON ,NARODOWOSC ,STANOWISKO  FROM pracownicy
WHERE narodowosc = 'Polska'
ORDER BY id_pracownik ASC;

-- 5 Informacje o danym kliencie
SELECT ID_KLIENT ,IMIE ,NAZWISKO ,PLEC ,TELEFON ,PESEL ,NARODOWOSC  FROM klienci
WHERE id_klient = 1;

-- 6 Informacje o danym pokoju
SELECT  max_osob, id_pracownik, cena FROM pokoje
WHERE id_pokoj = 1;

-- 7 Wyszukiwanie klientow o danej narodowosci
SELECT ID_KLIENT ,IMIE ,NAZWISKO ,PLEC ,TELEFON ,PESEL FROM klienci
WHERE narodowosc = 'Polska'
ORDER BY id_klient ASC;
 
-- 8 Wyszukiwanie klienta po jego telefonie
SELECT id_klient,imie,nazwisko FROM klienci 
WHERE pesel = 10278276271;

-- 9 Wyszukuje aktualnie zajête pokoje
SELECT id_pokoj,  data_wymeldowania from pobyt
WHERE data_zameldowania <= CURRENT_DATE and data_wymeldowania > CURRENT_DATE;

-- 10 Wykaz cen poszczególnuch posilków(w przypadku, ich duzej iloœci w celu zaoszczêdzenia czasu);
SELECT cena FROM menu_restauracji
WHERE nazwa = 'Pizza';



--------------------------------------------------------------
--Projekcje

-- 1 Zliczanie pracownikow
SELECT  COUNT(CASE WHEN plec='M' THEN 1 END) AS M,
COUNT(CASE WHEN plec='K' THEN 1 END) AS K,
COUNT(*) AS Razem
FROM pracownicy;

-- 2 Zliczanie klientow
SELECT  COUNT(CASE WHEN plec='M' THEN 1 END) AS M,
COUNT(CASE WHEN plec='K' THEN 1 END) AS K,
COUNT(*) AS Razem
FROM Klienci;

-- 3 Spis pracownikow(imie, nazwisko)
SELECT imie, nazwisko FROM pracownicy;

-- 4 Spis klientow(imie, nazwisko)
SELECT imie, nazwisko FROM klienci;

-- 5 Spis pokoi (id, ilosc_osob)
SELECT id_pokoj,max_osob FROM pokoje
ORDER BY id_pokoj ASC;

-- 6 Spis posilkow
SELECT nazwa, cena from menu_restauracji
ORDER BY cena ASC;

-- 7 Spis atrakcji
SELECT nazwa_atrakcji, cena from spis_atrakcji
ORDER BY cena ASC;

-- 8 Spis stanowisk
SELECT id_stanowiska ,nazwa_stanowiska  FROM stanowiska;

-- 9 Spsis zamowien klientow
SELECT id_klient, data_zamowienia FROM restauracja;

-- 10 grafik pracownikow
SELECT id_pracownik, dzien_tygodnia FROM grafik_pracownikow
ORDER BY id_pracownik ASC;
--------------------------------------------------------------









    




