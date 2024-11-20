const express = require('express');
const router = express.Router();
const employerController = require('../controllers/employerController');

router.post('/register', employerController.register);
router.post('/login', employerController.login);
router.post('/post-job', employerController.postJob);

module.exports = router;
