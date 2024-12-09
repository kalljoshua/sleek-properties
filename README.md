Here is the generated `README.md` content for your project:

---

# Property Management System

This is a **Property Management System** for managing properties, developed for **Sleek Properties LLC**. The system provides functionality to add, edit, and delete properties through a Flutter frontend (using Bloc for state management) and a Laravel backend API.

---

## Features

- Add, edit, and delete properties.
- Upload and display property images.
- Responsive UI with Flutter.
- Backend API built with Laravel.
- State management with Flutter Bloc.

---

## Prerequisites

### Backend
- PHP 8.x or higher
- Composer
- MySQL
- Laravel 9.x or higher

### Frontend
- Flutter 3.x or higher
- Dart 2.16 or higher

---

## Installation

### Backend Setup (Laravel API)
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd backend
   ```

2. Install dependencies:
   ```bash
   composer install
   ```

3. Set up environment variables:
   - Copy `.env.example` to `.env`:
     ```bash
     cp .env.example .env
     ```
   - Update the database credentials in the `.env` file.

4. Run migrations:
   ```bash
   php artisan migrate
   ```

5. Start the Laravel development server:
   ```bash
   php artisan serve --host=0.0.0.0 --port=8000
   ```

   If testing on a physical device, replace `0.0.0.0` with your machine's local IP address (e.g., `192.168.x.x`).

---

### Frontend Setup (Flutter)
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd frontend
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Update API URL:
   - Open `lib/services/property_service.dart`.
   - Set the `apiUrl`:
     - Use `http://10.0.2.2:8000` for Android Emulator.
     - Use `http://192.168.x.x:8000` for physical devices, replacing `192.168.x.x` with your machine's local IP address.

4. Run the app:
   ```bash
   flutter run
   ```

---

## Folder Structure

### Backend (Laravel)
```
backend/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   └── PropertyController.php
│   ├── Models/
│   │   └── Property.php
├── database/
│   ├── migrations/
│   │   └── 2024_xx_xx_create_properties_table.php
├── routes/
│   └── api.php
└── .env
```

### Frontend (Flutter)
```
frontend/
├── lib/
│   ├── bloc/
│   │   ├── property_bloc.dart
│   │   ├── property_event.dart
│   │   └── property_state.dart
│   ├── pages/
│   │   ├── add_edit_property_page.dart
│   │   └── property_list_page.dart
│   ├── services/
│   │   └── property_service.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```

---

## API Endpoints

### Base URL
`http://<host>:8000/api`

### Endpoints
- **GET** `/properties`: Fetch all properties.
- **POST** `/properties`: Add a new property.
  - Parameters:
    - `name` (string): Name of the property.
    - `description` (string): Description of the property.
    - `price` (float): Price of the property.
    - `image` (file): Optional property image.
- **PUT** `/properties/{id}`: Update an existing property.
- **DELETE** `/properties/{id}`: Delete a property.

---

## Usage

### Add Property
1. Open the app.
2. Click the **Add** button in the top-right corner.
3. Fill in the details and select an image.
4. Click **Save**.

### Edit Property
1. Click the **Edit** button next to a property.
2. Modify the details or upload a new image.
3. Click **Save**.

### Delete Property
1. Click the **Delete** button next to a property.
2. Confirm the deletion.

---

## Troubleshooting

### Flutter Errors
- **Provider not found**:
  - Ensure `BlocProvider` wraps the widget tree in `main.dart`.
- **Connection refused (errno=111)**:
  - Use `10.0.2.2` for Android Emulator or your local IP for physical devices.
  - Start Laravel with `php artisan serve --host=0.0.0.0`.

### Laravel Errors
- **Database not found**:
  - Ensure the database credentials in `.env` are correct.
  - Run `php artisan migrate` to create tables.

---

## Contribution

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature-name"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

