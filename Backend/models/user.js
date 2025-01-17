require('dotenv').config(); 
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const DB_URI = process.env.MONGO_URI;

mongoose
  .connect(DB_URI 
  )
  .then(() => {
    console.log('Connected to the MongoDB database successfully!');
  })
  .catch((err) => {
    console.error('Database connection error:', err);
  });

const UserSchema = new mongoose.Schema(
  {
    username: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    },
    name: {
      type: String,
      trim: true,
    },
    DOB: {
      type: Date,
    },
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
    },
    password: {
      type: String,
      required: true,
     minlength: 5,
    },
    PAN_Card: {
      type: String,
     
    },
    Aadhar_Card: {
      type: String,
     require:true
    },
    phone: {
      type: String,
    },
    Gst_id: {
      type: String,
     require:true
    },
    
     stores: [
      {
        type:String,
        
      },
    ],
  },
  { timestamps: true }
);

UserSchema.pre('save', async function (next) {
  if (this.isModified('password')) {
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
  }
  next();
});

UserSchema.methods.isValidPassword = async function (password) {
  return await bcrypt.compare(password, this.password);
};

const User = mongoose.model('User', UserSchema);
module.exports = User;
