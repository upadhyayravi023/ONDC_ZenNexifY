enum Endpoint {
  // User routes
  signUp('http://10.0.2.2:8000/api/ZenNexify/owner/signUp', HttpMethod.post),
  login('http://10.0.2.2:8000/api/ZenNexify/owner/login', HttpMethod.post),
  updateInfo(
      'https://yourdomain.com/api/ZenNexify/owner/updateInfo', HttpMethod.post),
  logout('http://10.0.2.2:8000/api/ZenNexify/owner/login', HttpMethod.post),
  // Store routes
  postStore(
      'https://yourdomain.com/api/ZenNexify/owner/stores', HttpMethod.post),
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
