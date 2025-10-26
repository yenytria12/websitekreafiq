# Gunakan image Nginx
FROM nginx:latest

# Hapus file default dari Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copy semua file website ke folder HTML Nginx
COPY . /usr/share/nginx/html

# Port default untuk Nginx
EXPOSE 80

# Jalankan Nginx di foreground
CMD ["nginx", "-g", "daemon off;"]
