const express = require('express');
const router = express.Router();
const userModel = require('../models/user');
const bcrypt = require('bcrypt');
const { generateToken } = require('../utils/generateToken');
const { isLoggedIn } = require('../middleware/authMiddleware');

// User Sign-Up
const multer = require('multer');
const path = require('path');




const storage = multer.memoryStorage();

// Filter to allow only PDF files for PAN and Aadhar cards
const fileFilter = (req, file, cb) => {
  if (file.mimetype === 'application/pdf' || file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
    cb(null, true); // Accept the file
  } else {
    cb(new Error('Only PDF, JPG, and PNG files are allowed.'));
  }
};

// Initialize Multer with the configuration
const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB limit for each file
});

// Route to handle the form data along with file upload
router.post('/userInformation',upload.fields([
  { name: 'PAN_Card', maxCount: 1 },
  { name: 'Aadhar_Card', maxCount: 1 }
]), async (req, res) => {
  const { username, name, phone, Gst_id } = req.body;

  // Validate required fields
  if (!username || !name || !phone || !Gst_id || !req.files || !req.files.PAN_Card || !req.files.Aadhar_Card) {
    return res.status(400).json({ message: 'All fields and files are required' });
  }
  

  try {
    
    const panCardData = req.files.PAN_Card[0].buffer; 
    const aadharCardData = req.files.Aadhar_Card[0].buffer; 
    
    const updatedUser = await userModel.findOneAndUpdate(
      { username },
      {
        name,
        phone,
        Gst_id,
        PAN_Card: panCardData, // Store PAN card file data as Buffer
        Aadhar_Card: aadharCardData, // Store Aadhar card file data as Buffer
      },
      { new: true } // Return the updated document
    );

    if (!updatedUser) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.status(200).json({
      message: 'User information updated successfully',
      user: updatedUser,
    });
  } catch (error) {
    console.error('Error updating user information:', error);
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;
