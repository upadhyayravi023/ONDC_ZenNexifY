const jwt = require('jsonwebtoken');
const userModel = require('../models/user');
const { generateToken } = require('../utils/generateToken');

const isLoggedIn = async (req, res, next) => {
  try {
    const token = req.cookies.token;

    if (!token) {
      return res.status(401).json({ message: 'Access denied. Please log in.' });
    }

    const decoded = jwt.verify(token, process.env.JWT_KEY);

    const user = await userModel.findOne({ email: decoded.email });

    if (!user) {
      return res.status(401).json({ message: 'Unauthorized access. User not found.' });
    }

    req.user = user; 

    next(); 
  } catch (error) {
    console.error('Authentication error:', error.message);
    res.status(401).json({ message: 'Invalid or expired token. Please log in again.' });
  }
};

module.exports = { isLoggedIn };
