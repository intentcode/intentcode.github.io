FROM nginx:alpine

# Copy static files to nginx html directory
COPY index.html /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/
COPY hooks/ /usr/share/nginx/html/hooks/

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
