# Green Sea · Bảng điều hành marketing

Web app để anh Kiên, sếp và Phương cùng xem, cập nhật kế hoạch, nộp và đánh giá báo cáo ngày.
Giao diện chạy trên **GitHub Pages** (miễn phí), dữ liệu và ảnh lưu trên **Supabase** (gói miễn phí).

## Gồm những file gì

| File | Dùng để |
|---|---|
| `index.html` | Toàn bộ web app |
| `config.js` | Nơi điền địa chỉ và khóa Supabase |
| `assets/logo.png` | Logo Green Sea nền trong suốt |
| `supabase/schema.sql` | Tạo bảng dữ liệu, phân quyền, kho ảnh |
| `supabase/seed.sql` | Nạp sẵn kế hoạch 19/10 – 31/12 (việc từng ngày, tổng quan, ngân sách, tài liệu) |

## Cài đặt (khoảng 20 phút, làm 1 lần)

### Bước 1. Tạo dữ liệu trên Supabase
1. Vào https://supabase.com → đăng nhập bằng tài khoản Google công ty → **New project** (đặt tên `green-sea-hub`, chọn khu vực Singapore).
2. Vào **SQL Editor** → New query → dán toàn bộ `supabase/schema.sql` → **Run**.
3. Tạo query mới → dán toàn bộ `supabase/seed.sql` → **Run**.
4. Vào **Authentication → Sign In / Providers → Email**: bật Email, **tắt "Allow new users to sign up"** để người lạ không tự đăng ký được.
5. Vào **Authentication → Users → Invite user**: mời email của anh Kiên, sếp, Phương.
6. Vào **Project Settings → API**: copy **Project URL** và khóa **anon public**.

### Bước 2. Điền cấu hình
Mở `config.js`, thay 2 dòng `DIEN_...` bằng Project URL và anon key vừa copy.
(Khóa anon được phép để công khai; dữ liệu vẫn chỉ người được mời mới đọc được.)

### Bước 3. Đưa lên GitHub Pages
1. Tạo repository mới trên GitHub, ví dụ `green-sea-hub` (để Private nếu tài khoản có GitHub Pro, không thì Public cũng được vì dữ liệu nằm ở Supabase).
2. Tải toàn bộ thư mục này lên (nút **Add file → Upload files**).
3. Vào **Settings → Pages** → Source: **Deploy from a branch** → Branch: `main`, thư mục `/ (root)` → Save.
4. Sau 1–2 phút có địa chỉ dạng `https://<tên-tài-khoản>.github.io/green-sea-hub/`.

### Bước 4. Khai báo địa chỉ web cho phần đăng nhập
Supabase → **Authentication → URL Configuration**: điền địa chỉ GitHub Pages ở trên vào **Site URL** và **Redirect URLs**.

## Cách đăng nhập
Mở địa chỉ web → nhập email đã được mời → bấm **Gửi link đăng nhập** → mở email, bấm link là vào.

## Lưu ý
- Gói miễn phí của Supabase tạm dừng dự án nếu **7 ngày liền không ai mở** web; chỉ cần vào trang Supabase bấm Restore. Dùng hằng ngày thì không bị.
- Ảnh minh chứng: gói miễn phí có 1 GB, đủ cho vài nghìn ảnh điện thoại.
- Muốn thêm người dùng: Supabase → Authentication → Users → Invite user.
