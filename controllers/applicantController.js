// controllers/applicantController.js
const db = require('../config/db');

// Apply for a job
exports.applyForJob = (req, res) => {
    const { job_id, applicant_id } = req.body;
    const sql = 'INSERT INTO applications (job_id, applicant_id) VALUES (?, ?)';

    db.query(sql, [job_id, applicant_id], (err, results) => {
        if (err) {
            console.error("Error inserting application:", err);
            return res.status(500).send(err.message);
        }
        res.status(201).send("Application submitted successfully");
    });
};

// Other functions (view application status, update profile) can go here.
