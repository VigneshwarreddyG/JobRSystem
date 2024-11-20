// config/db.js
const mysql = require('mysql');

const db = mysql.createConnection({
    host: 'localhost',    // Use your database host
    user: 'root',         // Use your database username
    password: 'Vigneshwar94', // Use your database password
    database: 'job_recruitment_system' // Use your database name
});

db.connect((err) => {
    if (err) {
        console.error("Database connection error:", err);
        throw err;
    }
    console.log("Connected to the database");
});

module.exports = db;
