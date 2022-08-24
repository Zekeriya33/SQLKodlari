CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); -- unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- unique
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- not null
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- primary key
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- primary key
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- primary key

select * from calisanlar;
-- FOREIGN KEY --> 

CREATE TABLE adresler(
adres_id char(5),
sokak varChar(20),
cadde varChar(30),
sehir varChar(20),
CONSTRAINT fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)	
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;

INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- PARENT TABLODA OLMAYAN İD İLE CHİLD TABLOYA EKLEME YAPAMAYİZ

INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
-- Calisanlar id ile adresler tablosundaki adres_id ile eslesenlere bakmak icin
select * from calisanlar,adresler WHERE calisanlar.id= adresler.adres_id;

DROP table calisanlar
--parent tabloyu yani primary key olan tabloyu silmek istedigimizde tabloyu silmez
-- once child tabloyu silmemiz gerekir

delete from calisanlar where id ='10002'; --Parent

delete from adresler where adres_id='10002'; --Child

-- ON DELETE CASCADE
--Her defasinda once child tablodaki verileri silmek yerine 
--ON DELETE CASCADE silme ozelligini aktif hale getirebiliriz

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);
INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar;

delete from talebeler where id='126' -- ON DELETE CASCADE kullandigimizicin PARENT table den direk silebildik
--parent tableden sildigimiz icin child tableden de silinmis olur
delete from talebeler;

Drop table talebeler CASCADE; -- parent tabloyu kaldirmak istersek Drop table table_adi'ndan sonra
--CASCADE komutu kullanilir

--Talebeler tablosundaki isim stununa NOT NULL kısıtlamasi ekleyiniz ve veri tipini VARCHAR(30) olaak degistiriniz

alter table talebeler
alter column isim TYPE VARCHAR(30),
alter column isim set NOT NULL;
-- TALEBELER TABLOSUNDAKİ yazili_notu stununa 60 dan buyuk rakam girilebilsin
alter table talebeler
ADD CONSTRAINT sinir CHECK (yazili_notu>60);

INSERT INTO talebeler VALUES(128, 'Mustafa Bak', 'Hasan',45);
--CHECK kısıtlaması ile tablodaki istediğimiz sutunu sınırlandırabiliriz
-- yukarda 60'i sinir olarak belirledigimiz icin bunu eklemedicreate table ogrenciler(
create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);

Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler;
select * from ogrenci_adres;

--Tablodaki bir stuna PRİMARY KEY ekleme
alter table ogrenciler
ADD PRIMARY KEY (id);

--PRIMARY KEY olusturmada 2. Yol
alter table ogrenciler
ADD CONSTRAINT pk_id PRIMARY KEY (id);

--PK dan sonra FK atamasi
alter table ogrenci_adres
ADD FOREIGN KEY (id) REFERENCES ogrenciler;

-- child tabloyu parent tablodan olusturdugumuz icin stun adi verilmedi

--PK'yi silme CONSTRAINT silme
alter table ogrenciler drop CONSTRAINT pk_id;
--Fk'yi silme CONSTRAINT silme
alter table ogrenci_adres drop CONSTRAINT ogrenci_adres_id_fkey;

--Yazili notu 85 den buyuk olan talebe bilgilerini getirin 

select * from talebeler where yazili_notu>85

-- ismi mustafa bak olan talebenin tum bilgilerini getirin

select * from talebeler where isim='Mustafa Bak'

-- SELECT komutunda BETWEEN kosulu
--Between belirttiginiz 2 veri arasindaki bilgileri listeler 
--Between de belirttigimiz degerlerde listelemeye dahildir
create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);