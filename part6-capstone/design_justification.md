## Storage Systems

To fulfill the four complex goals of the hospital network, I have implemented a **Polyglot Persistence** architecture. This approach ensures that each data type is stored in a system specifically optimized for its unique access pattern:

1. **Readmission Risk Prediction (Data Lakehouse):** I chose a **Data Lakehouse** (e.g., Delta Lake on Spark) for historical treatment data. AI models require massive volumes of structured and semi-structured historical data to identify patterns. A Lakehouse provides the high-performance machine learning capabilities of a Data Lake while maintaining the schema enforcement and ACID reliability of a traditional Data Warehouse.
2. **Patient History Semantic Search (Vector Database):** For "Plain English" queries, a **Vector Database** (e.g., Milvus or Pinecone) is used. Traditional SQL keyword searches fail when terminology varies (e.g., "heart attack" vs. "myocardial infarction"). By storing clinical notes as high-dimensional embeddings, the system performs semantic retrieval, understanding the conceptual meaning behind a doctor's question.
3. **Monthly Management Reporting (Relational/OLAP):** General hospital reporting, such as bed occupancy and department costs, is handled by the analytical layer of the **Data Lakehouse**. This system is optimized for complex SQL aggregations and joins across different operational tables to provide a "Single Source of Truth" for hospital management.
4. **Real-time ICU Vitals (Time-Series Database):** ICU monitoring devices generate high-velocity, sequential data. I selected a **Time-Series Database** (e.g., InfluxDB) because it is specialized for high-write throughput and efficient compression of time-stamped metrics (vitals vs. time), ensuring real-time dashboards remain responsive.

## OLTP vs OLAP Boundary

In this design, the **OLTP (Online Transactional Processing)** system resides within the hospital’s primary Electronic Medical Record (EMR) databases and ICU device hubs. These systems are optimized for frequent, small transactions (e.g., updating a patient's current heart rate or recording a new prescription).

The **OLAP (Online Analytical Processing)** boundary begins at the **Ingestion Layer (ETL/Streaming)**. Data is moved from the transactional systems into the Data Lakehouse and specialized databases. This separation is critical in a healthcare environment; it ensures that heavy analytical workloads—like training an AI model or generating a 50-page financial report—do not compete for CPU or Memory resources with the critical, life-saving transactional systems that doctors rely on during active patient care.

## Trade-offs

One significant trade-off in this design is **System Complexity vs. Specialized Performance**. By utilizing three different types of databases (Lakehouse, Vector, and Time-Series), the operational overhead for the hospital’s IT department increases significantly compared to a single-database solution.

To **mitigate** this risk, I have proposed a **Unified Data Governance** layer. This layer centralizes security, auditing, and metadata management across all storage systems. By using a unified catalog, we ensure that patient privacy (HIPAA compliance) is maintained consistently across the entire architecture, even though the data is physically distributed for performance reasons.