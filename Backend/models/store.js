const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const userModel = require('../models/user');
const storeModel = require('../models/store');
const productModel = require('../models/product');
const { generateToken } = require('../utils/generateToken');


router.post('/', async (req, res) => {
    const { username, location, contact, storename } = req.body;
  
    // Check if all fields are provided
    if (!username || !location || !contact || !storename) {
      return res.status(400).json({ message: 'All fields are required' });
    }
  
    try {
      const user = await userModel.findOne({ username });
  
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }
  
      const newStore = await storeModel.create({
        user_id: user._id,
        location,
        contact,
        storename,
      });
  
      user.stores.push(storename);
      await user.save(); 
  
      res.status(201).json({
        message: 'Store created successfully and user updated',
        store: newStore,
      });
    } catch (error) {
      console.error('Error creating store:', error);
      res.status(500).json({ message: error.message });
    }
  });
  
  
  
  router.get('/', async (req, res) => {
    const { username } = req.query;
  
    if (!username) {
      return res.status(400).json({ message: 'Username is required' });
    }
  
    try {
      const user = await userModel.findOne({ username });
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }
      
      const stores = await storeModel.find({ user_id: user._id }); 
  
      res.status(200).json({
        message: 'Stores retrieved successfully',
        stores,
      });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
  router.post('/products', async (req, res) => {
    const { storename, name, description, quantity, price, status } = req.body;
  
    if (!storename || !name || !quantity || !price) {
      return res.status(400).json({ message: 'All required fields must be provided' });
    }
  
    try {
      const store = await storeModel.findOne({ storename });
  
      if (!store) {
        return res.status(404).json({ message: 'Store not found' });
      }
  
      const product = await productModel.create({
        name,
        description,
        quantity,
        price,
        status,
        store_id: store._id,
      });
  
      store.products.push(product.name);
      await store.save(); 
  
      res.status(201).json({
        message: 'Product created successfully',
        product,
      });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
  
  
  router.get('/products', async (req, res) => {
    const { store_id, sortBy = 'createdAt', sortOrder = 'desc', limit = 10, page = 1 } = req.query;
  
    try {
      const query = store_id ? { store_id } : {};
      const products = await productModel
        .find(query)
        .sort({ [sortBy]: sortOrder === 'asc' ? 1 : -1 })
        .skip((page - 1) * limit)
        .limit(parseInt(limit));
  
      const totalProducts = await productModel.countDocuments(query);
  
      res.status(200).json({
        message: 'Products fetched successfully',
        products,
        totalProducts,
        totalPages: Math.ceil(totalProducts / limit),
        currentPage: parseInt(page),
      });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
  module.exports = router