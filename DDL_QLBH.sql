-- I. Data Definition Language
-- 1. Create the tables and declare the primary keys and foreign keys for the tables. 
-- 2. Add an attribute GHICHU with the data type VARCHAR(20) to the SANPHAM table.
ALTER TABLE SANPHAM ADD GHICHU VARCHAR(20)

-- 3. Add an attribute LOAIKH with the data type tinyint to the KHACHHANG table.
ALTER TABLE KHACHHANG ADD LOAIKH tinyint

-- 4. Change the data type of the GHICHU attribute in the SANPHAM table to VARCHAR(100).
ALTER TABLE SANPHAM ALTER COLUMN GHICHU VARCHAR(100)

-- 5. Remove the GHICHU attribute from the SANPHAM table.
ALTER TABLE SANPHAM DROP COLUMN GHICHU

-- 6. The LOAIKH attribute in the KHACHHANG table can store values such as: 'Vang lai', 'Thuong xuyen', 'Vip'.
ALTER TABLE KHACHHANG ADD CONSTRAINT KH_LOAIKH_CK CHECK (LOAIKH IN ('Vang lai', 'Thuong xuyen', 'Vip'))

-- 7. DVT in SANPHAM table can only store values: ('cay','hop','cai','quyen','chuc')
ALTER TABLE SANPHAM ADD CONSTRAINT SP_DVT_CK CHECK (DVT IN ('cay','hop','cai','quyen','chuc'))

-- 8. GIA in SANPHAM must be greater than 500 dong.
ALTER TABLE SANPHAM ADD CONSTRAINT SP_GIA_CK CHECK (GIA > 500)
