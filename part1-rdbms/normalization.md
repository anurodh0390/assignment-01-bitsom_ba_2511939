## Anomaly Analysis

The `orders_flat.csv` dataset is a denormalized file, which leads to the following data inconsistencies:

### 1. Insert Anomaly
- **Description:** New data regarding Sales Representatives or Products cannot be added to the system unless an associated order is placed.
- **Example:** If the company wants to add a new product (e.g., 'P010 - Wireless Mouse') to the inventory, it cannot be entered into this CSV file because there is no `order_id` associated with it yet. Since every row is centered around an order, standalone product data has no place.
- **Citation:** Every row in the dataset (Rows 0-185) must start with an `order_id`. There is no separate "Products" list to store items that haven't been sold yet.

### 2. Update Anomaly
- **Description:** When data is redundant, a single change requires multiple updates across many rows. Failure to update all rows leads to inconsistent data.
- **Example:** Customer **Rohan Mehta (C001)** appears in multiple records. If he changes his email address, the administrator must manually find and update every single row where his name appears.
- **Citation:** Refer to **Row 1, Row 9, and Row 20**. All three rows contain Rohan Mehta's email `rohan@gmail.com`. If an update is made to Row 1 but missed in Row 9, the database will show two different emails for the same customer.

### 3. Delete Anomaly
- **Description:** Deleting a transaction record might unintentionally result in the permanent loss of essential master data (like product or customer details).
- **Example:** If a product has only one or two orders, deleting those orders (due to cancellation or returns) will wipe out the product's price and category information from the entire system.
- **Citation:** Observe **Product P006 (Standing Desk)** in **Row 9 and Row 40**. If these specific orders are deleted, all information regarding the "Standing Desk" (UnitPrice: 22000, Category: Furniture) will vanish from the database.

## Normalization Justification

The argument that keeping all data in a single flat table is "simpler" is a common misconception that overlooks long-term data integrity and operational efficiency. While a flat file might appear easier to browse initially, it becomes an engineering nightmare as the business scales. Using the `orders_flat.csv` dataset as a reference, we can defend the necessity of normalization through several key points.

Firstly, **Data Redundancy and Storage Waste** are major concerns. In the current file, the details of Sales Representatives like **Anita Desai (SR02)** and their office addresses are repeated across every single order they handle. In a professional system, this information should be stored once. Normalization to 3NF ensures that we use a small `sales_rep_id` as a reference, significantly reducing the database size and storage costs.

Secondly, normalization is critical for **Data Accuracy**. In a flat structure, if a clerk updates a customer's city in one row but forgets to do so in others, the database enters an inconsistent state. For example, if **Rohan Mehta (C001)** has different email addresses in different rows, our automated marketing or shipping systems will fail. By isolating customer data into a dedicated `Customers` table, we create a "Single Source of Truth."

Lastly, **Maintenance and Flexibility** are improved. If the company decides to change the price of a product like the **Laptop (P001)**, a normalized system requires updating only one row in the `Products` table. In a flat file, we would have to search and update every historical order, which is slow and risks corrupting historical financial records. Therefore, normalization is not over-engineering; it is a fundamental requirement for building a scalable and reliable retail management system.