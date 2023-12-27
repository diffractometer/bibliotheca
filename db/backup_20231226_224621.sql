--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg110+1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    genre_id integer,
    cell integer,
    "position" integer,
    verified boolean DEFAULT false NOT NULL,
    cover_image_s3_url character varying(255),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_cell CHECK (((cell >= 1) AND (cell <= 40))),
    CONSTRAINT chk_position CHECK ((("position" >= 1) AND ("position" <= 8)))
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genres_id_seq OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- Name: processedimages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.processedimages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    image_key character varying(255) NOT NULL,
    processed_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.processedimages OWNER TO postgres;

--
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, title, author, genre_id, cell, "position", verified, cover_image_s3_url, created_at, updated_at) FROM stdin;
d6e26cf0-cce3-460f-97a3-699a0022a4ee	BAN THE BOMB	Milton S. Katz	\N	\N	\N	f	bookshelf_cells/IMG_2121.jpeg	2023-12-26 22:11:39.96006	2023-12-26 22:11:39.96006
e47ef64b-48cd-4a1b-bfe3-4cb5181ef184	TALES FROM THE LOOP	Simon Stålenhag	\N	\N	\N	f	bookshelf_cells/IMG_2130.jpeg	2023-12-26 22:11:39.963939	2023-12-26 22:11:39.963939
14b5d305-7725-482d-972e-5b8938e4cde0	MODERN PHYSICS	RONALD GAUTREAU, WILLIAM SAVIN	\N	\N	\N	f	bookshelf_cells/IMG_2131.jpeg	2023-12-26 22:11:39.966092	2023-12-26 22:11:39.966092
4f0c7d6d-1782-4d28-a712-4ade7523a5f6	A BRIEF INTRODUCTION TO MODERN PHILOSOPHY	ARTHUR KENYON ROGERS, Ph.D.	\N	\N	\N	f	bookshelf_cells/IMG_2132.jpeg	2023-12-26 22:11:39.968412	2023-12-26 22:11:39.968412
adfd2d3a-d630-48c8-9f4d-b91902f82f9a	COMPANY C	John Sack	\N	\N	\N	f	bookshelf_cells/IMG_2133.jpeg	2023-12-26 22:11:39.970227	2023-12-26 22:11:39.970227
1ac932d9-2a1a-4ded-9450-896cf03483ce	PERMUTATION CITY	Greg Egan	\N	\N	\N	f	bookshelf_cells/IMG_2134.jpeg	2023-12-26 22:11:39.97195	2023-12-26 22:11:39.97195
9ba4a362-b277-4c05-a6a5-9b8d42ec9d34	Why Is Sex Fun?	Jared Diamond	\N	\N	\N	f	bookshelf_cells/IMG_2139.jpeg	2023-12-26 22:12:10.956078	2023-12-26 22:12:10.956078
747b6656-08c6-4dc1-a0a9-26784252ea1b	Journey to the End of the Night	Louis-Ferdinand Céline	\N	\N	\N	f	bookshelf_cells/IMG_2140.jpeg	2023-12-26 22:12:10.960495	2023-12-26 22:12:10.960495
2e31a173-c004-4306-aaa0-29fa4431dbba	Don’t Sleep	There are Snakes,Daniel L. Everett	\N	\N	\N	f	bookshelf_cells/IMG_2141.jpeg	2023-12-26 22:12:10.963948	2023-12-26 22:12:10.963948
d03da473-c42c-4414-a0bb-4be082dc3bcc	The Plague of Fantasies	Slavoj Žižek	\N	\N	\N	f	bookshelf_cells/IMG_2142.jpeg	2023-12-26 22:12:10.967263	2023-12-26 22:12:10.967263
c4853ca7-8752-4887-a923-541b612e95cd	World War Z	Max Brooks	\N	\N	\N	f	bookshelf_cells/IMG_2143.jpeg	2023-12-26 22:12:10.970472	2023-12-26 22:12:10.970472
73de9b7f-9e8e-4fd6-a5ab-2b9fb9c85c50	Influence	Robert B. Cialdini	\N	\N	\N	f	bookshelf_cells/IMG_2144.jpeg	2023-12-26 22:12:10.97414	2023-12-26 22:12:10.97414
b1c91953-fd3e-451b-b43c-ad4669cb32d1	Everything Is Illuminated	Jonathan Safran Foer	\N	\N	\N	f	bookshelf_cells/IMG_2145.jpeg	2023-12-26 22:12:10.976936	2023-12-26 22:12:10.976936
ff23bb6d-d5a1-4c1a-850a-36e0798135dd	Behind The Oval Office	Dick Morris	\N	\N	\N	f	bookshelf_cells/IMG_2146.jpeg	2023-12-26 22:12:10.980392	2023-12-26 22:12:10.980392
0572f45c-0e53-4a6b-85e6-83aa7579dbe8	On Bullshit	Harry G. Frankfurt	\N	\N	\N	f	bookshelf_cells/IMG_2147.jpeg	2023-12-26 22:12:10.983694	2023-12-26 22:12:10.983694
c5b24678-8582-46ba-b444-791b02fe884a	BETRAYING AMBITION	Diego Agulló	\N	\N	\N	f	bookshelf_cells/IMG_2148.jpeg	2023-12-26 22:12:10.986123	2023-12-26 22:12:10.986123
fcf64278-1866-4059-8c7b-bdbfc91622fa	essays on physical practice	Nik Kosmas	\N	\N	\N	f	bookshelf_cells/IMG_2149.jpeg	2023-12-26 22:12:26.208461	2023-12-26 22:12:26.208461
0317bd0d-38c5-461a-b5d6-cc488c698be7	DOING ABSOLUTELY NOTHING	Paul Wiersbinski	\N	\N	\N	f	bookshelf_cells/IMG_2150.jpeg	2023-12-26 22:12:26.211053	2023-12-26 22:12:26.211053
8c339a76-55e2-45c1-b14b-d781ebd86869	WILD SEED	Octavia Butler	\N	\N	\N	f	bookshelf_cells/IMG_2151.jpeg	2023-12-26 22:12:26.21274	2023-12-26 22:12:26.21274
6b01d4ba-b827-468f-abd1-46400977aa34	ICARUS OR THE FUTURE OF SCIENCE	Bertrand Russell	\N	\N	\N	f	bookshelf_cells/IMG_2152.jpeg	2023-12-26 22:12:26.21426	2023-12-26 22:12:26.21426
aac9b0e2-7ec8-41fb-b7fd-e632d28346ab	Night Moves	Jessica Hopper	\N	\N	\N	f	bookshelf_cells/IMG_2154.jpeg	2023-12-26 22:12:26.215929	2023-12-26 22:12:26.215929
a2223ab6-8249-45db-87a1-e95b91ddd105	Man and Citizen	Thomas Hobbes	\N	\N	\N	f	bookshelf_cells/IMG_2155.jpeg	2023-12-26 22:12:26.217605	2023-12-26 22:12:26.217605
d98f6774-59df-4a4e-bc47-c7fc55ffb811	Design Patterns: Elements of Reusable Object-Oriented Software	Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides	\N	\N	\N	f	bookshelf_cells/IMG_2156.jpeg	2023-12-26 22:12:26.218886	2023-12-26 22:12:26.218886
17f582c8-a5f6-4792-9b11-a1e964c1e692	colombia centanni di solitudini	Danilo De Marco	\N	\N	\N	f	bookshelf_cells/IMG_2160.jpeg	2023-12-26 22:12:33.990432	2023-12-26 22:12:33.990432
af56775d-e34e-4c21-ac9f-f9b4d7caf07f	Dune Messiah	Frank Herbert	\N	\N	\N	f	bookshelf_cells/IMG_2161.jpeg	2023-12-26 22:12:33.993447	2023-12-26 22:12:33.993447
004e150b-02ea-4624-90ef-42760a1e43ed	The Martian Chronicles	Ray Bradbury	\N	\N	\N	f	bookshelf_cells/IMG_2162.jpeg	2023-12-26 22:12:33.996353	2023-12-26 22:12:33.996353
0e2a3632-7c2d-4acb-b1f9-7b2d4606033c	Herzog	Saul Bellow	\N	\N	\N	f	bookshelf_cells/IMG_2163.jpeg	2023-12-26 22:12:33.998657	2023-12-26 22:12:33.998657
0582938b-7203-4add-b5ee-568fb6594618	The Velvet Rage	Alan Downs, PhD	\N	\N	\N	f	bookshelf_cells/IMG_2164.jpeg	2023-12-26 22:12:34.001152	2023-12-26 22:12:34.001152
1cde6583-f4c2-4479-9b88-dc984c2fe362	The Order of Things	Michel Foucault	\N	\N	\N	f	bookshelf_cells/IMG_2165.jpeg	2023-12-26 22:12:34.003714	2023-12-26 22:12:34.003714
ceb2f39b-c792-4e94-a418-a928935c4382	The Fall of Hyperion	Dan Simmons	\N	\N	\N	f	bookshelf_cells/IMG_2166.jpeg	2023-12-26 22:12:34.00569	2023-12-26 22:12:34.00569
27349258-db39-438c-a876-49d7c4533d14	DUNE	Frank Herbert	\N	\N	\N	f	bookshelf_cells/IMG_2170.jpeg	2023-12-26 22:12:45.145971	2023-12-26 22:12:45.145971
9347102b-8be8-4e04-8fa2-c08b2bb92d27	Webster's New World Thesaurus	Charlton Laird	\N	\N	\N	f	bookshelf_cells/IMG_2171.jpeg	2023-12-26 22:12:45.150109	2023-12-26 22:12:45.150109
b0aa626b-63b0-4904-81e8-dc20f5f6f135	The Algorithm Design Manual	Steven S. Skiena	\N	\N	\N	f	bookshelf_cells/IMG_2172.jpeg	2023-12-26 22:12:45.15211	2023-12-26 22:12:45.15211
5cab1d05-e811-488d-8c25-9b237d9fafe2	Cut the Knot	Alexander Bogomolny	\N	\N	\N	f	bookshelf_cells/IMG_2173.jpeg	2023-12-26 22:12:45.154091	2023-12-26 22:12:45.154091
017c4316-6b97-43d1-85eb-aa8e0d199ad7	Building Microservices	Sam Newman	\N	\N	\N	f	bookshelf_cells/IMG_2174.jpeg	2023-12-26 22:12:45.156552	2023-12-26 22:12:45.156552
ade14435-c084-4512-aec7-98ea94df79a1	Cracking the Coding Interview	Gayle Laakmann McDowell	\N	\N	\N	f	bookshelf_cells/IMG_2175.jpeg	2023-12-26 22:12:45.159498	2023-12-26 22:12:45.159498
48f5699f-5be8-4955-ae50-af33e5963af1	Kill Decision	Daniel Suarez	\N	\N	\N	f	bookshelf_cells/IMG_2176.jpeg	2023-12-26 22:12:45.161012	2023-12-26 22:12:45.161012
4dbd27e2-176e-499b-b85c-73a9c31be798	Health Insurance	Michael A. Morrissey	\N	\N	\N	f	bookshelf_cells/IMG_2177.jpeg	2023-12-26 22:12:45.163227	2023-12-26 22:12:45.163227
a0cc62b8-ce93-44b6-95e7-9350d01d8b4c	Elementary Differential Equations and Boundary Value Problems	William E. Boyce, Richard C. DiPrima	\N	\N	\N	f	bookshelf_cells/IMG_2180.jpeg	2023-12-26 22:13:02.355828	2023-12-26 22:13:02.355828
313be7cb-8546-4fe1-9691-9287d34c7c86	State of Denial	Bob Woodward	\N	\N	\N	f	bookshelf_cells/IMG_2181.jpeg	2023-12-26 22:13:02.358976	2023-12-26 22:13:02.358976
19eb3fef-0102-46c6-a7ad-0f2f0cd5048f	No Ordinary Time	Doris Kearns Goodwin	\N	\N	\N	f	bookshelf_cells/IMG_2182.jpeg	2023-12-26 22:13:02.361786	2023-12-26 22:13:02.361786
39cd673d-2637-4204-9cb5-e78a1d8cadca	Prometheus Rising	Robert Anton Wilson	\N	\N	\N	f	bookshelf_cells/IMG_2183.jpeg	2023-12-26 22:13:02.364178	2023-12-26 22:13:02.364178
484575e3-af59-4b08-b12b-06240666e734	Principles of Magnetic Resonance	C. P. Slichter	\N	\N	\N	f	bookshelf_cells/IMG_2184.jpeg	2023-12-26 22:13:02.366112	2023-12-26 22:13:02.366112
4d3b748f-1e72-4787-8094-a4031d2ae0d5	The Best of Walden and Civil Disobedience	Henry David Thoreau	\N	\N	\N	f	bookshelf_cells/IMG_2185.jpeg	2023-12-26 22:13:02.368099	2023-12-26 22:13:02.368099
d4b188cf-2c56-4007-9312-6f661c64027b	Eloquent Ruby	Russ Olsen	\N	\N	\N	f	bookshelf_cells/IMG_2186.jpeg	2023-12-26 22:13:02.370712	2023-12-26 22:13:02.370712
434a4795-f4e7-45c1-93da-67346a5f63f0	Understanding Vincent Van Gogh	Frederick Dawe	\N	\N	\N	f	bookshelf_cells/IMG_2190.jpeg	2023-12-26 22:13:13.447334	2023-12-26 22:13:13.447334
632d1fa3-7d34-4b81-9c82-1948935a1dbf	The Gathering of the Juggalos	Daniel Cronin	\N	\N	\N	f	bookshelf_cells/IMG_2191.jpeg	2023-12-26 22:13:13.449915	2023-12-26 22:13:13.449915
f63fe8ee-e14b-4950-936c-866526aa8cca	Franz Kafka Pictures of a Life	Klaus Wagenbach	\N	\N	\N	f	bookshelf_cells/IMG_2192.jpeg	2023-12-26 22:13:13.451618	2023-12-26 22:13:13.451618
0549d39b-9d5f-4a0d-abfc-5c81d9994ca0	To Engineer Is Human	Henry Petroski	\N	\N	\N	f	bookshelf_cells/IMG_2193.jpeg	2023-12-26 22:13:13.452904	2023-12-26 22:13:13.452904
cd1f6b54-4d04-40f8-b1fd-f82b9f2a54d1	The Civil War	Geoffrey Ward with Ric Burns and Ken Burns	\N	\N	\N	f	bookshelf_cells/IMG_2194.jpeg	2023-12-26 22:13:13.454595	2023-12-26 22:13:13.454595
f7df5fda-ef2f-4cbe-a0b5-b2ccf1e64581	The Book of Genesis Illustrated	R. Crumb	\N	\N	\N	f	bookshelf_cells/IMG_2195.jpeg	2023-12-26 22:13:13.456584	2023-12-26 22:13:13.456584
fd93823c-964c-4b75-b693-3a917b562586	Mr. Scott's Guide to the Enterprise	Shane Johnson	\N	\N	\N	f	bookshelf_cells/IMG_2196.jpeg	2023-12-26 22:13:13.458735	2023-12-26 22:13:13.458735
ecfe5e7d-2796-4066-8dc7-f77f8b4e111a	From Star Wars to Indiana Jones	Mark Cotta Vaz and Shinji Hata	\N	\N	\N	f	bookshelf_cells/IMG_2197.jpeg	2023-12-26 22:13:13.460679	2023-12-26 22:13:13.460679
45d22723-16d5-40dc-9a36-3622b16b4c0d	null	Sharon Weiner Green and Ira Wolf	\N	\N	\N	f	bookshelf_cells/IMG_2200.jpeg	2023-12-26 22:13:40.960532	2023-12-26 22:13:40.960532
ca26682e-4b7a-47b3-8822-382e98e64b00	Cracking the GRE	2006 Edition,null	\N	\N	\N	f	bookshelf_cells/IMG_2201.jpeg	2023-12-26 22:13:40.963019	2023-12-26 22:13:40.963019
dc762703-53e2-4c1e-88de-3a546baac0d8	Cracking the GRE Math Subject Test	Steven A. Leduc	\N	\N	\N	f	bookshelf_cells/IMG_2202.jpeg	2023-12-26 22:13:40.964549	2023-12-26 22:13:40.964549
83a4d434-fa4b-4880-9c77-a2765160f252	The Bomb	Gerard J. DeGroot	\N	\N	\N	f	bookshelf_cells/IMG_2297.jpeg	2023-12-26 22:15:04.321224	2023-12-26 22:15:04.321224
0f67ad77-5123-417c-8248-0c27fb19e894	Syntactic Structures	Noam Chomsky	\N	\N	\N	f	bookshelf_cells/IMG_2203.jpeg	2023-12-26 22:13:40.966021	2023-12-26 22:13:40.966021
3c23b964-dd91-402e-a340-31a126dfa8ea	Geometry for Dummies	Mark Ryan	\N	\N	\N	f	bookshelf_cells/IMG_2204.jpeg	2023-12-26 22:13:40.968046	2023-12-26 22:13:40.968046
ed371de8-4dd0-4652-9881-dd28362d000d	Ina May's Guide to Childbirth	Ina May Gaskin	\N	\N	\N	f	bookshelf_cells/IMG_2205.jpeg	2023-12-26 22:13:40.969563	2023-12-26 22:13:40.969563
a9414a57-f2af-4840-87c2-0941edf3dc6f	No Good Men Among the Living	Anand Gopal	\N	\N	\N	f	bookshelf_cells/IMG_2206.jpeg	2023-12-26 22:13:40.970791	2023-12-26 22:13:40.970791
3d70f02f-daed-4460-a5bf-d5a6b06ecb4c	Inspector Mouse	Bernard Stone	\N	\N	\N	f	bookshelf_cells/IMG_2210.jpeg	2023-12-26 22:13:54.16963	2023-12-26 22:13:54.16963
e37ca5c4-6f9c-4f9e-9ad6-391fd7dca41e	Running Lean	Ash Maurya	\N	\N	\N	f	bookshelf_cells/IMG_2211.jpeg	2023-12-26 22:13:54.172044	2023-12-26 22:13:54.172044
b3d47e54-8595-430e-8568-67d47a6ce567	The Armed Society	Tristram Coffin	\N	\N	\N	f	bookshelf_cells/IMG_2235.jpeg	2023-12-26 22:13:54.174025	2023-12-26 22:13:54.174025
e98ebcfb-1df1-4b02-b0a8-0a523ac403f1	Brave New World	Aldous Huxley	\N	\N	\N	f	bookshelf_cells/IMG_2236.jpeg	2023-12-26 22:13:54.177098	2023-12-26 22:13:54.177098
0890fe75-fee7-4ae4-9182-1723b7c84a3f	Truly Tasteless Jokes	Blanche Knott	\N	\N	\N	f	bookshelf_cells/IMG_2237.jpeg	2023-12-26 22:13:54.179493	2023-12-26 22:13:54.179493
b8595d02-9de6-47fc-9848-5b3309043284	Down the Rabbit Hole	Juan Pablo Villalobos	\N	\N	\N	f	bookshelf_cells/IMG_2238.jpeg	2023-12-26 22:13:54.181342	2023-12-26 22:13:54.181342
867ba6c4-36d1-46c8-a4ba-2561746cc281	Lifemanship	Stephen Potter	\N	\N	\N	f	bookshelf_cells/IMG_2239.jpeg	2023-12-26 22:13:54.183532	2023-12-26 22:13:54.183532
6ac0d472-cd8e-4476-9d4c-1742031ed64f	Lessons of Azikwelwa	Dan Mokonyane	\N	\N	\N	f	bookshelf_cells/IMG_2240.jpeg	2023-12-26 22:13:54.185398	2023-12-26 22:13:54.185398
6a08cb83-1a86-43db-860d-2faa88c431d7	Studies in Classic American Literature	D. H. Lawrence	\N	\N	\N	f	bookshelf_cells/IMG_2241.jpeg	2023-12-26 22:13:54.186978	2023-12-26 22:13:54.186978
eac73da1-3b5e-404e-8cfa-4630d2e4d3fe	Love in the Time of Cholera	Gabriel Garcia Marquez	\N	\N	\N	f	bookshelf_cells/IMG_2242.jpeg	2023-12-26 22:13:54.188519	2023-12-26 22:13:54.188519
be1cffbc-eb92-40d3-8a7a-3ed13ee1f4cf	Where Does the Weirdness Go?	David Lindley	\N	\N	\N	f	bookshelf_cells/IMG_2243.jpeg	2023-12-26 22:14:04.578645	2023-12-26 22:14:04.578645
cdee5c35-1334-448d-864e-b72d32f5d503	The History of Corporal Punishment	George Ryley Scott	\N	\N	\N	f	bookshelf_cells/IMG_2244.jpeg	2023-12-26 22:14:04.581199	2023-12-26 22:14:04.581199
97762030-fb79-4d82-a27a-ebe972e0922c	The Antisocial Personalities	David T. Lykken	\N	\N	\N	f	bookshelf_cells/IMG_2245.jpeg	2023-12-26 22:14:04.582892	2023-12-26 22:14:04.582892
254bc31c-0ca2-412a-a776-dc1f6847f9df	The Rails 3 Way	Obie Fernandez	\N	\N	\N	f	bookshelf_cells/IMG_2246.jpeg	2023-12-26 22:14:04.585021	2023-12-26 22:14:04.585021
7dba8e8d-d8f9-48e6-94c8-1c99c4eba9b1	The Enlightened Heart	Stephen Mitchell	\N	\N	\N	f	bookshelf_cells/IMG_2247.jpeg	2023-12-26 22:14:04.586712	2023-12-26 22:14:04.586712
c3981776-50d3-42f9-98bf-6e72ffa6628d	Hitler's First War	Thomas Weber	\N	\N	\N	f	bookshelf_cells/IMG_2248.jpeg	2023-12-26 22:14:04.588054	2023-12-26 22:14:04.588054
4d447138-85eb-493e-b837-6811f61354b2	Vietnam War Diary	Fred Leo Brown	\N	\N	\N	f	bookshelf_cells/IMG_2249.jpeg	2023-12-26 22:14:04.589314	2023-12-26 22:14:04.589314
978e0e0c-21bb-44d9-ad27-a7a0b05a46a5	Men of Mathematics	E. T. Bell	\N	\N	\N	f	bookshelf_cells/IMG_2250.jpeg	2023-12-26 22:14:04.590839	2023-12-26 22:14:04.590839
fa19c339-326b-471e-8c70-527102e413a7	In the Realm of Hungry Ghosts	Gabor Maté, MD	\N	\N	\N	f	bookshelf_cells/IMG_2251.jpeg	2023-12-26 22:14:04.592259	2023-12-26 22:14:04.592259
d5b0da84-5138-4195-bdce-e25d67e07705	A Mad Catastrophe	Geoffrey Wawro	\N	\N	\N	f	bookshelf_cells/IMG_2253.jpeg	2023-12-26 22:14:15.118302	2023-12-26 22:14:15.118302
3d7adb21-54d9-4ff6-aae0-ae31568797dd	Antifragile	Nassim Nicholas Taleb	\N	\N	\N	f	bookshelf_cells/IMG_2254.jpeg	2023-12-26 22:14:15.121272	2023-12-26 22:14:15.121272
be8f6147-fa19-4058-a96d-25bc3bfebe75	Clean Code	Robert C. Martin	\N	\N	\N	f	bookshelf_cells/IMG_2255.jpeg	2023-12-26 22:14:15.123378	2023-12-26 22:14:15.123378
adf7f7c2-cc9f-46f7-828a-5cbac8da45f0	Effective Java	Joshua Bloch	\N	\N	\N	f	bookshelf_cells/IMG_2256.jpeg	2023-12-26 22:14:15.125504	2023-12-26 22:14:15.125504
1764b8fc-dcac-47a5-9b4a-eb8e6cf490b5	The Singularity is Near	Ray Kurzweil	\N	\N	\N	f	bookshelf_cells/IMG_2257.jpeg	2023-12-26 22:14:15.127322	2023-12-26 22:14:15.127322
1d8733b7-60fb-4571-a7e5-1ebe2148380e	Statistical Consequences of Fat Tails	Nassim Nicholas Taleb	\N	\N	\N	f	bookshelf_cells/IMG_2258.jpeg	2023-12-26 22:14:15.128954	2023-12-26 22:14:15.128954
c65908d3-c17a-4578-bb5f-4f83c7f3dd49	Staff Engineer	Will Larson	\N	\N	\N	f	bookshelf_cells/IMG_2259.jpeg	2023-12-26 22:14:15.130686	2023-12-26 22:14:15.130686
3b0fe1ab-60db-4532-91e6-caf2457bc547	American Splendor	Harvey Pekar	\N	\N	\N	f	bookshelf_cells/IMG_2263.jpeg	2023-12-26 22:14:31.238588	2023-12-26 22:14:31.238588
93535550-440f-454f-9009-0d00c3f92def	The Spoils of War	Bruce Bueno de Mesquita and Alastair Smith	\N	\N	\N	f	bookshelf_cells/IMG_2264.jpeg	2023-12-26 22:14:31.24174	2023-12-26 22:14:31.24174
a94f5480-f0fa-48e8-bac4-b6d81a0d7200	Cycles of Time	Roger Penrose	\N	\N	\N	f	bookshelf_cells/IMG_2265.jpeg	2023-12-26 22:14:31.243528	2023-12-26 22:14:31.243528
9b5affa5-48c7-49cf-8aa6-7eac86526408	Applications of Synchrotron Radiation	Wolfgang Eberhardt	\N	\N	\N	f	bookshelf_cells/IMG_2266.jpeg	2023-12-26 22:14:31.245439	2023-12-26 22:14:31.245439
7fa83c43-c6fb-42fe-b81e-c183f7a7a205	The Elegant Universe	Brian Greene	\N	\N	\N	f	bookshelf_cells/IMG_2267.jpeg	2023-12-26 22:14:31.247867	2023-12-26 22:14:31.247867
ae32df8a-87db-407a-b18d-bcbe8ed4efd6	Critical	Senator Tom Daschle with Scott S. Greenberger and Jeanne M. Lambrew	\N	\N	\N	f	bookshelf_cells/IMG_2268.jpeg	2023-12-26 22:14:31.249967	2023-12-26 22:14:31.249967
094e4df8-b563-4b14-b378-017985d8c513	Thereby Hangs a Tale: Stories of Curious Word Origins	Charles Earle Funk	\N	\N	\N	f	bookshelf_cells/IMG_2273.jpeg	2023-12-26 22:14:41.78391	2023-12-26 22:14:41.78391
7e2c25ce-feaa-4dae-9a8c-8bcc4c4e0556	Starship Troopers	Robert A. Heinlein	\N	\N	\N	f	bookshelf_cells/IMG_2274.jpeg	2023-12-26 22:14:41.787023	2023-12-26 22:14:41.787023
b7dc95ef-03be-4509-af79-015eb37132e6	Klingsor's Last Summer	Hermann Hesse	\N	\N	\N	f	bookshelf_cells/IMG_2275.jpeg	2023-12-26 22:14:41.789305	2023-12-26 22:14:41.789305
a8bda2c2-0066-43e3-be98-ee91e909eb58	Olympos	Dan Simmons	\N	\N	\N	f	bookshelf_cells/IMG_2276.jpeg	2023-12-26 22:14:41.792085	2023-12-26 22:14:41.792085
db54130a-ded8-4690-a1dc-9fd048f4971c	Going Downtown: The War Against Hanoi and Washington	Jack Broughton	\N	\N	\N	f	bookshelf_cells/IMG_2277.jpeg	2023-12-26 22:14:41.794262	2023-12-26 22:14:41.794262
03c79888-103b-4eca-bff5-3c228c0acdb3	Music Technology: A Survivor's Guide	Paul White	\N	\N	\N	f	bookshelf_cells/IMG_2278.jpeg	2023-12-26 22:14:41.796233	2023-12-26 22:14:41.796233
d1e13fdc-ef22-4310-8bc7-29c97717f79b	Battle Cry of Freedom	James M. McPherson	\N	\N	\N	f	bookshelf_cells/IMG_2279.jpeg	2023-12-26 22:14:41.798591	2023-12-26 22:14:41.798591
e4c27740-c94e-4e08-bf83-1ac92bac1e95	Speaker Project	Juan Angel Chávez	\N	\N	\N	f	bookshelf_cells/IMG_2280.jpeg	2023-12-26 22:14:41.800725	2023-12-26 22:14:41.800725
3a2d0498-5b49-4b6b-b746-d3afd67a3b10	Einstein: His Life and Universe	Walter Isaacson	\N	\N	\N	f	bookshelf_cells/IMG_2283.jpeg	2023-12-26 22:14:54.480064	2023-12-26 22:14:54.480064
a9cfa146-b718-45d2-9338-a67caa4176d4	An Inquiry into the Nature and Causes of the Wealth of Nations	Adam Smith	\N	\N	\N	f	bookshelf_cells/IMG_2284.jpeg	2023-12-26 22:14:54.481814	2023-12-26 22:14:54.481814
343b777b-ebf5-44c6-b5ee-eefc6dd7e1d1	The Idiot	Fyodor Dostoyevsky	\N	\N	\N	f	bookshelf_cells/IMG_2285.jpeg	2023-12-26 22:14:54.483087	2023-12-26 22:14:54.483087
c12f5401-bd22-47b8-8124-cff5cfbdfef0	Green Mars	Kim Stanley Robinson	\N	\N	\N	f	bookshelf_cells/IMG_2286.jpeg	2023-12-26 22:14:54.484361	2023-12-26 22:14:54.484361
f8c88704-3137-4372-b706-b718c2eea9c2	1493: Uncovering the New World Columbus Created	Charles C. Mann	\N	\N	\N	f	bookshelf_cells/IMG_2287.jpeg	2023-12-26 22:14:54.485512	2023-12-26 22:14:54.485512
b799b34a-9c46-451f-9e32-55424728110f	The Wide Window	Lemony Snicket	\N	\N	\N	f	bookshelf_cells/IMG_2288.jpeg	2023-12-26 22:14:54.486432	2023-12-26 22:14:54.486432
e0b20063-c082-43b2-9d3f-0eae908a2dd5	La Carreta Made a U-Turn	Tato Laviera	\N	\N	\N	f	bookshelf_cells/IMG_2289.jpeg	2023-12-26 22:14:54.487463	2023-12-26 22:14:54.487463
7e347de6-d2d4-432c-be38-b1b3024c656c	Reconstructing Reality in the Courtroom	W. Lance Bennett & Martha S. Feldman	\N	\N	\N	f	bookshelf_cells/IMG_2290.jpeg	2023-12-26 22:14:54.488338	2023-12-26 22:14:54.488338
5be34d4e-839f-4761-9d92-e546f07bf42c	Programming Kotlin	Stephen Samuel/Stefan Bocutiu	\N	\N	\N	f	bookshelf_cells/IMG_2293.jpeg	2023-12-26 22:15:04.311497	2023-12-26 22:15:04.311497
fc2aed6d-d3ff-439e-a7a7-51268e1f0843	A History Of Narrative Film	David A. Cook	\N	\N	\N	f	bookshelf_cells/IMG_2294.jpeg	2023-12-26 22:15:04.314718	2023-12-26 22:15:04.314718
fb46ff85-0691-479e-ae72-905715ad3c4b	CAITLIN	CAITLINnull	\N	\N	\N	f	bookshelf_cells/IMG_2295.jpeg	2023-12-26 22:15:04.317142	2023-12-26 22:15:04.317142
ae2d36da-bb53-4b5f-a525-401cc02c0243	Scanning Tunneling Microscopy and its Application	Chunli Bai	\N	\N	\N	f	bookshelf_cells/IMG_2296.jpeg	2023-12-26 22:15:04.319448	2023-12-26 22:15:04.319448
f95a4cd5-8473-4cee-a066-79f2a9a2ce88	Vincent Price	Victoria Price	\N	\N	\N	f	bookshelf_cells/IMG_2298.jpeg	2023-12-26 22:15:04.322772	2023-12-26 22:15:04.322772
234f19e8-7e0d-45b1-934f-15f263ce0a53	To the Distant Observer	Noël Burch	\N	\N	\N	f	bookshelf_cells/IMG_2299.jpeg	2023-12-26 22:15:04.324481	2023-12-26 22:15:04.324481
0faed513-a59a-40ae-b7f9-7bda48b2a99c	Programming Ruby 1.9	Dave Thomas	\N	\N	\N	f	bookshelf_cells/IMG_2300.jpeg	2023-12-26 22:15:04.325966	2023-12-26 22:15:04.325966
598e4b9b-e796-4ccf-90f5-2bb47c385ee1	Multitude	Chitra B. Divakaruni	\N	\N	\N	f	bookshelf_cells/IMG_2301.jpeg	2023-12-26 22:15:04.32922	2023-12-26 22:15:04.32922
8d8aa1b6-bdb1-4f25-a196-58059bce85f6	Israel's Attack on Osiraq: A Model for Future Preventive Strikes?	Peter S. Ford	\N	\N	\N	f	bookshelf_cells/IMG_2302.jpeg	2023-12-26 22:15:04.331577	2023-12-26 22:15:04.331577
2792aa6a-de42-42d7-adbd-44bf2247c0fb	International Security Negotiations: Lessons Learned from Negotiating with the Russians on Nuclear Arms	Michael O. Wheeler	\N	\N	\N	f	bookshelf_cells/IMG_2303.jpeg	2023-12-26 22:15:15.167157	2023-12-26 22:15:15.167157
a190452b-d3f4-41e5-8169-f94b6892e2ea	Cruel Shoes	Steve Martin	\N	\N	\N	f	bookshelf_cells/IMG_2304.jpeg	2023-12-26 22:15:15.17027	2023-12-26 22:15:15.17027
e60d444b-64bf-4160-b1b0-3f19dd2e072c	Where the Red Fern Grows	Wilson Rawls	\N	\N	\N	f	bookshelf_cells/IMG_2305.jpeg	2023-12-26 22:15:15.172022	2023-12-26 22:15:15.172022
a1541257-86c5-45ec-b570-fe7e4b7826d7	Astrophysics for People in a Hurry	Neil deGrasse Tyson	\N	\N	\N	f	bookshelf_cells/IMG_2306.jpeg	2023-12-26 22:15:15.173796	2023-12-26 22:15:15.173796
ef6880df-c9bb-4c4c-bff0-7d77a8b1389d	Eight Bells	and All's Well,null	\N	\N	\N	f	bookshelf_cells/IMG_2307.jpeg	2023-12-26 22:15:15.175587	2023-12-26 22:15:15.175587
36f62002-7e3e-4c6e-9eef-621b46f2b78e	The Carving of Mount Rushmore	Rex Alan Smith	\N	\N	\N	f	bookshelf_cells/IMG_2308.jpeg	2023-12-26 22:15:15.177504	2023-12-26 22:15:15.177504
e9adcb11-736c-4403-b0ca-8b1d8ba7afd7	Intelligence in War	John Keegan	\N	\N	\N	f	bookshelf_cells/IMG_2309.jpeg	2023-12-26 22:15:15.179152	2023-12-26 22:15:15.179152
6d99f054-6e16-46bf-8504-3c89349f48fc	The Genius of the Beast	Howard Bloom	\N	\N	\N	f	bookshelf_cells/IMG_2310.jpeg	2023-12-26 22:15:15.180939	2023-12-26 22:15:15.180939
7aa1a931-ef50-4eb5-bd9c-423cedff7e95	Junky	William S. Burroughs	\N	\N	\N	f	bookshelf_cells/IMG_2311.jpeg	2023-12-26 22:15:15.18252	2023-12-26 22:15:15.18252
7c5fb95a-b772-47bc-a92e-11d6f6b4b2d9	High-Pressure Shock Compression of Solids II	Lee Davison	\N	\N	\N	f	bookshelf_cells/IMG_2313.jpeg	2023-12-26 22:15:24.995212	2023-12-26 22:15:24.995212
57182049-a476-459f-b9c4-615654588e05	Hollywood Babylon	Kenneth Anger	\N	\N	\N	f	bookshelf_cells/IMG_2314.jpeg	2023-12-26 22:15:24.99907	2023-12-26 22:15:24.99907
1af156c2-99e3-44e4-a031-f2a4cb3b663e	Dare Not Linger: The Presidential Years	Nelson Mandela and Mandla Langa	\N	\N	\N	f	bookshelf_cells/IMG_2315.jpeg	2023-12-26 22:15:25.001183	2023-12-26 22:15:25.001183
0bca8c94-7f84-4178-9d42-0864a9780507	Man's Search for Meaning	Viktor E. Frankl	\N	\N	\N	f	bookshelf_cells/IMG_2316.jpeg	2023-12-26 22:15:25.002946	2023-12-26 22:15:25.002946
58c4c99a-494d-4a67-a754-abf0e83946bb	Leonardo da Vinci	Walter Isaacson	\N	\N	\N	f	bookshelf_cells/IMG_2317.jpeg	2023-12-26 22:15:25.004848	2023-12-26 22:15:25.004848
e8a6ad7d-75e1-4fc5-a6cc-909961a7b090	The Whole Shebang	Timothy Ferris	\N	\N	\N	f	bookshelf_cells/IMG_2318.jpeg	2023-12-26 22:15:25.00655	2023-12-26 22:15:25.00655
5915983a-3aec-4f11-bb6f-fb41750c88e6	11/22/63	Stephen King	\N	\N	\N	f	bookshelf_cells/IMG_2319.jpeg	2023-12-26 22:15:25.008237	2023-12-26 22:15:25.008237
304b1c59-c8e5-4e98-b564-382d767d99f7	A Briefer History of Time	Stephen Hawking with Leonard Mlodinow	\N	\N	\N	f	bookshelf_cells/IMG_2322.jpeg	2023-12-26 22:15:25.009845	2023-12-26 22:15:25.009845
79a945fb-de46-412d-ba4e-0c86926caf71	Palestine: Peace Not Apartheid	Jimmy Carter	\N	\N	\N	f	bookshelf_cells/IMG_2323.jpeg	2023-12-26 22:15:25.011394	2023-12-26 22:15:25.011394
26086fbe-9384-47fe-83b9-9d83d16dbcee	Descent into Hell	Charles Williams	\N	\N	\N	f	bookshelf_cells/IMG_2325.jpeg	2023-12-26 22:15:38.103223	2023-12-26 22:15:38.103223
0b3eeb30-f1d9-4a16-b15e-26f1c72ff5aa	The Tao of Physics	Fritjof Capra	\N	\N	\N	f	bookshelf_cells/IMG_2326.jpeg	2023-12-26 22:15:38.105641	2023-12-26 22:15:38.105641
09f45aaf-69c6-4158-96d1-cc66505c6850	Zen and the Art of Motorcycle Maintenance	Robert M. Pirsig	\N	\N	\N	f	bookshelf_cells/IMG_2327.jpeg	2023-12-26 22:15:38.107236	2023-12-26 22:15:38.107236
9b9d0775-04d7-49ae-a2a2-f4a25367e62f	Franklin and Winston	Jon Meacham	\N	\N	\N	f	bookshelf_cells/IMG_2328.jpeg	2023-12-26 22:15:38.109259	2023-12-26 22:15:38.109259
981f212d-6425-4447-a548-d8ef13082182	Analysis of Observed Chaotic Data	Henry D. I. Abarbanel	\N	\N	\N	f	bookshelf_cells/IMG_2329.jpeg	2023-12-26 22:15:38.111743	2023-12-26 22:15:38.111743
66be9427-8923-48ad-a262-9d95d27f43a9	The Dance of Anger	Harriet Lerner, Ph.D.	\N	\N	\N	f	bookshelf_cells/IMG_2330.jpeg	2023-12-26 22:15:38.114429	2023-12-26 22:15:38.114429
d0391b4d-b8f8-41a1-99f7-8336b00cf007	Victory Through Air Power	Seversky	\N	\N	\N	f	bookshelf_cells/IMG_2335.jpeg	2023-12-26 22:15:46.809246	2023-12-26 22:15:46.809246
9dc39bc5-82d8-46fa-8d81-f259561e1368	Geometry	Glencoe Mathematics	\N	\N	\N	f	bookshelf_cells/IMG_2336.jpeg	2023-12-26 22:15:46.811728	2023-12-26 22:15:46.811728
669d7c96-3e70-4d30-b07e-641c55c6fd79	Table of Integrals	Series, and Products,I. S. Gradshteyn/I. M. Ryzhik	\N	\N	\N	f	bookshelf_cells/IMG_2337.jpeg	2023-12-26 22:15:46.814096	2023-12-26 22:15:46.814096
4b7ae113-a9ae-4c2d-9dd5-01e8a0afecc7	Plasma Spectroscopy	E. Oks	\N	\N	\N	f	bookshelf_cells/IMG_2338.jpeg	2023-12-26 22:15:46.816916	2023-12-26 22:15:46.816916
5aeed473-bc27-430d-86bb-c8833e77f223	Desert Islands and Other Texts 1953-1974	Gilles Deleuze	\N	\N	\N	f	bookshelf_cells/IMG_2339.jpeg	2023-12-26 22:15:46.819175	2023-12-26 22:15:46.819175
00dd9502-d248-4c5d-b991-9c7032a47494	Evening in Paradise: More Stories	Lucia Berlin	\N	\N	\N	f	bookshelf_cells/IMG_2340.jpeg	2023-12-26 22:15:46.821099	2023-12-26 22:15:46.821099
aa394510-40a0-4d61-b318-747083d82ce8	Little Women	Louisa May Alcott	\N	\N	\N	f	bookshelf_cells/IMG_2341.jpeg	2023-12-26 22:15:46.822605	2023-12-26 22:15:46.822605
efdaa9cb-ca32-422d-885c-b94baddd6601	the art of seduction	Robert Greene	\N	\N	\N	f	bookshelf_cells/IMG_2342.jpeg	2023-12-26 22:15:46.824041	2023-12-26 22:15:46.824041
021d06e6-0fe3-40f0-a08e-db371586effd	Role Models	John Waters	\N	\N	\N	f	bookshelf_cells/IMG_2343.jpeg	2023-12-26 22:15:46.825819	2023-12-26 22:15:46.825819
6d63bda2-4798-4dc7-8182-e0bb15647c4a	The True Story of Oklahoma's Fabulous Flaming Lips Staring at Sound	Jim DeRogatis	\N	\N	\N	f	bookshelf_cells/IMG_2344.jpeg	2023-12-26 22:15:46.82747	2023-12-26 22:15:46.82747
58befad4-855e-4b18-8f19-b84d9b02559f	The Poetic Edda	Lee M. Hollander	\N	\N	\N	f	bookshelf_cells/IMG_2345.jpeg	2023-12-26 22:15:56.183569	2023-12-26 22:15:56.183569
ec1eabce-b8ad-4592-827d-3fb68f3a81a2	How the Scots Invented the Modern World	Arthur Herman	\N	\N	\N	f	bookshelf_cells/IMG_2346.jpeg	2023-12-26 22:15:56.186814	2023-12-26 22:15:56.186814
05b089c5-5785-44ac-91ff-6d62be8ff81b	The Russians	Hedrick Smith	\N	\N	\N	f	bookshelf_cells/IMG_2347.jpeg	2023-12-26 22:15:56.189075	2023-12-26 22:15:56.189075
d01d514e-11a3-4ad2-a808-56e58b1515bf	The Battle of Alamein	John Bierman and Colin Smith	\N	\N	\N	f	bookshelf_cells/IMG_2348.jpeg	2023-12-26 22:15:56.191409	2023-12-26 22:15:56.191409
c7b76a9c-340c-4b0b-9aea-df78f4c0cb2d	The Control Revolution	James R. Beniger	\N	\N	\N	f	bookshelf_cells/IMG_2349.jpeg	2023-12-26 22:15:56.193198	2023-12-26 22:15:56.193198
33dd83d8-3f44-49e2-bc91-5a4bcd066ca0	The Green Knight	Iris Murdoch	\N	\N	\N	f	bookshelf_cells/IMG_2350.jpeg	2023-12-26 22:15:56.195273	2023-12-26 22:15:56.195273
c96f02ad-7984-4026-a79d-d13060caddba	McMindfulness	Ronald Purser	\N	\N	\N	f	bookshelf_cells/IMG_2351.jpeg	2023-12-26 22:15:56.198789	2023-12-26 22:15:56.198789
f8f46c3f-caa3-4526-9d4a-12ac764cf92b	The Man Who Mistook His Wife for a Hat	Oliver Sacks	\N	\N	\N	f	bookshelf_cells/IMG_2352.jpeg	2023-12-26 22:15:56.201088	2023-12-26 22:15:56.201088
5af44788-0d27-4aed-b3b7-9d887f471e05	The Lady in Gold	Anne-Marie O'Connor	\N	\N	\N	f	bookshelf_cells/IMG_2353.jpeg	2023-12-26 22:15:56.204056	2023-12-26 22:15:56.204056
0573f536-d56e-4304-92fe-a61e4e6e63a3	Carsick	John Waters	\N	\N	\N	f	bookshelf_cells/IMG_2355.jpeg	2023-12-26 22:16:10.461344	2023-12-26 22:16:10.461344
bbf44dc8-1e77-4361-8157-56ba474fc2f8	Crime and Punishment	Fyodor Dostoevsky	\N	\N	\N	f	bookshelf_cells/IMG_2356.jpeg	2023-12-26 22:16:10.463937	2023-12-26 22:16:10.463937
aa1db28e-6759-469b-85dc-02875903b1dd	Stealing Rembrandts	Anthony M. Amore and Tom Mashberg	\N	\N	\N	f	bookshelf_cells/IMG_2357.jpeg	2023-12-26 22:16:10.465468	2023-12-26 22:16:10.465468
64a79b6c-4877-4537-965b-e793d74db11a	Infinite Jest	David Foster Wallace	\N	\N	\N	f	bookshelf_cells/IMG_2358.jpeg	2023-12-26 22:16:10.467181	2023-12-26 22:16:10.467181
23e852bf-3918-4170-b5e9-e51122e1a31f	The Book of Questions	Gregory Stock, Ph.D.	\N	\N	\N	f	bookshelf_cells/IMG_2395.jpeg	2023-12-26 22:16:21.520182	2023-12-26 22:16:21.520182
e431f367-36e7-4bf2-b795-c6fe50667e7f	An Atlas of Anatomy for Artists	Fritz Schider	\N	\N	\N	f	bookshelf_cells/IMG_2396.jpeg	2023-12-26 22:16:21.522263	2023-12-26 22:16:21.522263
9f5ce7a0-b89d-4ed7-979e-a287307266a6	Bukowski in Pictures	Howard Sounes	\N	\N	\N	f	bookshelf_cells/IMG_2397.jpeg	2023-12-26 22:16:21.523983	2023-12-26 22:16:21.523983
84de686f-ed83-492f-aee6-35a3a52c0a70	The Complete Poems of Emily Dickinson	Edited by Thomas H. Johnson	\N	\N	\N	f	bookshelf_cells/IMG_2405.jpeg	2023-12-26 22:16:29.840882	2023-12-26 22:16:29.840882
49df7215-bbfc-42c6-b01a-ea541f5342b3	The Iliad	Homer	\N	\N	\N	f	bookshelf_cells/IMG_2406.jpeg	2023-12-26 22:16:29.844088	2023-12-26 22:16:29.844088
bfd0a575-95f0-467b-b2b8-32fa677caa06	Among the Thugs	Bill Buford	\N	\N	\N	f	bookshelf_cells/IMG_2407.jpeg	2023-12-26 22:16:29.847241	2023-12-26 22:16:29.847241
06a3adb3-af44-43e8-977a-b30b28cca3d0	Hollywood Godfather	Gianni Russo with Patrick Picciarelli	\N	\N	\N	f	bookshelf_cells/IMG_2408.jpeg	2023-12-26 22:16:29.850203	2023-12-26 22:16:29.850203
e58085e0-5861-4ffa-838c-1c8b28400093	Coreyography	Corey Feldman	\N	\N	\N	f	bookshelf_cells/IMG_2409.jpeg	2023-12-26 22:16:29.852188	2023-12-26 22:16:29.852188
47e4bc96-c210-4e2d-b909-4cbee5def260	Drugs Are Nice	Lisa Crystal Carver	\N	\N	\N	f	bookshelf_cells/IMG_2410.jpeg	2023-12-26 22:16:29.853766	2023-12-26 22:16:29.853766
9d88d5c0-b391-4d8b-9f31-97ffbc8cb16d	The Zombie Survival Guide	Max Brooks	\N	\N	\N	f	bookshelf_cells/IMG_2411.jpeg	2023-12-26 22:16:29.855368	2023-12-26 22:16:29.855368
eeff0f1b-3c8c-4be8-b8eb-52c0f159a074	Understanding Movies	Louis D. Giannetti	\N	\N	\N	f	bookshelf_cells/IMG_2412.jpeg	2023-12-26 22:16:29.857499	2023-12-26 22:16:29.857499
6df64d39-6b42-45f0-98aa-0ae057796fbe	Notes from No Man's Land	Eula Biss	\N	\N	\N	f	bookshelf_cells/IMG_2413.jpeg	2023-12-26 22:16:29.859193	2023-12-26 22:16:29.859193
0aab205e-4cc9-4812-b812-38b8afa6321c	Rites of Spring	Modris Eksteins	\N	\N	\N	f	bookshelf_cells/IMG_2415.jpeg	2023-12-26 22:16:43.946959	2023-12-26 22:16:43.946959
70d94a72-b643-44b9-9695-f5fd92f9599a	Siddhartha	Hermann Hesse	\N	\N	\N	f	bookshelf_cells/IMG_2416.jpeg	2023-12-26 22:16:43.949823	2023-12-26 22:16:43.949823
ef62a50e-3cc6-4477-8310-a7b05cca7373	Graffiti Women	Nicholas Ganz	\N	\N	\N	f	bookshelf_cells/IMG_2417.jpeg	2023-12-26 22:16:43.951896	2023-12-26 22:16:43.951896
3461fa62-38af-4636-9a72-4a6372ed850b	American Gods	Neil Gaiman	\N	\N	\N	f	bookshelf_cells/IMG_2418.jpeg	2023-12-26 22:16:43.954521	2023-12-26 22:16:43.954521
710c9135-079c-4e07-853c-00d63f20251b	Slaughterhouse-Five	Kurt Vonnegut	\N	\N	\N	f	bookshelf_cells/IMG_2419.jpeg	2023-12-26 22:16:43.957034	2023-12-26 22:16:43.957034
523fb382-8150-4e10-bceb-8d346aad55d9	Wetlands	Charlotte Roche	\N	\N	\N	f	bookshelf_cells/IMG_2420.jpeg	2023-12-26 22:16:43.959233	2023-12-26 22:16:43.959233
116c9f0b-3a04-49d1-86a7-336f9632b64d	Lives of the Artists	Giorgio Vasari	\N	\N	\N	f	bookshelf_cells/IMG_2421.jpeg	2023-12-26 22:16:43.961614	2023-12-26 22:16:43.961614
019b2044-102a-4221-9a4d-05032de48990	The Book of Answers	Carol Bolt	\N	\N	\N	f	bookshelf_cells/IMG_2422.jpeg	2023-12-26 22:16:43.963366	2023-12-26 22:16:43.963366
21b902ca-ab01-4a13-9329-abccd8e5c055	Design of the 20th Century	Charlotte & Peter Fiell	\N	\N	\N	f	bookshelf_cells/IMG_2425.jpeg	2023-12-26 22:16:54.591102	2023-12-26 22:16:54.591102
d6ad65e0-8f82-4ae5-8021-dcecaedcd2b6	The Collected Poems	Sylvia Plath	\N	\N	\N	f	bookshelf_cells/IMG_2426.jpeg	2023-12-26 22:16:54.593964	2023-12-26 22:16:54.593964
93d4dc26-6fa9-405a-b874-b99aa51c5817	Soft Sculpture	DONA Z. MEILACH	\N	\N	\N	f	bookshelf_cells/IMG_2427.jpeg	2023-12-26 22:16:54.59541	2023-12-26 22:16:54.59541
8520253c-0943-4b85-a283-a7cff4a7a8f8	Fresh	Goliath	\N	\N	\N	f	bookshelf_cells/IMG_2428.jpeg	2023-12-26 22:16:54.596658	2023-12-26 22:16:54.596658
4a0792b5-b244-43d9-a61d-30e99167c58f	Dancing Queen	Lisa Carver	\N	\N	\N	f	bookshelf_cells/IMG_2429.jpeg	2023-12-26 22:16:54.597768	2023-12-26 22:16:54.597768
c6a70784-80ca-47b0-ada9-939687d400ce	Early Work	Patti Smith	\N	\N	\N	f	bookshelf_cells/IMG_2430.jpeg	2023-12-26 22:16:54.598937	2023-12-26 22:16:54.598937
1558128f-19a3-4c86-b8f1-c98d67c868a9	Hell's Angel	Ralph "Sonny" Barger	\N	\N	\N	f	bookshelf_cells/IMG_2431.jpeg	2023-12-26 22:16:54.600098	2023-12-26 22:16:54.600098
d1924430-281b-49c6-a518-2103920083f1	The Balloonists	Eula Biss	\N	\N	\N	f	bookshelf_cells/IMG_2432.jpeg	2023-12-26 22:16:54.601121	2023-12-26 22:16:54.601121
7fc777dd-4776-4f76-9a88-da0093b5dd83	Wild Creations	Hilton Carter	\N	\N	\N	f	bookshelf_cells/IMG_2435.jpeg	2023-12-26 22:17:05.042531	2023-12-26 22:17:05.042531
2930ba88-5803-4272-8976-5a35bcd06c38	Vocabolario della Lingua Italiana	Nicola Zingarelli	\N	\N	\N	f	bookshelf_cells/IMG_2436.jpeg	2023-12-26 22:17:05.045585	2023-12-26 22:17:05.045585
6146b6e4-9356-43f3-b3bb-db544a97ebc7	Concerning the Spiritual in Art	Wassily Kandinsky	\N	\N	\N	f	bookshelf_cells/IMG_2437.jpeg	2023-12-26 22:17:05.048103	2023-12-26 22:17:05.048103
6bb5046b-7969-456a-b61e-64b8cd8630c4	The Immoralist	André Gide	\N	\N	\N	f	bookshelf_cells/IMG_2438.jpeg	2023-12-26 22:17:05.04972	2023-12-26 22:17:05.04972
9f0032e8-a6f5-4056-88da-923e9eb5a9ec	Sharp Objects	Gillian Flynn	\N	\N	\N	f	bookshelf_cells/IMG_2439.jpeg	2023-12-26 22:17:05.05113	2023-12-26 22:17:05.05113
17b8466d-44b4-4210-980e-c0d946e7499b	In Cold Blood	Truman Capote	\N	\N	\N	f	bookshelf_cells/IMG_2440.jpeg	2023-12-26 22:17:05.052502	2023-12-26 22:17:05.052502
130d5679-39b0-4ff8-b58f-d623e6a1c7cd	My Life in France	Julia Child	\N	\N	\N	f	bookshelf_cells/IMG_2441.jpeg	2023-12-26 22:17:05.053869	2023-12-26 22:17:05.053869
c37ed56b-1910-489a-a4e7-9d8192d2ac69	My Life on the Road	Gloria Steinem	\N	\N	\N	f	bookshelf_cells/IMG_2442.jpeg	2023-12-26 22:17:05.055367	2023-12-26 22:17:05.055367
e66f32da-57b7-4c78-a202-d425643140a8	Bauhaus	Frank Whitford	\N	\N	\N	f	bookshelf_cells/IMG_2443.jpeg	2023-12-26 22:17:05.056971	2023-12-26 22:17:05.056971
15fb3d6d-1ae1-4697-af53-2232f549c272	Rocks Off	Bill Janovitz	\N	\N	\N	f	bookshelf_cells/IMG_2444.jpeg	2023-12-26 22:17:05.058466	2023-12-26 22:17:05.058466
2511e443-0c83-42f1-a254-81803394d190	BEETHOVEN	Impressions By His Contemporaries,null	\N	\N	\N	f	bookshelf_cells/IMG_2445.jpeg	2023-12-26 22:17:22.141625	2023-12-26 22:17:22.141625
806a0ed4-31e8-4cae-940b-227e8b5e5429	BODY OF SECRETS	James Bamford	\N	\N	\N	f	bookshelf_cells/IMG_2446.jpeg	2023-12-26 22:17:22.14453	2023-12-26 22:17:22.14453
2fba5055-f029-4136-9000-e82c792fbaba	THE FORTRESS OF SOLITUDE	Jonathan Lethem	\N	\N	\N	f	bookshelf_cells/IMG_2447.jpeg	2023-12-26 22:17:22.14658	2023-12-26 22:17:22.14658
11dfc0e2-67ad-42fc-8023-33390506109f	Gravity's Rainbow	Thomas Pynchon	\N	\N	\N	f	bookshelf_cells/IMG_2448.jpeg	2023-12-26 22:17:22.148767	2023-12-26 22:17:22.148767
592231b3-f894-4001-9cbb-02ead89b86e9	THE UNDOING PROJECT	Michael Lewis	\N	\N	\N	f	bookshelf_cells/IMG_2449.jpeg	2023-12-26 22:17:22.151561	2023-12-26 22:17:22.151561
b353cdd5-adca-42c1-8b80-1fb913b05349	HIGH OUTPUT MANAGEMENT	Andrew S. Grove	\N	\N	\N	f	bookshelf_cells/IMG_2450.jpeg	2023-12-26 22:17:22.153983	2023-12-26 22:17:22.153983
154042ef-16aa-4a5f-a34c-45aac82690e0	KAFKA ON THE SHORE	Haruki Murakami	\N	\N	\N	f	bookshelf_cells/IMG_2451.jpeg	2023-12-26 22:17:22.155584	2023-12-26 22:17:22.155584
6c03ec60-7f78-4857-b2ee-7885cb306244	dhalgren	samuel r. delany	\N	\N	\N	f	bookshelf_cells/IMG_2452.jpeg	2023-12-26 22:17:22.157064	2023-12-26 22:17:22.157064
ce224547-344c-477b-a07f-c04b6b85787d	HARD-BOILED WONDERLAND AND THE END OF THE WORLD	Haruki Murakami	\N	\N	\N	f	bookshelf_cells/IMG_2453.jpeg	2023-12-26 22:17:22.158528	2023-12-26 22:17:22.158528
5623bfee-3675-4105-ba13-cac5e1ee0088	EVERYTHING IS BULLSHIT	Priceonomics	\N	\N	\N	f	bookshelf_cells/IMG_2454.jpeg	2023-12-26 22:17:22.159847	2023-12-26 22:17:22.159847
ddceba3d-b8c6-4e0f-b45a-87773961e678	A World Out of Time	Larry Niven	\N	\N	\N	f	bookshelf_cells/IMG_2455.jpeg	2023-12-26 22:17:32.177261	2023-12-26 22:17:32.177261
fc158c87-2375-4a9e-8b93-7f9174d447da	The Year 1000	Robert Lacey and Danny Danziger	\N	\N	\N	f	bookshelf_cells/IMG_2456.jpeg	2023-12-26 22:17:32.180224	2023-12-26 22:17:32.180224
441b2c47-6216-44b6-851d-77b8da2886b2	We	Eugene Zamiatin	\N	\N	\N	f	bookshelf_cells/IMG_2457.jpeg	2023-12-26 22:17:32.18195	2023-12-26 22:17:32.18195
64f224ec-e947-4eae-88dc-9ef2b22fa99e	Feminism is for EVERYBODY	bell hooks	\N	\N	\N	f	bookshelf_cells/IMG_2458.jpeg	2023-12-26 22:17:32.183773	2023-12-26 22:17:32.183773
3802a83d-e357-429a-bd78-33583ff78b23	Platform	Michel Houellebecq	\N	\N	\N	f	bookshelf_cells/IMG_2459.jpeg	2023-12-26 22:17:32.186211	2023-12-26 22:17:32.186211
e0420037-7739-44c8-9a2d-407926094388	The Third Chimpanzee	Jared Diamond	\N	\N	\N	f	bookshelf_cells/IMG_2460.jpeg	2023-12-26 22:17:32.187766	2023-12-26 22:17:32.187766
224734ca-d099-480f-986e-beb591d82685	The Music of the Primes	Marcus du Sautoy	\N	\N	\N	f	bookshelf_cells/IMG_2461.jpeg	2023-12-26 22:17:32.189244	2023-12-26 22:17:32.189244
0c8d788d-e924-45a7-967a-1f4022a293be	The Logic of Scientific Discovery	Karl R. Popper	\N	\N	\N	f	bookshelf_cells/IMG_2462.jpeg	2023-12-26 22:17:32.190841	2023-12-26 22:17:32.190841
bc464bf1-d940-4b13-8663-70552d96c1c2	The Disuniting of America	Arthur M. Schlesinger, Jr.	\N	\N	\N	f	bookshelf_cells/IMG_2463.jpeg	2023-12-26 22:17:32.194274	2023-12-26 22:17:32.194274
b473d02a-9b1f-4e35-97d3-1556607e8bee	INSPIRED	Marty Cagan	\N	\N	\N	f	bookshelf_cells/IMG_2465.jpeg	2023-12-26 22:17:43.814636	2023-12-26 22:17:43.814636
2dd62665-b172-4ddf-8656-5bc1ca6ee35e	Learning Rails	Simon St. Laurent & Edd Dumbill	\N	\N	\N	f	bookshelf_cells/IMG_2466.jpeg	2023-12-26 22:17:43.818155	2023-12-26 22:17:43.818155
98544d98-10a9-4c27-861e-e8d74e0ab3ad	The Signal and the Noise	Nate Silver	\N	\N	\N	f	bookshelf_cells/IMG_2467.jpeg	2023-12-26 22:17:43.820685	2023-12-26 22:17:43.820685
273fda52-fc1b-4990-9b4f-9e1590df7b69	Applied Photographic Optics	Sidney F. Ray	\N	\N	\N	f	bookshelf_cells/IMG_2468.jpeg	2023-12-26 22:17:43.82309	2023-12-26 22:17:43.82309
17cb3116-5331-4bc7-bfc6-4fe380e3b5cd	The American Revolution	Gordon S. Wood	\N	\N	\N	f	bookshelf_cells/IMG_2469.jpeg	2023-12-26 22:17:43.825392	2023-12-26 22:17:43.825392
a7a107c7-9dc9-4bc7-88f3-37156a16c6f5	Beyond Malthus	Lester R. Brown & Gary Gardner & Brian Halweil	\N	\N	\N	f	bookshelf_cells/IMG_2470.jpeg	2023-12-26 22:17:43.827687	2023-12-26 22:17:43.827687
a0944bb3-633a-42e6-bfdb-eebceb012dce	CAPABLE OF HONOR	ALLEN DRURY	\N	\N	\N	f	bookshelf_cells/IMG_2475.jpeg	2023-12-26 22:17:52.860865	2023-12-26 22:17:52.860865
debd3e69-ceb2-40da-b90c-760963023c7d	THE WORLD UNTIL YESTERDAY	Jared Diamond	\N	\N	\N	f	bookshelf_cells/IMG_2476.jpeg	2023-12-26 22:17:52.864407	2023-12-26 22:17:52.864407
3beea362-2f58-4a9a-9bb0-8d0f30113140	THE ART OF ACTION	Stephen Bungay	\N	\N	\N	f	bookshelf_cells/IMG_2477.jpeg	2023-12-26 22:17:52.866707	2023-12-26 22:17:52.866707
9e176697-0f35-4f3d-8f84-95a9ad346584	THE INNER REACHES OF OUTER SPACE	Joseph Campbell	\N	\N	\N	f	bookshelf_cells/IMG_2478.jpeg	2023-12-26 22:17:52.86851	2023-12-26 22:17:52.86851
0514e539-9a5b-4eba-aeeb-5bd3ba5bf293	MY MOTHER MADAME EDWARD THE DEAD MAN	Georges Bataille	\N	\N	\N	f	bookshelf_cells/IMG_2479.jpeg	2023-12-26 22:17:52.870466	2023-12-26 22:17:52.870466
d5f1d3e1-0a37-4789-b8c9-10e172272bbb	Dear Mr. President	Gabe Hudson	\N	\N	\N	f	bookshelf_cells/IMG_2480.jpeg	2023-12-26 22:17:52.872761	2023-12-26 22:17:52.872761
6112173f-a0c5-4ffd-b51b-ddb6f2ba9eb4	The Best War Ever	Michael C.C. Adams	\N	\N	\N	f	bookshelf_cells/IMG_2481.jpeg	2023-12-26 22:17:52.874659	2023-12-26 22:17:52.874659
84545d1e-384c-4c1f-8e09-bd059b797916	THE LOST CITY OF Z	David Grann	\N	\N	\N	f	bookshelf_cells/IMG_2482.jpeg	2023-12-26 22:17:52.876804	2023-12-26 22:17:52.876804
2d1e0ea6-d8b0-4ae0-b9c6-a522e0574a83	The Visual Display of Quantitative Information	Edward R. Tufte	\N	\N	\N	f	bookshelf_cells/IMG_2485.jpeg	2023-12-26 22:18:03.275893	2023-12-26 22:18:03.275893
d7816681-a950-4a5b-9a9e-4436280e3446	The Coast of Chicago	Stuart Dybek	\N	\N	\N	f	bookshelf_cells/IMG_2486.jpeg	2023-12-26 22:18:03.279271	2023-12-26 22:18:03.279271
7f55f836-20a0-4cef-84b1-cf1e47bb6d18	How Adam Smith Can Change Your Life	Russ Roberts	\N	\N	\N	f	bookshelf_cells/IMG_2487.jpeg	2023-12-26 22:18:03.281093	2023-12-26 22:18:03.281093
a3d14bc0-2f92-4830-bbcb-be189808fbec	Chicago	David Mamet	\N	\N	\N	f	bookshelf_cells/IMG_2488.jpeg	2023-12-26 22:18:03.283255	2023-12-26 22:18:03.283255
e30e6351-9003-411f-add6-7d876d42781a	A New Kind of Science	Stephen Wolfram	\N	\N	\N	f	bookshelf_cells/IMG_2489.jpeg	2023-12-26 22:18:03.285087	2023-12-26 22:18:03.285087
1a62f00f-6e4b-477b-b1fd-dd21dbc92725	Complete Tales & Poems	Edgar Allan Poe	\N	\N	\N	f	bookshelf_cells/IMG_2490.jpeg	2023-12-26 22:18:03.286672	2023-12-26 22:18:03.286672
24a01335-ed95-4e65-a540-23048927a397	The Innocent	David Baldacci	\N	\N	\N	f	bookshelf_cells/IMG_2509.jpeg	2023-12-26 22:18:03.289586	2023-12-26 22:18:03.289586
7ff29477-59ad-4e84-917b-05e716e4113d	My Ántonia	Willa Cather	\N	\N	\N	f	bookshelf_cells/IMG_2510.jpeg	2023-12-26 22:18:03.291339	2023-12-26 22:18:03.291339
9b99ba5b-e9ce-4fc8-b90c-403bcfffca7b	The FDR Years	William E. Leuchtenburg	\N	\N	\N	f	bookshelf_cells/IMG_2512.jpeg	2023-12-26 22:18:13.957383	2023-12-26 22:18:13.957383
eb3a6c91-4eeb-41a1-9f40-38df2e5796c9	Basic Writings	Martin Heidegger	\N	\N	\N	f	bookshelf_cells/IMG_2513.jpeg	2023-12-26 22:18:13.960623	2023-12-26 22:18:13.960623
debc69c8-fe97-44b6-9b45-83f3d0a2a51f	The Philosophy of Mathematics	Stephan Körner	\N	\N	\N	f	bookshelf_cells/IMG_2514.jpeg	2023-12-26 22:18:13.962513	2023-12-26 22:18:13.962513
e327569a-7be4-43f6-85cc-686892c81e71	Global Inequality	Branko Milanovic	\N	\N	\N	f	bookshelf_cells/IMG_2515.jpeg	2023-12-26 22:18:13.964537	2023-12-26 22:18:13.964537
a1d4797d-3642-47b5-8a3e-0b2b582660c6	The Karl Lagerfeld Diet	Dr. Jean-Claude Houdret	\N	\N	\N	f	bookshelf_cells/IMG_2516.jpeg	2023-12-26 22:18:13.966296	2023-12-26 22:18:13.966296
7141ac10-7584-41c8-83e9-f50d9aff346b	The White Boy Shuffle	Paul Beatty	\N	\N	\N	f	bookshelf_cells/IMG_2517.jpeg	2023-12-26 22:18:13.968028	2023-12-26 22:18:13.968028
52a788e6-afad-4b8f-837b-73b34a8ec959	Clojure for Finance	Timothy Washington	\N	\N	\N	f	bookshelf_cells/IMG_2518.jpeg	2023-12-26 22:18:13.970119	2023-12-26 22:18:13.970119
6aaede29-dc2b-4366-bf0e-8412196f241a	Vivian Maier: A Photographer's Life and Afterlife	Pamela Bannos	\N	\N	\N	f	bookshelf_cells/IMG_2522.jpeg	2023-12-26 22:18:25.834455	2023-12-26 22:18:25.834455
9eed5809-bfe9-455f-b08b-4648fbeafe89	In the Studio with Michael Jackson	Bruce Swedien	\N	\N	\N	f	bookshelf_cells/IMG_2523.jpeg	2023-12-26 22:18:25.837486	2023-12-26 22:18:25.837486
da5e2786-0822-4ac6-843d-e1b138c2b278	The Large	the Small and the Human Mind,Roger Penrose	\N	\N	\N	f	bookshelf_cells/IMG_2524.jpeg	2023-12-26 22:18:25.839672	2023-12-26 22:18:25.839672
7500193d-e088-4970-ac71-7c2e3e959b5c	But What If We're Wrong?	Chuck Klosterman	\N	\N	\N	f	bookshelf_cells/IMG_2525.jpeg	2023-12-26 22:18:25.841438	2023-12-26 22:18:25.841438
bcfad56e-edde-45fe-84b8-b4647853fdbc	Time's Arrows	Richard Morris	\N	\N	\N	f	bookshelf_cells/IMG_2526.jpeg	2023-12-26 22:18:25.843051	2023-12-26 22:18:25.843051
ae40af25-6132-413c-898a-127aa750c3c7	Only the Dead	Bear F. Braumoeller	\N	\N	\N	f	bookshelf_cells/IMG_2527.jpeg	2023-12-26 22:18:25.845116	2023-12-26 22:18:25.845116
23614aaa-f1cd-47c9-8ebe-c760b8188628	Switch: How to Change Things When Change Is Hard	Chip Heath & Dan Heath	\N	\N	\N	f	bookshelf_cells/IMG_2528.jpeg	2023-12-26 22:18:25.84668	2023-12-26 22:18:25.84668
16e50579-384f-450a-844e-8fb7b7ca1cab	Spiritual Diary	Sergius Bulgakov	\N	\N	\N	f	bookshelf_cells/IMG_2529.jpeg	2023-12-26 22:18:25.848354	2023-12-26 22:18:25.848354
effbc6d1-f80d-4703-89e1-08e461f4db03	Engineering Management for the Rest of Us	Sarah Drasner	\N	\N	\N	f	bookshelf_cells/IMG_2530.jpeg	2023-12-26 22:18:25.849801	2023-12-26 22:18:25.849801
140abba7-2b76-440a-af5b-eac1988a4434	The Dawn of Everything	David Graeber and David Wengrow	\N	\N	\N	f	bookshelf_cells/IMG_2532.jpeg	2023-12-26 22:18:35.647159	2023-12-26 22:18:35.647159
09c1ee40-1841-4968-a3ce-e640bcef1a29	Chicago’s Pilsen Neighborhood	Peter N. Pero	\N	\N	\N	f	bookshelf_cells/IMG_2533.jpeg	2023-12-26 22:18:35.65063	2023-12-26 22:18:35.65063
9c41d4ea-4d2b-4769-a155-0ac6b200196f	An Astronaut's Guide to Life on Earth	Col. Chris Hadfield	\N	\N	\N	f	bookshelf_cells/IMG_2534.jpeg	2023-12-26 22:18:35.653264	2023-12-26 22:18:35.653264
b9536be6-7466-4ed0-b955-685f9b8403d0	Q is for Quantum	John Gribbin	\N	\N	\N	f	bookshelf_cells/IMG_2535.jpeg	2023-12-26 22:18:35.655861	2023-12-26 22:18:35.655861
58b3c4ca-8122-4208-9efe-84fb4c6498d7	Speakable and unspeakable in quantum mechanics	J. S. Bell	\N	\N	\N	f	bookshelf_cells/IMG_2536.jpeg	2023-12-26 22:18:35.658127	2023-12-26 22:18:35.658127
9a178e09-1101-415f-8d9e-114dbb2029e0	Chuck Klosterman IV	Chuck Klosterman	\N	\N	\N	f	bookshelf_cells/IMG_2537.jpeg	2023-12-26 22:18:35.660363	2023-12-26 22:18:35.660363
af999cc4-3834-47d7-85f3-0eca670facf5	A Short Guide to Writing About History	Richard Marius	\N	\N	\N	f	bookshelf_cells/IMG_2538.jpeg	2023-12-26 22:18:35.662437	2023-12-26 22:18:35.662437
7a30ed6f-0601-4be4-b3e1-7b372652f5ce	Originals: American Women Artists	Eleanor Munro	\N	\N	\N	f	bookshelf_cells/IMG_2539.jpeg	2023-12-26 22:18:35.664083	2023-12-26 22:18:35.664083
0a405d9f-5681-45a7-82a1-8faba9c6559b	The Shortest History of Germany	James Hawes	\N	\N	\N	f	bookshelf_cells/IMG_2542.jpeg	2023-12-26 22:18:45.24961	2023-12-26 22:18:45.24961
0a8bd724-2fa5-4bb3-adf8-ac6576e32d4d	The Soul of a New Machine	Tracy Kidder	\N	\N	\N	f	bookshelf_cells/IMG_2543.jpeg	2023-12-26 22:18:45.25226	2023-12-26 22:18:45.25226
f98271df-92f1-4def-8398-5cbea9dfe286	The Great Leveler	Walter Scheidel	\N	\N	\N	f	bookshelf_cells/IMG_2544.jpeg	2023-12-26 22:18:45.253948	2023-12-26 22:18:45.253948
002abfcd-b77d-4dfc-ac52-f8a9d5489376	Explaining Hitler	Ron Rosenbaum	\N	\N	\N	f	bookshelf_cells/IMG_2545.jpeg	2023-12-26 22:18:45.256362	2023-12-26 22:18:45.256362
ae92233b-a84f-4f67-a8cb-e4173b82db03	Sapiens	Yuval Noah Harari	\N	\N	\N	f	bookshelf_cells/IMG_2546.jpeg	2023-12-26 22:18:45.258898	2023-12-26 22:18:45.258898
0eee44b9-66a2-48ae-987e-3e8dc061979c	Nothing Like It In The World	Stephen E. Ambrose	\N	\N	\N	f	bookshelf_cells/IMG_2547.jpeg	2023-12-26 22:18:45.260687	2023-12-26 22:18:45.260687
36488592-c9cd-4a79-bc15-c398e1ab0e83	Physics Fun	and Beyond,Eduardo de Campos Valadares	\N	\N	\N	f	bookshelf_cells/IMG_2548.jpeg	2023-12-26 22:18:45.262479	2023-12-26 22:18:45.262479
56546285-754c-4beb-81f1-511489033539	Welcome to the Monkey House	Kurt Vonnegut	\N	\N	\N	f	bookshelf_cells/IMG_2549.jpeg	2023-12-26 22:18:45.264185	2023-12-26 22:18:45.264185
e3302158-3e0a-4af3-ab88-e4681d835125	Total Harmonic Distortion	Charles Rodrigues	\N	\N	\N	f	bookshelf_cells/IMG_2550.jpeg	2023-12-26 22:18:45.265961	2023-12-26 22:18:45.265961
091e45d2-e81f-40cc-9186-a99ea7c0ce59	Helgoland	Carlo Rovelli	\N	\N	\N	f	bookshelf_cells/IMG_2551.jpeg	2023-12-26 22:18:45.267541	2023-12-26 22:18:45.267541
6e0decbb-8392-4d2e-a2c8-66fcd48f7fc0	Diana Cooper	Philip Ziegler	\N	\N	\N	f	bookshelf_cells/IMG_2552.jpeg	2023-12-26 22:18:56.220239	2023-12-26 22:18:56.220239
753d05f0-4c21-4636-a26c-61c1b361e9c3	The End of Policing	Alex S. Vitale	\N	\N	\N	f	bookshelf_cells/IMG_2553.jpeg	2023-12-26 22:18:56.22333	2023-12-26 22:18:56.22333
0daff81c-c1ca-41b5-ba8f-4de988d85f4a	Preventable	Andy Slavitt	\N	\N	\N	f	bookshelf_cells/IMG_2554.jpeg	2023-12-26 22:18:56.22503	2023-12-26 22:18:56.22503
d31c83b3-99a0-4353-8d8b-10d057d7c75e	Game of Thrones	George R.R. Martin	\N	\N	\N	f	bookshelf_cells/IMG_2555.jpeg	2023-12-26 22:18:56.226747	2023-12-26 22:18:56.226747
6ba141ff-72ce-4b27-bb83-e17f49728dee	Art & Fear	David Bayles & Ted Orland	\N	\N	\N	f	bookshelf_cells/IMG_2556.jpeg	2023-12-26 22:18:56.228027	2023-12-26 22:18:56.228027
c0d73ad2-d27b-4bdd-b9c4-db929f48c88a	The Peregrine	J.A. Baker	\N	\N	\N	f	bookshelf_cells/IMG_2557.jpeg	2023-12-26 22:18:56.229254	2023-12-26 22:18:56.229254
1e29e2b9-b3c8-4b8c-bc91-bfe52981c9e0	The Rime of the Ancient Mariner	Samuel Taylor Coleridge	\N	\N	\N	f	bookshelf_cells/IMG_2558.jpeg	2023-12-26 22:18:56.230726	2023-12-26 22:18:56.230726
4932a43c-b63f-4e08-8351-7a69e73a28c3	The Industries of the Future	Alec Ross	\N	\N	\N	f	bookshelf_cells/IMG_2559.jpeg	2023-12-26 22:18:56.232379	2023-12-26 22:18:56.232379
8fd36807-62bf-490f-8561-6d46483caed8	The BIG SELL OUT	Dan Mokonyane	\N	\N	\N	f	bookshelf_cells/IMG_2560.jpeg	2023-12-26 22:18:56.23444	2023-12-26 22:18:56.23444
a8df9de8-510f-4503-a58b-c6208d5b6a47	Korea	Security Pivot in Northeast Asia, Robert Dujarric	\N	\N	\N	f	bookshelf_cells/IMG_2562.jpeg	2023-12-26 22:19:15.159533	2023-12-26 22:19:15.159533
7cfd7ab7-26d8-4ee9-9642-19ff266a1bd7	Simulacra and Simulation	Jean Baudrillard	\N	\N	\N	f	bookshelf_cells/IMG_2563.jpeg	2023-12-26 22:19:15.162456	2023-12-26 22:19:15.162456
fef67701-2d23-468b-9ca8-0298d57ff0e8	Women of the Klan	Kathleen M. Blee	\N	\N	\N	f	bookshelf_cells/IMG_2564.jpeg	2023-12-26 22:19:15.164625	2023-12-26 22:19:15.164625
9260a644-e59b-4db3-8723-6879987abecb	Gods in Everyman	Jean Shinoda Bolen	\N	\N	\N	f	bookshelf_cells/IMG_2565.jpeg	2023-12-26 22:19:15.166796	2023-12-26 22:19:15.166796
f61ec668-1f3b-4e76-a76c-dc80aa070b32	Contact	Carl Sagan	\N	\N	\N	f	bookshelf_cells/IMG_2566.jpeg	2023-12-26 22:19:15.169128	2023-12-26 22:19:15.169128
64ef30d0-8ef8-4688-a99d-eab32e287480	Shakey	Jimmy McDonough	\N	\N	\N	f	bookshelf_cells/IMG_2567.jpeg	2023-12-26 22:19:15.171769	2023-12-26 22:19:15.171769
d45a760a-c5f1-49f5-9f8c-7f8a6f628e12	The Code Book	Simon Singh	\N	\N	\N	f	bookshelf_cells/IMG_2568.jpeg	2023-12-26 22:19:15.173288	2023-12-26 22:19:15.173288
a4fce5a3-26d0-4a12-b35d-08396eae054e	American Nations	Colin Woodard	\N	\N	\N	f	bookshelf_cells/IMG_2569.jpeg	2023-12-26 22:19:15.174755	2023-12-26 22:19:15.174755
7b307852-0319-4fcf-8578-d9316f229813	Mr. Gatling's Terrible Marvel	Julia Keller	\N	\N	\N	f	bookshelf_cells/IMG_2572.jpeg	2023-12-26 22:19:28.573309	2023-12-26 22:19:28.573309
f586637a-6e2d-4443-a86f-79bfd2e8f719	The Woman Warrior	Maxine Hong Kingston	\N	\N	\N	f	bookshelf_cells/IMG_2573.jpeg	2023-12-26 22:19:28.576979	2023-12-26 22:19:28.576979
ec1f785d-5f2f-4deb-a829-27a1f03ecd49	Nonlinear Dynamics And Chaos	Steven H. Strogatz	\N	\N	\N	f	bookshelf_cells/IMG_2574.jpeg	2023-12-26 22:19:28.581277	2023-12-26 22:19:28.581277
dce1b616-f800-45c3-b523-e2e3acfb23bc	Mathematica for the Sciences	Richard E. Crandall	\N	\N	\N	f	bookshelf_cells/IMG_2575.jpeg	2023-12-26 22:19:28.583879	2023-12-26 22:19:28.583879
2b170eaa-e502-47e2-ace5-75500a69e07a	Kids These Days	Malcolm Harris (B. 1988)	\N	\N	\N	f	bookshelf_cells/IMG_2576.jpeg	2023-12-26 22:19:28.585758	2023-12-26 22:19:28.585758
6b5ff5a4-893d-4129-919a-52f772d1e459	Ghost Fleet	P.W. Singer and August Cole	\N	\N	\N	f	bookshelf_cells/IMG_2577.jpeg	2023-12-26 22:19:28.587142	2023-12-26 22:19:28.587142
a19ebf58-468d-47e7-bc4c-233728fc196e	Hit Men	Fredric Dannen	\N	\N	\N	f	bookshelf_cells/IMG_2578.jpeg	2023-12-26 22:19:28.588482	2023-12-26 22:19:28.588482
a6555fae-8457-4553-9e79-60abfac64ba1	Apostrophes & Apocalypses	John Barnes	\N	\N	\N	f	bookshelf_cells/IMG_2579.jpeg	2023-12-26 22:19:28.590805	2023-12-26 22:19:28.590805
851e6414-8218-4eb9-98db-d4291bcf2fb1	Selected Poems	Osip Mandelstam	\N	\N	\N	f	bookshelf_cells/IMG_2582.jpeg	2023-12-26 22:19:36.866541	2023-12-26 22:19:36.866541
665d8efb-f835-4272-bd63-9e3e0a3e4c44	Grit	Angela Duckworth	\N	\N	\N	f	bookshelf_cells/IMG_2583.jpeg	2023-12-26 22:19:36.870641	2023-12-26 22:19:36.870641
b346dfe4-765b-45d0-ba57-21f988543f77	Purple Squirrel	Michael B. Junge	\N	\N	\N	f	bookshelf_cells/IMG_2584.jpeg	2023-12-26 22:19:36.872899	2023-12-26 22:19:36.872899
81c11e04-cde5-4304-83ad-ca21fa419b75	Conspiracy	Ryan Holiday	\N	\N	\N	f	bookshelf_cells/IMG_2585.jpeg	2023-12-26 22:19:36.87595	2023-12-26 22:19:36.87595
efd56248-fe5b-46d0-806a-5e61572a6fd9	The Entrepreneur's Guide to Customer Development	Brant Cooper & Patrick Vlaskovits	\N	\N	\N	f	bookshelf_cells/IMG_2586.jpeg	2023-12-26 22:19:36.878189	2023-12-26 22:19:36.878189
f2456ffb-a971-4bff-bc56-4d31a9bd009a	His Excellency: George Washington	Joseph J. Ellis	\N	\N	\N	f	bookshelf_cells/IMG_2587.jpeg	2023-12-26 22:19:36.879967	2023-12-26 22:19:36.879967
2f28809b-8786-4705-9903-c77981c5d196	Gulag: A History	Anne Applebaum	\N	\N	\N	f	bookshelf_cells/IMG_2588.jpeg	2023-12-26 22:19:36.881476	2023-12-26 22:19:36.881476
564bfc27-a950-4aae-bdd5-f41e71f2b375	100 Questions Every First-Time Home Buyer Should Ask	Ilyce R. Glink	\N	\N	\N	f	bookshelf_cells/IMG_2589.jpeg	2023-12-26 22:19:36.883025	2023-12-26 22:19:36.883025
8a07ab4b-3454-44f6-a9a0-dc291e488377	The Singularity Trap	Dennis E. Taylor	\N	\N	\N	f	bookshelf_cells/IMG_2590.jpeg	2023-12-26 22:19:36.885369	2023-12-26 22:19:36.885369
396771d5-02d7-4895-9a14-8fc96661c9fb	OCCUPIED TERRITORY	Simon Balto	\N	\N	\N	f	bookshelf_cells/IMG_2592.jpeg	2023-12-26 22:19:46.399201	2023-12-26 22:19:46.399201
8ad1fc6a-90ab-4bc8-bd73-7d46e6516271	Asymptotic Methods for Relaxation Oscillations and Applications	Johan Grasman	\N	\N	\N	f	bookshelf_cells/IMG_2593.jpeg	2023-12-26 22:19:46.401799	2023-12-26 22:19:46.401799
b193f907-4bbd-43d0-a47a-ba90feb77081	CANCER WARD	Aleksandr Solzhenitsyn	\N	\N	\N	f	bookshelf_cells/IMG_2594.jpeg	2023-12-26 22:19:46.404719	2023-12-26 22:19:46.404719
6114b519-c281-4938-bc5c-9652f57ed791	Structure and Interpretation of Computer Programs	Harold Abelson and Gerald Jay Sussman with Julie Sussman	\N	\N	\N	f	bookshelf_cells/IMG_2595.jpeg	2023-12-26 22:19:46.407619	2023-12-26 22:19:46.407619
71851aa3-d28c-4f2c-b767-236fe4910e80	ISADORA	Fredrika Blair	\N	\N	\N	f	bookshelf_cells/IMG_2596.jpeg	2023-12-26 22:19:46.410399	2023-12-26 22:19:46.410399
bece5726-ce60-4dca-a666-787c5127f8f3	Discrete Mathematics	Kenneth A. Ross & Charles R.B. Wright	\N	\N	\N	f	bookshelf_cells/IMG_2597.jpeg	2023-12-26 22:19:46.41313	2023-12-26 22:19:46.41313
56f578b5-6905-4472-bf7f-e8aa7f91dc56	QUANTUM METHODS with MATHEMATICA	James M. Feagin	\N	\N	\N	f	bookshelf_cells/IMG_2598.jpeg	2023-12-26 22:19:46.414759	2023-12-26 22:19:46.414759
fb68c096-9001-4e56-b625-fb4ea8526899	LISP	Patrick Henry Winston and Berthold Klaus Paul Horn	\N	\N	\N	f	bookshelf_cells/IMG_2599.jpeg	2023-12-26 22:19:46.416289	2023-12-26 22:19:46.416289
9b19067e-82f7-4413-863d-ac03c6574cf1	SOFT SKILLS	John Z. Sonmez	\N	\N	\N	f	bookshelf_cells/IMG_2600.jpeg	2023-12-26 22:19:46.418153	2023-12-26 22:19:46.418153
44cc26e6-fce0-43e1-bb99-40081a07ca73	A Short History of Nearly Everything	Bill Bryson	\N	\N	\N	f	bookshelf_cells/IMG_2602.jpeg	2023-12-26 22:19:55.742322	2023-12-26 22:19:55.742322
21061fa4-acd0-4181-9cef-df8f1789a89a	An Introduction to Analysis	William R. Wade	\N	\N	\N	f	bookshelf_cells/IMG_2603.jpeg	2023-12-26 22:19:55.74587	2023-12-26 22:19:55.74587
5f24414c-9448-4e9e-8795-ed5ca74a3562	Nature's Metropolis	William Cronon	\N	\N	\N	f	bookshelf_cells/IMG_2604.jpeg	2023-12-26 22:19:55.747829	2023-12-26 22:19:55.747829
5f03bf55-e364-4bf4-95da-67a4289c1135	Uncovering Soviet Disasters	James E. Oberg	\N	\N	\N	f	bookshelf_cells/IMG_2605.jpeg	2023-12-26 22:19:55.749492	2023-12-26 22:19:55.749492
903ed6d2-1728-4cbd-8a64-343df1b23512	The Fall of Berlin 1945	Antony Beevor	\N	\N	\N	f	bookshelf_cells/IMG_2606.jpeg	2023-12-26 22:19:55.750834	2023-12-26 22:19:55.750834
4c75621e-3957-45b4-9f40-9b7bf0b297e1	A Pillar of Iron	Taylor Caldwell	\N	\N	\N	f	bookshelf_cells/IMG_2607.jpeg	2023-12-26 22:19:55.752397	2023-12-26 22:19:55.752397
f4082196-ceb4-4b97-bf3e-558242b5df5f	Symmetry in Science	Joe Rosen	\N	\N	\N	f	bookshelf_cells/IMG_2608.jpeg	2023-12-26 22:19:55.755516	2023-12-26 22:19:55.755516
3dde656b-048f-435e-a11c-64ae45a4c433	Summer for the Gods	Edward J. Larson	\N	\N	\N	f	bookshelf_cells/IMG_2609.jpeg	2023-12-26 22:19:55.757685	2023-12-26 22:19:55.757685
d9aa9f56-28bf-4acd-bdf0-c77b1ce4a12e	The Blair Handbook	Toby Fulwiler and Alan R. Hayakawa	\N	\N	\N	f	bookshelf_cells/IMG_2612.jpeg	2023-12-26 22:20:10.383504	2023-12-26 22:20:10.383504
e667dc22-c07c-4205-85d0-fb4cbf29e8f3	Introduction to Quantum Mechanics	David J. Griffiths	\N	\N	\N	f	bookshelf_cells/IMG_2613.jpeg	2023-12-26 22:20:10.386569	2023-12-26 22:20:10.386569
5c27a434-a41a-4c10-aaac-5b0c96aabf43	The Killer Inside Me	Jim Thompson	\N	\N	\N	f	bookshelf_cells/IMG_2614.jpeg	2023-12-26 22:20:10.388769	2023-12-26 22:20:10.388769
d06c6b3e-5f7b-43f0-ad68-e87bcb4bc2fe	The Pantry Primer	Daisy Luther	\N	\N	\N	f	bookshelf_cells/IMG_2615.jpeg	2023-12-26 22:20:10.39084	2023-12-26 22:20:10.39084
37d13b84-2b69-43e0-b286-d979dda1cbcd	Love Poems	Anne Sexton	\N	\N	\N	f	bookshelf_cells/IMG_2616.jpeg	2023-12-26 22:20:10.392059	2023-12-26 22:20:10.392059
8f80071c-8673-43e4-bd52-885ce0dacf58	The Comingled Code	Josh Lerner and Mark Schankerman	\N	\N	\N	f	bookshelf_cells/IMG_2617.jpeg	2023-12-26 22:20:10.393226	2023-12-26 22:20:10.393226
8c0a928d-b7f3-4e36-aea3-696668f24f05	Modern Quantum Mechanics	J. J. Sakurai	\N	\N	\N	f	bookshelf_cells/IMG_2618.jpeg	2023-12-26 22:20:10.394824	2023-12-26 22:20:10.394824
dce8224d-35a2-4701-8424-3a8c63f8c533	Supercapitalism	Robert B. Reich	\N	\N	\N	f	bookshelf_cells/IMG_2619.jpeg	2023-12-26 22:20:10.397285	2023-12-26 22:20:10.397285
d1bf3b26-229f-41f7-940c-34425ca7cfad	Things to Come	H. G. Wells	\N	\N	\N	f	bookshelf_cells/IMG_2622.jpeg	2023-12-26 22:20:29.225607	2023-12-26 22:20:29.225607
ceb267cc-3f5b-4a78-8e3d-fa720ac3b504	Understanding Computation	Tom Stuart	\N	\N	\N	f	bookshelf_cells/IMG_2623.jpeg	2023-12-26 22:20:29.22838	2023-12-26 22:20:29.22838
390cbb85-8ac0-43c1-bca8-fdad165174cc	JavaScript: The Good Parts	Douglas Crockford	\N	\N	\N	f	bookshelf_cells/IMG_2624.jpeg	2023-12-26 22:20:29.230301	2023-12-26 22:20:29.230301
646300d9-dca3-48d6-8e99-e7b9671fe095	Junkbots	Bugbots & Bots on Wheels,Dave Hrynkiw;Mark W. Tilden	\N	\N	\N	f	bookshelf_cells/IMG_2625.jpeg	2023-12-26 22:20:29.232547	2023-12-26 22:20:29.232547
ab4b8f63-9ccb-45cd-9bd4-586fca808332	The Silk Roads	Peter Frankopan	\N	\N	\N	f	bookshelf_cells/IMG_2626.jpeg	2023-12-26 22:20:29.234063	2023-12-26 22:20:29.234063
6f20829b-9b17-4334-9a1d-eabb70aec9c4	Refactoring	Martin Fowler;Kent Beck	\N	\N	\N	f	bookshelf_cells/IMG_2627.jpeg	2023-12-26 22:20:29.235982	2023-12-26 22:20:29.235982
ee879d62-2504-48f4-8eaa-21ef3789c9b4	Atomic Design	Brad Frost	\N	\N	\N	f	bookshelf_cells/IMG_2628.jpeg	2023-12-26 22:20:29.238173	2023-12-26 22:20:29.238173
5a3725f5-c5be-48da-bbb5-d982eeed4dd6	MobX Quick Start Guide	Pavan Podila;Michel Weststrate	\N	\N	\N	f	bookshelf_cells/IMG_2629.jpeg	2023-12-26 22:20:29.240553	2023-12-26 22:20:29.240553
0f2317f4-ac6f-4861-8891-82548d77eb24	The Innovator's Solution	Clayton M. Christensen;Michael E. Raynor	\N	\N	\N	f	bookshelf_cells/IMG_2630.jpeg	2023-12-26 22:20:29.242062	2023-12-26 22:20:29.242062
6b64eb69-ffc5-40ad-8016-95833f826353	Clojure for the Brave and True	Daniel Higginbotham	\N	\N	\N	f	bookshelf_cells/IMG_2631.jpeg	2023-12-26 22:20:29.243864	2023-12-26 22:20:29.243864
55ceff7a-f712-43d2-8a80-1484df2139b5	The Warrior Who Would Rule Russia	Benjamin S. Lambeth	\N	\N	\N	f	bookshelf_cells/IMG_2632.jpeg	2023-12-26 22:20:39.670042	2023-12-26 22:20:39.670042
45741fb0-98ff-4f16-917c-af3105e55d60	Pale Blue Dot	Carl Sagan	\N	\N	\N	f	bookshelf_cells/IMG_2633.jpeg	2023-12-26 22:20:39.673293	2023-12-26 22:20:39.673293
63aa7c66-ed4a-453d-b893-46db45b98e00	The Pragmatic Programmer	Andrew Hunt; David Thomas	\N	\N	\N	f	bookshelf_cells/IMG_2634.jpeg	2023-12-26 22:20:39.675116	2023-12-26 22:20:39.675116
d4ee0b3d-1d14-443d-84ec-e934275db1f1	The World War II Quiz & Fact Book	Timothy B. Benford	\N	\N	\N	f	bookshelf_cells/IMG_2635.jpeg	2023-12-26 22:20:39.677324	2023-12-26 22:20:39.677324
cd80ee24-dba5-4263-bc8f-05fd4d6baf0e	New Directions in Japanese Architecture	Robin Boyd	\N	\N	\N	f	bookshelf_cells/IMG_2636.jpeg	2023-12-26 22:20:39.679872	2023-12-26 22:20:39.679872
3de921e2-aef4-42dd-bd6c-e8c82ee23fd9	Quantum Physics of Atoms	Molecules, Solids, Nuclei, and Particles,Robert Eisberg; Robert Resnick	\N	\N	\N	f	bookshelf_cells/IMG_2637.jpeg	2023-12-26 22:20:39.681271	2023-12-26 22:20:39.681271
2fcfb66d-f104-4c29-9413-dea7967b4736	War	Sebastian Junger	\N	\N	\N	f	bookshelf_cells/IMG_2638.jpeg	2023-12-26 22:20:39.68284	2023-12-26 22:20:39.68284
b52128c4-1b2a-4631-a313-ab2f60ed29c6	Picasso's Picassos	David Douglas Duncan	\N	\N	\N	f	bookshelf_cells/IMG_2642.jpeg	2023-12-26 22:20:51.272588	2023-12-26 22:20:51.272588
e6c3a90f-df39-4144-b8f9-eb59f79a00b5	Testimony of Two Men	Taylor Caldwell	\N	\N	\N	f	bookshelf_cells/IMG_2643.jpeg	2023-12-26 22:20:51.275181	2023-12-26 22:20:51.275181
67e23a4b-9968-4bd5-b9aa-8239ee158adb	2010: Odyssey Two	Arthur C. Clarke	\N	\N	\N	f	bookshelf_cells/IMG_2644.jpeg	2023-12-26 22:20:51.277001	2023-12-26 22:20:51.277001
41342108-e015-4168-bfa4-455269ab9d39	JavaScript: The Definitive Guide	David Flanagan	\N	\N	\N	f	bookshelf_cells/IMG_2645.jpeg	2023-12-26 22:20:51.278735	2023-12-26 22:20:51.278735
b6fa50fa-50c4-4d5d-863f-5bdcd87d3155	Electricity and Magnetism	Ralph P. Winch	\N	\N	\N	f	bookshelf_cells/IMG_2646.jpeg	2023-12-26 22:20:51.280347	2023-12-26 22:20:51.280347
0185d8e3-c7b8-4ebb-a507-caaab565f79e	The Complete Guide to High-End Audio	Robert Harley	\N	\N	\N	f	bookshelf_cells/IMG_2647.jpeg	2023-12-26 22:20:51.281998	2023-12-26 22:20:51.281998
d2c7bf35-f224-4d2e-ac41-79b1f5d846d5	Handbook of Modern Sensors	Jacob Fraden	\N	\N	\N	f	bookshelf_cells/IMG_2652.jpeg	2023-12-26 22:21:02.704074	2023-12-26 22:21:02.704074
da74beb7-5a9f-4d18-bf94-c340ac17e152	Ghosts from the Nursery	Robin Karr-Morse and Meredith S. Wiley	\N	\N	\N	f	bookshelf_cells/IMG_2653.jpeg	2023-12-26 22:21:02.707463	2023-12-26 22:21:02.707463
d365666d-c5b4-4048-a733-03a4396bda58	The Rainbow and the Worm	Mae-Wan Ho	\N	\N	\N	f	bookshelf_cells/IMG_2654.jpeg	2023-12-26 22:21:02.709517	2023-12-26 22:21:02.709517
1df4831a-51f1-4c08-8f64-0971c383b583	Infinite Potential	F. David Peat	\N	\N	\N	f	bookshelf_cells/IMG_2655.jpeg	2023-12-26 22:21:02.711498	2023-12-26 22:21:02.711498
82a00229-cd5e-4377-8aa6-b6c97573ae31	Modern Man in Search of a Soul	C. G. Jung	\N	\N	\N	f	bookshelf_cells/IMG_2656.jpeg	2023-12-26 22:21:02.713345	2023-12-26 22:21:02.713345
9696eda2-3f39-46c0-b9ba-b3b310baa52f	The Picture of Dorian Gray	Oscar Wilde	\N	\N	\N	f	bookshelf_cells/IMG_2658.jpeg	2023-12-26 22:21:02.715058	2023-12-26 22:21:02.715058
e11d50a6-9099-4214-8453-f0e4080e8d42	Romeo and Juliet	William Shakespeare	\N	\N	\N	f	bookshelf_cells/IMG_2663.jpeg	2023-12-26 22:21:13.053438	2023-12-26 22:21:13.053438
4177d084-7205-4caa-be18-32ed75e80d3e	Ah	Wilderness!",Eugene O'Neill	\N	\N	\N	f	bookshelf_cells/IMG_2664.jpeg	2023-12-26 22:21:13.056217	2023-12-26 22:21:13.056217
fda1eafa-cfc8-41d6-a87b-a49ce818b402	Mary Stuart	Friedrich Schiller	\N	\N	\N	f	bookshelf_cells/IMG_2665.jpeg	2023-12-26 22:21:13.058242	2023-12-26 22:21:13.058242
2b0023ec-d8b2-4692-9260-f987fc381767	All My Sons	Arthur Miller	\N	\N	\N	f	bookshelf_cells/IMG_2666.jpeg	2023-12-26 22:21:13.060297	2023-12-26 22:21:13.060297
3c46f4ac-141e-4788-a910-280ac0196edb	Wit	Margaret Edson	\N	\N	\N	f	bookshelf_cells/IMG_2667.jpeg	2023-12-26 22:21:13.064736	2023-12-26 22:21:13.064736
c5a79fa2-5afa-413e-afee-0d83c8bf3998	The Importance of Being Earnest	Oscar Wilde	\N	\N	\N	f	bookshelf_cells/IMG_2668.jpeg	2023-12-26 22:21:13.067224	2023-12-26 22:21:13.067224
3c5bb170-c19f-421b-a7b4-e816c1535fcc	Animals Out Of Paper	Rajiv Joseph	\N	\N	\N	f	bookshelf_cells/IMG_2669.jpeg	2023-12-26 22:21:13.0692	2023-12-26 22:21:13.0692
1ddf476c-8520-4d28-adc2-77fa12698b7c	reasons to be pretty	Neil Labute	\N	\N	\N	f	bookshelf_cells/IMG_2670.jpeg	2023-12-26 22:21:13.071211	2023-12-26 22:21:13.071211
a6b089f0-038f-4f86-93ca-095f7251f3a7	A Streetcar Named Desire	Tennessee Williams	\N	\N	\N	f	bookshelf_cells/IMG_2671.jpeg	2023-12-26 22:21:13.072947	2023-12-26 22:21:13.072947
0ee99e0f-ec90-4ddb-95e4-068346520f85	The Piano Lesson	August Wilson	\N	\N	\N	f	bookshelf_cells/IMG_2673.jpeg	2023-12-26 22:21:25.694589	2023-12-26 22:21:25.694589
53dfcba3-2e82-4a3f-a809-b6e1d45e0bc2	Doubt	John Patrick Shanley	\N	\N	\N	f	bookshelf_cells/IMG_2674.jpeg	2023-12-26 22:21:25.69754	2023-12-26 22:21:25.69754
7a84ffd3-56e7-42df-ba31-eda79705b982	The Myth of Sisyphus	Albert Camus	\N	\N	\N	f	bookshelf_cells/IMG_2675.jpeg	2023-12-26 22:21:25.699353	2023-12-26 22:21:25.699353
689c9dd4-a5d4-43e4-9141-f93efd634eab	Bauer	Lauren Gunderson	\N	\N	\N	f	bookshelf_cells/IMG_2676.jpeg	2023-12-26 22:21:25.700933	2023-12-26 22:21:25.700933
73fc713a-2263-4661-9c74-e31fc3f0e803	Libra	Don DeLillo	\N	\N	\N	f	bookshelf_cells/IMG_2677.jpeg	2023-12-26 22:21:25.703208	2023-12-26 22:21:25.703208
e95ca8de-95ac-440d-8221-0df9505d3e5c	Hiroshima Mon Amour	Marguerite Duras	\N	\N	\N	f	bookshelf_cells/IMG_2678.jpeg	2023-12-26 22:21:25.705631	2023-12-26 22:21:25.705631
a76e3009-5e4a-4394-aad7-120efbe52454	1Q84	Haruki Murakami	\N	\N	\N	f	bookshelf_cells/IMG_2679.jpeg	2023-12-26 22:21:25.707719	2023-12-26 22:21:25.707719
c930f4aa-7413-4d3d-baa1-27b44a394a0a	The Brothers Size	Tarell Alvin McCraney	\N	\N	\N	f	bookshelf_cells/IMG_2680.jpeg	2023-12-26 22:21:25.710508	2023-12-26 22:21:25.710508
cbd61f66-474b-4d39-9316-a35777670891	On the Technique of Acting	Michael Chekhov	\N	\N	\N	f	bookshelf_cells/IMG_2683.jpeg	2023-12-26 22:21:34.556191	2023-12-26 22:21:34.556191
7f8941c0-43d0-434b-8d28-2a2b98c7f992	'ART'	Yasmina Reza	\N	\N	\N	f	bookshelf_cells/IMG_2684.jpeg	2023-12-26 22:21:34.558928	2023-12-26 22:21:34.558928
a9effc45-5e90-40ed-ac9e-1200b06b9b47	Dom Juan	Molière	\N	\N	\N	f	bookshelf_cells/IMG_2685.jpeg	2023-12-26 22:21:34.560438	2023-12-26 22:21:34.560438
d21d8e26-4fef-4737-9cc3-f266b81cf0cb	The Comedies of William Shakespeare	William Shakespeare	\N	\N	\N	f	bookshelf_cells/IMG_2686.jpeg	2023-12-26 22:21:34.561689	2023-12-26 22:21:34.561689
2e40d6f4-5238-429e-89c8-29c4c5344d74	On Tour	Gregory Burke	\N	\N	\N	f	bookshelf_cells/IMG_2687.jpeg	2023-12-26 22:21:34.563245	2023-12-26 22:21:34.563245
3e3b2322-a4a4-4252-b677-2031014743f2	Purity of Heart	Søren Kierkegaard	\N	\N	\N	f	bookshelf_cells/IMG_2689.jpeg	2023-12-26 22:21:34.565457	2023-12-26 22:21:34.565457
2b436e6e-7111-4a91-8168-7dc4479c8814	Nine Plays	Eugene O'Neill	\N	\N	\N	f	bookshelf_cells/IMG_2690.jpeg	2023-12-26 22:21:34.566602	2023-12-26 22:21:34.566602
86232a59-62d9-41c7-819a-427af875db99	Physics	Paul A. Tipler	\N	\N	\N	f	bookshelf_cells/IMG_2691.jpeg	2023-12-26 22:21:34.567559	2023-12-26 22:21:34.567559
117d7b8d-ac43-423b-ab31-938f50182774	ARMAGEDDON	Max Hastings	\N	\N	\N	f	bookshelf_cells/IMG_2693.jpeg	2023-12-26 22:21:48.995176	2023-12-26 22:21:48.995176
6202adc4-6ad7-4222-a1be-addaf1909ea4	Problem Solver's Guide to Differential Equations	Research and Education Association	\N	\N	\N	f	bookshelf_cells/IMG_2694.jpeg	2023-12-26 22:21:48.99839	2023-12-26 22:21:48.99839
1aea57f8-0f66-47a6-93a3-67fe82b4658a	Nuclear War Survival Skills	Cresson H. Kearny	\N	\N	\N	f	bookshelf_cells/IMG_2695.jpeg	2023-12-26 22:21:49.000288	2023-12-26 22:21:49.000288
720e2e0d-0d4f-4edf-872b-88d1164c6b70	The Complete Encyclopedia of Pistols and Revolvers	A.E. Hartink	\N	\N	\N	f	bookshelf_cells/IMG_2696.jpeg	2023-12-26 22:21:49.001961	2023-12-26 22:21:49.001961
9327f2a7-4f2d-4ca0-a1c9-5032a384a358	Forbidden Photographs	Charles Gatewood	\N	\N	\N	f	bookshelf_cells/IMG_2697.jpeg	2023-12-26 22:21:49.003695	2023-12-26 22:21:49.003695
69a6ac91-9e98-4370-9062-a8968e6acbec	Joe Ellis Pinturas Flashes Bocetos Vol. IV	Joe Ellis	\N	\N	\N	f	bookshelf_cells/IMG_2698.jpeg	2023-12-26 22:21:49.005378	2023-12-26 22:21:49.005378
41494848-52dc-4abb-895b-8a884967fb05	Photoelectron Spectroscopy	Stefan Hüfner	\N	\N	\N	f	bookshelf_cells/IMG_2703.jpeg	2023-12-26 22:21:55.34466	2023-12-26 22:21:55.34466
a910782a-d7c7-452f-be22-d28cce3cbb4e	History of the World War	Frank H. Simonds	\N	\N	\N	f	bookshelf_cells/IMG_2704.jpeg	2023-12-26 22:21:55.347765	2023-12-26 22:21:55.347765
d18b2ed2-6ee7-48d9-ab24-c8418f76c39e	crucial conversations	Joseph Grenny; Kerry Patterson; Ron McMillan; Al Switzler; Emily Gregory	\N	\N	\N	f	bookshelf_cells/IMG_2705.jpeg	2023-12-26 22:21:55.350385	2023-12-26 22:21:55.350385
e0b7d9af-e450-40ad-a020-9951978d53db	The Elements of Music	Jason Martineau	\N	\N	\N	f	bookshelf_cells/IMG_2706.jpeg	2023-12-26 22:21:55.353262	2023-12-26 22:21:55.353262
6f87feca-7cb2-4410-986f-cdc5f157e4a0	Encyclopedia of World History	Introduction by Patrick K. O’Brien	\N	\N	\N	f	bookshelf_cells/IMG_2714.jpeg	2023-12-26 22:22:01.797309	2023-12-26 22:22:01.797309
63bbcdb6-72f6-49d2-8e0a-facd3aec5593	The Lord of the Rings	J.R.R. Tolkien	\N	\N	\N	f	bookshelf_cells/IMG_2715.jpeg	2023-12-26 22:22:01.801049	2023-12-26 22:22:01.801049
84fd8fe5-afbd-4ff3-b2e1-13035ee895c2	WHAT TO EXPECT THE FIRST YEAR	Heidi Murkoff	\N	\N	\N	f	bookshelf_cells/IMG_2105.jpeg	2023-12-26 22:24:04.776458	2023-12-26 22:24:04.776458
aa406345-13c8-4968-8a72-c3113108d796	THE DEATH AND LIFE OF GREAT AMERICAN CITIES	Jane Jacobs	\N	\N	\N	f	bookshelf_cells/IMG_2107.jpeg	2023-12-26 22:24:04.779599	2023-12-26 22:24:04.779599
eef9719b-4a98-4560-8f95-971e84194971	Hieronymus Bosch	Stefan Fischer	\N	\N	\N	f	bookshelf_cells/IMG_2108.jpeg	2023-12-26 22:24:04.78247	2023-12-26 22:24:04.78247
fbba7e0c-cf62-47a8-8261-8cc7e90fe77d	WILD PROBLEMS	Russ Roberts	\N	\N	\N	f	bookshelf_cells/IMG_2109.jpeg	2023-12-26 22:24:04.784292	2023-12-26 22:24:04.784292
e0fb2600-825a-4bc9-8776-d50815b3bcf5	What Is ChatGPT Doing...	Stephen Wolfram	\N	\N	\N	f	bookshelf_cells/IMG_2110.jpeg	2023-12-26 22:24:04.785898	2023-12-26 22:24:04.785898
0b8564ae-7a21-4c89-b5c5-71c53e8cfe07	Vincent van Gogh	Nienke Bakker,Leo Jansen,Hans Luijten	\N	\N	\N	f	bookshelf_cells/IMG_2111.jpeg	2023-12-26 22:24:04.787235	2023-12-26 22:24:04.787235
fa63b530-1fe3-460b-872e-ac7659356020	DAEMON	Daniel Suarez	\N	\N	\N	f	bookshelf_cells/IMG_2112.jpeg	2023-12-26 22:24:04.788783	2023-12-26 22:24:04.788783
ba05c224-5e0a-4e31-8918-8da40e6e9141	KOMMANDO	James Lucas	\N	\N	\N	f	bookshelf_cells/IMG_2113.jpeg	2023-12-26 22:24:04.789975	2023-12-26 22:24:04.789975
228f4d69-0ef8-4c66-816d-d7e6527bfa86	Hyperion	Dan Simmons	\N	\N	\N	f	bookshelf_cells/IMG_2114.jpeg	2023-12-26 22:24:04.791205	2023-12-26 22:24:04.791205
fb923f6c-bf91-47ce-89f2-0e7200358426	EAT TO WIN	Dr. Robert Haas	\N	\N	\N	f	bookshelf_cells/IMG_2115.jpeg	2023-12-26 22:24:04.792452	2023-12-26 22:24:04.792452
0e1e927a-e875-421d-a433-a7ed84213402	Walden and Civil Disobedience	Henry David Thoreau	\N	\N	\N	f	bookshelf_cells/IMG_2187.jpeg	2023-12-26 22:24:40.041383	2023-12-26 22:24:40.041383
88360024-a38b-4749-8dbb-6e035c53e87a	The Best of the Lucasfilm Archives	Mark Cotta Vaz and Shinji Hata	\N	\N	\N	f	bookshelf_cells/IMG_2198.jpeg	2023-12-26 22:24:40.048145	2023-12-26 22:24:40.048145
304194e2-1cf4-41a3-b370-9351f4e4f3e3	Palestine Peace Not Apartheid	Jimmy Carter	\N	\N	\N	f	bookshelf_cells/IMG_2324.jpeg	2023-12-26 22:25:01.741898	2023-12-26 22:25:01.741898
f8834174-fa79-47ad-a7aa-9e8abb6848a2	Flowers	Herbert S. Zim & Alexander C. Martin	\N	\N	\N	f	bookshelf_cells/IMG_2390.jpeg	2023-12-26 22:25:10.026713	2023-12-26 22:25:10.026713
48147171-c57c-43b2-b878-e71578a65d8e	The Travel Book	Josh Hall	\N	\N	\N	f	bookshelf_cells/IMG_2392.jpeg	2023-12-26 22:25:10.03344	2023-12-26 22:25:10.03344
a5e3d6f3-86b4-4d54-afe2-db86c2995b86	REVERSE	Cowgirl	\N	\N	\N	f	bookshelf_cells/IMG_2393.jpeg	2023-12-26 22:25:10.036314	2023-12-26 22:25:10.036314
8b197a86-3cb0-4a64-9f6f-69b4085022c8	Fear and Loathing	Paul Perry	\N	\N	\N	f	bookshelf_cells/IMG_2464.jpeg	2023-12-26 22:25:21.381408	2023-12-26 22:25:21.381408
773cbe3a-f334-43ed-be7b-5479ae91baec	The Criminal	Jim Thompson	\N	\N	\N	f	bookshelf_cells/IMG_2473.jpeg	2023-12-26 22:25:34.464391	2023-12-26 22:25:34.464391
165f9d31-0dd6-4c79-999c-789111665720	DESIGN PATTERNS	Erich Gamma,Richard Helm,Ralph Johnson,John Vlissides	\N	\N	\N	f	bookshelf_cells/IMG_2158.jpeg	2023-12-26 22:26:03.247898	2023-12-26 22:26:03.247898
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (id, name) FROM stdin;
1	Fantasy
2	Self-Help
3	Art
4	Design
5	Horror
6	Science Fiction
7	Non-Fiction
8	Mystery
9	Biography
10	History
11	Children’s Literature
12	Young Adult
13	Classics
14	Poetry
15	Drama
16	Philosophy
17	Science
18	Health & Fitness
19	Business
20	Cookbooks
21	Travel
22	Humor
23	Romance
24	Thriller
25	Literary Fiction
26	Graphic Novels
27	Education
28	Politics
29	Cultural Studies
30	Religion
31	Sports
32	Music
33	Law
34	Psychology
35	Technology
36	True Crime
37	Crafts & Hobbies
38	Guide / How-to
39	Memoir
40	Adventure
41	Action
42	Western
43	Dystopian
44	Fantasy Romance
45	Biographical Fiction
46	Historical Fiction
47	Inspirational
48	Satire
49	Military Fiction
50	Hard Science Fiction
51	Space Opera
52	Short Stories
53	Anthology
54	Erotica
55	Sagas
56	Noir
57	Legal Thriller
58	Espionage
59	Supernatural
60	Action & Adventure
61	Alternate History
62	Comic Book
63	Contemporary Fiction
64	Magical Realism
65	Metaphysical & Visionary
66	Myths & Legends
67	New Adult
68	Personal Growth
69	Psychological
70	Social Sciences
71	Parenting & Families
72	Women’s Fiction
73	Urban Planning
74	Techno-Thriller
75	Bibliographical Fiction
76	Engineering
77	Unknown
78	Uncertain
79	Reference
80	Refere
81	Linguistics
\.


--
-- Data for Name: processedimages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.processedimages (id, image_key, processed_at) FROM stdin;
\.


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_id_seq', 81, true);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: genres genres_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: processedimages processedimages_image_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.processedimages
    ADD CONSTRAINT processedimages_image_key_key UNIQUE (image_key);


--
-- Name: processedimages processedimages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.processedimages
    ADD CONSTRAINT processedimages_pkey PRIMARY KEY (id);


--
-- Name: books books_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id);


--
-- PostgreSQL database dump complete
--

