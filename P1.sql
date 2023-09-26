-- Criação da tabela para armazenar os dados
CREATE TABLE wine_reviews (
    id SERIAL PRIMARY KEY,
    country VARCHAR(255),
    description TEXT,
    points INTEGER,
    price NUMERIC
);