--Personel isminde bir tablo olusturalim
create table personel(
personel_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),	
adres varchar (50)
);
--Varolan personel tablosundan pers_id, sehir,adres fieldlerina sahip
--personel_adres adinda yeni bir tablo olusturralim
CREATE TABLE Personel_adres
as
select 	personel_id,sehir,adres from personel;


select *from personel

--DML__>Data Manupulation lang.
--Tabloya veri ekleme,tablodan veri guncelleme ve silme islemlerinde kullanilan komutlar
--Insert
Create table student(
id varchar(4),
st_name VARCHAR(30),
age INT	
);

Insert into student VALUES('1001','AliCan',25);
Insert into student VALUES('1002','Veli Can',35);
Insert into student VALUES('1003','Ayse Can',45);
Insert into student VALUES('1004','Derya Can',55);
--Tabloya parcali veri ekleme
INSERT into student(st_name,age)VALUES('Murat Can',65);

--DQL-->Data Qery Lang.
--Select
select * from student;
select st_name from student;
--Select komutu where kosulu
select * from student where age>35;
--TCL -Transaction Control Lang.
--Begin -Savepoint-rollback- commit
--Transaction veritabani sistemlerinde bir islem basladiginda baslar ve islem bitince sona erer
--BU islemler veri tabani olusturma,veri silme ,veri guncelleme,veriyi getirme gibi islemler olabilir
CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
Begin;
insert into ogrenciler2 values (DEFAULT,'Ali Can','Hasan Can',75.5);
insert into ogrenciler2 values (DEFAULT,'Canan Gul','Ayse Sen',90.5);
savepoint x;
insert into ogrenciler2 values (DEFAULT,'Kemal Can','Ahmet Can',90.5);
insert into ogrenciler2 values (DEFAULT,'Ahmet Sen','Ayse Can',65.5);
ROLLBACK TO x;
select * from ogrenciler2;
commit;

--Transaction kullaniminda Serial data turu kullanimi tavsiye edilmez.
--Savepointten sonra ekledigimiz veride sayac mantigi ile calistigi icin
--sayacta hangi sayi  kaldi ise oradan devam eder
--Not: PosgreSQL de transaction kullnimi icin Begin komutu ile baslariz
--sonrasinda tekrar yalnis bir veriyi duzeltmek veya
--bizim icin onemli olan verilerden sonra ekleme yapabilmek icin 'Savepoint'
--komutunu kullaniriz ve bu savepointe donebilmek icin 'Rollback to' savepointisi
--komutunu kullaniriz verollback calistirildiginda savepoint yazdigimiz satirin ustundeki verileri 
--tabloda bize verir ve son olarak transaction u sonlandirmak icin mutlaka 
--COMMIT komutunu kullaniriz.Mysql de transaction olmadanda kullanilir


--DML-Delete-
--Delete from tablo_adi-->Tablonun tum icerigini siler
--veriyi secerek silmek icin WHERE kosulu kullanilir
--DELETE from tablo_adi WHERE sutun_adi= veri-->Tablodaki istedigimiz veriyi siler
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
select * from ogrenciler;
--soru id si 124 olan ogrenciyi siliniz
Delete from ogrenciler where id=124;
--soru ismi kemal yasa olan satiri siliniz
Delete from ogrenciler where isim='Kemal Yasa';
--soru ismi nasibe yilmaz veya mustfa bak olan kayitlari silelim
Delete from ogrenciler where isim='Nesibe Yilmaz' or isim='Mustafa Bak';
--Soru ismi ali can ve id si 123 olan kaydi siliniz
-Delete Truncate--
--Truncate komutu Delete komutu gibi bir tablodaki verilerin tamamini siler
--Ancak , secmeli silme yapmaz

select *from ogrenciler;
Truncate table ogrenciler

--DDL -Data defination Lang.
--Create -Alter -Drop
--Alter Table--
--ALTER TABLE tabloda ADD TYPE,SET,RENAME VEYA DROP CLOUMS islemleri icin kullanilir
create table personel(
personel_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar (50)
);
select * from isciler;
--SORU
--personel tablosuna cinsiyet varchar(20) ve yas int seklinde yeni sutunlar ekleyiniz
Alter table personel add cinsiyet varchar (20),add yas int;

--Soru
--Personel tablosundan sirket fieldini siliniz
alter table personel drop column sirket;
 
 --Soru
--personel tablosundaki sehir sutununun adini ulke olarak degistirelim
alter table personel rename column sehir to ulke;

--SORU
--Personel tablosunun adini isciler olarak degistiriniz
alter table personel rename to isciler ;

--DDL- DROP komutu
drop table isciler;


  --CONSTRANINT--KISITLAMALAR
  --PRIMARY KEY--> BIR sutunun NULL icermemesini ve sutundaki verilerin benzersiz olmasini sagler (Not null -uniqe)
  --Foregin key-->Baska bir tablodaki Primary Key i referans gostermek icin kullanilir
  --boylelikle tablolar arasinda iliski kurmus oluruz.
  --uniqe--> bir sutundaki tum degerlerin benzersiz yani tek olmasini saglar
  --NOt null --> bur sutunun NULL icermemesini yani bos olmasini saglar
  --NOT null--> kisitlamasi icin canstraint ismi tanimlanmaz bu kisitlama veri turunden hemen sonra yerlestirilir
  --Check --> bir sutuna yerlestirilecek deger araligini sinirlamak icin kullanilir
 
  create table calisanlar(
id char(5)primary key,
isim varchar(50) unique,
maas int not null,
ise_baslama Date
);

create table calisanlar2(
id char(5),
isim varchar(50),
maas int not null,
ise_baslama date,
constraint pk_fd primary key(id),
constraint isim_unq unique(isim)

);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY


select * from calisanlar;

--FOREIGN KEY__

CREATE TABLE adresler (
adres_id char(5),
sokak varchar(20),	
cadde varchar(30),					 
sehir varchar(20),					 
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
 
 SELECT* from adresler;
 
--Parent tabloda olmayan id ile ile child tabloya ekleme yapamayiz

insert into adresler values (null,'Aga sok','30.cad','Antep');


--Calisanlar id ile adresler tablosundaki adres id ile eslesenlere bakmak icin
select *from calisanlar,adresler where calisanlar.id=adresler.adres_id;

Drop table calisanlar
--Parent tabloyu yani primary key olan tabloyu silmek istedigimizde tabloyu silmez
--Önce child tabloyu silmemiz gerekir






























