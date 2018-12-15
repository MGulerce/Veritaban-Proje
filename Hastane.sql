--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 10.6

-- Started on 2018-12-15 21:10:19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2896 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 30765)
-- Name: Cinsiyet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cinsiyet" (
    "CNSYT_Turu" integer NOT NULL,
    "CNSYT_Tipi" character varying NOT NULL
);


ALTER TABLE public."Cinsiyet" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 30893)
-- Name: Doktor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Doktor" (
    "DKTR_maas" character varying,
    "DKTR_nobetDurumu" boolean NOT NULL,
    "DKTR_odaNo" character varying NOT NULL,
    "DKTR_sicilNo" character varying NOT NULL,
    "KSI_No" integer NOT NULL,
    "POL_Kodu" character varying NOT NULL
);


ALTER TABLE public."Doktor" OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 30736)
-- Name: Fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Fatura" (
    "FTR_No" integer NOT NULL,
    "FTR_Tutar" character varying NOT NULL,
    "FTR_KesimTarihi" date NOT NULL,
    "MEMR_KSI_No" integer NOT NULL,
    "HSTA_KSI_No" integer NOT NULL,
    "ODM_Turu" integer NOT NULL
);


ALTER TABLE public."Fatura" OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 30794)
-- Name: Hasta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Hasta" (
    "HSTA_No" integer NOT NULL,
    "HSTA_saglikSigortaNo" character varying NOT NULL,
    "HSTA_sigortaTuru" character varying NOT NULL,
    "KSI_No" integer NOT NULL
);


ALTER TABLE public."Hasta" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 30833)
-- Name: Hastane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Hastane" (
    "HSTN_adres" character varying NOT NULL,
    "HSTN_telNo" character varying NOT NULL,
    "HSTN_tolamCalisan" integer NOT NULL,
    "HSTN_Kodu" character varying NOT NULL,
    "HSTN_adi" character varying NOT NULL
);


ALTER TABLE public."Hastane" OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 30952)
-- Name: Kisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kisi" (
    "KSI_No" integer NOT NULL,
    "KSI_adi" character varying NOT NULL,
    "KSI_soyadi" character varying NOT NULL,
    "KSI_dTarihi" date NOT NULL,
    "KSI_telNo" character varying NOT NULL,
    "CNSYT_Turu" integer NOT NULL,
    "KSI_kimlikNo" character varying NOT NULL,
    "KSI_Tipi" character varying NOT NULL
);


ALTER TABLE public."Kisi" OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 30780)
-- Name: Memur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Memur" (
    "KSI_No" integer NOT NULL,
    "MEMR_calismaSaatleri" character varying NOT NULL,
    "MEMR_maas" character varying NOT NULL,
    "MEMR_No" integer NOT NULL,
    "MEMR_nobetDurum" boolean NOT NULL
);


ALTER TABLE public."Memur" OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 30719)
-- Name: OdemeTuru; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OdemeTuru" (
    "ODM_TurAd" character varying NOT NULL,
    "ODM_Turu" integer NOT NULL
);


ALTER TABLE public."OdemeTuru" OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 30808)
-- Name: Poliklinik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Poliklinik" (
    "POL_adi" character varying NOT NULL,
    "POL_telNo" character varying NOT NULL,
    "HSTN_Kodu" character varying NOT NULL,
    "POL_Kodu" character varying NOT NULL
);


ALTER TABLE public."Poliklinik" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 30854)
-- Name: Randevu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Randevu" (
    "DKTR_Kisi_No" integer NOT NULL,
    "HSTA_Kisi_No" integer NOT NULL,
    "muayeneSira" integer NOT NULL,
    "muayaneTarihi" date NOT NULL,
    "RNDV_durum" character varying NOT NULL,
    "RNDV_No" integer NOT NULL,
    "POL_Kodu" character varying NOT NULL
);


ALTER TABLE public."Randevu" OWNER TO postgres;

--
-- TOC entry 2881 (class 0 OID 30765)
-- Dependencies: 198
-- Data for Name: Cinsiyet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cinsiyet" ("CNSYT_Turu", "CNSYT_Tipi") FROM stdin;
1	Kadın
2	Erkek
3	Cocuk
\.


--
-- TOC entry 2887 (class 0 OID 30893)
-- Dependencies: 204
-- Data for Name: Doktor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Doktor" ("DKTR_maas", "DKTR_nobetDurumu", "DKTR_odaNo", "DKTR_sicilNo", "KSI_No", "POL_Kodu") FROM stdin;
18.000	t	101	24852478	1	1
15.000	f	102	47854785	2	3
8.000	f	103	24785488	3	2
\.


--
-- TOC entry 2880 (class 0 OID 30736)
-- Dependencies: 197
-- Data for Name: Fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Fatura" ("FTR_No", "FTR_Tutar", "FTR_KesimTarihi", "MEMR_KSI_No", "HSTA_KSI_No", "ODM_Turu") FROM stdin;
1	18.00	2018-12-15	4	7	1
2	15.00	2018-12-15	4	8	2
3	105.00	2018-12-15	5	9	3
\.


--
-- TOC entry 2883 (class 0 OID 30794)
-- Dependencies: 200
-- Data for Name: Hasta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Hasta" ("HSTA_No", "HSTA_saglikSigortaNo", "HSTA_sigortaTuru", "KSI_No") FROM stdin;
1	1475852478	Bagkur	7
2	1471489636	SSK	8
3	3698785247	SSK	9
\.


--
-- TOC entry 2885 (class 0 OID 30833)
-- Dependencies: 202
-- Data for Name: Hastane; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Hastane" ("HSTN_adres", "HSTN_telNo", "HSTN_tolamCalisan", "HSTN_Kodu", "HSTN_adi") FROM stdin;
asdasdasdasd	51452147852	180	1	Cerrahpasa
asfasdfddfrqwred	14785475414	190	2	Vatan hastanesi
adfergfdrfgfdertg	17854744185	280	3	Özel ada tıp merkezi
\.


--
-- TOC entry 2888 (class 0 OID 30952)
-- Dependencies: 205
-- Data for Name: Kisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Kisi" ("KSI_No", "KSI_adi", "KSI_soyadi", "KSI_dTarihi", "KSI_telNo", "CNSYT_Turu", "KSI_kimlikNo", "KSI_Tipi") FROM stdin;
1	Mehmet	Borak	1969-02-14	1474875258	2	789854786524	Doktor
2	Fatma	Borak	1968-11-28	1478521478	1	147852147856	Doktor
3	Ferhat	Yekte	1989-12-14	3698745654	2	214785417858	Doktor
4	Fatih	Yasar	1979-11-11	4785478654	2	589547854785	Memur
5	Yesim	Yasar	1979-10-18	2478547858	1	247854785478	Memur
6	Hakan	Levent	1989-05-14	1478547858	2	24785478/745	Memur
7	Muammer	Yekte	1997-02-22	2147854787	2	478547854147	Hasta
8	Busra	Gokgoz	1998-01-11	1478547857	1	248652478745	Hasta
9	Elif	Odabas	1979-03-19	1478514447	1	248954785478	Hasta
\.


--
-- TOC entry 2882 (class 0 OID 30780)
-- Dependencies: 199
-- Data for Name: Memur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Memur" ("KSI_No", "MEMR_calismaSaatleri", "MEMR_maas", "MEMR_No", "MEMR_nobetDurum") FROM stdin;
4	8-5	4.000	1	f
5	8-5	5.000	2	f
6	5-2	6.000	3	t
\.


--
-- TOC entry 2879 (class 0 OID 30719)
-- Dependencies: 196
-- Data for Name: OdemeTuru; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OdemeTuru" ("ODM_TurAd", "ODM_Turu") FROM stdin;
Nakit	1
Tek çekim	2
Taksit	3
\.


--
-- TOC entry 2884 (class 0 OID 30808)
-- Dependencies: 201
-- Data for Name: Poliklinik; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Poliklinik" ("POL_adi", "POL_telNo", "HSTN_Kodu", "POL_Kodu") FROM stdin;
Ortopedi	148521475	1	1
Noroloji	147852471	1	2
Göz hastalıkları	147285471	1	3
\.


--
-- TOC entry 2886 (class 0 OID 30854)
-- Dependencies: 203
-- Data for Name: Randevu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Randevu" ("DKTR_Kisi_No", "HSTA_Kisi_No", "muayeneSira", "muayaneTarihi", "RNDV_durum", "RNDV_No", "POL_Kodu") FROM stdin;
1	7	1	2018-12-15	normal	1	1
1	8	2	2018-12-15	normal	2	1
2	9	1	2018-12-15	normal	3	2
\.


--
-- TOC entry 2722 (class 2606 OID 30772)
-- Name: Cinsiyet Cinsiyet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cinsiyet"
    ADD CONSTRAINT "Cinsiyet_pkey" PRIMARY KEY ("CNSYT_Turu");


--
-- TOC entry 2740 (class 2606 OID 30900)
-- Name: Doktor Doktor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Doktor"
    ADD CONSTRAINT "Doktor_pkey" PRIMARY KEY ("DKTR_sicilNo", "KSI_No");


--
-- TOC entry 2717 (class 2606 OID 30743)
-- Name: Fatura Fatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "Fatura_pkey" PRIMARY KEY ("FTR_No");


--
-- TOC entry 2727 (class 2606 OID 30801)
-- Name: Hasta Hasta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hasta"
    ADD CONSTRAINT "Hasta_pkey" PRIMARY KEY ("HSTA_No", "KSI_No");


--
-- TOC entry 2733 (class 2606 OID 30840)
-- Name: Hastane Hastane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hastane"
    ADD CONSTRAINT "Hastane_pkey" PRIMARY KEY ("HSTN_Kodu");


--
-- TOC entry 2744 (class 2606 OID 30959)
-- Name: Kisi Kisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kisi"
    ADD CONSTRAINT "Kisi_pkey" PRIMARY KEY ("KSI_No");


--
-- TOC entry 2724 (class 2606 OID 30787)
-- Name: Memur Memur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Memur"
    ADD CONSTRAINT "Memur_pkey" PRIMARY KEY ("KSI_No", "MEMR_No");


--
-- TOC entry 2715 (class 2606 OID 30726)
-- Name: OdemeTuru OdemeTuru_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OdemeTuru"
    ADD CONSTRAINT "OdemeTuru_pkey" PRIMARY KEY ("ODM_Turu");


--
-- TOC entry 2730 (class 2606 OID 31081)
-- Name: Poliklinik POL_Kodu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Poliklinik"
    ADD CONSTRAINT "POL_Kodu" PRIMARY KEY ("POL_Kodu");


--
-- TOC entry 2735 (class 2606 OID 30861)
-- Name: Randevu Randevu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Randevu"
    ADD CONSTRAINT "Randevu_pkey" PRIMARY KEY ("RNDV_No");


--
-- TOC entry 2745 (class 1259 OID 30966)
-- Name: fki_fk_cnsyt_ksı; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_fk_cnsyt_ksı" ON public."Kisi" USING btree ("CNSYT_Turu");


--
-- TOC entry 2736 (class 1259 OID 31099)
-- Name: fki_fk_dkr_ksı_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_fk_dkr_ksı_no" ON public."Randevu" USING btree ("DKTR_Kisi_No");


--
-- TOC entry 2741 (class 1259 OID 31087)
-- Name: fki_fk_dkr_pol_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_dkr_pol_no ON public."Doktor" USING btree ("POL_Kodu");


--
-- TOC entry 2742 (class 1259 OID 30995)
-- Name: fki_fk_dkt_ksı_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_fk_dkt_ksı_no" ON public."Doktor" USING btree ("KSI_No");


--
-- TOC entry 2718 (class 1259 OID 31058)
-- Name: fki_fk_ftr_hst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_ftr_hst ON public."Fatura" USING btree ("HSTA_KSI_No");


--
-- TOC entry 2719 (class 1259 OID 31069)
-- Name: fki_fk_ftr_memr_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_ftr_memr_no ON public."Fatura" USING btree ("MEMR_KSI_No");


--
-- TOC entry 2728 (class 1259 OID 30975)
-- Name: fki_fk_hst_ksı_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_fk_hst_ksı_no" ON public."Hasta" USING btree ("KSI_No");


--
-- TOC entry 2737 (class 1259 OID 31112)
-- Name: fki_fk_hsta_ksı_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_fk_hsta_ksı_no" ON public."Randevu" USING btree ("HSTA_Kisi_No");


--
-- TOC entry 2725 (class 1259 OID 30989)
-- Name: fki_fk_mmr_ksı_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_fk_mmr_ksı_no" ON public."Memur" USING btree ("KSI_No");


--
-- TOC entry 2720 (class 1259 OID 30759)
-- Name: fki_fk_odm_turu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_odm_turu ON public."Fatura" USING btree ("ODM_Turu");


--
-- TOC entry 2731 (class 1259 OID 31135)
-- Name: fki_fk_pol_htn_kodu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_pol_htn_kodu ON public."Poliklinik" USING btree ("HSTN_Kodu");


--
-- TOC entry 2738 (class 1259 OID 31129)
-- Name: fki_fk_rand_pol_kodu; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_rand_pol_kodu ON public."Randevu" USING btree ("POL_Kodu");


--
-- TOC entry 2757 (class 2606 OID 30961)
-- Name: Kisi fk_cnsyt_ksı; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kisi"
    ADD CONSTRAINT "fk_cnsyt_ksı" FOREIGN KEY ("CNSYT_Turu") REFERENCES public."Cinsiyet"("CNSYT_Turu");


--
-- TOC entry 2752 (class 2606 OID 31094)
-- Name: Randevu fk_dkr_ksı_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Randevu"
    ADD CONSTRAINT "fk_dkr_ksı_no" FOREIGN KEY ("DKTR_Kisi_No") REFERENCES public."Kisi"("KSI_No") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2756 (class 2606 OID 31082)
-- Name: Doktor fk_dkr_pol_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Doktor"
    ADD CONSTRAINT fk_dkr_pol_no FOREIGN KEY ("POL_Kodu") REFERENCES public."Poliklinik"("POL_Kodu") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2755 (class 2606 OID 30990)
-- Name: Doktor fk_dkt_ksı_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Doktor"
    ADD CONSTRAINT "fk_dkt_ksı_no" FOREIGN KEY ("KSI_No") REFERENCES public."Kisi"("KSI_No") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2747 (class 2606 OID 31053)
-- Name: Fatura fk_ftr_hst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT fk_ftr_hst FOREIGN KEY ("HSTA_KSI_No") REFERENCES public."Kisi"("KSI_No") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2748 (class 2606 OID 31064)
-- Name: Fatura fk_ftr_memr_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT fk_ftr_memr_no FOREIGN KEY ("MEMR_KSI_No") REFERENCES public."Kisi"("KSI_No") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2750 (class 2606 OID 30976)
-- Name: Hasta fk_hst_ksı_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hasta"
    ADD CONSTRAINT "fk_hst_ksı_no" FOREIGN KEY ("KSI_No") REFERENCES public."Kisi"("KSI_No") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2753 (class 2606 OID 31115)
-- Name: Randevu fk_hst_ksı_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Randevu"
    ADD CONSTRAINT "fk_hst_ksı_no" FOREIGN KEY ("HSTA_Kisi_No") REFERENCES public."Kisi"("KSI_No") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2749 (class 2606 OID 30984)
-- Name: Memur fk_mmr_ksı_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Memur"
    ADD CONSTRAINT "fk_mmr_ksı_no" FOREIGN KEY ("KSI_No") REFERENCES public."Kisi"("KSI_No") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2746 (class 2606 OID 30754)
-- Name: Fatura fk_odm_turu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT fk_odm_turu FOREIGN KEY ("ODM_Turu") REFERENCES public."OdemeTuru"("ODM_Turu");


--
-- TOC entry 2751 (class 2606 OID 31130)
-- Name: Poliklinik fk_pol_htn_kodu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Poliklinik"
    ADD CONSTRAINT fk_pol_htn_kodu FOREIGN KEY ("HSTN_Kodu") REFERENCES public."Hastane"("HSTN_Kodu") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2754 (class 2606 OID 31124)
-- Name: Randevu fk_rand_pol_kodu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Randevu"
    ADD CONSTRAINT fk_rand_pol_kodu FOREIGN KEY ("POL_Kodu") REFERENCES public."Poliklinik"("POL_Kodu") ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2018-12-15 21:10:21

--
-- PostgreSQL database dump complete
--

