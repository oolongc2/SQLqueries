-- II. Data Manipulation Language
/* 2. Create the table SANPHAM1 containing all the data from the table SANPHAM. 
Create the table KHACHHANG1 containing all the data from the table KHACHHANG.
*/
SELECT *
INTO SANPHAM1
FROM SANPHAM

SELECT *
INTO KHACHHANG1
FROM KHACHHANG

-- 3. Update the prices to increase by 5% for products manufactured in 'Thailand' (for the SANPHAM1 table)
UPDATE SANPHAM1
SET GIA = GIA * 1.05
WHERE NUOCSX = 'Thai Lan'

-- 4. Update the prices to decrease by 5% for products manufactured in 'China' with prices of 10,000 or less (for the SANPHAM1 table)."
UPDATE SANPHAM1
SET GIA = GIA * 0.95
WHERE NUOCSX = 'Trung Quoc' AND GIA <= 10000

/*
   5."Update the LOAIKH value to 'Vip' for customers who registered as members before January 1, 2007,
with sales of 10.000.000 or more, 
or customers who registered on or after January 1, 2007, 
with sales of 2.000.000 or more (for the KHACHHANG1 table).
*/
UPDATE KHACHHANG1
SET LOAIKH = 'Vip' 
WHERE (NGDK < '2007/01/01' AND DOANHSO >= 10000000) OR (NGDK >= '2007/01/01' AND DOANHSO >= 2000000)