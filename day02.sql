--Personel isminde bir tablo oluşturalım
create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
--Varolan personel tablosundan pers_id,sehir,adres fieldlarına sahip personel_adres adında yeni tablo olusturalım
create table personel_adres
as
select pers_id, sehir, adres from personel;
select * from personel
-- DML --> Data Manupulation Lang.
-- INSERT - UPDATE - DELETE
--Tabloya veri ekleme, tablodan veri güncelleme ve silme işlemlerinde kullanılan komutlar
--INSERT
create table student
(
id varchar(4),
st_name varchar(30),
age int
);
INSERT into student VALUES ('1001','Ali Can',25);
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003','Ayse Can',45);
INSERT into student VALUES ('1004','Derya Can',55);
--Tabloya parçalı veri ekleme
insert into student(st_name,age) values ('Murat Can',65);
--DQL --> Data Query Lang.
--SELECT
select * from student;
select st_name from student;
--SELECT KOMUTU WHERE KOŞULU
select * from student WHERE age>35;
--TCL Transaction Control Lang.
--Begin- SavePoint -rollback-comit
--Transaction Veritabani sistemlerinde bir islem basladiginda baslar ve islem bitince sona erer
-- Bu islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir
CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
Begin; 
insert into ogrenciler2 VALUES (default,'Ali Can','Hasan Can',75.5);
insert into ogrenciler2 VALUES (default,'Canan Gül','Ayşe Şen',90.5);
savepoint x;
insert into ogrenciler2 VALUES (default,'Kemal Can','Ahmet Can',85.5);
insert into ogrenciler2 VALUES (default,'Ahmet Şen','Ayşe Can',65.5);
ROLLBACK TO x;
select * from ogrenciler2;
COMMIT;

--Transaction kullaniminda SERİAL data turu kullanimi tavsiye edilmez 
--Savepoint den sonra ekledigimiz veride sayac mantigi ile calistigi icin 
--sayac da en son hangi sayida kaldi ise ordan devam eder
-- NOT : PostgreSQL de transaction kullanımı için 'Begin' komutuyla başlarız sonrasında tekrar yanlış bir veriyi
-- düzeltmek veya bizim için önemli olan verilerden sonra ekleme yapabilmek için 'SAVEPOINT savepointadi'
-- kullanırız ve bu savepointe dönebilmek için 'ROLLBACK TO savepointismi'
-- komutunu kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki verileri tabloda bize
-- verir ve son olarak Transaction'ı sonlandırmak için mutlaka 'COMMIT' komutu kullanırız. MySQL de
-- transaction olmadanda kullanılır

--DML -DELETE -
-- DELETE FROM tablo_adi tablonun tum icerigini siler
-- veriyi secerek silmek icin WHERE kosulu kullanilir
-- DELETE FROM tablo_adi WHERE sutun_adi= veri--> tablodaki istedigimiz veriyi siler

CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

SELECT * from ogrenciler;

-- soru : id si 124 olan ogrenciyi silinq

DELETE from ogrenciler Where id =124;

-- soru 2 ismi kemal yasar 123 olan satiri silin

delete from ogrenciler where isim ='Kemal Yasa';

-- Soru : ismi Nesibe Yılmaz veya Mustafa Bak olan kayıtları silelim
DELETE FROM ogrenciler where isim ='Nesibe Yilmaz'or isim='Mustafa Bak';
--soru ismi alican ve id si 123 olan kaydi silin
delete from ogrenciler where isim='Ali Can' or id=123;

--DELETE -TRUNCATE--
-- TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamini siler.
--ancak , secmeli silme yapmaz

SELECT * from ogrenciler;

TRUNCATE TABLE ogrenciler;

--DDL Data Definition Lang
--CREATE-ALTER-DROP
-- ALTER TABLE
--ALTER TABLE tabloda ADD, TYPE, SET, RENAME veya DROP COLUMNS islemleri icin kullanilir
--Personel tablosuna cinsiyet VarChar(20) ve yas int seklinde yeni sutunlar ekleyiniz
create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
select * from isciler;

alter table personel add cinsiyet varChar(20), add yas int;

--Personel tablosundan sirket field ini siliniz

alter table personel drop COLUMN sirket;

-- personel tablosundaki sehir sutunun adini ulke olarak degistirelim

alter table personel rename column sehir to ulke;

--personel tablosunun adini isciler olarak degistirin

alter table personel rename  to isciler; 

-- DDL - DROP komutu

DROP table isciler;

-- CONSTRANINT -- Kısıtlamalar
-- Primary Key --> Bir stunun null icermemesini ve stundaki verilerin BENZERSİZ olmasini saglar(Not NULL - UNIQUE)
-- Foregin Key --> Baska bir tablodaki primary key referans gostermek icin kullanilir 
-- boylelikle tablolar arasinda iliski kurmus olur
--UNIQUE --> bir stundaki tum degerlerin BENZERSİZ yani tek olmasini saglar 
-- NOT NULL --> Bir stunun NULL icermemesini yani bos olmamasini saglar 
-- NOT NULL kısıtlamasi CONSTRAINT  ismi tanimlanmaz. Bu kisitlama veri turunden hemen sonra yerlestirilir
-- CHECK --> Bir stuna yerlestirilebilecek deger araligini sinirlamak icin kullanilir

CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); -- unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- unique
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- not null
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- unique
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- primary key
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- primary key

select * from calisanlar;

-- FOREIGN KEY --> 

CREATE TABLE adresler(
adres_id char(5),
sokak varChar(20),
cadde varChar(30),
sehir varChar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)	
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;