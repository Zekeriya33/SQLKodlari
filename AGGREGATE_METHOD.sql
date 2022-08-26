-- AGGREGATE METHOD KULLANIMI--
/*
-Aggregate Methotlari (SUM(topla),COUNT(say),MIN(en kucuk deger),MAX(en buyuk deger),AVG(ortalama)) 
-SUBQUERY İCİNDE KULLANİLİR
-Ancak, sorgu tek bir deger donduruyor olmalidir
SYNTAX: sum() seklinde olmali sum () arasinda bosluk olmamali  
*/
select * from calisanlar2 

-- calisanlar2 tablosundaki en yuksek maas degerini listeleyiniz
select max(maas) from calisanlar2 

--calisanlar tablosundaki maaslarin toplamini hesaplayiniz
select sum(maas) from calisanlar2

--calisanlar tablosundaki maas ortalamalarini listeleyiniz
SELECT avg(maas) from calisanlar2
select round(avg(maas)) from calisanlar2
select round(avg(maas),2) from calisanlar2

-- calisanlar tablosundan en dusuk maasi listeleyiniz
select min(maas) from calisanlar2

--calisanlar tablosundaki kac kisinin maas aldigini listeleyiniz
select count(maas) from calisanlar2

---- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select * from markalar

select marka_isim,calisan_sayisi,(select sum(maas)from calisanlar2 
where marka_isim=isyeri)AS toplam_maas from markalar

--ALIAS(AS) toplada gecici isim vermek istersek kosuldan sonra AS sutun_isim olarak kullanilir

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
--maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

SELECT marka_isim,calisan_sayisi,(SELECT max(maas) from calisanlar2 where marka_isim=isyeri) AS max_maas,
                                 (SELECT min(maas) from calisanlar2 where marka_isim=isyeri) AS min_maas
from markalar;

Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
select marka_id,marka_isim,(select count(sehir) from calisanlar2 where marka_isim=isyeri) AS sehir_sayisi from markalar

--En yüksek ikinci maas değerini çağırın.
select max(maas) AS enyuksek_ikinci_maas from calisanlar2
where maas < (select max(maas) from calisanlar2)

--En düşük ikinci maas değerini çağırın.
Select min(maas) AS endusukIkinciMaas from calisanlar2
where maas>(select min(maas) from calisanlar2);
--En yüksek üçüncü maas değerini bulun
select max(maas)as enyuksek_ucuncumaas from calisanlar2 where
maas<(select max(maas) from calisanlar2 where maas<(select max(maas) from calisanlar2))
--En dusuk üçüncü maas değerini bulun