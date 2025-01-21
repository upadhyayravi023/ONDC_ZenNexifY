
# Bazaar To Go




## Description of the Solution

Bazaar To-Go is an all-in-one marketplace solution designed to empower sellers and enhance customer shopping experiences. The application offers seamless inventory management, centralized order handling, insightful analytics, and customer feedback tools—all in one platform. By streamlining operations and providing actionable insights, Bazaar To-Go helps sellers grow their businesses and cater to their customers more effectively.


## Tech Stack Used

1. Frontend: React.js

2. Backend: Python (Flask/Django)

3. Database: PostgreSQL

4. Cloud Services: AWS (S3 for storage, Lambda for serverless functions)

5. APIs: OCR.Space API for catalog generation, Stripe API for payment handling

6. Version Control: Git and GitHub


## Use Cases



1. Streamlined Inventory Management

 -> Upload catalogs manually, via images, or through API integration.

 -> Auto-generate product descriptions and titles using OCR technology.

2. Centralized Order Hub

 -> Manage all orders from multiple online stores in one place.

 -> Track and fulfill orders with real-time updates.

3. Generate Custom Sales Reports

 -> Download detailed Excel reports tailored to specific time periods.

 -> Analyze sales trends to optimize strategies.

4. Customer Feedback Analysis

 -> Collect and analyze feedback to refine product offerings.

 -> Use insights to improve pricing, inventory, and customer satisfaction.

5. Multi-Store Support

 -> Easily manage inventory and orders across various e-commerce platforms.

6. ML-Based Product Recommendations:

 -> Help customers find similar products based on an uploaded product image.

 -> Recommend items with similar prices and features to enhance the shopping experience.

## Libraries and Dependencies

1. Backend:

 -> Flask/Django: Web framework

 -> SQLAlchemy: Database ORM

 -> Requests: For making API calls

2. Frontend:

 -> React.js: Frontend library

 -> Axios: For API calls

 -> Chart.js: For visualizing analytics

3. Additional Tools:

 -> OCR.Space API: For optical character recognition

 -> Stripe API: For secure payment processing

 -> AWS SDK: For cloud storage and serverless functions


## ML Model Integration

We integrated a machine learning model to enhance the customer shopping experience. This model uses image recognition and feature extraction to identify visually similar products in the inventory. Based on the uploaded product image, the system:
- Matches the product with similar-looking items in the database.
- Suggests products within the same price range and category.

