--85. Kaç farklı ülkeye ihracat yapıyorum..?
SELECT COUNT(DISTINCT country) FROM customers;

--86. a.Bu ülkeler hangileri..?
SELECT DISTINCT country FROM customers;

--87. En Pahalı 5 ürün
SELECT product_name, unit_price FROM products
ORDER BY unit_price DESC LIMIT 5;

--88. ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
SELECT COUNT(*) AS order_count FROM orders
WHERE customer_id='ALFKI';

--89. Ürünlerimin toplam maliyeti
SELECT SUM(units_in_stock*unit_price) FROM products;

--90. Şirketim, şimdiye kadar ne kadar ciro yapmış..?
SELECT SUM((quantity*unit_price)*(1-discount)) FROM order_details;

--91. Ortalama Ürün Fiyatım
SELECT AVG(unit_price) FROM products;

--92. En Pahalı Ürünün Adı
SELECT product_name, unit_price FROM products
ORDER BY unit_price DESC LIMIT 1;

--93. En az kazandıran sipariş
SELECT order_id, SUM((quantity*unit_price)*(1-discount)) FROM order_details
GROUP BY order_id ORDER BY 2 LIMIT 1;

--94. Müşterilerimin içinde en uzun isimli müşteri
SELECT company_name FROM customers 
ORDER BY LENGTH(company_name) DESC LIMIT 1;

--95. Çalışanlarımın Ad, Soyad ve Yaşları
SELECT first_name, last_name, EXTRACT(YEAR FROM AGE(NOW(), birth_date)) AS yas FROM employees;
select first_name,extract(year from now())- extract(year from birth_date) from employees;

--96. Hangi üründen toplam kaç adet alınmıştır
SELECT  product_id, SUM(quantity) AS total FROM order_details
GROUP BY product_id ORDER BY product_id;

--97. Hangi siparişte toplam ne kadar kazanmışım..?
SELECT order_id, SUM((quantity*unit_price)*(1-discount)) AS kazanc FROM order_details 
GROUP BY order_id;

--98. Hangi kategoride toplam kaç adet ürün bulunuyor..?
SELECT category_id, COUNT(product_id) AS urun_sayisi FROM products --ürün çeşitliliğimi toplam ürün hacmi mi?
GROUP BY category_id;

--99. 1000 Adetten fazla satılan ürünler?
SELECT product_id, SUM(quantity) AS satis FROM order_details
GROUP BY product_id HAVING SUM(quantity) >1000;

--100. Hangi Müşterilerim hiç sipariş vermemiş..?
SELECT c.company_name, o.order_id FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE order_id IS null;

--101. Hangi tedarikçi hangi ürünü sağlıyor ?
SELECT s.company_name, p.product_name FROM products p
INNER JOIN suppliers s ON p.supplier_id=s.supplier_id;

--102. Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş..?
SELECT o.order_id, s.company_name, o.shipped_date FROM orders o 
INNER JOIN shippers s ON o.ship_via = s.shipper_id;

--103. Hangi siparişi hangi müşteri verir..?
SELECT o.order_id, c.company_name FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

--104. Hangi çalışan, toplam kaç sipariş almış..?
SELECT  CONCAT(e.first_name,' ',e.last_name) AS ad_soyad, 
COUNT(order_id) AS total FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id
GROUP BY ad_soyad ;

--105. En fazla siparişi kim almış..?
SELECT  CONCAT(e.first_name,' ',e.last_name) AS ad_soyad, 
COUNT(order_id) AS total FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id
GROUP BY ad_soyad ORDER BY total DESC LIMIT 1;

--106. Hangi siparişi, hangi çalışan, hangi müşteri vermiştir..?
SELECT o.order_id, CONCAT(e.first_name,' ',e.last_name) AS ad_soyad, c.company_name FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN customers c ON o.customer_id = c.customer_id;

--107. Hangi ürün, hangi kategoride bulunmaktadır..? Bu ürünü kim tedarik etmektedir..?
SELECT p.product_name, c.category_name, s.company_name FROM products p 
INNER JOIN categories c ON p.category_id = c.category_id
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id;

--108. Hangi siparişi hangi müşteri vermiş, hangi çalışan almış, hangi tarihte, 
--hangi kargo şirketi tarafından gönderilmiş hangi üründen kaç adet alınmış, 
--hangi fiyattan alınmış, ürün hangi kategorideymiş bu ürünü hangi tedarikçi sağlamış
SELECT o.order_id, c.company_name, o.employee_id, o.shipped_date, sh.company_name,
p.product_name, od.quantity, p.unit_price, ca.category_name, s.company_name FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
INNER JOIN shippers sh ON sh.shipper_id = o.ship_via
INNER JOIN order_details od ON od.order_id = o.order_id
INNER JOIN products p ON p.product_id = od.product_id
INNER JOIN categories ca ON ca.category_id = p.category_id
INNER JOIN suppliers s ON s.supplier_id = p.supplier_id;

--109. Altında ürün bulunmayan kategoriler

SELECT category_name FROM categories
WHERE category_id NOT IN (SELECT DISTINCT category_id 
						  FROM products WHERE category_id IS NOT NULL);

--110. Manager ünvanına sahip tüm müşterileri listeleyiniz.
SELECT company_name, contact_title FROM customers 
WHERE contact_title ILIKE '%manager%';

--111. FR ile başlayan 5 karekter olan tüm müşterileri listeleyiniz.
SELECT company_name FROM customers 
WHERE company_name ILIKE 'fr___';

--112. (171) alan kodlu telefon numarasına sahip müşterileri listeleyiniz.
SELECT customer_id, company_name, phone
FROM customers WHERE phone LIKE '(171)%';

--113. BirimdekiMiktar alanında boxes geçen tüm ürünleri listeleyiniz.
SELECT product_name, quantity_per_unit FROM products
WHERE quantity_per_unit ILIKE '%boxes%';

--114. Fransa ve Almanyadaki (France,Germany) Müdürlerin (Manager)
--Adını ve Telefonunu listeleyiniz.(MusteriAdi,Telefon)
SELECT company_name, phone FROM customers
WHERE country IN ('France', 'Germany') AND contact_title ILIKE '%Manager%';

--115. En yüksek birim fiyata sahip 10 ürünü listeleyiniz.
SELECT product_name, unit_price FROM products
ORDER BY unit_price DESC LIMIT 10;

--116. Müşterileri ülke ve şehir bilgisine göre sıralayıp listeleyiniz.
SELECT company_name, country, city FROM customers
ORDER BY country, city;

--117. Personellerin ad,soyad ve yaş bilgilerini listeleyiniz.
SELECT first_name as ad, last_name AS soyad, 
EXTRACT(YEAR FROM age(current_date, birth_date)) AS yas
FROM employees;

--118. 35 gün içinde sevk edilmeyen satışları listeleyiniz.
SELECT order_id, order_date, shipped_date FROM orders
WHERE shipped_date IS NULL OR (shipped_date - order_date) > 35;

--119. Birim fiyatı en yüksek olan ürünün kategori adını listeleyiniz. (Alt Sorgu)
SELECT category_name FROM categories
WHERE category_id = (SELECT category_id FROM products
    				ORDER BY unit_price DESC LIMIT 1);

--120. Kategori adında 'on' geçen kategorilerin ürünlerini listeleyiniz. (Alt Sorgu)
SELECT product_name FROM products p
WHERE EXISTS(SELECT category_name FROM categories c
			WHERE  p.category_id = c.category_id
			AND category_name ILIKE '%on%');

--121. Konbu adlı üründen kaç adet satılmıştır.
SELECT SUM(quantity) AS total FROM order_details
WHERE product_id = (SELECT product_id FROM products 
					WHERE product_name = 'Konbu');

--122. Japonyadan kaç farklı ürün tedarik edilmektedir.
SELECT COUNT(DISTINCT product_id) FROM products
WHERE supplier_id = ANY (SELECT supplier_id FROM suppliers 
						 WHERE country = 'Japan');
						 
--123. 1997 yılında yapılmış satışların en yüksek, en düşük ve ortalama nakliye ücretlisi ne kadardır?
SELECT MIN(freight), MAX(freight), AVG(freight) FROM orders
WHERE EXTRACT(YEAR FROM order_date ) = 1997;

--124. Faks numarası olan tüm müşterileri listeleyiniz.
SELECT company_name, contact_name, address, city, country FROM customers
WHERE fax IS NOT null;

--125. 1996-07-16 ile 1996-07-30 arasında sevk edilen satışları listeleyiniz. 
SELECT * FROM orders
WHERE shipped_date BETWEEN '1996-07-16' AND '1996-07-30';

