# Proyek Terraform untuk Arsitektur AWS

## Deskripsi
Proyek ini menggunakan Infrastructure as Code (IaC) dengan Terraform untuk membuat infrastruktur AWS sesuai dengan arsitektur yang telah ditentukan. Arsitektur mencakup berbagai layanan AWS seperti Route 53, CloudFront, ALB, WAF, EKS, S3, RDS, Cognito, serta monitoring dengan CloudWatch, Grafana, dan ELK Stack.

## Prasyarat
- **Terraform CLI** terinstal
- **Akun AWS** dengan kredensial akses
- **Terraform Cloud** *(opsional, jika menggunakan Terraform Cloud untuk state management)*

## Cara Menggunakan
1. **Clone repositori ini:**
```bash
git clone <repository-url>
cd <repository-directory>
```

2. **Inisialisasi direktori Terraform:**
```bash
terraform init
```

3. **Buat dan lihat rencana infrastruktur:**
```bash
terraform plan
```

4. **Terapkan perubahan untuk membangun infrastruktur:**
```bash
terraform apply
```

## Kendala
Karena tidak ada akses langsung ke akun AWS, proses `terraform plan` dan `terraform apply` tidak dapat dijalankan untuk mendapatkan screenshot hasilnya. Jika akses AWS tersedia, proses tersebut akan menghasilkan rencana infrastruktur yang menunjukkan sumber daya yang akan dibuat di AWS.