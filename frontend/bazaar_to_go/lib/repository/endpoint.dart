enum Endpoint {
  // User routes

  signUp('http://10.0.2.2:8000/api/ZenNexify/user', HttpMethod.post),
  login('http://10.0.2.2:8000/api/ZenNexify/user/login', HttpMethod.post),
  updateInfopost('http://10.0.2.2:8000/api/ZenNexify/user/userInformation', HttpMethod.post),
  logout('http://10.0.2.2:8000/api/ZenNexify/user/logout', HttpMethod.post),
  delete('http://10.0.2.2:8000/api/ZenNexify/user/deleteUser', HttpMethod.delete),
  updateInfoget('http://10.0.2.2:8000/api/ZenNexify/user/userInformation', HttpMethod.get),
  // Store routes
  postStore(
      'https://10.0.2.2:8000/api/ZenNexify/stores', HttpMethod.post),
  getStore('https://yourdomain.com/api/ZenNexify/owner/stores', HttpMethod.get),

  // Product routes
  postProduct(
      'https://yourdomain.com/api/ZenNexify/owner/products', HttpMethod.post),
  getProduct(
      'https://yourdomain.com/api/ZenNexify/owner/products', HttpMethod.get),

  // Address lookup (using a more appropriate URL - consider a dedicated API)
  getAddress('http://www.postalpincode.in/api/pincode/', HttpMethod.get);

  final String url;
  final HttpMethod method;

  const Endpoint(this.url, this.method);

  String getUrl() {
    return url;
  }

  HttpMethod getMethod() {
    return method;
  }
}

enum HttpMethod {
  get,
  post,
  put,
  delete,
}
