-- III. Data Query Language
-- 1. Print out the list of products (MASP, TENSP) manufactured by 'TRUNGQUOC'.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'TRUNGQUOC'

-- 2. Print out the list of products (MASP, TENSP) with units of measurement as 'cay' or 'quyen'.
SELECT MASP, TENSP
FROM SANPHAM
WHERE DVT IN ('cay', 'quyen') 
-- Another query with WHERE clause: WHERE DVT = 'cay' OR DVT = 'quyen'

-- 3. Print out the list of products (MASP, TENSP) whose product ID starts with 'B' and ends with '01'.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%01'

-- 4. Print out the list of products (MASP, TENSP) manufactured by 'China' with prices ranging from 30,000 to 40,000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'TRUNGQUOC' AND (GIA BETWEEN 30000 AND 40000) 
-- Another query with WHERE clause: WHERE NUOCSX = 'TRUNGQUOC' AND GIA >= 30000 AND GIA <= 40000

-- 5. Print out the list of products (MASP, TENSP) manufactured by 'China' or 'Thailand' with prices ranging from 30,000 to 40,000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE (NUOCSX = 'TRUNGQUOC' OR NUOCSX = 'THAILAN') AND (GIA BETWEEN 30000 AND 40000) 

-- 6. Print out (SOHD, TRIGIA) for sales made on January 1, 2007 and January 2, 2007.
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD = '2007/01/01' OR NGHD = '2007/01/02'

-- 7. Print out (SOHD, TRIGIA) for January 2007, sorted by NGHD (ascending) and SOHD (descending).
SELECT SOHD, TRIGIA
FROM HOADON
WHERE YEAR(NGHD) = 2007 AND MONTH(NGHD) = 1 
ORDER BY NGHD ASC, SOHD DESC

-- 8. Print out the list of customers (MAKH, HOTEN) who made purchases on January 1, 2007.
SELECT KH.MAKH, HOTEN
FROM KHACHHANG KH, HOADON HD
WHERE KH.MAKH = HD.MAKH AND NGHD = '2007/01/01'

-- 9. Print out (SOHD, TRIGIA) of invoices created by the employee named 'Nguyen Van B' on October 28, 2006.
SELECT SOHD, SUM(TRIGIA) AS TRIGIA
FROM HOADON HD, NHANVIEN NV
WHERE HD.MANV = NV.MANV AND HOTEN = 'Nguyen Van B' AND NGHD = '2006/10/28'
GROUP BY SOHD

-- 10. Print out the list of products (MASP, TENSP) purchased by the customer named 'Nguyen Van A' in October 2006.
SELECT SP.MASP, TENSP
FROM KHACHHANG KH, HOADON HD, CTHD CT, SANPHAM SP
WHERE KH.MAKH = HD.MAKH AND HD.SOHD = CT.SOHD AND CT.MASP = SP.MASP 
AND YEAR(NGHD) = 2006 AND MONTH(NGHD) = 10 AND HOTEN = 'Nguyen Van A'