-- 1. Örnek: companies tablosundan en yüksek ikinci number_of_employees değeri olan company ve number_of_employees değerlerini çağırın.
-- 1. yol OFFSET VE FETCH NEXT kullanarak
select company, number_of_employees 
from companies 
ORDER BY number_of_employees desc 
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

--2. Yol
select company, number_of_employees 
from companies 
WHERE  number_of_employees = (SELECT  MAX(number_of_employees) 
                              FROM companies
                              WHERE number_of_employees < (SELECT MAX(number_of_employees) 
							 FROM companies))
							 
--1. Örnek: number_of_employees değeri ortalama çalışan sayısından az olan 
-- number_of_employees değerlerini 16000 olarak UPDATE edin.	

UPDATE companies 
set number_of_employees = 17000
where number_of_employees < (select avg(number_of_employees) 
from companies )

-- 1. Örnek: Prepared statement kullanarak company adı IBM olan number_of_employees değerini 9999 olarak güncelleyin.
UPDATE companies set number_of_employees = 9999 where company = 'IBM';

							 
select * from companies							 




