-- 21. How many different products were sold in 2006?
SELECT COUNT(DISTINCT CT.MASP) AS SLSPKHACHNHAU
FROM CTHD CT, HOADON HD 
WHERE CT.SOHD = HD.SOHD AND YEAR(NGHD) = 2006

-- 22. What are the highest and lowest invoice values?
SELECT MAX(TRIGIA) AS HighestInvoiceValues, MIN(TRIGIA) AS LowestInvoiceValues
FROM HOADON

-- 23. What is the average value of all invoices sold in 2006?
SELECT AVG(TRIGIA)
FROM HOADON
WHERE YEAR(NGHD) = 2006 

-- 24. Calculate the total sales revenue for the year 2006.
SELECT SUM(GIA)
FROM CTHD CT, SANPHAM SP, HOADON HD
WHERE CT.MASP = SP.MASP AND HD.SOHD = CT.SOHD AND YEAR(NGHD) = 2006

-- 25. Find the invoice number with the highest value in 2006.
SELECT SOHD
FROM HOADON
WHERE TRIGIA = ( SELECT MAX(TRIGIA)
					  FROM HOADON 
					  WHERE YEAR(NGHD) = 2006 )

-- 26. Find the full names of customers who purchased the invoice with the highest value in 2006.
SELECT HOTEN
FROM KHACHHANG KH, HOADON HD
WHERE KH.MAKH = HD.MAKH AND TRIGIA = ( SELECT MAX(TRIGIA)
									   FROM HOADON 
									   WHERE YEAR(NGHD) = 2006 )
						
-- 27. Print out the list of the top 3 customers (MAKH, HOTEN) sorted by descending sales revenue.
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC

--  28. Print out the list of products (MASP, TENSP) 
-- that have a price equal to one of the top 3 highest prices.
SELECT MASP, TENSP
FROM SANPHAM 
WHERE GIA = ANY ( SELECT TOP 3 GIA
				  FROM SANPHAM
				  ORDER BY GIA DESC )
-- Another query:
/*
SELECT TOP 3 MASP, TENSP
FROM SANPHAM 
ORDER BY GIA DESC
*/

--  29. Print out the list of products (MASP,TENSP) made by 'Thailand' 
-- that have a price equal to one of the top 3 highest prices (of all products)
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'THAILAN' AND GIA = ANY ( SELECT TOP 3 GIA
										 FROM SANPHAM
										 ORDER BY GIA DESC )
										 
--  30. Print out the list of products (MASP,TENSP) made by 'Trung Quoc' 
-- that have a price equal to one of the top 3 highest prices (of Trung Quoc's products)
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'TRUNGQUOC' AND GIA = ANY ( SELECT TOP 3 WITH TIES GIA
										   FROM SANPHAM
										   WHERE NUOCSX = 'TRUNGQUOC'
										   ORDER BY GIA DESC )

-- 31. Print out the list of customers in the top 3 rankings (ranked by sales revenue)
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC

-- 32. Calculate the total number of products manufactured by 'China'.
SELECT COUNT(MASP) AS TONGSOSPTRUNGQUOCSANXUAT
FROM SANPHAM
WHERE NUOCSX = 'TRUNGQUOC'

-- 33. Calculate the total number of products manufactured by each region.
SELECT NUOCSX, COUNT(MASP) AS TONGSOSPSANXUAT
FROM SANPHAM
GROUP BY NUOCSX

-- 34. For each country of manufacture, find the highest, lowest, and average selling price of the products.
SELECT NUOCSX, MAX(GIA) AS GIACAONHAT, MIN(GIA) AS GIATHAPNHAT, AVG(GIA) AS GIATRUNGBINH
FROM SANPHAM
GROUP BY NUOCSX 

-- 35. Calculate the daily sales revenue.
SELECT NGHD, SUM(TRIGIA) AS DOANHTHUMOINGAY
FROM HOADON
GROUP BY NGHD

-- 36. Calculate the total quantity of each product sold in October 2006."
SELECT SUM(SL) AS TONGSLSANPHAM
FROM CTHD CT, HOADON HD
WHERE CT.SOHD = HD.SOHD AND YEAR(NGHD) = 2006

-- 37. Calculate the sales revenue for each month in 2006.
SELECT MONTH(NGHD) AS THANG, SUM(TRIGIA) AS DOANHTHU
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)

-- 38. Find the invoice that purchased at least 4 different products.
SELECT SOHD
FROM CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) > 3

-- 39. Find the invoice that purchased 3 products manufactured by 'Vietnam' (3 different products).
SELECT SOHD
FROM CTHD CT, SANPHAM SP
WHERE CT.MASP = SP.MASP AND NUOCSX = 'VIETNAM'
GROUP BY SOHD
HAVING COUNT(DISTINCT SP.MASP) >= 3

-- 40. Find the customer (MAKH, HOTEN) with the most purchases.
SELECT TOP 1 WITH TIES KH.MAKH, HOTEN
FROM KHACHHANG KH, HOADON HD
WHERE KH.MAKH = HD.MAKH
GROUP BY KH.MAKH, HOTEN
ORDER BY COUNT(KH.MAKH) DESC

-- 41. In which month of 2006 was the highest sales revenue?
SELECT TOP 1 WITH TIES MONTH(NGHD) AS THANG, SUM(TRIGIA) AS Revenue
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC

-- 42. Find the product (MASP, TENSP) with the lowest total quantity sold in 2006.
SELECT TOP 1 WITH TIES SP.MASP, TENSP
FROM SANPHAM SP, CTHD CT
WHERE SP.MASP = CT.MASP
GROUP BY SP.MASP, TENSP
ORDER BY SUM(SL) ASC

-- 43. For each country of manufacture, find the product (MASP, TENSP) with the highest selling price.
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
WHERE SP.GIA = (
	SELECT MAX(GIA)
	FROM SANPHAM
	WHERE NUOCSX = SP.NUOCSX
)

-- 44. Find the countries of manufacture that produce at least 3 products with different selling prices.
SELECT NUOCSX
FROM SANPHAM
GROUP BY NUOCSX
HAVING COUNT(DISTINCT GIA) > 2


--  45. Among the top 10 customers with the highest sales revenue, 
-- find the customer with the most number of purchases.
SELECT TOP 1 WITH TIES KH.MAKH, HOTEN, COUNT(SOHD) AS SLMUAHANG
FROM KHACHHANG KH, HOADON HD
WHERE KH.MAKH = HD.MAKH AND EXISTS (
		SELECT TOP 10 MAKH, HOTEN
		FROM KHACHHANG
		ORDER BY DOANHSO DESC
)
GROUP BY KH.MAKH, HOTEN
ORDER BY SLMUAHANG DESC



