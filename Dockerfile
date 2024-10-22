# Use the official Python image for the backend
FROM python:3.11 AS backend
WORKDIR /app/src/server

# Copy the backend requirements file, install dependencies and run server
COPY src/server/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY src/server/ .
EXPOSE 8000
CMD ["python", "manage.py", "runserver"]

# Use the official Flutter image for the frontend
FROM cirrusci/flutter:latest AS frontend

WORKDIR /app/src/client

# Copy the frontend pubspec file and install dependencies
COPY src/client/pubspec.yaml .
RUN flutter pub get
COPY src/client/ .

# Build the Flutter application for web
RUN flutter build web
FROM nginx:alpine
COPY --from=frontend /app/src/client/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
