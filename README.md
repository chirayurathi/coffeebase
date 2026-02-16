# Coffee Brewing & Social App

A Flutter-based social network for coffee enthusiasts with a Django backend.

## Features
- **Social Feed:** Posts and reels with full video playback.
- **Coffee Recipes:** Log detailed brewing recipes with searchable dropdowns.
- **Brew Timer:** Interactive, multi-stage timer for precise brewing.
- **Pro Mode:** Fields for TDS and Extraction Yield logging.
- **Map:** Find coffee-related locations using OpenStreetMap.
- **Offline Support:** Local caching of recipes using sqflite.
- **Modern UI:** Sleek black and brown color palette.

## Project Structure
- `backend/`: Django REST Framework project.
- `frontend/coffee_frontend/`: Flutter mobile application (Android/iOS).

---

## How to Run

### 1. Backend (Django)
1.  **Navigate to the backend directory:**
    ```bash
    cd backend
    ```
2.  **Install dependencies:**
    ```bash
    pip install -r requirements.txt
    ```
3.  **Setup Database:**
    The app is configured to use SQLite by default for development. To use PostgreSQL, update the `.env` file.
4.  **Run Migrations:**
    ```bash
    python manage.py migrate
    ```
5.  **Start the Server:**
    ```bash
    python manage.py runserver
    ```
    The API will be available at `http://localhost:8000/api/`.

### 2. Frontend (Flutter)
1.  **Navigate to the frontend directory:**
    ```bash
    cd frontend/coffee_frontend
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the App:**
    Ensure you have an emulator running or a physical device connected.
    ```bash
    flutter run
    ```

---

## Configuration
- **Google Login:** Requires setting up a project in the Google Cloud Console and adding the Client ID/Secret to the Django Admin (`Social Applications`).
- **OneSignal:** Add your OneSignal App ID in `lib/main.dart` to enable push notifications.
- **Media:** Images and videos are stored in the `backend/media/` directory.
