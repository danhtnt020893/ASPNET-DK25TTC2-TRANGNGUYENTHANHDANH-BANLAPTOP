# Báo cáo tiến độ - Tuần 3

**Họ và tên:** Trang Nguyễn Thanh Danh

**MSSV:** DK25TTC2 - 170125093

**Dự án:** Xây dựng website bán laptop (ASP.NET)

---

## 1. Các bước chuẩn bị project

- [x] Xây dựng trang chủ (`HomeController`) — danh sách laptop mới, laptop bán chạy, banner
- [x] Chức năng tìm kiếm sản phẩm — tìm theo tên, lọc theo hãng, theo nhu cầu sử dụng
- [x] Trang chi tiết laptop — hiển thị thông số kỹ thuật, hình ảnh, đánh giá, bình luận
- [x] Xây dựng chức năng giỏ hàng (`GioHangController`) — thêm, cập nhật số lượng, xóa sản phẩm
- [x] Lưu giỏ hàng vào Session
- [x] Trang quản trị Admin Dashboard — thống kê tổng quan (số đơn hàng, số sản phẩm, doanh thu)
- [x] CRUD Laptop — thêm, sửa, xóa, upload hình ảnh sản phẩm
- [x] CRUD Hãng Laptop, Nhu cầu sử dụng, Chủ đề Blog
- [x] Cấu hình CKEditor + CKFinder cho phần quản lý nội dung

---

## 2. Các vấn đề gặp phải

- **Upload hình ảnh sản phẩm** — đường dẫn lưu file cần cấu hình đúng trong `Web.config` và quyền ghi thư mục. Đã cấu hình thư mục `Data/files/` với quyền ghi.
- **Session giỏ hàng bị mất** — cần lưu vào database cho người dùng đã đăng nhập, Session chỉ dùng cho khách chưa đăng nhập.
- **Phân trang danh sách sản phẩm** — sử dụng PagedList.Mvc, cấu hình số sản phẩm mỗi trang trong controller.

---

## 3. Các tài liệu liên quan để xây dựng

- Bootstrap 5 Grid System & Components
- PagedList.Mvc Documentation
- CKEditor + CKFinder Integration Guide
- ASP.NET MVC Session Management
- jQuery AJAX — gửi yêu cầu không reload trang

---

## 4. Các lỗi thường gặp (phòng tránh)

| Lỗi | Nguyên nhân | Cách xử lý |
|------|-------------|------------|
| Upload file thất bại | Không có quyền ghi thư mục | Cấp quyền IIS App Pool hoặc đổi đường dẫn |
| Hình ảnh không hiển thị | Đường dẫn tương đối sai | Kiểm tra đường dẫn trong `Web.config` |
| Session timeout | Session timeout quá ngắn | Đặt timeout trong `Web.config` (mặc định 20 phút) |
| Phân trang lỗi | Model không implement IEnumerable đúng | Dùng `ToPagedList()` từ PagedList |

---

## 5. Các yếu tố cơ bản đã hoàn thành tuần này

| STT | Yếu tố | Trạng thái |
|-----|--------|------------|
| 1 | Trang chủ — danh sách sản phẩm, banner | Hoàn thành |
| 2 | Tìm kiếm + lọc sản phẩm | Hoàn thành |
| 3 | Trang chi tiết laptop | Hoàn thành |
| 4 | Giỏ hàng (Session) | Hoàn thành |
| 5 | Admin Dashboard — thống kê | Hoàn thành |
| 6 | CRUD Laptop, Hãng, Nhu cầu, Chủ đề | Hoàn thành |
| 7 | CKEditor tích hợp | Hoàn thành |

---

## 6. Kế hoạch tuần tiếp theo (Tuần 4)

- Chức năng đặt hàng — tạo đơn hàng từ giỏ hàng
- Quản lý đơn hàng Admin — duyệt, cập nhật trạng thái đơn hàng
- Đánh giá & bình luận sản phẩm — người dùng đánh giá, admin duyệt bình luận
- Quản lý liên hệ — form liên hệ, admin phản hồi
- Thanh toán — tích hợp PayPal, Momo, Payoo, thẻ ATM
- Xác thực hai yếu tố (2FA) qua SMS Twilio

---

## 7. Ghi chú

- Thời gian thực hiện tuần 3: **7 ngày** (08/07 — 14/07/2026)
- Tiến độ so với kế hoạch: **Đúng tiến độ**
- Cần tối ưu truy vấn database cho trang danh sách sản phẩm (nhiều hình ảnh)
