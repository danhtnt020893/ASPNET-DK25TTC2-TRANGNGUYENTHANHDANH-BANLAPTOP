# Báo cáo tiến độ - Tuần 2

**Họ và tên:** Trang Nguyễn Thanh Danh

**MSSV:** DK25TTC2 - 170125093

**Dự án:** Xây dựng website bán laptop (ASP.NET)
---

## 1. Các bước chuẩn bị project

- [x] Chạy script tạo database `ShopLaptop` trên SQL Server
- [x] Cấu hình Entity Framework — DbContext, Entity Models
- [x] Thiết lập ASP.NET Identity — đăng nhập, đăng ký, quản lý tài khoản
- [x] Xây dựng layout chính (`_Layout.cshtml`) — header, footer, navigation
- [x] Phân chia Areas: `Administrator` (trang quản trị) và public (người dùng)
- [x] Cấu hình routing trong `RouteConfig.cs` và `AdministratorAreaRegistration.cs`
- [x] Tạo tài khoản admin đầu tiên trong database

---

## 2. Các vấn đề gặp phải

- **NuGet package vulnerability warnings** khi rebuild — BouncyCastle 1.8.9 và System.Security.Cryptography.Xml 8.0.2 có lỗ hổng bảo mật đã biết. Khắc phục bằng cách tắt NuGet audit trong `nuget.config` vì các gói này phụ thuộc vào Twilio/PayPal, không có version .NET 4.8 an toàn hơn.
- **Connection string không khớp** — tên SQL Server (`THWAVE\SQLEXPRESS`) khác giữa máy dev và database. Đã đồng bộ trong `Web.config`.
- **Trang trắng khi chạy** — do `customErrors mode="On"` ẩn lỗi. Đã bật `customErrors mode="Off"` để debug.

---

## 3. Các tài liệu liên quan để xây dựng

- Microsoft Docs — ASP.NET Identity
- Entity Framework 6 — Code First Migrations
- Bootstrap 5 Components Documentation
- ASP.NET MVC 5 Area Routing
- PasswordHasher — Microsoft.AspNet.Identity

---

## 4. Các lỗi thường gặp (phòng tránh)

| Lỗi | Nguyên nhân | Cách xử lý |
|------|-------------|------------|
| Trang trắng (blank page) | customErrors=On hoặc lỗi DB | Bật customErrors=Off, kiểm tra Event Viewer |
| "Invalid login attempt" | Password hash không khớp | Sử dụng UserManager.AddPassword() hoặc SQL update hash |
| "Server not found" | SQL Server name sai | Mở SSMS xem tên chính xác |
| Binding redirect mismatch | Assembly version không khớp | Revert packages.config về version cũ, thêm binding redirect |
| Could not load assembly | DLL trong bin không đúng version | Clean + Rebuild Solution |

---

## 5. Các yếu tố cơ bản đã hoàn thành tuần này

| STT | Yếu tố | Trạng thái |
|-----|--------|------------|
| 1 | Database ShopLaptop + script tạo bảng | Hoàn thành |
| 2 | Entity Framework — DbContext, Models | Hoàn thành |
| 3 | ASP.NET Identity — đăng nhập / đăng ký | Hoàn thành |
| 4 | Layout chính website | Hoàn thành |
| 5 | Phân chia Areas (Admin / Public) | Hoàn thành |
| 6 | Routing — trang chủ, Admin, Login | Hoàn thành |
| 7 | Tài khoản Admin mặc định | Hoàn thành |

---

## 6. Kế hoạch tuần tiếp theo (Tuần 3)

- Xây dựng trang chủ — hiển thị danh sách laptop, banner, thống kê
- Chức năng tìm kiếm, lọc theo hãng, theo nhu cầu sử dụng
- Trang chi tiết laptop
- Giỏ hàng — thêm, sửa, xóa sản phẩm
- Trang quản trị Admin — Dashboard thống kê
- Quản lý Laptop — CRUD sản phẩm

---

## 7. Ghi chú

- Thời gian thực hiện tuần 2: **7 ngày** (01/07 — 07/07/2026)
- Tiến độ so với kế hoạch: **Đúng tiến độ**
- Vấn đề kỹ thuật đáng chú ý: cần theo dõi NuGet audit warnings và tắt suppress nếu không ảnh hưởng đến chức năng
