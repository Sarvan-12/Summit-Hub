# Summit Hub 🚀

## Overview

Summit Hub is a centralized platform designed to bring together event organizers, speakers, and attendees in one place. It simplifies how individuals interact with conference schedules, presentation uploads, and administrative controls by providing a structured, highly secure, and elegant retro-modern interface.

---

## Live Demo

Access the deployed application here:
🔗 [https://summit-hub.onrender.com/](https://summit-hub.onrender.com/)

⭐ If you like this project, please star this repository!

---

## Features

### 🔒 Security & Privacy
* **JWT Cookie Authentication:** Admin and Speaker dashboards are secured using HTTP-only cookies and robust JWT parsing middleware.
* **Bcrypt Password Hashing:** Secure password hashing on registration and password updates.
* **Privacy Controls:** Public endpoints explicitly filter out sensitive speaker data (such as phone numbers and password hashes).

### 📅 Conference & Schedule Management
* **Attendee Schedule:** Interactive day-by-day and hall-by-hall grid for attendees to explore tracks.
* **Admin Dashboard:** Manage halls, schedule slots, and speakers dynamically. Export schedules to CSV files easily.
* **File Management Hub:** Secure administrative dashboard to inspect, download, or delete uploaded speaker slide decks.

### 🎙️ Speaker Dashboards
* **Speaker Self-Service:** Unique speaker codes (e.g., `SP001`) with personal passwords.
* **Upload System:** Secure PDF/PPTX upload validation for presentation slides.

---

## Tech Stack

* **Frontend:** Vanilla HTML5, CSS3 (Modern custom variables & flex/grid layout), and ES6 Javascript.
* **Backend:** Node.js, Express, Multer (secure uploads validation), and json2csv (data exports).
* **Database:** MySQL (relational constraints, connection pooling via `mysql2/promise`).
* **Security:** JSON Web Tokens (JWT), BCryptJS.
* **Deployment:** Railway / Vercel ready.

---

## Project Structure

```
Summit-Hub/
├── database/
│   └── setup.sql           # Database schema definition and seed data
├── public/                 # Static frontend client code
│   ├── index.html          # Main attendee schedule display
│   ├── admin-login.html    # Admin authentication
│   ├── admin.html          # Admin dashboard (schedule, halls & speakers)
│   ├── speaker-login.html  # Speaker authentication page
│   ├── speaker-dashboard.html # Speaker upload panel & profile updates
│   ├── style.css           # Modern CSS variables and app styling
│   └── *.js                # Client logic handlers
├── uploads/                # Repository for uploaded slide files (git-ignored)
├── .env                    # Config & database credentials (git-ignored)
├── server.js               # Central Node.js Express server & security routing
├── test-system.js          # Browser automated system testing suite
└── package.json            # Dependencies and start scripts
```

---

## Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Sarvan-12/Summit-Hub.git
   cd Summit-Hub
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Configure Environment Variables:**
   Create a `.env` file in the root directory:
   ```env
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your_mysql_password
   DB_NAME=conference_portal
   PORT=3000
   NODE_ENV=development
   JWT_SECRET=your-jwt-secret-key
   ADMIN_USER=admin
   ADMIN_PASSWORD=admin123
   ```

4. **Initialize Database:**
   Import the schema and seed data from `database/setup.sql` into your MySQL server.

5. **Start Server:**
   ```bash
   # Production mode
   npm start

   # Development mode (nodemon)
   npm run dev
   ```

