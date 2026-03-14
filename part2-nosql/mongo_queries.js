// ==========================================
// Part 2.2: MongoDB Operations
// ==========================================

// OP1: insertMany() — Insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "product_id": "E101",
    "name": "Gaming Laptop",
    "category": "Electronics",
    "price": 75000,
    "specifications": { "processor": "Intel i7", "ram": "16GB" },
    "in_stock": true
  },
  {
    "product_id": "C201",
    "name": "Cotton T-Shirt",
    "category": "Clothing",
    "price": 999,
    "details": { "sizes": ["S", "M", "L"], "color": "Blue" }
  },
  {
    "product_id": "G301",
    "name": "Organic Honey",
    "category": "Groceries",
    "price": 450,
    "expiry_date": ISODate("2024-12-31"),
    "nutritional_info": { "calories": 60 }
  }
]);

// OP2: find() — Retrieve all Electronics products with price > 20000
db.products.find({
    "category": "Electronics",
    "price": { "$gt": 20000 }
});

// OP3: find() — Retrieve all Groceries expiring before 2025-01-01
db.products.find({
    "category": "Groceries",
    "expiry_date": { "$lt": ISODate("2025-01-01") }
});

// OP4: updateOne() — Add a "discount_percent" field to a specific product
db.products.updateOne(
    { "product_id": "E101" },
    { "$set": { "discount_percent": 10 } }
);

// OP5: createIndex() — Create an index on category field and explain why
db.products.createIndex({ "category": 1 });
// Explanation: An index on the "category" field is essential for query optimization. 
// Without an index, MongoDB must perform a "Collection Scan" (scanning every document). 
// With an index, MongoDB can jump directly to the relevant documents, making searches 
// significantly faster as the database grows.