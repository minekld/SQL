
--DDL -DATA DEFINATION LANGUAGE
--CREATE -ALTER -DROP

--CREATE - TABLO OLUSTURMA
CREATE TABLE ogrenci (
ogr_no int,
ogr_isim VARCHAR(30),
notlar Real,
yas int,
adres VARCHAR(50),	
kayit_tarih Date
);
--Varolan tablodan yeni bir tablo olusturma	
Create table ogr_notlari
as
select ogr_no,notlar from ogrenci;

select *from ogrenci;
select *from ogr_notlari;