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
