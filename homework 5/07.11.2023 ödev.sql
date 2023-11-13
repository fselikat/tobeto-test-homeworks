--07.11.2023 ÖDEV
--26. Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve 
--iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın.
SELECT p.product_id,p.product_name,s.company_name,s.phone
FROM products p
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE p.units_in_stock = 0;
--27. 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı
SELECT o.order_id,o.ship_address,concat(e.first_name,e.last_name) as "çalışanın adı soyadı", 
o.order_date
FROM orders o INNER JOIN employees e ON o.employee_id = e.employee_id
WHERE (EXTRACT(YEAR FROM o.order_date ) = 1998
AND EXTRACT(MONTH FROM o.order_date) = 3) ;
--28. 1997 yılı şubat ayında kaç siparişim var?
SELECT COUNT(order_id) FROM orders
WHERE EXTRACT(YEAR FROM order_date ) = 1997
AND EXTRACT(MONTH FROM order_date) = 2;
--29. London şehrinden 1998 yılında kaç siparişim var?
SELECT COUNT(order_id) FROM orders
WHERE EXTRACT(YEAR FROM order_date ) = 1998
AND ship_city = 'London';
--30. 1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası
SELECT DISTINCT c.customer_id, c.contact_name,c.phone FROM customers c
inner join orders o on c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM order_date ) = 1997;

--31. Taşıma ücreti 40 üzeri olan siparişlerim
SELECT order_id, freight FROM orders WHERE freight>40;
--32. Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı
SELECT o.order_id, o.ship_city, c.company_name, o.freight
FROM orders o INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE freight>=40;
--33. 1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf),
SELECT o.order_id, o.order_date, o.ship_city,
UPPER(CONCAT(e.first_name,' ',e.last_name)) AS "çalışanın adı soyadı"
FROM orders o INNER JOIN employees e ON o.employee_id=e.employee_id
WHERE EXTRACT(YEAR FROM order_date ) = 1997;

--34. 1997 yılında sipariş veren müşterilerin contactname i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )
SELECT DISTINCT c.contact_name, regexp_replace(c.phone, '[^0-9]', '', 'g') 
FROM customers c INNER JOIN orders o ON c.customer_id=o.customer_id 
WHERE order_date<='1997-12-31' AND order_date>='1997-01-01';
--
SELECT o.order_date, c.contact_name , TRANSLATE( phone,'()-. ' , '') AS telephone 
FROM orders o INNER JOIN customers c ON c.customer_id = o.customer_id  
WHERE o.order_date BETWEEN '1997-01-01' AND '1997-12-31' ORDER BY c.contact_name;

--35. Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyad
SELECT o.order_date, c.contact_name, e.first_name AS calisan_adi, e.last_name AS calisan_soyadi FROM orders o
INNER JOIN customers c ON o.customer_id=c.customer_id
INNER JOIN employees e ON o.employee_id =e.employee_id;

--36. Geciken siparişlerim?
SELECT order_id FROM orders WHERE shipped_date>required_date;
--37. Geciken siparişlerimin tarihi, müşterisinin adı
SELECT o.order_id, o.order_date, c.company_name FROM orders o
INNER JOIN customers c ON o.customer_id=c.customer_id WHERE shipped_date>required_date;
--38. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
SELECT p.product_name, c.category_name, od.quantity FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
INNER JOIN order_details od ON p.product_id = od.product_id
WHERE order_id=10248;
--39. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı
SELECT od.order_id, p.product_name, s.company_name FROM products p
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
INNER JOIN order_details od ON p.product_id = od.product_id
WHERE od.order_id=10248;
--40. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
SELECT o.employee_id, p.product_name,od.quantity FROM order_details od
INNER JOIN products p ON od.product_id=p.product_id
INNER JOIN orders o ON o.order_id = od.order_id
WHERE EXTRACT(YEAR FROM order_date ) = 1997 AND employee_id = 3;
--41. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
SELECT o.order_id, e.employee_id, e.first_name, e.last_name, 
SUM(od.quantity*od.unit_price) Toplam FROM orders o
INNER JOIN order_details od ON o.order_id=od.order_id
INNER JOIN employees e ON e.employee_id=o.employee_id
WHERE order_date<='1997-12-31' AND order_date>='1997-01-01' 
GROUP BY o.order_id, e.employee_id, e.first_name, e.last_name 
ORDER BY Toplam DESC LIMIT 1;

--42. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
SELECT o.employee_id, e.first_name, e.last_name, SUM(od.quantity) AS total_sell FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id INNER JOIN order_details od ON o.order_id = od.order_id
WHERE EXTRACT(YEAR FROM o.order_date ) = 1997 GROUP BY o.employee_id,  e.first_name, e.last_name
ORDER BY total_sell DESC LIMIT 1;
--43. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
SELECT p.product_name, p.unit_price, c.category_name FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
ORDER BY p.unit_price DESC LIMIT 1;
--44. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
SELECT e.first_name, e.last_name, o.order_date, o.order_id FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id
ORDER BY o.order_date;
--45. SON 5 siparişimin ortalama fiyatı ve orderid nedir?
SELECT AVG(od.unit_price*od.quantity) AS average, od.order_id, o.order_date FROM order_details od
INNER JOIN orders o ON od.order_id = o.order_id GROUP BY od.order_id, o.order_date
ORDER BY o.order_date DESC LIMIT 5;
--46. Ocak-- ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
SELECT p.product_name, c.category_name, SUM(od.quantity) FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id
INNER JOIN categories c ON p.category_id = c.category_id
INNER JOIN orders o ON od.order_id = o.order_id
WHERE EXTRACT(MONTH FROM o.order_date) = 1
GROUP BY p.product_name, c.category_name;

--47. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
SELECT  order_id, SUM(quantity) FROM order_details  
WHERE quantity > (SELECT AVG(quantity) FROM order_details) GROUP BY order_id, quantity
ORDER BY order_id;

--48. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
SELECT p.product_name, c.category_name, s.company_name,od.quantity AS adet FROM products p 
INNER JOIN order_details od ON od.product_id=p.product_id
INNER JOIN suppliers s ON s.supplier_id=p.supplier_id
INNER JOIN categories c ON c.category_id=p.category_id
GROUP BY p.product_name, c.category_name, s.company_name, od.quantity
ORDER BY od.quantity DESC LIMIT 1;

--49. Kaç ülkeden müşterim var
SELECT COUNT(DISTINCT country) FROM customers;
--50. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
SELECT SUM(od.quantity*p.unit_price) AS sonuc FROM orders o 
INNER JOIN order_details od ON od.order_id=o.order_id
INNER JOIN products p ON p.product_id=od.product_id
INNER JOIN employees e ON e.employee_id=o.employee_id
WHERE o.order_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '11 months' AND e.employee_id=3;

SELECT SUM(quantity) FROM orders o
INNER JOIN order_details od ON od.order_id=o.order_id
WHERE o.employee_id = 3 AND date_part('year' ,o.order_date)>=1998
AND date_part('month',order_date)>=1

--65. 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?
SELECT od.product_id, SUM(unit_price*quantity) ciro,EXTRACT(month from order_date) ay from orders o 
INNER JOIN order_details od ON o.order_id=od.order_id
WHERE product_id = 10 GROUP BY od.product_id,EXTRACT(month from order_date)
ORDER BY ay DESC LIMIT 3;

SELECT product_id, SUM((unit_price*quantity)*(1-discount)) AS ciro FROM order_details od
INNER JOIN orders o  ON od.order_id = o.order_id
WHERE od.product_id =10 AND o.order_date >=(date '1998-05-31' - INTERVAL '3 months')
GROUP BY product_id;
  
--66. Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?
SELECT employee_id, COUNT(order_id) AS total_order FROM orders GROUP BY employee_id 
ORDER BY employee_id;
--67. 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
SELECT c.company_name, o.order_id FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE order_id IS null;
--68. Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
SELECT company_name, contact_name, address, city, country FROM customers
WHERE country='Brazil';
--69. Brezilya’da olmayan müşteriler
SELECT company_name, contact_name, address, city, country FROM customers
WHERE country!='Brazil';
--70. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
SELECT company_name, contact_name, address, city, country FROM customers
WHERE country='Spain' OR country='France' OR country='Germany';
--71. Faks numarasını bilmediğim müşteriler
SELECT company_name, contact_name, address, city, country FROM customers
WHERE fax IS null;
--72. Londra’da ya da Paris’de bulunan müşterilerim
SELECT company_name, contact_name, address, city, country FROM customers
WHERE city='London' OR city='Paris';
--73. Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
SELECT company_name, contact_name, address, city, country, contact_title FROM customers
WHERE city='México D.F.' AND contact_title = 'Owner' ;
--74. C ile başlayan ürünlerimin isimleri ve fiyatları
SELECT product_name,unit_price FROM products
WHERE product_name ILIKE 'C%';

--75. Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
SELECT first_name,last_name,birth_date from employees
WHERE first_name ilike 'a%';

--76. İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
SELECT company_name from customers
WHERE company_name ilike '%restaurant%';
--77. 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
SELECT product_name, unit_price FROM products
WHERE unit_price BETWEEN 50 AND 100;

--78. 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders),
--SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
SELECT order_id, order_date FROM orders 
WHERE order_date BETWEEN '01-07-1996' AND '31-12-1996';

--81. Müşterilerimi ülkeye göre sıralıyorum:
SELECT company_name, country FROM customers
ORDER BY country;
--82. Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
SELECT product_name, unit_price FROM products
ORDER BY unit_price DESC;
--83. Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz
SELECT product_name, unit_price, units_in_stock FROM products
ORDER BY units_in_stock ASC, unit_price DESC;
--84. 1 Numaralı kategoride kaç ürün vardır..?
SELECT COUNT(product_id), category_id FROM products
WHERE category_id=1 GROUP BY category_id;
--85. Kaç farklı ülkeye ihracat yapıyorum..?
SELECT COUNT(DISTINCT country) FROM customers;








