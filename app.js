// app.js
const express = require('express');
const app = express();
const applicantRoutes = require('./routes/applicantRoutes');
const path = require('path');

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve static files (for HTML)
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.use('/applicants', applicantRoutes);

// Start Server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
