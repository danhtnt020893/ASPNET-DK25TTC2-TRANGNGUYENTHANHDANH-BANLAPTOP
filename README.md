# Website Bán Laptop - Trang Nguyễn Thanh Danh

Website thương mại điện tử bán laptop, xây dựng trên **ASP.NET MVC 5** + **SQL Server**.

---

## 1. Cài đặt

### Yêu cầu hệ thống

| Thành phần | Phiên bản tối thiểu |
|------------|---------------------|
| Windows | 10 / 11 |
| Visual Studio | 2022 Community trở lên |
| SQL Server | 2019 Express trở lên |
| .NET Framework | 4.8 |

### Các bước

**1. Clone / Copy** toàn bộ thư mục `ShopLaptop` sang máy mới.

**2. Mở SQL Server Management Studio**, ghi nhận tên server (format: `TENMAY\INSTANCE`).

**3. Chạy script cài đặt:**

```
setup/setup.bat
```

Nhấn **Y** để đồng ý. Nhập tên SQL Server nếu khác mặc định.

**4. Mở project trong Visual Studio:**

```
src/Shop/Shop.csproj
```

**5. Nhấn F5** để chạy.

---

## 2. Tài khoản

| Vai trò | Email | Password |
|---------|-------|----------|
| **Admin** | `admin@gmail.com` | `Admin@123456` |
| **Tester** | `tester@gmail.com` | `Admin@123456` |

---

## 3. Link truy cập

| Trang | URL |
|-------|-----|
| Trang chủ | `http://localhost:54243/` |
| Quản trị Admin | `http://localhost:54243/Admin` |
| Trang quản trị (tương đương) | `http://localhost:54243/Administrator` |

---

## 4. Chức năng hiện có

### Người dùng (User)

- Đăng ký / Đăng nhập / Đăng xuất
- Xem danh sách laptop theo hãng, theo nhu cầu sử dụng, theo chủ đề blog
- Tìm kiếm sản phẩm
- Xem chi tiết laptop
- Đánh giá & bình luận sản phẩm
- Giỏ hàng
- Đặt hàng
- Xem lịch sử đơn hàng
- Liên hệ hỗ trợ
- Thanh toán qua PayPal, Momo, Payoo, thẻ ATM, thẻ tín dụng
- Xác thực hai yếu tố qua SMS (Twilio)

### Quản trị (Admin)

- **Quản lý Laptop** — thêm / sửa / xóa sản phẩm
- **Quản lý Hãng Laptop** — CRUD hãng sản xuất
- **Quản lý Nhu cầu sử dụng** — CRUD danh mục nhu cầu
- **Quản lý Chủ đề Blog** — CRUD chủ đề bài viết
- **Quản lý Tin tức / Blog** — viết & quản lý bài viết
- **Quản lý Đơn hàng** — xem, duyệt, cập nhật trạng thái đơn hàng
- **Quản lý Chi tiết Đơn hàng** — xem từng sản phẩm trong đơn
- **Quản lý Bình luận** — duyệt / xóa bình luận
- **Quản lý Đánh giá** — duyệt / xóa đánh giá
- **Quản lý Liên hệ** — xem & phản hồi liên hệ khách hàng
- **Quản lý Quảng cáo** — quản lý banner quảng cáo
- **Quản lý Người dùng** — CRUD tài khoản người dùng
- **Quản lý Vai trò** — gán vai trò Admin / Staff cho user
- **Dashboard** — thống kê tổng quan

---

## 5. Cấu trúc Project

```
ShopLaptop/
├── README.md
├── setup/
│   ├── setup.bat              # Script cài đặt (Windows)
│   ├── setup.ps1             # Script cài đặt (PowerShell)
│   ├── scriptlaptop.sql       # Script tạo database
│   └── HashPass.exe          # Tool reset password
│
└── src/
    └── Shop/
        ├── Shop.sln
        ├── Shop.csproj
        ├── Web.config
        ├── packages.config
        ├── Global.asax(.cs)
        │
        ├── App_Start/                # Cấu hình ứng dụng
        │   ├── RouteConfig.cs
        │   ├── FilterConfig.cs
        │   ├── BundleConfig.cs
        │   ├── IdentityConfig.cs     # Cấu hình Identity, SMS (Twilio)
        │   └── Startup.cs
        │
        ├── Controllers/              # Controllers công khai
        │   ├── AccountController.cs   # Đăng nhập / đăng ký
        │   ├── HomeController.cs      # Trang chủ, tìm kiếm
        │   ├── GioHangController.cs   # Giỏ hàng
        │   ├── ManageController.cs    # Quản lý tài khoản
        │   └── ReportController.cs    # Báo cáo
        │
        ├── Areas/
        │   └── Administrator/
        │       ├── AdministratorAreaRegistration.cs
        │       ├── Controllers/        # Tất cả controller admin
        │       │   ├── MainPageController.cs    # Dashboard, login admin
        │       │   ├── LaptopController.cs       # Quản lý laptop
        │       │   ├── HangController.cs         # Quản lý hãng
        │       │   ├── NhuCauController.cs      # Quản lý nhu cầu
        │       │   ├── ChuDeController.cs       # Quản lý chủ đề
        │       │   ├── TinTucController.cs      # Quản lý tin tức
        │       │   ├── DonHangController.cs     # Quản lý đơn hàng
        │       │   ├── ChiTietDonHangController.cs
        │       │   ├── BinhLuanController.cs    # Quản lý bình luận
        │       │   ├── DanhGiaController.cs     # Quản lý đánh giá
        │       │   ├── LienHeController.cs      # Quản lý liên hệ
        │       │   ├── QuangCaoController.cs    # Quản lý quảng cáo
        │       │   ├── MetaLaptopController.cs # Quản lý metadata
        │       │   ├── AspNetUsersController.cs   # CRUD users
        │       │   ├── AspNetRolesController.cs   # CRUD roles
        │       │   ├── AspNetUserRolesController.cs
        │       │   └── AspNetUserClaimsController.cs
        │       └── Data/
        │           ├── excel/         # Đọc/ghi Excel
        │           ├── message/       # Toast notification, flash message
        │           └── libraries/     # CSS/JS thư viện (Toastr, SweetAlert2)
        │
        ├── Models/                     # Entity Models + Identity
        │   ├── IdentityModels.cs       # ApplicationUser, ApplicationDbContext
        │   ├── MyData.designer.cs      # LINQ to SQL context
        │   └── ...
        │
        ├── EF/                         # Entity Framework
        ├── Data/                       # Dữ liệu (file upload, hình ảnh)
        │   └── files/
        ├── Migrations/                 # EF Migrations
        ├── Common/                     # Helper, utilities
        ├── Others/                     # Assets, mail templates
        ├── Plugins/                    # CKEditor, CKFinder
        ├── Content/                    # CSS, hình ảnh frontend
        ├── Scripts/                    # JavaScript
        └── Views/
            ├── Shared/
            │   ├── _Layout.cshtml      # Layout chính
            │   └── _LoginPartial.cshtml
            ├── Home/
            ├── Account/
            ├── GioHang/
            └── ...
```

---

## 6. Công nghệ sử dụng

| Lĩnh vực | Công nghệ |
|----------|-----------|
| Backend | ASP.NET MVC 5, .NET Framework 4.8 |
| ORM | Entity Framework 6, LINQ to SQL |
| Database | SQL Server |
| Authentication | ASP.NET Identity 2 |
| Frontend | Bootstrap 5, HTML5, CSS3, jQuery |
| Editor | CKEditor 4 + CKFinder |
| Thanh toán | PayPal, Momo, Payoo, ATM, Credit Card |
| SMS | Twilio API |
| Export | EPPlus, ClosedXML (Excel), OpenXml (Word) |
| CAPTCHA | BotDetect |

---
## Liên hệ

- **Email:** danhtnt020893@tvu-onschool.edu.vn
- **Hotline:** 077.268.4206
- **Địa chỉ:** Phường Gia Định, Thành phố Hồ Chí Minh
