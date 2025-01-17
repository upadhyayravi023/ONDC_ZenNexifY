const express = require('express');
const router = express.Router();
const userModel = require('../models/user');
const bcrypt = require('bcrypt');
const { generateToken } = require('../utils/generateToken');
const { isLoggedIn } = require('../middleware/authMiddleware');

const path = require('path');

router.post('/userInformation', async (req, res) => {
  try {
    const { username, name, phone, Gst_id } = req.body;

    // Validate required fields
    if (!username || !name || !phone || !Gst_id ) {
      return res.status(400).json({ message: 'All fields and files are required' });
    }

    

   

    const updatedUser = await userModel.findOneAndUpdate(
      { username },
      {
        name,
        phone,
        Gst_id,
        
      },
      { new: true } 
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




router.post('/', async (req, res) => {
  const { username, email, password } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  try {
    const saltRounds = 10; 
    const salt = await bcrypt.genSalt(saltRounds); 
    const hashedPassword = await bcrypt.hash(password, salt);
    const newUser = await userModel.create({
      username,
      email,
      password:hashedPassword
    });

    const token = generateToken({ email: newUser.email, id: newUser._id });
    res.cookie('token', token, { httpOnly: true });

    res.status(201).json({
      message: 'User signed up successfully',
      user: newUser,
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});



router.post('/login', async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Email and password are required' });
  }

  try {
    const user = await userModel.findOne({ username });
    if (!user) {
      return res.status(400).json({ message: 'Invalid email or password' });
    }
   
    const isMatch = await bcrypt.compare(password, user.password);
    if (isMatch) {
      return res.status(400).json({ message: 'Invalid email or password' });
    }
    
    const token = generateToken({ username: user.username });
    res.cookie('token', token, { httpOnly: true });

    res.status(200).json({ message: 'Login successful', token });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
})

router.post('/logout', (req, res) => {
  const {username} = req.body
  let user = userModel.findOne({username})
  if(user){
    res.clearCookie('token', { httpOnly: true }); // Clear the token cookie
    res.status(200).json({ message: 'Logged out successfully' });
  }
  else{
    res.status(400).json("not an user")}
   
  });
  
  router.delete('/deleteUser', async (req, res) => {
    const { username } = req.body;
  
    try {
      const user = await userModel.findOneAndDelete({ username: username });
  
      if (user) {
        res.status(200).json({ message: 'User deleted successfully' });
      } else {
        res.status(404).json({ message: 'User not found' });
      }
    } catch (error) {
      res.status(500).json({ message: 'Internal Server Error', error: error.message });
    }
  });
  

module.exports = router;
