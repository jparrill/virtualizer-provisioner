mkdir -p /opt/minio/data

podman run -d --name minio -p 9002:9000 -p 9001:9001 -v /opt/minio/data:/data -e "MINIO_ROOT_USER=ROOTNAME" -e "MINIO_ROOT_PASSWORD=CHANGEME123" quay.io/minio/minio server /data --console-address ":9001"
