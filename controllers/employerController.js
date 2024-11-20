const db = require('../config/db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

exports.register = (req, res) => {
    const { name, email, password } = req.body;
    bcrypt.hash(password, 10, (err, hash) => {
        if (err) return res.status(500).send(err.message);
        const sql = 'INSERT INTO employers (name, email, password) VALUES (?, ?, ?)';
        db.query(sql, [name, email, hash], (error, results) => {
            if (error) return res.status(500).send(error.message);
            res.status(201).send("Employer registered");
        });
    });
};

exports.login = (req, res) => {
    const { email, password } = req.body;
    const sql = 'SELECT * FROM employers WHERE email = ?';
    db.query(sql, [email], (error, results) => {
        if (error || results.length === 0) return res.status(401).send("Invalid credentials");
        bcrypt.compare(password, results[0].password, (err, match) => {
            if (err || !match) return res.status(401).send("Invalid credentials");
            const token = jwt.sign({ employer_id: results[0].employer_id }, 'secretKey', { expiresIn: '1h' });
            res.json({ token });
        });
    });
};

exports.postJob = (req, res) => {
    const { employer_id, title, description, location, job_type } = req.body;
    const sql = 'INSERT INTO jobs (employer_id, title, description, location, job_type) VALUES (?, ?, ?, ?, ?)';
    db.query(sql, [employer_id, title, description, location, job_type], (error, results) => {
        if (error) return res.status(500).send(error.message);
        res.status(201).send("Job posted successfully");
    });
};
