-- GROUPBY -- HAVİNG 
/*
HAVİNG ifadesinin islevi where ifadesininkine cok benziyor ancak kumeleme fonksiyonlari ile
where ifadesi birlikte kullanilmadigindan having ifadesine ihtiyac duyulmustur
GROUP BYE ile kullanilir gruplamadan sonraki sart icin GROUP BY dan sonra HAVING kullanilir
*/

--Maaş ortalaması 3000’den fazla olan ülkelerdeki erkek çalışanların maaş ortalaması.
select ulke, round(avg(maas)) as maas_ortalama from personel
where cinsiyet='E'
group by ulke 
HAVING avg(maas)>3000
CREATE TABLE workers
(
  id CHAR(9),
  name VARCHAR(50),
  state VARCHAR(50),
  salary SMALLINT,
  company VARCHAR(20)
);
INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM workers;

--Toplam salary değeri 2500 üzeri olan her bir çalışan için salary toplamını bulun.
select name , sum(salary) as "Total Salary" 
from workers 
group by name 
having sum(salary)>2500; -- Group by ardindan where kullanilmaz .

--Birden fazla çalışanı olan, her bir state için çalışan toplamlarını bulun.
select state,
count(state) as calisan_sayisi 
from workers
group by state 
having count(state) >1 -- having group by ardindan filtreleme icin kullanilir

SELECT * FROM workers;

--Her bir state için değeri 3000'den az olan maximum salary değerlerini bulun.
select state,max(salary)
from workers
group by state
having  max(salary)<3000; 

--Her bir company için değeri 2000'den fazla olan minimum salary değerlerini bulun.
select company, min(salary)
from workers 
group by company
having min(salary)>2000;

--Tekrarsız isimleri çağırın.
select distinct name 
from workers -- distinct clause , cagirilan terimlerden tekrarli olanlarin sadece birincisini alir

--Name değerlerini company kelime uzunluklarına göre sıralayın.
select name , company
from workers
order by LENGTH(company)

--Tüm name ve state değerlerini aynı sütunda çağırarak her bir sütun değerinin uzunluğuna göre sıralayın.
--Concat() fonksiyonu birden fazla sutun veya string degerinin birlestirmek icin kullanilir
--1.YOL
select CONCAT(name ,' ',company)as name_and_state
from workers
order by LENGTH(name)+ LENGTH(state);
--2.YOL
select name || ' ' ||state || ' ' ||LENGTH(name)+ LENGTH(state) as name_and_state
from workers
order by LENGTH(name)+ LENGTH(state);
/*
UNION operator: 1) Iki sorgu (query) sonucunu birlestirmk icin kullanilir
                2) Tekrarsiz(unique) recordlar verir
				3) Tek bir stuna cok sutun koyabiliriz
				4) Tek bir stuna cok sutun mevcut data durumuna dikkat etmek gerekir
*/
--salary değeri 3000'den yüksek olan state değerlerini ve 
--salary değeri 2000'den küçük olan name değerlerini tekrarsız olarak bulun.

select state,salary
from workers
where salary > 3000

UNION

select name,salary
from workers
where salary < 2000;

--salary değeri 3000'den yüksek olan state değerlerini ve ,
--2000'den küçük olan name değerlerini tekrarlı olarak bulun.
select state,salary
from workers
where salary > 3000

UNION ALL --> union ile ayni isi yapar yanliz tekrarli degerleri de verir 

select name,salary
from workers
where salary < 2000;

--salary değeri 1000'den yüksek, 2000'den az olan "ortak" name değerlerini bulun.
select name
from workers
where salary>1000

INTERSECT--INTERSECT Operator: İki sorgu (query) sonucunun ortak(common) değerlerini verir. Unique(tekrarsız) recordları verir.

select name
from workers
where salary<2000;
--salary değeri 2000'den az olan ve company değeri  IBM, APPLE yada MICROSOFT olan 
--ortak "name" değerlerini bulun.

select name 
from workers
where salary < 2000

INTERSECT

select name
from workers
where company IN('IBM','APPLE','MICROSOFT')

--EXCEPT Operator : Bir sorgu sonucundan başka bir sorgu sonucunu çıkarmak için kullanılır. Unique(tekrarsız) recordları verir.

--salary değeri 3000'den az ve GOOGLE'da çalışmayan  name değerlerini bulun.

select name
from workers
where salary < 3000 

EXCEPT

select name 
from workers
where company = 'GOOGLE'

	   
CREATE TABLE my_companies
(
  company_id CHAR(3),
  company_name VARCHAR(20)
);
INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');


CREATE TABLE orders
(
  company_id CHAR(3),
  order_id CHAR(3),
  order_date DATE
);
INSERT INTO orders VALUES(101, 11, '17-Apr-2020');
INSERT INTO orders VALUES(102, 22, '18-Apr-2020');
INSERT INTO orders VALUES(103, 33, '19-Apr-2020');
INSERT INTO orders VALUES(104, 44, '20-Apr-2020');
INSERT INTO orders VALUES(105, 55, '21-Apr-2020');

SELECT * FROM orders;	
SELECT * FROM my_companies;

/*

 JOINS : 1) INNER JOIN:
         2) LEFT JOIN :
		 3) RIGHT JOIN:
		 4) FULL JOIN :
		 5) SELF JOIN :
*/		 
		 
--1) INNER JOIN
--Ortak companyler için company_name, order_id ve order_date değerlerini çağırın.	

select company_name,order_id,order_date
from my_companies mc INNER JOIN orders o
on mc.company_id=o.company_id

-- 2) LEFT JOIN
--my_companies table'ındaki companyler için order_id ve order_date değerlerini çağırın.

select  company_name,order_id,order_date
from my_companies mc LEFT JOIN orders o
on mc.company_id=o.company_id

--3) RIGHT JOIN
--Orders table'ındaki company'ler için company_name, company_id ve order_date değerlerini çağırın.
select  company_name,o.company_id,order_date
from my_companies mc RIGHT JOIN orders o
on mc.company_id=o.company_id

--FULL JOIN
--İki table'dan da company_name, order_id ve order_date değerlerini çağırın.
select  company_name,o.order_id,order_date
from orders o  FULL JOIN my_companies mc
on mc.company_id=o.company_id

--SELF JOIN
CREATE TABLE workers
(
  id CHAR(2),
  name VARCHAR(20),
  title VARCHAR(60),
  manager_id CHAR(2)
);
INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);
SELECT * FROM workers;
--workers tablosunu kullanarak çalışanların yöneticilerini gösteren bir tablo hazırlayın.

select employee.name, manager.name
from workers employee FULL JOIN workers manager
on employee.manager_id =manager.id;





