# Summit Hub

## Overview

Summit Hub is a centralized platform designed to bring together users, ideas, and activities in one place. It aims to simplify how individuals interact with events, projects, or collaborative spaces by providing a structured and accessible hub.

The platform focuses on usability, clarity, and scalability, making it suitable for academic, community, or organizational use.

---

## Live Demo

Access the deployed application here:
https://summit-hub-production.up.railway.app/

---

## Problem Statement

Managing multiple activities, events, or collaborative efforts across different platforms can be inefficient and fragmented. Users often struggle with:

* Lack of a single unified interface
* Difficulty in tracking and organizing information
* Poor accessibility and user experience

---

## Solution

Summit Hub addresses these issues by offering a unified platform where users can interact, explore, and manage content in a structured way. It provides a streamlined interface that improves accessibility and reduces complexity.

---

## Features

* Centralized hub for managing and accessing content
* Clean and intuitive user interface
* Scalable architecture for future enhancements
* Organized structure for better usability
* Deployment-ready and accessible via web

---

## Tech Stack

* Frontend: Vanilla HTML5, CSS3 (Modern Flexbox/Grid, custom variables), and ES6 Javascript
* Backend: Node.js, Express, Multer (secure file uploads), and json2csv (schedule exports)
* Database: MySQL (relational constraints, connection pooling via `mysql2/promise`)
* Deployment: Railway / Vercel ready

---

## Project Structure

```
Summit-Hub/
├── database/
│   └── setup.sql           # Database schema definition and seed data
├── public/                 # Static frontend client code
│   ├── admin-login.html    # Admin login page
│   ├── admin.html          # Admin dashboard (schedule & speaker manager)
│   ├── speaker-login.html  # Speaker authentication
│   ├── speaker-dashboard.html # Speaker slide upload & profile manager
│   ├── index.html          # Main attendee schedule display
│   ├── style.css           # App stylesheet (Flexbox/Grid structure)
│   └── *.js                # Client logic handlers
├── uploads/                # Structured repository for uploaded slide files
├── .env                    # Application config & secrets (ignored by git)
├── server.js               # Central Node.js Express server & REST API
├── test-system.js          # Browser automated system testing suite
└── package.json            # Dependencies and start scripts
```

---

## Installation

1. Clone the repository:

```
git clone https://github.com/Sarvan-12/Summit-Hub.git
```

2. Navigate to the project folder:

```
cd Summit-Hub
```

3. Install dependencies:

```
npm install
```

4. Run the application:

```
npm start
```

---

## Future Scope

* User authentication and role management
* Real-time features and notifications
* Advanced dashboard and analytics
* AI-based recommendations and automation
* Mobile-friendly enhancements

---

## Author

Sarvan D Suvarna

---

## License

This project is open-source and available for learning and development purposes.
