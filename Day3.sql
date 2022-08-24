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

delete from calisanlar where id

-- ON DELETE CASCADE--
-- Her defasinda once child tablodaki verileri silmek yerine 
-- ON DELETE CASCADE silme ozelligini aktif hale getirebiliriz 
-- boylece hem Parent hemde childe siler
-- ON DELETE CASCADE --
--Her defasında önce child tablodaki verileri silmek yerine
--ON DELETE CASCADE silme özelliğini aktif hale getirebiliriz
--Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmamız yeterli

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

select *from talebeler
select *from notlar

delete from notlar where talebe_id='123'

delete from *talebeler where id='126'--ON DELETE CASCADE kullandigimiz icin parent 
--tableden direkt silebildik.Parent tableden sildigimiz icin child tableden silinmis olur

delete from talebeler

Drop table talebeler cascade; --Parent tabloyu kaldirmak istersek
--drop table tablo adindan sonra CASCADE comutunu kullaniriz


--SORUU
--Talebeler tablosundaki isim kismina NOT NULL kisitlamasi ekleyiniz ve 
--veri tipini varchar(30) olarak degistiriniz

ALTER TABLE talebeler 
alter column isim type varchar(30),
alter column isim set NOT NULL;

--SORU
--TALEBELER TABLOSUNDAKI YAZILI NOTU SUTUNUNA 60 dan buyuk rakam girebilsin

alter table  talebeler
add constraint sinir check(yazili_notu>60);
--CHECK kisitlamasi ile tablodaki istedigimiz sutunu sinirlandirabiliriz
--Açiklama : -- yukarda 60'i sinir olarak belirledigimiz icin bunu eklemedi
drop table ogrenciler;

create table ogrenciler(
id int, 
isim varchar(45),
adres varchar(100),
sinav_notu int
);


Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

alter table ogrenciler add column adres varchar(50)

--Tablodaki bir sutuna PRIMARY KEY ekleme
alter table ogrenciler
add primary key (id);

--Tablodaki bir sutuna PRIMARY KEY ekleme 2.yol
alter table ogrenciler
add constraint pk_id primary key (id)

--Pk den sonra fk atamasi
alter table ogrenci_adres
add foreign key (id) references ogrenciler;

--Child tabloyu parent tablodan olusturdugumuz icin sutun adi verilmedi 
--FK constraint silme
alter table ogrenci_adres drop constraint ogrenci_adres_id_fkey;

--PK'yi Constraint silme
alter table ogrenciler drop constraint pk_id;

--sinav notu 85 den buyuk olan talebe bilgilerini getirin
select * from talebeler
where yazili_notu > 85;

-- ismi Mustafa Bak olan ogrencinin tum bilgilerini getirin
select * from talebeler
where isim = 'Mustafa Bak';

-- SELECT komutunda --BETWEEN kosulu
-- Between belirttiginiz 2 veri arasindaki bilgileri listeler
-- Between de belirttigimiz degerlerde listelemeye dahildir
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

/*
AND (ve): Belirtilen sartlarin her ikiside gerceklesiyorsa o kayit listelenir
Bir tanesi gerceklesmezse listelemez
  select * from matematik sinav1 > 50 and sinav2 > 50
  Hem sinav1 hem de sinav2 alani, 50'den buyuk olan kayitlari listeler
OR (VEYA): Belirtilen sartlardan biri gerceklesirse, kayit listelenir
  select * from matematik sinav1 > 50 OR sinav2 > 50
Hem sinav1 veya sinav2 alani, 50'den buyuk olan kayitlar listeler
*/

--id'si 1003 ile 1995 arasinda olan personel bilgiini listele
select * from personel
where id between '1003' AND '1005'
--2. yol
select *from personel where id>'1003' and id<'1005';

--derya soylu ile yavuz bal arasindaki personel bilgisini listeleyiniz
select *from personel where isim between 'derya soylu' and 'yavuz bal'

--Maasi 70000 ve ismi sena olan personeli listele

select * from personel where maas=70000 or isim='Sena Beyaz'

--IN: Birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutta yazabilme
--imkani verir.Farkli sutunlar icin  IN KULLANILMAZ

--SORU
--ID SI 1001,1002, VE 1004 OLAN PERSONELIN bilgilerini listele
select * from personel where id= '1001' or id ='1002' or id='1004';

2.Yol
select * from personel where id in ('1001',1002','1004);

--SORU
---MaaSI SADECE 70000,1000000 OLAN PERSONELI LISTELE
SELECT * FROM PERSONEL WHERE MAAS IN (700000,100000);


/*
SELECT - LIKE koşulu
LIKE : Sorgulama yaparken belirli(PATTERN) kalıp ifadeleri kullanabilmemizi sağlar
ILIKE : Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE :!~~*
% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir
*/


--soru
---- Ismi A harfi ile baslayan personeli listele

select * from personel where isim like 'A%';

--SORU
---- Ismi t harfi ile biten personeli listele
select * from personel where isim like '%t';


--isminin 2. harfi e olan personeli listeleyiniz
select * from personel where isim like '_e%';














































































































































































































