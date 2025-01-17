const mongoose = require('mongoose');
const { type } = require('os');

const storeSchema = new mongoose.Schema(
  {
    storename: {
      type: String,
      required: true,
    },
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    location: {
      street: { type: String, required: true, trim: true },
      city: { type: String, required: true, trim: true },
      state: { type: String, required: true, trim: true },
      zip: {
        type: Number,
      },
      country: { type: String, required: true, trim: true },
    },
    contact: {
      type: Number,
      required: true,
    },
    products: [
      {
        type: String
         // Correct ref to match product schema
      },
    ],
  },
  { timestamps: true }
);

const Store = mongoose.model('Store', storeSchema);
module.exports = Store;


