// routes/applicantRoutes.js
const express = require('express');
const router = express.Router();
const applicantController = require('../controllers/applicantController');

// Route to apply for a job
router.post('/apply', applicantController.applyForJob);

// Other routes can go here, such as viewing application status, updating profile, etc.

module.exports = router;
