enum Endpoint {
  //user routes
  signUp('https://yourdomain.com/api/ZenNexify/owner/signUp'), //POST
  login('https://yourdomain.com/api/ZenNexify/owner/login'), //POST
  updateInfo('https://yourdomain.com/api/ZenNexify/owner/login'), //POST

  //store routes
  createStore('https://yourdomain.com/api/ZenNexify/owner/stores'), //POST
  fetchStore('https://yourdomain.com/api/ZenNexify/owner/stores'), //GET

  //product routes
  addProduct('https://yourdomain.com/api/ZenNexify/owner/stores'), //POST
  fetchProduct('https://yourdomain.com/api/ZenNexify/owner/stores'); //GET

  const Endpoint(this.url);
  final String url;
}
