# Báo cáo tiến độ - Tuần 1

**Họ và tên:** Trang Nguyễn Thanh Danh

**MSSV:** DK25TTC2 - 170125093

**Dự án:** Xây dựng website bán laptop (ASP.NET)

----

## 1. Các bước chuẩn bị project

- [x] Phân tích yêu cầu đồ án — xác định chức năng cốt lõi (bán laptop, quản trị, thanh toán)
- [x] Xây dựng sơ đồ usecase, sơ đồ ER cho database
- [x] Thiết kế wireframe / mockup giao diện các trang chính
- [x] Lựa chọn công nghệ: ASP.NET MVC 5 + SQL Server + Entity Framework
- [x] Cài đặt môi trường phát triển: Visual Studio 2022, SQL Server, .NET Framework 4.8
- [x] Tạo project ASP.NET MVC 5, cấu hình NuGet packages
- [x] Thiết lập kết nối database trong Web.config

---

## 2. Các vấn đề gặp phải

- Chưa có (tuần đầu tiên — giai đoạn chuẩn bị)

---

## 3. Các tài liệu liên quan để xây dựng

- Tài liệu đề cương đồ án
- MSDN — ASP.NET MVC 5 Documentation
- Microsoft Docs — Entity Framework 6
- Tài liệu ASP.NET Identity
- Bootstrap 5 Documentation

---

## 4. Các lỗi thường gặp (phòng tránh)

| Lỗi | Nguyên nhân | Cách xử lý |
|------|-------------|------------|
| Kết nối SQL thất bại | Tên server không đúng | Kiểm tra tên SQL Server trong SSMS |
| NuGet restore lỗi | Package version không tồn tại | Verify version trên nuget.org trước khi update |
| Database not found | Chưa chạy script tạo DB | Chạy `setup/setup.bat` |

---

## 5. Các yếu tố cơ bản đã hoàn thành tuần này

| STT | Yếu tố | Trạng thái |
|-----|--------|------------|
| 1 | Phân tích yêu cầu | Hoàn thành |
| 2 | Thiết kế database (ER Diagram) | Hoàn thành |
| 3 | Thiết kế giao diện (Wireframe) | Hoàn thành |
| 4 | Setup môi trường dev | Hoàn thành |
| 5 | Tạo project + cấu hình | Hoàn thành |

---

## 6. Kế hoạch tuần tiếp theo (Tuần 2)

- Xây dựng database: tạo bảng, quan hệ, stored procedures
- Cài đặt ASP.NET Identity — hệ thống đăng nhập / đăng ký
- Xây dựng trang chủ + layout chính
- Phát triển chức năng người dùng: đăng ký, đăng nhập, quản lý tài khoản
- Tạo trang quản trị Admin — Dashboard

---

## 7. Ghi chú

- Thời gian thực hiện tuần 1: **5 ngày** (24/06 — 30/06/2026)
- Tiến độ so với kế hoạch: **Đúng tiến độ**
