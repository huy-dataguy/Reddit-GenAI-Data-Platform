#!/bin/bash

# Cấu hình các biến
ALIAS="minio_local"
MINIO_URL="http://minio1:9000"
ACCESS_KEY="minio"
SECRET_KEY="mypassword"
BUCKET_NAME="lakehouse"

echo "Configuring MinIO client alias..."
# Thêm alias. Sử dụng --with-config-only để không ghi vào ~/.mc/config.json
# Nếu bạn đã có alias rồi, mc alias set sẽ cập nhật lại.
mc alias set "$ALIAS" "$MINIO_URL" "$ACCESS_KEY" "$SECRET_KEY"

# Kiểm tra xem alias đã được cấu hình thành công chưa
if [ $? -ne 0 ]; then
  echo "Error: Failed to configure MinIO alias. Please check your MinIO URL and credentials."
  exit 1
fi

echo "Creating bucket '$BUCKET_NAME' on MinIO..."
# Tạo bucket. Sử dụng --ignore-existing để không báo lỗi nếu bucket đã tồn tại
mc mb "$ALIAS/$BUCKET_NAME" --ignore-existing

if [ $? -eq 0 ]; then
  echo "Successfully created or verified bucket '$BUCKET_NAME'."
else
  echo "Error: Failed to create or verify bucket '$BUCKET_NAME'."
  exit 1
fi