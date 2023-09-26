-- Criação da tabela para armazenar os dados
CREATE TABLE wine_reviews (
    id SERIAL PRIMARY KEY,
    country VARCHAR(255),
    description TEXT,
    points INTEGER,
    price NUMERIC
);


-- 2.Calcular o preço médio dos vinhos de cada país utilizando um cursor não vinculado.

--Criação da tabela para armazenar os resultados
CREATE TABLE wine_avg_price_by_country (
    id SERIAL PRIMARY KEY,
    nome_pais VARCHAR(255),
    preco_medio NUMERIC
);

-- Criação da função para cálculo do preço médio por país
CREATE OR REPLACE FUNCTION calculate_avg_price_by_country()
RETURNS VOID AS $$
DECLARE
    country_name VARCHAR(255);
    avg_price NUMERIC;
BEGIN
    FOR country_name IN (SELECT DISTINCT country FROM wine_reviews)
    LOOP
        SELECT AVG(price) INTO avg_price
        FROM wine_reviews
        WHERE country = country_name;

        INSERT INTO wine_avg_price_by_country (nome_pais, preco_medio)
        VALUES (country_name, avg_price);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Chamar a função para calcular o preço médio por país
SELECT calculate_avg_price_by_country();
]

--3.Identificar a descrição mais longa para os vinhos de cada país utilizando um cursor vinculado.

-- Criação da tabela para armazenar os resultados
CREATE TABLE longest_description_by_country (
    id SERIAL PRIMARY KEY,
    nome_pais VARCHAR(255),
    descricao_mais_longa TEXT
);

-- Criação da função para identificar a descrição mais longa por país
CREATE OR REPLACE FUNCTION find_longest_description_by_country()
RETURNS VOID AS $$
DECLARE
    country_name VARCHAR(255);
    max_description TEXT;
BEGIN
    FOR country_name IN (SELECT DISTINCT country FROM wine_reviews)
    LOOP
        SELECT description INTO max_description
        FROM wine_reviews
        WHERE country = country_name
        ORDER BY LENGTH(description) DESC
        LIMIT 1;

        INSERT INTO longest_description_by_country (nome_pais, descricao_mais_longa)
        VALUES (country_name, max_description);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

 -- Chamar a função para encontrar a descrição mais longa por país
SELECT find_longest_description_by_country();
