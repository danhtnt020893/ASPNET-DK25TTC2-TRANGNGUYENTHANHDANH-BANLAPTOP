# Tuần 5: 22/07/2026 — 01/08/2026

---

## 1. Các bước chuẩn bị project

- [x] Quản lý quảng cáo — upload banner, hiển thị banner trên trang chủ theo vị trí
- [x] Quản lý người dùng (Admin) — CRUD tài khoản, gán vai trò Admin / Staff
- [x] Gán quyền Admin cho user — cập nhật bảng `AspNetUserRoles` khi reset vai trò
- [x] Export báo cáo đơn hàng ra **Excel** (EPPlus) — danh sách đơn hàng, thống kê doanh thu
- [x] Export báo cáo sản phẩm ra **Excel** (ClosedXML)
- [x] Import sản phẩm từ file Excel qua **OpenXml**
- [x] Kiểm thử toàn diện — test tất cả chức năng người dùng và admin
- [x] Sửa các lỗi phát sinh trong quá trình kiểm thử
- [x] Tối ưu hóa — nén hình ảnh sản phẩm, lazy loading hình ảnh, cache fragment
- [x] Hoàn thiện README.md — hướng dẫn cài đặt, tài khoản, cấu trúc project
- [x] Hoàn thiện báo cáo đồ án
- [x] Viết báo cáo tiến độ 5 tuần

---

## 2. Các vấn đề gặp phải

- **Export Excel lỗi format** — file Excel xuất ra bị lỗi font tiếng Việt. Khắc phục bằng cách set `ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"` và dùng EPPlus.
- **Import Excel — đọc sai cột** — cần mapping chính xác column index trong file Excel với model. Đã kiểm tra header row trước khi đọc dữ liệu.
- **Reset password toàn bộ user** — ASP.NET Identity hash password không đọc trực tiếp bằng SQL. Giải pháp: sử dụng `PasswordHasher.HashPassword()` từ DLL Identity, compile C# console app để generate hash, update thẳng vào database.
- **Gán vai trò Admin cho user mới** — cần INSERT vào bảng `AspNetUserRoles` với `RoleId = '1'` (ADMIN). Đã viết script SQL gán quyền.

---

## 3. Các tài liệu liên quan để xây dựng

- EPPlus 8 — Excel Export Documentation
- ClosedXML — Excel Library for .NET
- DocumentFormat.OpenXml — Word Export
- ASP.NET MVC Testing Best Practices
- SEO & Performance Optimization Guide

---

## 4. Các lỗi thường gặp (phòng tránh)

| Lỗi | Nguyên nhân | Cách xử lý |
|------|-------------|------------|
| Export Excel lỗi font | Encoding không đúng | Set UTF-8 BOM hoặc dùng EPPlus |
| Import Excel sai dữ liệu | Header row không khớp | Validate header trước khi import |
| Lỗi phân quyền | Thiếu vai trò trong AspNetUserRoles | Kiểm tra và INSERT vai trò bằng SQL |
| Image upload lỗi MIME type | Server không cho phép MIME type | Thêm MIME type trong Web.config |
| Session lost sau login | Redirect không giữ session | Dùng `[SessionState]` hoặc lưu vào cookie |

---

## 5. Các yếu tố cơ bản đã hoàn thành tuần này

| STT | Yếu tố | Trạng thái |
|-----|--------|------------|
| 1 | Quản lý quảng cáo | Hoàn thành |
| 2 | Quản lý người dùng — CRUD + gán vai trò | Hoàn thành |
| 3 | Export Excel (EPPlus, ClosedXML) | Hoàn thành |
| 4 | Import từ Excel (OpenXml) | Hoàn thành |
| 5 | Kiểm thử toàn diện | Hoàn thành |
| 6 | Tối ưu hóa hiệu năng | Hoàn thành |
| 7 | README.md hoàn chỉnh | Hoàn thành |
| 8 | Báo cáo đồ án | Hoàn thành |
| 9 | Báo cáo tiến độ 5 tuần | Hoàn thành |

---

## 6. Tổng kết toàn dự án

### Chức năng đã hoàn thành

| Phân hệ | Chức năng | Trạng thái |
|---------|-----------|------------|
| **Người dùng** | Đăng ký / Đăng nhập / Đăng xuất | Hoàn thành |
| | Quản lý tài khoản cá nhân | Hoàn thành |
| | Xem danh sách laptop theo hãng / nhu cầu | Hoàn thành |
| | Tìm kiếm sản phẩm | Hoàn thành |
| | Chi tiết laptop + đánh giá + bình luận | Hoàn thành |
| | Giỏ hàng (Session) | Hoàn thành |
| | Đặt hàng | Hoàn thành |
| | Thanh toán (PayPal, Momo, Payoo, ATM) | Hoàn thành |
| | 2FA SMS (Twilio) | Hoàn thành |
| | Xem lịch sử đơn hàng | Hoàn thành |
| | Liên hệ hỗ trợ | Hoàn thành |
| **Quản trị** | Dashboard — thống kê | Hoàn thành |
| | CRUD Laptop, Hãng, Nhu cầu, Chủ đề | Hoàn thành |
| | Quản lý tin tức / blog (CKEditor) | Hoàn thành |
| | Quản lý đơn hàng — duyệt, cập nhật trạng thái | Hoàn thành |
| | Duyệt bình luận / đánh giá | Hoàn thành |
| | Quản lý quảng cáo | Hoàn thành |
| | Quản lý người dùng — CRUD + gán vai trò | Hoàn thành |
| | Export / Import Excel | Hoàn thành |

### Công nghệ sử dụng

| Lĩnh vực | Công nghệ |
|----------|-----------|
| Backend | ASP.NET MVC 5, .NET Framework 4.8 |
| Database | SQL Server |
| ORM | Entity Framework 6, LINQ to SQL |
| Authentication | ASP.NET Identity 2 |
| Frontend | Bootstrap 5, jQuery |
| Editor | CKEditor 4 + CKFinder |
| Thanh toán | PayPal, Momo, Payoo, ATM, Credit Card |
| SMS | Twilio API |
| Export | EPPlus, ClosedXML, OpenXml |

---

## 7. Ghi chú

- Thời gian thực hiện tuần 5: **9 ngày** (22/07 — 01/08/2026)
- Tiến độ so với kế hoạch: **Hoàn thành đúng hạn**
- Dự án đã hoàn thành 100% các chức năng yêu cầu
