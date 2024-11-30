-- 11. Find (SOHD) for purchases of products with the codes 'BB01' or 'BB02'
SELECT HD.SOHD
FROM HOADON HD, CTHD CT, SANPHAM SP
WHERE CT.MASP = SP.MASP AND HD.SOHD = CT. SOHD AND (SP.MASP = 'BB01' OR SP.MASP = 'BB02')

--	12. Find the invoice numbers for purchases of products with the codes 'BB01' or 'BB02'
-- where each product was purchased in quantities between 10 and 20.
SELECT SOHD
FROM CTHD CT, SANPHAM SP
WHERE CT.MASP = SP.MASP
AND SL BETWEEN 10 AND 20 AND (SP.MASP = 'BB01' OR SP.MASP = 'BB02')

--  13. Find the invoice numbers (SOHD) for purchases of products with the codes 'BB01' and 'BB02', 
-- where each product was purchased in quantities between 10 and 20.
SELECT SOHD
FROM CTHD CT, SANPHAM SP
WHERE CT.MASP = SP.MASP
AND SL BETWEEN 10 AND 20 AND SP.MASP = 'BB01' 
INTERSECT
SELECT SOHD
FROM CTHD CT, SANPHAM SP
WHERE CT.MASP = SP.MASP
AND SL BETWEEN 10 AND 20 AND SP.MASP = 'BB02' 

-- 14. Print out the (MASP, TENSP) that are either manufactured by 'China' or were sold on January 1, 2007.
SELECT SP.MASP, TENSP
FROM SANPHAM SP, CTHD CT, HOADON HD
WHERE SP.MASP = CT.MASP AND CT.SOHD = HD.SOHD
AND (NUOCSX = 'TRUNGQUOC' OR NGHD = '2007/01/01')

-- 15. Print out the list of products (MASP, TENSP) that were not sold.
SELECT MASP, TENSP
FROM SANPHAM
EXCEPT
SELECT SP.MASP, TENSP
FROM SANPHAM SP, CTHD CT
WHERE SP.MASP = CT.MASP

-- 16. Print out the list of products (MASP, TENSP) that were not sold in 2006.
SELECT MASP, TENSP
FROM SANPHAM SP
WHERE NOT EXISTS (
    SELECT 1
    FROM CTHD CT, HOADON HD
    WHERE CT.SOHD = HD.SOHD AND SP.MASP = CT.MASP AND YEAR(HD.NGHD) = 2006
)

-- 17. "Print out (MASP, TENSP) manufactured by 'China' that were not sold in 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'TRUNGQUOC'
EXCEPT
SELECT SP.MASP, TENSP
FROM SANPHAM SP, CTHD CT, HOADON HD
WHERE SP.MASP = CT.MASP AND HD.SOHD = CT.SOHD AND YEAR(NGHD) = 2006 AND NUOCSX = 'TRUNGQUOC'4

-- 18. Find the invoice numbers (SOHD) for purchases of all products manufactured by Singapore.
SELECT SOHD
FROM HOADON HD
WHERE NOT EXISTS (
	SELECT *
	FROM SANPHAM SP
	WHERE NUOCSX = 'SINGAPORE' AND NOT EXISTS (
		SELECT *
		FROM CTHD CT
		WHERE CT.MASP = SP.MASP AND CT.SOHD = HD.SOHD))


-- 19. Find the invoice numbers (SOHD) in 2006 that purchased at least all products manufactured by Singapore.
SELECT HD.SOHD
FROM HOADON HD
JOIN CTHD CT ON CT.SOHD = HD.SOHD
JOIN SANPHAM SP ON SP.MASP = CT.MASP
WHERE NUOCSX = 'SINGAPORE' AND YEAR(NGHD) = 2006
GROUP BY HD.SOHD
HAVING COUNT(DISTINCT SP.MASP) = (
    SELECT COUNT(MASP)
    FROM SANPHAM
    WHERE NUOCSX = 'Singapore'
)

-- 20. How many invoices were purchased by customers who are not registered members?
SELECT COUNT(SOHD) AS SLHD0LATV
FROM HOADON HD
EXCEPT
SELECT COUNT(HD.SOHD) AS SLHD0LATV
FROM HOADON HD, KHACHHANG KH
WHERE HD.MAKH = KH.MAKH
