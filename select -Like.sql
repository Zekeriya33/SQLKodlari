/*
SELECT - LIKE koşulu
LIKE : Sorgulama yaparken belirli (pattern) kalıp ifadeleri kullanabilmemizi sağlar
ILIKE : Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE :!~~*
% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir
*/
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

 Ismi A harfi ile baslayan personeli listele
select * from personel WHERE isim like 'A%';
-- Ismi t harfi ile biten personeli listele
select * from personel WHERE isim like '%t';
-- Isminin 2. harfi e olan personeli listeleyiniz
select * from personel WHERE isim ilike '_e%'
-- 'a' ile başlayıp 'n' ile biten personel isimlerini listeleyiniz
select isim from personel WHERE isim ~~* 'a%n'
-- İçinde 'e' ve 'r' bulunan personel isimlerini listeleyiniz
select isim from personel where isim ilike '%e%r%' or isim ~~*'%r%e'
-- 2. harfi e olup diğer harflerinde y olan personeli listeleyiniz
select isim from personel where isim ilike '_e%y%'
-- a harfi olmayan personeli listeleyin
select * from personel where isim not like '%a%'
-- 1. harfi A ve 7. harfi a olan personeli listeleyin
select * from personel where isim~~* 'A______a%'
--Sondan ikinci karakteri 'r' olan "isim" değerlerini listeleyiniz.
select isim from personel where isim like '%r__'

select * from personel WHERE isim Not ILIKE '%t';
select * from personel WHERE isim Not ILIKE '%b';