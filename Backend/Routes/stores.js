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
  
    if (!username || !location || !contact || !storename) {
      return res.status(400).json({ message: 'All fields are required' });
    }
  
    try {
      
      const user = await userModel.findOne({ username });
  
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }
  
      // Create a new store document using the user's _id
      const newStore = await storeModel.create({
        user_id: user._id,
        location,
        contact,
        storename,
      });
  
      // Push the store's ObjectId to the user's stores array
      user.stores.push(storename);
      await user.save(); // Save the updated user document
  
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
    const { username } = req.body;
  
    if (!username) {
      return res.status(400).json({ message: 'Username is required' });
    }
  
    try {
      const user = await userModel.findOne({ username });
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }
      
      const stores = await storeModel.find({ user_id: user._id }); // Query by user_id (not username)
  
      res.status(200).json({
        message: 'Stores retrieved successfully',
        stores,
      });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });

  router.delete('/deleteStore', async (req, res) => {
    const { username, storename } = req.body;
  
    if (!username || !storename) {
      return res.status(400).json({ message: 'Username and storename are required' });
    }
  
    try {
      const user = await userModel.findOne({ username });
  
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }
  
      const store = await storeModel.findOneAndDelete({ storename, user_id: user._id });
  
      if (!store) {
        return res.status(404).json({ message: 'Store not found' });
      }
  
      user.stores = user.stores.filter((name) => name !== storename);
      await user.save();
  
      res.status(200).json({ message: 'Store deleted successfully' });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
  router.delete('/products/deleteStoreProduct', async (req, res) => {
    const { storename, productName } = req.body;
  
    if (!storename || !productName) {
      return res.status(400).json({ message: 'Storename and product name are required' });
    }
  
    try {
      const store = await storeModel.findOne({ storename });
  
      if (!store) {
        return res.status(404).json({ message: 'Store not found' });
      }
  
      const product = await productModel.findOneAndDelete({ name: productName, store_id: store._id });
  
      if (!product) {
        return res.status(404).json({ message: 'Product not found' });
      }
  
      store.products = store.products.filter((name) => name !== productName);
      await store.save();
  
      res.status(200).json({ message: 'Product deleted successfully' });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
 
  router.post('/products',async (req, res) => {
    const { storename, name, description, quantity, price, status } = req.body;
    st = storename
    // Validate input
    if (!storename || !name || !quantity || !price) {
      return res.status(400).json({ message: 'All required fields must be provided' });
    }
  
    try {
      const store = await storeModel.findOne({ storename });
  
      if (!store) {
        return res.status(404).json({ message: 'Store not found' });
      }
  
      // Create the product
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
    const { storename, sortBy = 'createdAt', sortOrder = 'desc', limit = 10, page = 1 } = req.body;
  
    try {
      // Find the store by storename
      const store = await storeModel.findOne({ storename });
  
      if (!store) {
        return res.status(404).json({ message: 'Store not found' });
      }
  
      // Fetch products associated with the store
      const query = { store_id: store._id };
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