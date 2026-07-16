# Báo cáo tiến độ - Tuần 4

**Họ và tên:** Trang Nguyễn Thanh Danh

**MSSV:** DK25TTC2 - 170125093

**Dự án:** Xây dựng website bán laptop (ASP.NET)

---

## 1. Các bước chuẩn bị project

- [x] Chức năng đặt hàng — tạo đơn hàng từ giỏ hàng, lưu vào database
- [x] Trang xác nhận đơn hàng — hiển thị chi tiết đơn hàng, địa chỉ giao hàng
- [x] Quản lý đơn hàng Admin — xem danh sách, duyệt đơn, cập nhật trạng thái (Chờ xử lý → Đang giao → Đã giao → Hủy)
- [x] Quản lý chi tiết đơn hàng — xem từng sản phẩm trong đơn
- [x] Đánh giá sản phẩm — người dùng đăng nhập đánh giá (sao + bình luận)
- [x] Bình luận sản phẩm — người dùng bình luận, admin duyệt/xóa
- [x] Form liên hệ — gửi thông tin liên hệ, admin xem & phản hồi
- [x] Tích hợp thanh toán PayPal — SDK PayPal .NET
- [x] Tích hợp thanh toán Momo, Payoo, ATM, thẻ tín dụng
- [x] Xác thực hai yếu tố (2FA) — gửi mã qua SMS Twilio

---

## 2. Các vấn đề gặp phải

- **Tích hợp thanh toán** — mỗi cổng thanh toán (PayPal, Momo, Payoo) có API khác nhau, cần xử lý response riêng. Đã cấu hình sandbox (test mode) cho tất cả các cổng.
- **Twilio 2FA** — `MessageResource.Create()` là sync trong bản 7.x, cần chuyển sang async trong bản mới hơn. Hiện tại đang dùng bản 7.11.4 để tương thích .NET 4.8.
- **Bình luận & đánh giá spam** — cần cơ chế duyệt trước khi hiển thị. Đã thêm trường `Duyet` (bool) trong bảng BinhLuan và DanhGia.
- **Đơn hàng trùng lặp** — khi người dùng click nhiều lần nút "Đặt hàng". Đã thêm kiểm tra trùng đơn hàng trong controller.

---

## 3. Các tài liệu liên quan để xây dựng

- PayPal Developer Documentation — .NET SDK
- Momo API Documentation
- Payoo Integration Guide
- Twilio SMS API — .NET Quickstart
- ASP.NET Identity — Two-Factor Authentication

---

## 4. Các lỗi thường gặp (phòng tránh)

| Lỗi | Nguyên nhân | Cách xử lý |
|------|-------------|------------|
| Thanh toán PayPal lỗi | Sandbox credentials sai | Kiểm tra Client ID + Secret trong Web.config |
| SMS Twilio không gửi được | Credentials hết hạn | Renew API Key từ Twilio Console |
| Đơn hàng không lưu | Transaction không commit | Dùng `using (var scope = new TransactionScope())` |
| Bình luận không hiển thị | Chưa duyệt (Duyet=false) | Admin duyệt trong trang quản lý |
| Duplicate order | User click nhiều lần | Thêm kiểm tra trùng + disable button khi submit |

---

## 5. Các yếu tố cơ bản đã hoàn thành tuần này

| STT | Yếu tố | Trạng thái |
|-----|--------|------------|
| 1 | Chức năng đặt hàng | Hoàn thành |
| 2 | Quản lý đơn hàng Admin | Hoàn thành |
| 3 | Cập nhật trạng thái đơn hàng | Hoàn thành |
| 4 | Đánh giá sản phẩm | Hoàn thành |
| 5 | Bình luận + duyệt bình luận | Hoàn thành |
| 6 | Form liên hệ + phản hồi | Hoàn thành |
| 7 | Thanh toán PayPal | Hoàn thành |
| 8 | Thanh toán Momo / Payoo / ATM | Hoàn thành |
| 9 | 2FA SMS qua Twilio | Hoàn thành |

---

## 6. Kế hoạch tuần tiếp theo (Tuần 5)

- Quản lý quảng cáo — upload banner, quản lý vị trí hiển thị
- Quản lý người dùng — CRUD tài khoản, gán vai trò Admin/Staff
- Export báo cáo — xuất Excel (EPPlus), Word (OpenXml)
- Kiểm thử toàn diện — test tất cả chức năng, sửa lỗi
- Tối ưu hóa — tối ưu truy vấn, nén hình ảnh, cache
- Hoàn thiện tài liệu — README, báo cáo đồ án

---

## 7. Ghi chú

- Thời gian thực hiện tuần 4: **7 ngày** (15/07 — 21/07/2026)
- Tiến độ so với kế hoạch: **Đúng tiến độ**
- Lưu ý: credentials thanh toán (PayPal, Momo, Twilio) cần thay bằng production credentials trước khi deploy
