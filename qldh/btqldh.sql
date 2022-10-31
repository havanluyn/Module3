-- 1 In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất.
select MaSP, TenSP,Gia from sanpham
where sanpham.NuocSX like "Trung Quốc";
-- 2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cây”, ”quyển”.
select MaSP, TenSP, DVT from sanpham
where sanpham.DVT like "cây" or sanpham.DVT like "quyển";
-- 3 In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
select MaSP, TenSP from sanpham
where sanpham.MaSP like "B%01";
-- 4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 20.000 đến 30.000.
select MaSP, TenSP, Gia from sanpham
where (sanpham.Gia between "20000" and "30000") and sanpham.NuocSX like "Trung Quốc" ;
-- 5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” hoặc “Thái Lan” sản xuất có giá từ 20.000 đến 30.000.
select MaSP, TenSP, Gia from sanpham
where (sanpham.Gia between "20000" and "30000") and (sanpham.NuocSX like "Trung Quốc" or sanpham.NuocSX like "Thái Lan");
-- 6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
select SoHoaDon, TriGia from hoadon
where hoadon.NgayMuaHang between "2007-01-01" and "2007-01-02";
-- 7 In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của óa đơn (giảm dần).
select SoHoaDon, TriGia, NgayMuaHang from hoadon
where hoadon.NgayMuaHang like "2007-01%"
order by hoadon.NgayMuaHang ASC, hoadon.TriGia DESC;
--  8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
select khachhang.MaKH,khachhang.HoTen from hoadon
 join khachhang on khachhang.MaKH = hoadon.MaKH
 where hoadon.NgayMuaHang like "2007-01-01%";
 -- 9. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyễn Văn A” mua trong háng 10/2006.
 select sanpham.MaSP, sanpham.TenSP  from sanpham
inner join cthd on cthd.MaSP = sanpham.MaSP
inner join hoadon on cthd.SoHD = hoadon.SoHoaDon
inner join khachhang on hoadon.MaKH = khachhang.MaKH
where khachhang.HoTen like "Nguyễn Văn A" and hoadon.NgayMuaHang like "2006-10%";
--  10. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyễn Văn B” lập trong ngày 10/10/2006.
select hoadon.SoHoaDon, hoadon.TriGia  from hoadon
inner join nhanvien on hoadon.MaNV = nhanvien.MaNV
where nhanvien.HoTen like "Nguyễn Văn B" and hoadon.NgayMuaHang like "2006-10-10%";
--  11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
select hoadon.SoHoaDon from hoadon
inner join cthd on hoadon.SoHoaDon = cthd.SoHD
 inner join sanpham on cthd.MaSP = sanpham.MaSP
 where sanpham.MaSP like "BB01" or sanpham.MaSP like "BB02";
 -- 12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số ượng từ 10 đến 20.
 select hoadon.SoHoaDon, cthd.SoLuong, sanpham.MaSP from hoadon
inner join cthd on hoadon.SoHoaDon = cthd.SoHD
 inner join sanpham on cthd.MaSP = sanpham.MaSP
 where (sanpham.MaSP like "BB01" or sanpham.MaSP like "BB02") and (cthd.SoLuong between "10"and"20");
 -- 13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số ượng từ 10 đến 20.
 select hoadon.SoHoaDon, cthd.SoLuong, sanpham.MaSP from hoadon
 join cthd on hoadon.SoHoaDon = cthd.SoHD
  join sanpham on cthd.MaSP = sanpham.MaSP
 where (cthd.MaSP like "BB01") and (cthd.SoLuong between "10"and"20") and
 exists( select hoadon.SoHoaDon, cthd.SoLuong, sanpham.MaSP from hoadon
 join cthd on hoadon.SoHoaDon = cthd.SoHD
  join sanpham on cthd.MaSP = sanpham.MaSP
  where
  (cthd.MaSP like "BB02") and (cthd.SoLuong between "10"and"20"));
  -- 14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất hoặc các sản phẩm được bán a trong ngày 1/1/2007.
  select sanpham.MaSP, sanpham.TenSP from sanpham
  join cthd on cthd.MaSP = sanpham.MaSP
  join hoadon on hoadon.SoHoaDon = cthd.SoHD
  where sanpham.NuocSX like "Trung Quốc" or hoadon.NgayMuaHang like "2007-01-01";
  -- 15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
   select sanpham.MaSP, sanpham.TenSP from sanpham
  where sanpham.MaSP not in ( select sanpham.MaSP from sanpham
   join cthd on cthd.MaSP = sanpham.MaSP
  join hoadon on hoadon.SOHD = cthd.SoHD);
  -- 16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
  select sanpham.MaSP, sanpham.TenSP from sanpham
  where sanpham.MaSP not in ( select sanpham.MaSP from sanpham
   join cthd on cthd.MaSP = sanpham.MaSP
  join hoadon on hoadon.SOHD = cthd.SoHD
  where hoadon.NGHD like "2006%");
  -- 17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất không bán được trong năm 2006.
  select sanpham.MaSP, sanpham.TenSP, sanpham.NuocSX from sanpham
  where sanpham.MaSP not in ( select sanpham.MaSP from sanpham
   join cthd on cthd.MaSP = sanpham.MaSP
  join hoadon on hoadon.SOHD = cthd.SoHD
  where hoadon.NGHD like "2006%") and sanpham.MaSP in (select sanpham.MaSP from sanpham
   join cthd on cthd.MaSP = sanpham.MaSP
  join hoadon on hoadon.SOHD = cthd.SoHD
  where  sanpham.NuocSX not like "Trung Quốc");
-- 18. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
select count(hoadon.soHD) from hoadon where hoadon.makh is null;
-- 19. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
select max(trigia),min(trigia) from hoadon;
-- 20. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
select avg(trigia) from hoadon where NGHD like "2006%";
-- 21. Tính doanh thu bán hàng trong năm 2006.
select sum(trigia) from hoadon where NGHD like "2006%";
-- 22. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
select SOHD,max(trigia) from hoadon where NGHD like "2006%";
-- 23. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
select khachhang.HOTEN from khachhang 
join (select *,max(trigia) from hoadon where NGHD like "2006%") as max on max.MAKH=khachhang.makh;
-- 24. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
select * from khachhang order by DOANHSO desc limit 3;
-- 25. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT *FROM  SANPHAM WHERE gia in (select gia from sanpham order by gia desc limit 3);