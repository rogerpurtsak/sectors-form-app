--
-- PostgreSQL database dump
--

-- Dumped from database version 17.10
-- Dumped by pg_dump version 17.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: sectors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sectors (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    parent_id integer,
    level smallint DEFAULT 0 NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: user_profile_sectors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_profile_sectors (
    user_profile_id bigint NOT NULL,
    sector_id integer NOT NULL
);


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_profiles (
    id bigint NOT NULL,
    session_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    agree_to_terms boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: user_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_profiles_id_seq OWNED BY public.user_profiles.id;


--
-- Name: user_profiles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles ALTER COLUMN id SET DEFAULT nextval('public.user_profiles_id_seq'::regclass);


--
-- Data for Name: sectors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sectors (id, name, parent_id, level, sort_order, created_at, updated_at) FROM stdin;
1	Manufacturing	\N	0	1	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
19	Construction materials	1	1	2	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
18	Electronics and Optics	1	1	3	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
6	Food and Beverage	1	1	4	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
342	Bakery & confectionery products	6	2	5	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
43	Beverages	6	2	6	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
42	Fish & fish products	6	2	7	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
40	Meat & meat products	6	2	8	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
39	Milk & dairy products	6	2	9	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
437	Other	6	2	10	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
378	Sweets & snack food	6	2	11	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
13	Furniture	1	1	12	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
389	Bathroom/sauna	13	2	13	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
385	Bedroom	13	2	14	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
390	Children's room	13	2	15	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
98	Kitchen	13	2	16	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
101	Living room	13	2	17	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
392	Office	13	2	18	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
394	Other (Furniture)	13	2	19	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
341	Outdoor	13	2	20	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
99	Project furniture	13	2	21	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
12	Machinery	1	1	22	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
94	Machinery components	12	2	23	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
91	Machinery equipment/tools	12	2	24	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
224	Manufacture of machinery	12	2	25	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
97	Maritime	12	2	26	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
271	Aluminium and steel workboats	97	3	27	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
269	Boat/Yacht building	97	3	28	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
230	Ship repair and conversion	97	3	29	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
93	Metal structures	12	2	30	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
508	Other	12	2	31	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
227	Repair and maintenance service	12	2	32	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
11	Metalworking	1	1	33	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
67	Construction of metal structures	11	2	34	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
263	Houses and buildings	11	2	35	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
267	Metal products	11	2	36	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
542	Metal works	11	2	37	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
75	CNC-machining	542	3	38	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
62	Forgings, Fasteners	542	3	39	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
69	Gas, Plasma, Laser cutting	542	3	40	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
66	MIG, TIG, Aluminum welding	542	3	41	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
9	Plastic and Rubber	1	1	42	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
54	Packaging	9	2	43	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
556	Plastic goods	9	2	44	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
559	Plastic processing technology	9	2	45	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
55	Blowing	559	3	46	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
57	Moulding	559	3	47	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
53	Plastics welding and processing	559	3	48	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
560	Plastic profiles	9	2	49	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
5	Printing	1	1	50	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
148	Advertising	5	2	51	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
150	Book/Periodicals printing	5	2	52	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
145	Labelling and packaging printing	5	2	53	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
7	Textile and Clothing	1	1	54	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
44	Clothing	7	2	55	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
45	Textile	7	2	56	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
8	Wood	1	1	57	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
337	Other (Wood)	8	2	58	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
51	Wooden building materials	8	2	59	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
47	Wooden houses	8	2	60	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
3	Other	\N	0	61	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
37	Creative industries	3	1	62	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
29	Energy technology	3	1	63	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
33	Environment	3	1	64	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
2	Service	\N	0	65	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
25	Business services	2	1	66	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
35	Engineering	2	1	67	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
28	Information Technology and Telecommunications	2	1	68	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
581	Data processing, Web portals, E-marketing	28	2	69	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
576	Programming, Consultancy	28	2	70	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
121	Software, Hardware	28	2	71	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
122	Telecommunications	28	2	72	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
22	Tourism	2	1	73	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
141	Translation services	2	1	74	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
21	Transport and Logistics	2	1	75	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
111	Air	21	2	76	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
114	Rail	21	2	77	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
112	Road	21	2	78	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
113	Water	21	2	79	2026-06-03 08:43:36.272375+00	2026-06-03 08:43:36.272375+00
\.


--
-- Data for Name: user_profile_sectors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_profile_sectors (user_profile_id, sector_id) FROM stdin;
\.


--
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_profiles (id, session_id, name, agree_to_terms, created_at, updated_at) FROM stdin;
\.


--
-- Name: user_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_profiles_id_seq', 1, false);


--
-- Name: sectors sectors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_pkey PRIMARY KEY (id);


--
-- Name: user_profile_sectors user_profile_sectors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profile_sectors
    ADD CONSTRAINT user_profile_sectors_pkey PRIMARY KEY (user_profile_id, sector_id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- Name: user_profiles user_profiles_session_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_session_id_key UNIQUE (session_id);


--
-- Name: sectors sectors_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.sectors(id);


--
-- Name: user_profile_sectors user_profile_sectors_sector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profile_sectors
    ADD CONSTRAINT user_profile_sectors_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(id);


--
-- Name: user_profile_sectors user_profile_sectors_user_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profile_sectors
    ADD CONSTRAINT user_profile_sectors_user_profile_id_fkey FOREIGN KEY (user_profile_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

