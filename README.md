# CS3083_Demo - Flask

## Prerequisites
- Python
- pip
- MySQL Server (e.g., XAMPP)
- MySQL Client

---

## Setup

### 1. Create the MySQL Database
Create your database using your preferred MySQL client or CLI.

---

### 2. Set Up the Python Environment

1. Create a virtual environment:
   ```python -m venv venv```

2. Acvitate the virtual environment:
   ```source venv/bin/activate  # On Windows: venv\Scripts\activate```

3. Create a `requirements.txt` file containing:
   ```flask
   flask-mysqldb```

4. Install the dependencies
   ```pip install -r requirements.txt```

---

### 3. Setup workspace
    - `templates/` - stores the html files
    - `static/` - stores CSS, images, and JS files (each in respective subfolders)
    - `app.py` - main backend application
    - `config.py` - database connection configuration

---

### 4. Update config.py
Configure your database connection like this:
    ```MYSQL_HOST = 'localhost'
        MYSQL_USER = 'your_mysql_user'
        MYSQL_PASSWORD = 'your_mysql_password'
        MYSQL_DB = 'your_db_name'```

---

### 5. Create app.py
Implement your Flask backend logic here.

---

### 6. Create HTML Files 
Add your frontend templates inside the `templates/` folder.

---

### 7. Running the app
To run the app, run: 
    ```python app.py```
