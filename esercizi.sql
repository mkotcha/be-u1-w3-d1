CREATE TABLE public.clienti
(
    numero_cliente integer NOT NULL,
    nome text NOT NULL,
    cognome text NOT NULL,
    data_nascita date NOT NULL,
    regione_residenza text NOT NULL,
    PRIMARY KEY (numero_cliente)
);

CREATE TABLE public.prodotti
(
    id_prodotto integer NOT NULL,
    descrizione text NOT NULL,
    in_produzione boolean DEFAULT true,
    in_commercio boolean DEFAULT false,
    data_attivazione date,
    data_disattivazione date,
    PRIMARY KEY (id_prodotto)
);

CREATE TABLE IF NOT EXISTS public.fatture
(
    numero_fattura integer NOT NULL,
    tipologia text COLLATE pg_catalog."default" NOT NULL,
    importo double precision NOT NULL,
    iva integer NOT NULL,
    id_cliente integer NOT NULL,
    data_fattura date NOT NULL,
    numero_fornitore integer NOT NULL,
    CONSTRAINT fatture_pkey PRIMARY KEY (numero_fattura),
    CONSTRAINT clienti FOREIGN KEY (id_cliente)
        REFERENCES public.clienti (numero_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fornitori FOREIGN KEY (numero_fornitore)
        REFERENCES public.fornitori (numero_fornitore) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE public.fornitori
(
    numero_fornitore integer NOT NULL,
    denominazione text NOT NULL,
    regione_residenza text NOT NULL,
    PRIMARY KEY (numero_fornitore)
);

