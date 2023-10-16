CREATE TABLE public.clienti (
    numero_cliente integer NOT NULL,
    nome text NOT NULL,
    cognome text NOT NULL,
    data_nascita date NOT NULL,
    regione_residenza text NOT NULL,
    PRIMARY KEY (numero_cliente)
);
CREATE TABLE public.prodotti (
    id_prodotto integer NOT NULL,
    descrizione text NOT NULL,
    in_produzione boolean DEFAULT true,
    in_commercio boolean DEFAULT false,
    data_attivazione date,
    data_disattivazione date,
    PRIMARY KEY (id_prodotto)
);
CREATE TABLE IF NOT EXISTS public.fatture (
    numero_fattura integer NOT NULL,
    tipologia text COLLATE pg_catalog."default" NOT NULL,
    importo double precision NOT NULL,
    iva integer NOT NULL,
    id_cliente integer NOT NULL,
    data_fattura date NOT NULL,
    numero_fornitore integer NOT NULL,
    CONSTRAINT fatture_pkey PRIMARY KEY (numero_fattura),
    CONSTRAINT clienti FOREIGN KEY (id_cliente) REFERENCES public.clienti (numero_cliente) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fornitori FOREIGN KEY (numero_fornitore) REFERENCES public.fornitori (numero_fornitore) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION NOT VALID
) CREATE TABLE public.fornitori (
    numero_fornitore integer NOT NULL,
    denominazione text NOT NULL,
    regione_residenza text NOT NULL,
    PRIMARY KEY (numero_fornitore)
);
SELECT nome, cognome
FROM clienti
WHERE data_nascita BETWEEN '1-1-1982' AND '31-12-1982';

SELECT numero_fattura
FROM fatture
WHERE iva = '22';

SELECT COUNT(*) AS count_fatture,
    EXTRACT(YEAR FROM data_fattura) AS anno,
    SUM(importo) AS totale_fatturato
FROM fatture
GROUP BY anno;

SELECT *
FROM prodotti
WHERE in_produzione = 'true' OR in_commercio = 'true';

SELECT COUNT(*) AS count_fatture,
    EXTRACT(YEAR FROM data_fattura) AS anno
FROM fatture
WHERE iva = '20'
GROUP BY anno;

SELECT extract(YEAR FROM data_fattura) AS anno,
    count(*) AS num
FROM fatture
WHERE tipologia='a'
GROUP BY anno
HAVING count(*)>2;

SELECT * FROM fatture LEFT JOIN fornitori
ON fatture.numero_fornitore = fornitori.numero_fornitore;

SELECT SUM(fatture.importo) AS totale, clienti.regione_residenza
FROM fatture LEFT JOIN clienti
ON fatture.id_cliente = clienti.numero_cliente
GROUP BY clienti.regione_residenza;

SELECT COUNT(DISTINCT clienti) as num_fatture, EXTRACT(YEAR FROM clienti.data_nascita) as anno
FROM fatture LEFT JOIN clienti 
ON fatture.id_cliente = clienti.numero_cliente
WHERE fatture.importo > 50 
GROUP BY anno
HAVING EXTRACT(YEAR FROM clienti.data_nascita) = 1980;

SELECT CONCAT(clienti.nome, ' - ', clienti.cognome) AS Denominazione
FROM clienti
WHERE regione_residenza ILIKE 'lombardia';