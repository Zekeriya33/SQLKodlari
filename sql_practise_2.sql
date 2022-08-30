-- sql_practise_2 
CREATE TABLE workers
(
  id int,
  name varchar(20),
  title varchar(60),
  manager_id int
);
INSERT INTO workers VALUES(1, 'Ali Can', 'Dev', 2);
INSERT INTO workers VALUES(2, 'John Davis', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'Dev Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5,'asade');

select * from workers;
-- Tabloya company_industry isminde sütun ekleyiniz
alter table workers add company_industry varchar(20);
-- TABLOYA worker_address sütunu ve defaullt olarakta 'Miami, FL, USA' adresini ekleyiniz.
alter table workers add worker_address varchar(30) default 'Miami, FL, USA';
-- tablodaki worker_address sütununu siliniz
alter table workers drop  worker_address
-- Tablodaki company_industry sütununu, company_profession olarak değiştiriniz.
alter table workers rename  company_industry to company_profession
-- Tablonun ismini employees olarak değişitiriniz.
alter table workers rename to employees;
select * from employees;
-- Tablodaki title sütununa data tipini VARCHAR(50) olarak değiştiriniz.
ALTER TABLE employees
ALTER title TYPE VARCHAR(50);
-- Tablodaki title sütununa "UNIQUE" kıstlaması ekleyiniz.
alter table employees
add constraint title  UNIQUE (title) 
