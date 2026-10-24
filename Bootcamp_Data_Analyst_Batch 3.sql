######################################################################### Session 1 #########################################################################
# SELECT
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders;

# Tugas A =Jalankan query users dengan SELECT * dan LIMIT 10. Catat 3 nama kolom yang kamu temukan.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.users
LIMIT 10
# Tugas B = Ubah query agar hanya menampilkan id, gender, country, dan created_at.
SELECT id, gender, country, created_at
FROM bigquery-public-data.thelook_ecommerce.users
LIMIT 10
# Tugas C = Ubah LIMIT 10 menjadi LIMIT 25. Apa yang berubah? Apa yang tidak berubah?
SELECT id, gender, country, created_at
FROM bigquery-public-data.thelook_ecommerce.users
LIMIT 10;
#
SELECT id, gender, country, created_at
FROM bigquery-public-data.thelook_ecommerce.users
LIMIT 25

# TAMPILKAN TABEL USER
SELECT * 
FROM bigquery-public-data.thelook_ecommerce.users
# TAMPILKAN TABEL ORDER
SELECT *
FROM bigquery-public-data.thelook_ecommerce.orders


######################################################################### Session 2 #########################################################################
# SELECT dan LIMIT = Mengambil baris dengan jumlah yang kita inginkan
SELECT order_id,status,created_at
FROM bigquery-public-data.thelook_ecommerce.orders
LIMIT 10 

# WHERE = memfilter dengan label/kategori kita inginkan
SELECT order_id,status,created_at
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status = 'Complete'
LIMIT 10
# AND
SELECT order_id,status,created_at,num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status = 'Complete' AND num_of_item > 1
LIMIT 10
# OR
SELECT order_id,status,created_at,num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status = 'Complete' OR num_of_item > 3
LIMIT 10

# ORDER BY = mengurUtkan data numerik
# Menampilkan item terbanyak 
SELECT order_id,status,created_at,num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
ORDER BY num_of_item DESC
# Menampilkan item paling sedikit
SELECT  order_id,status,created_at,num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
ORDER BY num_of_item ASC

# DISTINCT
SELECT DISTINCT status
FROM bigquery-public-data.thelook_ecommerce.orders
ORDER BY status ASC


# cari order Complete dengan lebih dari satu item, urutkan dari item terbanyak.
SELECT order_id,status,created_at,num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status='Complete' AND num_of_item > 1
ORDER BY num_of_item DESC


# Praktik 1 = MENAMPILAKN transaksi dengan status complete dari tanggal terbaru
SELECT order_id, status, created_at
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status='Complete'
ORDER BY created_at DESC

# Tantangan A =Tampilkan daftar status unik dari tabel orders.
SELECT DISTINCT status
FROM bigquery-public-data.thelook_ecommerce.orders
# Tantangan B = Tampilkan 15 order dengan num_of_item lebih dari 1, urutkan dari terbesar.
SELECT order_id, status, created_at, num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE num_of_item > 1 
ORDER BY num_of_item DESC
LIMIT 15
# Tantangan C = Tampilkan id dan created_at untuk order dengan status Shipped.
SELECT order_id, status, created_at, num_of_item 
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status='Shipped'

# kak krn WHERE case sensitive, kalo data nya banyak kita gmn bisa tahu ya udah ke filter semua misal kategori status “complete’? kl ternyata di data nya itu ada yg nulisnya pake capital case ada yg engga
SELECT DISTINCT status
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status='Complete' OR status='Complete' OR status='cancelled' OR status='Cancelled'


######################################################################### Session 3 #########################################################################
# COUNT * = menghitung jumlah baris
SELECT COUNT(*) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders

# SUM = menjumlah nilai kolom
SELECT SUM(num_of_item) AS total_item_terjual
FROM bigquery-public-data.thelook_ecommerce.orders

# AVG = mencari rata-rata nilai kolom
SELECT AVG(num_of_item) AS avg_item_per_order
FROM bigquery-public-data.thelook_ecommerce.orders

# MIN & MAX 
# MIN= MENCARI NILAI TERKECIL
# MAX= MENCARI NILAI TERBESAR
SELECT MIN(num_of_item) AS min_items,
      MAX(num_of_item) AS max_items
FROM bigquery-public-data.thelook_ecommerce.orders

# Ringkasan
SELECT COUNT (*) AS total_order,
      SUM(num_of_item) AS total_item_terjual,
      AVG(num_of_item) AS avg_item_per_order,
      MIN(num_of_item) AS min_tems,
      MAX(num_of_item) AS max_items
FROM bigquery-public-data.thelook_ecommerce.orders
  
# GROUP BY = MENGELOMPOK KATEGORI UNTUK MELAKUKAN AGREGATE
# mencari total order dari setiap status ordernya?
SELECT status,
      COUNT(*) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status
# mencari total order dari setiap status order dan mencari rata2 item terjual dari setiap status
SELECT status #NAG,
      COUNT (*) AS total_order #AG,
      AVG(num_of_item) AS avg_item_terjual #AG
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status

# praktik 1 Ringkasa


## Praktik Mandiri
# Tampilkan setiap status dan jumlah order di dalamnya.
# Tambahkan rata-rata num_of_item untuk setiap status.
# Urutkan hasil dari total order terbanyak.
SELECT status,
      COUNT(*) AS total_order,
      AVG(num_of_item) AS rata_rata_item_terjual
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status
ORDER BY 2 DESC


######################################################################### Session 4 #########################################################################
# Berapa total order yang tercatat? (dari dept sales/dept marketing)
SELECT COUNT(*) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status='Complete';

# Berapa order untuk setiap status?
SELECT status,
      COUNT(*) AS total_orders,
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status
ORDER BY total_orders DESC

# Produk yang paling sering muncul pada order
SELECT product_id,
      COUNT(*) AS item_rows
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY product_id
ORDER BY 2 DESC
limit 10
# Produk yang terlaris
SELECT
    product_id,
    COUNT(*) AS jumlah_item_terjual
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status IN ('Complete')
GROUP BY product_id
ORDER BY jumlah_item_terjual DESC
LIMIT 10;
# Mengecek product id yang dalam 1 transaksi hanya ada 1 product yang sama
SELECT
    product_id,
    COUNT(*) AS item_rows,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) - COUNT(DISTINCT order_id) AS selisih
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE product_id IN (
    19714, 25153, 20449, 23549, 27588,
    19640, 19736, 25691, 17629, 28791
)
GROUP BY product_id
ORDER BY item_rows DESC;
# Mengecek product id yang dalam 1 transaksi ada 2 product yang sama
SELECT
    product_id,
    COUNT(*) AS jumlah_kemunculan,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) - COUNT(DISTINCT(order_id)) AS selisih
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE product_id IN (26864, 6921, 7397, 12898, 14258, 23170)
GROUP BY
    product_id
ORDER BY Jumlah_kemunculan DESC;

# Jumlah customer per negara
SELECT country,
      COUNT(*) AS record_customer
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY 1
ORDER BY 2 DESC

# Analisis data order_items untuk membandingkan setiap status pesanan berdasarkan jumlah item, jumlah order unik, total nilai penjualan, dan rata-rata harga jual. Tampilkan hanya status dengan minimal 100 item, kemudian urutkan berdasarkan total penjualan dari yang terbesar hingga terkecil.
SELECT status,
      COUNT(*) AS total_items,
      COUNT(DISTINCT(order_id)) AS total_orders,
      SUM(sale_price) AS total_sales,
      AVG(sale_price) AS avg_sales
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY 1
HAVING COUNT(*) >= 100
ORDER BY total_sales DESC
# Analisis data order_items untuk membandingkan setiap status pesanan berdasarkan jumlah item, jumlah order unik, total nilai penjualan, dan rata-rata harga jual. Tampilkan hanya status dengan minimal total orders 20.000, kemudian urutkan berdasarkan total penjualan dari yang terbesar hingga terkecil.
SELECT status,
      COUNT(*) AS total_items,
      COUNT(DISTINCT(order_id)) AS total_orders,
      SUM(sale_price) AS total_sales,
      AVG(sale_price) AS avg_sales
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY 1
HAVING COUNT(DISTINCT(order_id)) >= 20000
ORDER BY total_sales DESC
#
SELECT status,
      COUNT(*) AS total_items,
      COUNT(DISTINCT(order_id)) AS total_orders,
      ROUND(SUM(sale_price),2) AS total_sales,
      ROUND(AVG(sale_price),2) AS avg_sales
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY 1
HAVING COUNT(DISTINCT(order_id)) >= 20000
ORDER BY total_sales DESC

# Jumlahkan nilai sale_price pada item order
SELECT SUM(sale_price) AS total_item_sales
FROM bigquery-public-data.thelook_ecommerce.order_items

# Berapa rata-rata harga produk dan total product yang ada per kategori?
SELECT category,
      COUNT(*) AS total_product,
      AVG(retail_price) AS avg_retail_price
FROM bigquery-public-data.thelook_ecommerce.products
GROUP BY 1
ORDER BY 3 DESC

# Analisis jumlah pengguna di setiap negara untuk mengetahui negara dengan jumlah pengguna terbanyak.
SELECT country,
      COUNT(*) AS jumlah_user
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY 1
ORDER BY 2 DESC


################################## Session 5
# INNER JOIN hanya mengambil pasangan yang cocok
# tabel users dan tanbel orders
SELECT o.order_id,
      o.status,
      u.id AS id_user,
      u.first_name,
      u.country
FROM bigquery-public-data.thelook_ecommerce.orders AS o
INNER JOIN bigquery-public-data.thelook_ecommerce.users AS u
      ON o.user_id = u.id
LIMIT 10

# LEFT JOIN = mempertahankan semua baris tabel kiri
SELECT u.id AS id_user,
      u.first_name,
      u.country,
      o.user_id AS user_id,
      o.order_id AS order_id
FROM bigquery-public-data.thelook_ecommerce.users AS u
LEFT JOIN bigquery-public-data.thelook_ecommerce.orders AS o
      ON u.id = o.user_id
LIMIT 10
#
SELECT u.id AS id_user,
      u.first_name,
      u.country,
      o.user_id AS user_id,
      o.status AS status
FROM bigquery-public-data.thelook_ecommerce.users AS u
LEFT JOIN bigquery-public-data.thelook_ecommerce.orders AS o
      ON o.user_id = u.id  
LIMIT 10

# Cek tabel secara terpisah dulu
# tabel order
SELECT order_id,
      user_id,
      status
FROM bigquery-public-data.thelook_ecommerce.orders
LIMIT 5
# tabel user
SELECT id AS id_user,
      country
FROM bigquery-public-data.thelook_ecommerce.users
LIMIT 5


# Tugas A
SELECT
  o.order_id AS order_id,
  o.status,
  u.id AS id_user,
  u.country
FROM `bigquery-public-data.thelook_ecommerce.orders` o
INNER JOIN `bigquery-public-data.thelook_ecommerce.users` u
  ON o.user_id = u.id
;
# Tugas B
SELECT
  u.id AS id_user,
  u.country,
  o.user_id,
  o.order_id AS order_id,
  o.status,
FROM `bigquery-public-data.thelook_ecommerce.users` u
LEFT JOIN `bigquery-public-data.thelook_ecommerce.orders` o
  ON u.id =o.user_id
;


# Contoh query user tanpa order
SELECT u.id,
      u.first_name,
      u.country
FROM bigquery-public-data.thelook_ecommerce.users AS u
LEFT JOIN bigquery-public-data.thelook_ecommerce.orders AS o
      ON u.id=o.user_id
WHERE o.order_id IS NULL
LIMIT 100

