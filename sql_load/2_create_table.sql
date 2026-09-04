CREATE TABLE customer_churn (
    customer_id INT PRIMARY KEY,
    credit_score INT,
    geography VARCHAR(50),
    gender VARCHAR(20),
    age INT,
    tenure INT,
    balance NUMERIC(15, 2),
    num_of_products INT,
    has_cr_card INT,
    is_active_member INT,
    estimated_salary NUMERIC(15, 2),
    churn INT
);