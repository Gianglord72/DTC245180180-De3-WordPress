# Đề 3 — Website Quảng bá Sản phẩm (WordPress)

Học phần: **Triển khai và Quản trị Hệ thống Phần mềm**

## Công nghệ sử dụng
- **WordPress** (php8.2-apache) — Website giới thiệu/quảng bá sản phẩm
- **MySQL 8.0** — Cơ sở dữ liệu (chạy mạng internal, không publish cổng)
- **phpMyAdmin 5.2** — Quản trị CSDL qua giao diện web
- **Nginx 1.25** — Reverse proxy + SSL termination (HTTPS self-signed)
- **Prometheus** — Thu thập metrics (MySQL, Nginx, container qua cAdvisor)
- **Grafana** — Dashboard giám sát + khám phá log (tự provision datasource & dashboard)
- **Loki + Promtail** — Tập trung & truy vấn log (LogQL)
- **Docker Compose** — Điều phối toàn bộ stack, phân tách 4 mạng (edge/data/metrics/logs)

## Khởi chạy nhanh
```bash
cp .env.example .env          # điền IP máy ảo và đổi tất cả mật khẩu
bash infra/ssl/generate-cert.sh wordpress.local <IP_MAY_AO>
docker compose --env-file .env up -d
```

## Các endpoint (sau khi khởi chạy)
| Dịch vụ | Địa chỉ |
|---|---|
| WordPress (HTTPS) | `https://<IP>:8443` hoặc `https://wordpress.local:8443` |
| phpMyAdmin | `http://<IP>:5050` |
| Grafana | `http://<IP>:3001` |

> HTTP cổng `8081` tự động redirect 301 sang HTTPS `8443`.

## Cấu trúc thư mục
Xem file `HUONG_DAN_LAM_DE3.md` để biết hướng dẫn chi tiết từng bước trên Ubuntu.

## Bảo mật (Hardening)
- MySQL/Prometheus/Loki chạy trên mạng Docker `internal` (không expose ra host)
- Nginx ẩn phiên bản, chỉ TLS 1.2/1.3, HSTS + security headers
- Tài khoản exporter riêng (không dùng root), chỉ quyền SELECT
- Tường lửa UFW chỉ mở các cổng cần thiết; SSH cấm login root trực tiếp
- File `.env`, khóa riêng `.key` không commit lên Git (xem `.gitignore`)
