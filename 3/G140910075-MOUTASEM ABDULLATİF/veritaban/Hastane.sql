--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.5
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: doktorlari_sirala(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION doktorlari_sirala(pol_kod character) RETURNS TABLE(doktor_adi text, doktor_no integer)
    LANGUAGE plpgsql
    AS $$
BEGIN

RETURN QUERY SELECT "KSI_adi" || "KSI_soyadi","Doktor"."KSI_No"
from "Poliklinik"
JOIN "Doktor" on "Doktor"."POL_Kodu"= "Poliklinik"."POL_Kodu"
JOIN "Kisi" on "Doktor"."KSI_No"="Kisi"."KSI_No"
WHERE "Poliklinik"."POL_Kodu"=pol_kod;

END;
$$;


ALTER FUNCTION public.doktorlari_sirala(pol_kod character) OWNER TO postgres;

--
-- Name: ksi_no_tcden(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ksi_no_tcden(tc character) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
ksi_no INTEGER;
BEGIN
 SELECT "KSI_No" INTO ksi_no FROM "Kisi" WHERE "KSI_kimlikNo"=tc;

RETURN ksi_no;
END;
$$;


ALTER FUNCTION public.ksi_no_tcden(tc character) OWNER TO postgres;

--
-- Name: randevu_goruntule(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION randevu_goruntule(tc text) RETURNS TABLE(kimlik_no character varying, hasta_adi character varying, hasta_soyadi character varying, "Cinsiyet" character, "saglikSigortaTuru" character varying, doktor_adi character varying, doktor_soyadi character varying, muayene_yeri character varying, randevu_durum character, randevu_no integer)
    LANGUAGE plpgsql
    AS $$
BEGIN

RETURN QUERY SELECT "Kisi"."KSI_kimlikNo","Kisi"."KSI_adi","Kisi"."KSI_soyadi","CNSYT_tipi","HSTA_sigortaTuru","doctor"."KSI_adi","doctor"."KSI_soyadi",
"POL_adi","RNDV_durum","RNDV_No"
FROM "Kisi"
JOIN "Cinsiyet" on "Kisi"."CNSYT_Turu"= "Cinsiyet"."CNSYT_Turu"
JOIN "Hasta" on "Kisi"."KSI_No"="Hasta"."KSI_No"
JOIN "Randevu" on "Hasta"."HSTA_No"= "Randevu"."HSTA_KSI_No"
join "Doktor" on "Doktor"."KSI_No"="Randevu"."DKTR_Kisi_No"
join "Kisi" as "doctor" on "doctor"."KSI_No"="Randevu"."DKTR_Kisi_No"
JOIN "Poliklinik" on "Randevu"."POL_Kodu"= "Poliklinik"."POL_Kodu"
WHERE "Kisi"."KSI_kimlikNo"= tc;

END;
$$;


ALTER FUNCTION public.randevu_goruntule(tc text) OWNER TO postgres;

--
-- Name: randevu_iptal(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION randevu_iptal(num integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE "Randevu" SET "RNDV_durum"='iptal' WHERE "RNDV_No"=num;
END;
$$;


ALTER FUNCTION public.randevu_iptal(num integer) OWNER TO postgres;

--
-- Name: randevu_olustur(character, character, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION randevu_olustur(tc character, pol_kod character, doktor_ksi_no integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO "Randevu" VALUES (ksi_no_tcden(tc),'devam',nextval('"Randevu_RNDV_No_seq"'::regclass),doktor_ksi_no,now(),poL_kod,nextval('"Randevu_RNDV_muayeneSira_seq"'::regclass));
END;
$$;


ALTER FUNCTION public.randevu_olustur(tc character, pol_kod character, doktor_ksi_no integer) OWNER TO postgres;

--
-- Name: toplam_calisan_artir(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION toplam_calisan_artir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW."KSI_Tipi"<>'H' THEN
update "public"."Hastane" SET"HSTN_toplamCalisan" =toplam_calisan_sayisi()
where 
"HSTN_Kodu"='101';
END IF;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.toplam_calisan_artir() OWNER TO postgres;

--
-- Name: toplam_calisan_eksi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION toplam_calisan_eksi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF OLD."KSI_Tipi"<>'H' THEN
update "public"."Hastane" SET"HSTN_toplamCalisan" =toplam_calisan_sayisi()
where 
"HSTN_Kodu"='101';
END IF;
RETURN OLD;
END;
$$;


ALTER FUNCTION public.toplam_calisan_eksi() OWNER TO postgres;

--
-- Name: toplam_calisan_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION toplam_calisan_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
sayi INTEGER;
BEGIN
select count(*) from "Kisi" where "KSI_Tipi" <> 'H' INTO sayi;
RETURN sayi;
END;
$$;


ALTER FUNCTION public.toplam_calisan_sayisi() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Cinsiyet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Cinsiyet" (
    "CNSYT_Turu" bit(1) NOT NULL,
    "CNSYT_tipi" character(5) NOT NULL
);


ALTER TABLE "Cinsiyet" OWNER TO postgres;

--
-- Name: Doktor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Doktor" (
    "KSI_No" integer NOT NULL,
    "DKTR_sicilNo" character varying(30) NOT NULL,
    "POL_Kodu" character(6) NOT NULL,
    "DKTR_maas" money NOT NULL,
    "DKTR_odaNo" integer,
    "DKTR_nobetDurumu" boolean
);


ALTER TABLE "Doktor" OWNER TO postgres;

--
-- Name: Fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Fatura" (
    "HSTA_KSI_No" integer NOT NULL,
    "MEMR_KSI_No" integer NOT NULL,
    "FTR_kesimTarihi" date NOT NULL,
    "FTR_tutar" money NOT NULL,
    "FTR_No" integer NOT NULL,
    "ODM_Turu" bit(1) NOT NULL,
    CONSTRAINT "check" CHECK ((("ODM_Turu" = B'0'::"bit") OR ("ODM_Turu" = B'1'::"bit")))
);


ALTER TABLE "Fatura" OWNER TO postgres;

--
-- Name: Fatura_FTR_No_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Fatura_FTR_No_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Fatura_FTR_No_seq" OWNER TO postgres;

--
-- Name: Fatura_FTR_No_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Fatura_FTR_No_seq" OWNED BY "Fatura"."FTR_No";


--
-- Name: Hasta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Hasta" (
    "KSI_No" integer NOT NULL,
    "HSTA_saglikSigortaNo" character varying(30),
    "HSTA_sigortaTuru" character varying(30),
    "HSTA_No" integer NOT NULL
);


ALTER TABLE "Hasta" OWNER TO postgres;

--
-- Name: Hasta_HSTA_No_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Hasta_HSTA_No_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Hasta_HSTA_No_seq" OWNER TO postgres;

--
-- Name: Hasta_HSTA_No_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Hasta_HSTA_No_seq" OWNED BY "Hasta"."HSTA_No";


--
-- Name: Hastane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Hastane" (
    "HSTN_Kodu" character(6) NOT NULL,
    "HSTN_adi" character varying(40) NOT NULL,
    "HSTN_adres" character varying(80),
    "HSTN_telNo" character varying(12),
    "HSTN_toplamCalisan" integer
);


ALTER TABLE "Hastane" OWNER TO postgres;

--
-- Name: Kisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Kisi" (
    "KSI_kimlikNo" character varying(11) NOT NULL,
    "KSI_adi" character varying(50) NOT NULL,
    "KSI_soyadi" character varying(50) NOT NULL,
    "KSI_dogumTarihi" date,
    "KSI_telNo" character varying(12),
    "KSI_Tipi" character(1) NOT NULL,
    "KSI_No" integer NOT NULL,
    "CNSYT_Turu" bit(1) NOT NULL,
    CONSTRAINT "Cinsiyet_Kisi_Check_Constraint" CHECK ((("CNSYT_Turu" = B'0'::"bit") OR ("CNSYT_Turu" = B'1'::"bit"))),
    CONSTRAINT "KisiTipi_Kisi_Check_Constraint" CHECK ((("KSI_Tipi" = 'H'::bpchar) OR ("KSI_Tipi" = 'D'::bpchar) OR ("KSI_Tipi" = 'M'::bpchar)))
);


ALTER TABLE "Kisi" OWNER TO postgres;

--
-- Name: Kisi_KSI_No_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Kisi_KSI_No_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Kisi_KSI_No_seq" OWNER TO postgres;

--
-- Name: Kisi_KSI_No_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Kisi_KSI_No_seq" OWNED BY "Kisi"."KSI_No";


--
-- Name: Memur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Memur" (
    "KSI_No" integer NOT NULL,
    "MEMR_calismaSaatleri" character varying(40),
    "MEMR_maas" money NOT NULL,
    "MEMR_nobetDurum" boolean,
    "MEMR_No" integer NOT NULL
);


ALTER TABLE "Memur" OWNER TO postgres;

--
-- Name: Memur_MEMR_No_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Memur_MEMR_No_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Memur_MEMR_No_seq" OWNER TO postgres;

--
-- Name: Memur_MEMR_No_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Memur_MEMR_No_seq" OWNED BY "Memur"."MEMR_No";


--
-- Name: OdemeTuru; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "OdemeTuru" (
    "ODM_Turu" bit(1) NOT NULL,
    "ODM_TurAd" character varying(5) NOT NULL,
    CONSTRAINT "check" CHECK (((("ODM_TurAd")::text = 'Kart'::text) OR (("ODM_TurAd")::text = 'Nakit'::text)))
);


ALTER TABLE "OdemeTuru" OWNER TO postgres;

--
-- Name: Poliklinik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Poliklinik" (
    "POL_Kodu" character(6) NOT NULL,
    "POL_adi" character varying(40) NOT NULL,
    "POL_telNo" character varying(12),
    "HSTN_Kodu" character(6) NOT NULL
);


ALTER TABLE "Poliklinik" OWNER TO postgres;

--
-- Name: Randevu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Randevu" (
    "HSTA_KSI_No" integer NOT NULL,
    "RNDV_durum" character(5) NOT NULL,
    "RNDV_No" integer NOT NULL,
    "DKTR_Kisi_No" integer NOT NULL,
    "RNDV_muayeneTarihi" timestamp without time zone NOT NULL,
    "POL_Kodu" character(6) NOT NULL,
    "RNDV_muayeneSira" integer NOT NULL,
    CONSTRAINT "Randevu_Durum_check_constraint" CHECK ((("RNDV_durum" = 'iptal'::bpchar) OR ("RNDV_durum" = 'devam'::bpchar) OR ("RNDV_durum" = 'bitti'::bpchar)))
);


ALTER TABLE "Randevu" OWNER TO postgres;

--
-- Name: Randevu_RNDV_No_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Randevu_RNDV_No_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Randevu_RNDV_No_seq" OWNER TO postgres;

--
-- Name: Randevu_RNDV_No_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Randevu_RNDV_No_seq" OWNED BY "Randevu"."RNDV_No";


--
-- Name: Randevu_RNDV_muayeneSira_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Randevu_RNDV_muayeneSira_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Randevu_RNDV_muayeneSira_seq" OWNER TO postgres;

--
-- Name: Randevu_RNDV_muayeneSira_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Randevu_RNDV_muayeneSira_seq" OWNED BY "Randevu"."RNDV_muayeneSira";


--
-- Name: Fatura FTR_No; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Fatura" ALTER COLUMN "FTR_No" SET DEFAULT nextval('"Fatura_FTR_No_seq"'::regclass);


--
-- Name: Hasta HSTA_No; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Hasta" ALTER COLUMN "HSTA_No" SET DEFAULT nextval('"Hasta_HSTA_No_seq"'::regclass);


--
-- Name: Kisi KSI_No; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Kisi" ALTER COLUMN "KSI_No" SET DEFAULT nextval('"Kisi_KSI_No_seq"'::regclass);


--
-- Name: Memur MEMR_No; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Memur" ALTER COLUMN "MEMR_No" SET DEFAULT nextval('"Memur_MEMR_No_seq"'::regclass);


--
-- Name: Randevu RNDV_No; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Randevu" ALTER COLUMN "RNDV_No" SET DEFAULT nextval('"Randevu_RNDV_No_seq"'::regclass);


--
-- Name: Randevu RNDV_muayeneSira; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Randevu" ALTER COLUMN "RNDV_muayeneSira" SET DEFAULT nextval('"Randevu_RNDV_muayeneSira_seq"'::regclass);


--
-- Data for Name: Cinsiyet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Cinsiyet" VALUES (B'0', 'Kadın');
INSERT INTO "Cinsiyet" VALUES (B'1', 'Erkek');


--
-- Data for Name: Doktor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Doktor" VALUES (16, '6546545asasd', '201   ', '$9,500.00', 211, NULL);
INSERT INTO "Doktor" VALUES (17, '6as54d98qw6', '202   ', '$11,500.00', 312, NULL);
INSERT INTO "Doktor" VALUES (18, '98hd6zg89g98', '203   ', '$6,000.00', 311, NULL);
INSERT INTO "Doktor" VALUES (35, 'asd897as9daoo', '202   ', '$20,000.00', 555, NULL);


--
-- Data for Name: Fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: Fatura_FTR_No_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Fatura_FTR_No_seq"', 1, false);


--
-- Data for Name: Hasta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Hasta" VALUES (2, '123452', 'Bağ-kur', 2);
INSERT INTO "Hasta" VALUES (3, '123453', 'Emekli Sandığı', 3);
INSERT INTO "Hasta" VALUES (1, '123451', 'SSK', 1);
INSERT INTO "Hasta" VALUES (4, '123454', 'SSK', 4);
INSERT INTO "Hasta" VALUES (5, '123455', 'SSK', 5);
INSERT INTO "Hasta" VALUES (6, NULL, NULL, 6);
INSERT INTO "Hasta" VALUES (7, '123456', 'SSK', 7);
INSERT INTO "Hasta" VALUES (8, '123457', 'Emekli Sandığı', 8);
INSERT INTO "Hasta" VALUES (9, NULL, NULL, 9);
INSERT INTO "Hasta" VALUES (10, '123458', 'Bağ-kur', 10);
INSERT INTO "Hasta" VALUES (11, '123459', 'SSK', 11);
INSERT INTO "Hasta" VALUES (12, '123461', 'Bağ-kur', 12);
INSERT INTO "Hasta" VALUES (13, NULL, NULL, 13);
INSERT INTO "Hasta" VALUES (14, '123462', 'SSK', 14);
INSERT INTO "Hasta" VALUES (15, NULL, NULL, 15);


--
-- Name: Hasta_HSTA_No_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Hasta_HSTA_No_seq"', 15, true);


--
-- Data for Name: Hastane; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Hastane" VALUES ('101   ', 'Güneş Hastanesi', 'Mevlana Bulv. 1422. Sok. No:4, 06520 Kızılay/Ankara', '02162546545', 5);


--
-- Data for Name: Kisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Kisi" VALUES ('12121212121', 'Ahmet', 'Yıldız', '1975-03-12', '5531461215', 'H', 1, B'1');
INSERT INTO "Kisi" VALUES ('34343434343', 'Olcay', 'Şengül', '1985-09-15', '5323253353', 'H', 2, B'1');
INSERT INTO "Kisi" VALUES ('41414141418', 'Aslı', 'Eryılmaz', '2000-11-06', '5340652548', 'H', 3, B'0');
INSERT INTO "Kisi" VALUES ('90199922131', 'Yeşim', 'Demir', '1993-01-19', '5041351648', 'H', 4, B'0');
INSERT INTO "Kisi" VALUES ('23232323232', 'Sinem', 'Kılıç', '1997-04-04', '5450251575', 'H', 5, B'0');
INSERT INTO "Kisi" VALUES ('89811112312', 'İbrahim', 'Doğan', '2003-10-12', '5645265235', 'H', 6, B'1');
INSERT INTO "Kisi" VALUES ('84832482371', 'Gamze', 'Aydoğdu', '1987-05-29', '5369854514', 'H', 7, B'0');
INSERT INTO "Kisi" VALUES ('43573458371', 'Muhammed', 'Güler', '1971-07-13', '5472546515', 'H', 8, B'1');
INSERT INTO "Kisi" VALUES ('58645694956', 'Yasemin', 'Solmaz', '1989-12-30', '5035246854', 'H', 9, B'0');
INSERT INTO "Kisi" VALUES ('23523234211', 'Okan', 'Şimşek', '1994-11-01', '5145698547', 'H', 10, B'1');
INSERT INTO "Kisi" VALUES ('43545645632', 'Ebru', 'Şener', '2004-06-15', '5325605465', 'H', 11, B'0');
INSERT INTO "Kisi" VALUES ('64564565443', 'Kerim', 'Polat', '1972-12-14', '5462546215', 'H', 12, B'1');
INSERT INTO "Kisi" VALUES ('65646444322', 'Songül', 'Doğramacı', '1984-01-28', '5445125545', 'H', 13, B'0');
INSERT INTO "Kisi" VALUES ('33466222332', 'Mahmut', 'Korkmaz', '1969-03-15', '5325245544', 'H', 14, B'1');
INSERT INTO "Kisi" VALUES ('74774636323', 'Yağmur', 'Toprak', '1990-09-24', '5485445845', 'H', 15, B'0');
INSERT INTO "Kisi" VALUES ('19998744447', 'Cemil', 'Tan', '1968-03-14', '5535658585', 'D', 16, B'1');
INSERT INTO "Kisi" VALUES ('19999988454', 'Melek', 'Işık', '1975-11-24', '5535877988', 'D', 17, B'0');
INSERT INTO "Kisi" VALUES ('19998874444', 'Hayrettin', 'Ekiz', '1964-12-02', '5534545447', 'D', 18, B'1');
INSERT INTO "Kisi" VALUES ('18888888777', 'Yusuf', 'Elvan', '1986-03-19', '5002144477', 'M', 19, B'1');
INSERT INTO "Kisi" VALUES ('99772805906', 'moutasem', 'abdullatif', '1992-08-15', '05437892351', 'D', 35, B'1');


--
-- Name: Kisi_KSI_No_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Kisi_KSI_No_seq"', 35, true);


--
-- Data for Name: Memur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Memur" VALUES (19, '08.30 - 17.00', '$5,000.00', NULL, 5);


--
-- Name: Memur_MEMR_No_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Memur_MEMR_No_seq"', 5, true);


--
-- Data for Name: OdemeTuru; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "OdemeTuru" VALUES (B'0', 'Nakit');
INSERT INTO "OdemeTuru" VALUES (B'1', 'Kart');


--
-- Data for Name: Poliklinik; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Poliklinik" VALUES ('201   ', 'Göz Hastalıkları', '2064587454', '101   ');
INSERT INTO "Poliklinik" VALUES ('202   ', 'Kulak Burun Boğaz Hastalıkları', '2065879854', '101   ');
INSERT INTO "Poliklinik" VALUES ('203   ', 'Kardiyoloji', '2064774145', '101   ');


--
-- Data for Name: Randevu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Randevu" VALUES (1, 'bitti', 3, 17, '2016-12-11 09:38:32.145832', '202   ', 3);
INSERT INTO "Randevu" VALUES (1, 'iptal', 8, 18, '2016-12-11 10:43:22.670871', '203   ', 8);
INSERT INTO "Randevu" VALUES (1, 'iptal', 7, 17, '2016-12-11 10:43:16.928806', '202   ', 7);
INSERT INTO "Randevu" VALUES (1, 'devam', 9, 35, '2016-12-11 10:51:59.298847', '202   ', 9);
INSERT INTO "Randevu" VALUES (1, 'iptal', 6, 16, '2016-12-11 10:43:10.86826', '201   ', 6);


--
-- Name: Randevu_RNDV_No_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Randevu_RNDV_No_seq"', 9, true);


--
-- Name: Randevu_RNDV_muayeneSira_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Randevu_RNDV_muayeneSira_seq"', 9, true);


--
-- Name: Cinsiyet Cİnsiyet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Cinsiyet"
    ADD CONSTRAINT "Cİnsiyet_pkey" PRIMARY KEY ("CNSYT_Turu");


--
-- Name: Doktor Doktor_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Doktor"
    ADD CONSTRAINT "Doktor_PK" PRIMARY KEY ("DKTR_sicilNo");


--
-- Name: Fatura Fatura_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Fatura"
    ADD CONSTRAINT "Fatura_PK" PRIMARY KEY ("FTR_No");


--
-- Name: Hasta Hasta_KSI_No_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Hasta"
    ADD CONSTRAINT "Hasta_KSI_No_key" UNIQUE ("KSI_No");


--
-- Name: Hasta Hasta_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Hasta"
    ADD CONSTRAINT "Hasta_PK" PRIMARY KEY ("HSTA_No");


--
-- Name: Hastane Hastane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Hastane"
    ADD CONSTRAINT "Hastane_pkey" PRIMARY KEY ("HSTN_Kodu");


--
-- Name: Kisi KSI_kimlikNo_Unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Kisi"
    ADD CONSTRAINT "KSI_kimlikNo_Unique" UNIQUE ("KSI_kimlikNo");


--
-- Name: Memur Memur_KSI_No_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Memur"
    ADD CONSTRAINT "Memur_KSI_No_key" UNIQUE ("KSI_No");


--
-- Name: Memur Memur_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Memur"
    ADD CONSTRAINT "Memur_PK" PRIMARY KEY ("MEMR_No");


--
-- Name: OdemeTuru OdemeTuru_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OdemeTuru"
    ADD CONSTRAINT "OdemeTuru_pkey" PRIMARY KEY ("ODM_Turu");


--
-- Name: Poliklinik Poliklinik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Poliklinik"
    ADD CONSTRAINT "Poliklinik_pkey" PRIMARY KEY ("POL_Kodu");


--
-- Name: Randevu Randevu_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Randevu"
    ADD CONSTRAINT "Randevu_PK" PRIMARY KEY ("RNDV_No");


--
-- Name: Kisi kisi_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Kisi"
    ADD CONSTRAINT "kisi_PK" PRIMARY KEY ("KSI_No");


--
-- Name: Doktor unique_KSI_No; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Doktor"
    ADD CONSTRAINT "unique_KSI_No" UNIQUE ("KSI_No");


--
-- Name: Kisi toplam_calisan_artir_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER toplam_calisan_artir_tr AFTER INSERT ON "Kisi" FOR EACH ROW EXECUTE PROCEDURE toplam_calisan_artir();


--
-- Name: Kisi toplam_calisan_eksi_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER toplam_calisan_eksi_tr AFTER DELETE ON "Kisi" FOR EACH ROW EXECUTE PROCEDURE toplam_calisan_eksi();


--
-- Name: Kisi lnk_Cinsiyet_Kisi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Kisi"
    ADD CONSTRAINT "lnk_Cinsiyet_Kisi" FOREIGN KEY ("CNSYT_Turu") REFERENCES "Cinsiyet"("CNSYT_Turu") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Poliklinik lnk_Hastane_Poliklinik; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Poliklinik"
    ADD CONSTRAINT "lnk_Hastane_Poliklinik" FOREIGN KEY ("HSTN_Kodu") REFERENCES "Hastane"("HSTN_Kodu") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Doktor lnk_Kisi_Doktor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Doktor"
    ADD CONSTRAINT "lnk_Kisi_Doktor" FOREIGN KEY ("KSI_No") REFERENCES "Kisi"("KSI_No") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Fatura lnk_Kisi_Fatura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Fatura"
    ADD CONSTRAINT "lnk_Kisi_Fatura" FOREIGN KEY ("HSTA_KSI_No") REFERENCES "Kisi"("KSI_No") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Fatura lnk_Kisi_Fatura_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Fatura"
    ADD CONSTRAINT "lnk_Kisi_Fatura_2" FOREIGN KEY ("MEMR_KSI_No") REFERENCES "Kisi"("KSI_No") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Hasta lnk_Kisi_Hasta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Hasta"
    ADD CONSTRAINT "lnk_Kisi_Hasta" FOREIGN KEY ("KSI_No") REFERENCES "Kisi"("KSI_No") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Memur lnk_Kisi_Memur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Memur"
    ADD CONSTRAINT "lnk_Kisi_Memur" FOREIGN KEY ("KSI_No") REFERENCES "Kisi"("KSI_No") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Randevu lnk_Kisi_Randevu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Randevu"
    ADD CONSTRAINT "lnk_Kisi_Randevu" FOREIGN KEY ("HSTA_KSI_No") REFERENCES "Kisi"("KSI_No") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Randevu lnk_Kisi_Randevu_3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Randevu"
    ADD CONSTRAINT "lnk_Kisi_Randevu_3" FOREIGN KEY ("DKTR_Kisi_No") REFERENCES "Kisi"("KSI_No") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Fatura lnk_OdemeTuru_Fatura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Fatura"
    ADD CONSTRAINT "lnk_OdemeTuru_Fatura" FOREIGN KEY ("ODM_Turu") REFERENCES "OdemeTuru"("ODM_Turu") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Doktor lnk_Poliklinik_Doktor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Doktor"
    ADD CONSTRAINT "lnk_Poliklinik_Doktor" FOREIGN KEY ("POL_Kodu") REFERENCES "Poliklinik"("POL_Kodu") MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Randevu randevu_polikilinik_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Randevu"
    ADD CONSTRAINT randevu_polikilinik_link FOREIGN KEY ("POL_Kodu") REFERENCES "Poliklinik"("POL_Kodu");


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

