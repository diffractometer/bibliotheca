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
7225efcb-2cbf-4e22-8001-af74b8396d1f	What to Expect the First Year	Heidi Murkoff	\N	\N	\N	f	bookshelf_cells/IMG_2105.jpeg	2023-12-25 15:47:55.265668	2023-12-25 15:47:55.265668
0cb803b8-af76-497b-bbc6-5d6413c92718	The Death and Life of Great American Cities	Jane Jacobs	\N	\N	\N	f	bookshelf_cells/IMG_2106.jpeg	2023-12-25 15:47:55.269819	2023-12-25 15:47:55.269819
1ea32915-51d1-4689-83f6-9cb086130970	Hieronymus Bosch	Stefan Fischer	\N	\N	\N	f	bookshelf_cells/IMG_2107.jpeg	2023-12-25 15:47:55.272243	2023-12-25 15:47:55.272243
fdb8b8b0-eafc-4729-a0e6-70f0959683dd	Wild Problems	Russ Roberts	\N	\N	\N	f	bookshelf_cells/IMG_2108.jpeg	2023-12-25 15:47:55.274515	2023-12-25 15:47:55.274515
187a5cba-846e-4066-8eec-8b801929cdc5	What Is ChatGPT Doing... and Why Does It Work?	Stephen Wolfram	\N	\N	\N	f	bookshelf_cells/IMG_2109.jpeg	2023-12-25 15:47:55.276655	2023-12-25 15:47:55.276655
7d279db6-24fd-4fb9-b001-56eb6e629531	Vincent van Gogh	Nienke Bakker, Leo Jansen, Hans Luijten	\N	\N	\N	f	bookshelf_cells/IMG_2110.jpeg	2023-12-25 15:47:55.278829	2023-12-25 15:47:55.278829
e4436303-4ea8-46ea-a93f-97f389178aaa	Daemon	Daniel Suarez	\N	\N	\N	f	bookshelf_cells/IMG_2111.jpeg	2023-12-25 15:47:55.280686	2023-12-25 15:47:55.280686
c8e0f12a-0b2b-4670-b7a2-5abef9149023	Kommando	James Lucas	\N	\N	\N	f	bookshelf_cells/IMG_2112.jpeg	2023-12-25 15:47:55.282291	2023-12-25 15:47:55.282291
6ec00492-16bb-4089-917f-040ef59f6007	Hyperion	Dan Simmons	\N	\N	\N	f	bookshelf_cells/IMG_2113.jpeg	2023-12-25 15:47:55.283818	2023-12-25 15:47:55.283818
4c8d5eaf-1e9d-422e-9785-d6301d08da10	Eat to Win	Dr. Robert Haas	\N	\N	\N	f	bookshelf_cells/IMG_2114.jpeg	2023-12-25 15:47:55.284815	2023-12-25 15:47:55.284815
4ea123ec-1643-4e66-9f17-70c95900a32b	Ban the Bomb	Milton S. Katz	\N	\N	\N	f	bookshelf_cells/IMG_2115.jpeg	2023-12-25 15:47:55.285787	2023-12-25 15:47:55.285787
28b46c30-9a62-4cf3-a81a-d23a50b0862b	Tales from the Loop	Simon Stålenhag	\N	\N	\N	f	bookshelf_cells/IMG_2121.jpeg	2023-12-25 15:47:55.287018	2023-12-25 15:47:55.287018
8b88030f-c99d-4d60-b2fc-e439b05d47f5	Modern Physics	Ronald Gautreau, William Savin	\N	\N	\N	f	bookshelf_cells/IMG_2130.jpeg	2023-12-25 15:47:55.288251	2023-12-25 15:47:55.288251
304cd25c-7892-43b2-b8e2-ce2fa4e0cdff	A Brief Introduction to Modern Philosophy	Arthur Kenyon Rogers, Ph.D.	\N	\N	\N	f	bookshelf_cells/IMG_2131.jpeg	2023-12-25 15:47:55.289441	2023-12-25 15:47:55.289441
62ca38bb-0b8c-4fa7-9992-2df165935410	Company C	John Sack	\N	\N	\N	f	bookshelf_cells/IMG_2132.jpeg	2023-12-25 15:47:55.290587	2023-12-25 15:47:55.290587
d5b0a5af-4f58-41e5-992c-a2e75a4b2082	Permutation City	Greg Egan	\N	\N	\N	f	bookshelf_cells/IMG_2133.jpeg	2023-12-25 15:47:55.291686	2023-12-25 15:47:55.291686
5dd28561-3c84-4ffa-ab3c-c20c116cf9b0	How to Lose a War	Bill Fawcett	\N	\N	\N	f	bookshelf_cells/IMG_2138.jpeg	2023-12-25 15:48:10.519404	2023-12-25 15:48:10.519404
a8873499-84d4-4fec-bb0d-4d696795dbd4	Why Is Sex Fun?	Jared Diamond	\N	\N	\N	f	bookshelf_cells/IMG_2139.jpeg	2023-12-25 15:48:10.525028	2023-12-25 15:48:10.525028
e9f6acf5-30be-4126-9c0d-e837a2159a92	Journey to the End of the Night	Louis-Ferdinand Céline	\N	\N	\N	f	bookshelf_cells/IMG_2140.jpeg	2023-12-25 15:48:10.527083	2023-12-25 15:48:10.527083
9f1b3a54-8c89-4974-8cfa-39035ead2e79	Don't Sleep	There Are Snakes,Daniel L. Everett	\N	\N	\N	f	bookshelf_cells/IMG_2141.jpeg	2023-12-25 15:48:10.528875	2023-12-25 15:48:10.528875
322556c6-0b49-416d-8844-e64d89441cc6	The Plague of Fantasies	Slavoj Žižek	\N	\N	\N	f	bookshelf_cells/IMG_2142.jpeg	2023-12-25 15:48:10.530618	2023-12-25 15:48:10.530618
d6c48d64-c9b2-4bb5-a04a-5756f88594d9	World War Z	Max Brooks	\N	\N	\N	f	bookshelf_cells/IMG_2143.jpeg	2023-12-25 15:48:10.532231	2023-12-25 15:48:10.532231
d3041f66-987e-4f26-940e-373f8077cf1e	Influence	Robert B. Cialdini	\N	\N	\N	f	bookshelf_cells/IMG_2144.jpeg	2023-12-25 15:48:10.533766	2023-12-25 15:48:10.533766
cd2af970-f379-490d-9fae-a5c4be847a8c	Behind the Oval Office	Dick Morris	\N	\N	\N	f	bookshelf_cells/IMG_2145.jpeg	2023-12-25 15:48:10.535439	2023-12-25 15:48:10.535439
5c935335-bc05-4c29-9f3a-31b40cd071ae	On Bullshit	Harry G. Frankfurt	\N	\N	\N	f	bookshelf_cells/IMG_2146.jpeg	2023-12-25 15:48:10.536845	2023-12-25 15:48:10.536845
09ffff3b-e4d9-427f-8e18-fe09b4bdf7ea	Betraying Ambition	Diego Agulló	\N	\N	\N	f	bookshelf_cells/IMG_2147.jpeg	2023-12-25 15:48:10.538089	2023-12-25 15:48:10.538089
0be940b1-b310-4793-92b8-fe4ae5fbdf38	Wild Seed	Octavia E. Butler	\N	\N	\N	f	bookshelf_cells/IMG_2148.jpeg	2023-12-25 15:48:10.539453	2023-12-25 15:48:10.539453
7f024bb8-6dfb-472e-8067-05be28e461ab	Night Moves	Jessica Hopper	\N	\N	\N	f	bookshelf_cells/IMG_2149.jpeg	2023-12-25 15:48:10.54081	2023-12-25 15:48:10.54081
b6077206-d140-442f-a31c-2e57f1a23da4	Man and Citizen	Thomas Hobbes	\N	\N	\N	f	bookshelf_cells/IMG_2150.jpeg	2023-12-25 15:48:10.542135	2023-12-25 15:48:10.542135
730c29ed-b101-47fa-8be0-c42aa9194b1b	Design Patterns: Elements of Reusable Object-Oriented Software	Erich Gamma,Richard Helm,Ralph Johnson,John Vlissides	\N	\N	\N	f	bookshelf_cells/IMG_2158.jpeg	2023-12-25 15:48:25.771696	2023-12-25 15:48:25.771696
4246c2a2-1bc0-411a-91f2-0793bb903be5	colombia cent'anni di solitudine	William Ospina,Alfredo Molano,Javier Giraldo,Gustavo Morales,Danilo De Marco	\N	\N	\N	f	bookshelf_cells/IMG_2159.jpeg	2023-12-25 15:48:25.774421	2023-12-25 15:48:25.774421
ea735b50-77e9-4265-bb14-316ee6b3f09b	Dune Messiah	Frank Herbert	\N	\N	\N	f	bookshelf_cells/IMG_2160.jpeg	2023-12-25 15:48:25.775781	2023-12-25 15:48:25.775781
c4aa9cce-d8ff-4c62-9e0f-de339f249839	Words from the Myths	Isaac Asimov	\N	\N	\N	f	bookshelf_cells/IMG_2161.jpeg	2023-12-25 15:48:25.777823	2023-12-25 15:48:25.777823
bb539398-812e-424e-866f-bdf14e6704c1	The Martian Chronicles	Ray Bradbury	\N	\N	\N	f	bookshelf_cells/IMG_2162.jpeg	2023-12-25 15:48:25.780253	2023-12-25 15:48:25.780253
fbc6fd36-03d8-4bd3-9b85-b80f42be49cb	Herzog	Saul Bellow	\N	\N	\N	f	bookshelf_cells/IMG_2163.jpeg	2023-12-25 15:48:25.782627	2023-12-25 15:48:25.782627
620f0fef-ecb6-4dd8-acc0-b037308d0e50	The Velvet Rage	Alan Downs, PhD	\N	\N	\N	f	bookshelf_cells/IMG_2164.jpeg	2023-12-25 15:48:25.784607	2023-12-25 15:48:25.784607
e41d46c0-e63d-4c54-9d4e-68f0f99d441f	The Fall of Hyperion	Dan Simmons	\N	\N	\N	f	bookshelf_cells/IMG_2165.jpeg	2023-12-25 15:48:25.786713	2023-12-25 15:48:25.786713
4d55843d-67b9-477b-8d8c-97a946be8b81	Dune	Frank Herbert	\N	\N	\N	f	bookshelf_cells/IMG_2166.jpeg	2023-12-25 15:48:25.788181	2023-12-25 15:48:25.788181
ee442384-087f-4b0f-ba90-982da8fbdd46	Webster's New World Thesaurus	Charlton Laird	\N	\N	\N	f	bookshelf_cells/IMG_2167.jpeg	2023-12-25 15:48:25.789627	2023-12-25 15:48:25.789627
d7c026b9-a74f-4b00-b9f3-320daad835cd	The Algorithm Design Manual	Steven S. Skiena	\N	\N	\N	f	bookshelf_cells/IMG_2168.jpeg	2023-12-25 15:48:25.791183	2023-12-25 15:48:25.791183
22d282e6-bb11-4cbd-8d51-01b7b6f092cc	Building Microservices	Sam Newman	\N	\N	\N	f	bookshelf_cells/IMG_2169.jpeg	2023-12-25 15:48:25.792645	2023-12-25 15:48:25.792645
d2d5c69c-a4b9-4c25-aa6a-ab304fb98e6a	Cracking the Coding Interview	Gayle Laakmann McDowell	\N	\N	\N	f	bookshelf_cells/IMG_2170.jpeg	2023-12-25 15:48:25.794349	2023-12-25 15:48:25.794349
9dbad71f-bfff-4404-b604-babd45af70b7	Kill Decision	Daniel Suarez	\N	\N	\N	f	bookshelf_cells/IMG_2178.jpeg	2023-12-25 15:48:43.338911	2023-12-25 15:48:43.338911
1072653a-5a46-45ed-841d-5c8c90a55da7	Health Insurance	Michael A. Morrisey	\N	\N	\N	f	bookshelf_cells/IMG_2179.jpeg	2023-12-25 15:48:43.341988	2023-12-25 15:48:43.341988
fad944fc-9a92-42b2-9f3f-114d9fce1f01	Elementary Differential Equations and Boundary Value Problems	William E. Boyce,Richard C. DiPrima	\N	\N	\N	f	bookshelf_cells/IMG_2180.jpeg	2023-12-25 15:48:43.343873	2023-12-25 15:48:43.343873
7ac638c5-a592-48e9-b2b0-810e815aa147	State Of Denial	Bob Woodward	\N	\N	\N	f	bookshelf_cells/IMG_2181.jpeg	2023-12-25 15:48:43.345144	2023-12-25 15:48:43.345144
a526311a-8a6d-44a1-86aa-290fc8fe3985	No Ordinary Time	Doris Kearns Goodwin	\N	\N	\N	f	bookshelf_cells/IMG_2182.jpeg	2023-12-25 15:48:43.346321	2023-12-25 15:48:43.346321
65520bb1-382c-42df-abac-1b1d779f927a	The RSpec Book	David Chelimsky,Dave Astels,Zach Dennis,Aslak Hellesoy,Bryan Helmkamp,Dan North	\N	\N	\N	f	bookshelf_cells/IMG_2183.jpeg	2023-12-25 15:48:43.347537	2023-12-25 15:48:43.347537
4b62fcf7-9bc0-4c04-be23-eb032f6422e4	Prometheus Rising	Robert Anton Wilson	\N	\N	\N	f	bookshelf_cells/IMG_2184.jpeg	2023-12-25 15:48:43.349118	2023-12-25 15:48:43.349118
4a95a6c8-f93e-4cc1-98cb-65a16c5db249	Principles of Magnetic Resonance	C. P. Slichter	\N	\N	\N	f	bookshelf_cells/IMG_2185.jpeg	2023-12-25 15:48:43.350904	2023-12-25 15:48:43.350904
ac2b6a57-bbaf-48f0-9160-d63f807672d4	Divine Assassin	Bob Reiss	\N	\N	\N	f	bookshelf_cells/IMG_2186.jpeg	2023-12-25 15:48:43.352186	2023-12-25 15:48:43.352186
46703ee8-b471-4186-8f2f-602d4b70cdcb	Walden and Civil Disobedience	Henry David Thoreau	\N	\N	\N	f	bookshelf_cells/IMG_2187.jpeg	2023-12-25 15:48:43.353213	2023-12-25 15:48:43.353213
6f569d05-53e1-42d1-b4b1-b704e0b524bd	Eloquent Ruby	Russ Olsen	\N	\N	\N	f	bookshelf_cells/IMG_2188.jpeg	2023-12-25 15:48:43.354151	2023-12-25 15:48:43.354151
15f1af3f-b444-417f-a008-2e5332d2efe7	Understanding Vincent Van Gogh	Frederick Dawe	\N	\N	\N	f	bookshelf_cells/IMG_2189.jpeg	2023-12-25 15:48:43.355219	2023-12-25 15:48:43.355219
54244e82-a70e-4958-bcc2-4d0b4037c832	The Gathering of the Juggalos	Daniel Cronin	\N	\N	\N	f	bookshelf_cells/IMG_2190.jpeg	2023-12-25 15:48:43.356331	2023-12-25 15:48:43.356331
0fc1850a-0ba9-4141-8f27-2e343b2e8b15	To Engineer Is Human	Henry Petroski	\N	\N	\N	f	bookshelf_cells/IMG_2191.jpeg	2023-12-25 15:48:43.357641	2023-12-25 15:48:43.357641
13a821f1-b064-49a2-a7d1-5af790c5fe5d	Conspiracy	Ryan Holiday	\N	\N	\N	f	bookshelf_cells/IMG_2584.jpeg	2023-12-25 16:16:06.651821	2023-12-25 16:16:06.651821
80458746-3aba-41ce-ac18-1d688266cd3f	The Civil War	Geoffrey C. Ward,Ric Burns,Ken Burns	\N	\N	\N	f	bookshelf_cells/IMG_2192.jpeg	2023-12-25 15:48:43.358872	2023-12-25 15:48:43.358872
a4b972e3-a0e8-4eb9-affa-041562f35f67	The Book of Genesis Illustrated	R. Crumb	\N	\N	\N	f	bookshelf_cells/IMG_2193.jpeg	2023-12-25 15:48:43.360476	2023-12-25 15:48:43.360476
f0615f58-e1a6-4a54-bf4d-8189e79b3a0e	Mr. Scott's Guide to the Enterprise	Shane Johnson	\N	\N	\N	f	bookshelf_cells/IMG_2198.jpeg	2023-12-25 15:49:06.14691	2023-12-25 15:49:06.14691
65d61607-ec12-4fc3-b334-46d80529ae13	From Star Wars to Indiana Jones: The Best of the Lucasfilm Archives	Mark Cotta Vaz,Shinji Hata	\N	\N	\N	f	bookshelf_cells/IMG_2199.jpeg	2023-12-25 15:49:06.1509	2023-12-25 15:49:06.1509
8bdb51ba-35b2-4a30-a8bc-7bcad7d88d77	How to Prepare for the GRE Test	Sharon Weiner Green,Ira Wolf	\N	\N	\N	f	bookshelf_cells/IMG_2200.jpeg	2023-12-25 15:49:06.157354	2023-12-25 15:49:06.157354
1b06a651-4c67-42cc-bc20-903833a02000	Cracking the GRE 2006 Edition	Karen Lurie,Magda Pecsenye,Adam Robinson	\N	\N	\N	f	bookshelf_cells/IMG_2201.jpeg	2023-12-25 15:49:06.164031	2023-12-25 15:49:06.164031
5ab638e0-095a-4f9f-9919-b6d734743af3	Cracking the GRE Math Subject Test 3rd Edition	Steven A. Leduc	\N	\N	\N	f	bookshelf_cells/IMG_2202.jpeg	2023-12-25 15:49:06.16604	2023-12-25 15:49:06.16604
511819ee-cbd1-4336-bd9d-50c5773b6b9b	Syntactic Structures	Noam Chomsky	\N	\N	\N	f	bookshelf_cells/IMG_2203.jpeg	2023-12-25 15:49:06.168203	2023-12-25 15:49:06.168203
34a22805-5351-49eb-85d8-aecdfac25c12	Geometry for Dummies 3rd Edition	Mark Ryan	\N	\N	\N	f	bookshelf_cells/IMG_2204.jpeg	2023-12-25 15:49:06.170205	2023-12-25 15:49:06.170205
8106e000-1921-4bf3-ab97-5456dcee0001	Ina May's Guide to Childbirth	Ina May Gaskin	\N	\N	\N	f	bookshelf_cells/IMG_2205.jpeg	2023-12-25 15:49:06.172083	2023-12-25 15:49:06.172083
71612c58-0799-4be2-b96a-ad38c20e0bcd	No Good Men Among the Living	Anand Gopal	\N	\N	\N	f	bookshelf_cells/IMG_2206.jpeg	2023-12-25 15:49:06.174059	2023-12-25 15:49:06.174059
1c888bf9-b607-4480-85c9-7afff78d4f26	Inspector Mouse	Bernard Stone	\N	\N	\N	f	bookshelf_cells/IMG_2207.jpeg	2023-12-25 15:49:06.175581	2023-12-25 15:49:06.175581
e7044ff9-8bb3-4534-961a-6554bffeec1a	Running Lean	Ash Maurya	\N	\N	\N	f	bookshelf_cells/IMG_2208.jpeg	2023-12-25 15:49:06.177011	2023-12-25 15:49:06.177011
81f6c1c9-2600-4cbf-8e0c-41e68e5cc737	The Armed Society	Tristram Coffin	\N	\N	\N	f	bookshelf_cells/IMG_2209.jpeg	2023-12-25 15:49:06.178405	2023-12-25 15:49:06.178405
4e7149f1-2e5d-4ac8-9a68-1e87cd35d199	Lessons of Azikwelwa	Dan Mokonyane	\N	\N	\N	f	bookshelf_cells/IMG_2210.jpeg	2023-12-25 15:49:06.179635	2023-12-25 15:49:06.179635
640b51b4-5d67-4f80-9850-613aef121c7a	Studies in Classic American Literature	D. H. Lawrence	\N	\N	\N	f	bookshelf_cells/IMG_2241.jpeg	2023-12-25 15:49:27.177516	2023-12-25 15:49:27.177516
0318d8aa-cfa1-4c38-b475-8b693b549c5a	Love in the Time of Cholera	Gabriel Garcia Marquez	\N	\N	\N	f	bookshelf_cells/IMG_2242.jpeg	2023-12-25 15:49:27.17987	2023-12-25 15:49:27.17987
05caa8ec-f33f-422f-9569-345592e322ca	The History of Corporal Punishment	George Ryley Scott	\N	\N	\N	f	bookshelf_cells/IMG_2243.jpeg	2023-12-25 15:49:27.181632	2023-12-25 15:49:27.181632
7b47433e-5746-4492-9631-2f93fbb2c9aa	The Antisocial Personalities	David T. Lykken	\N	\N	\N	f	bookshelf_cells/IMG_2244.jpeg	2023-12-25 15:49:27.183949	2023-12-25 15:49:27.183949
3386d1b3-9c57-4b72-ada1-e0b8000ce33a	The Rails 3 Way	Obie Fernandez	\N	\N	\N	f	bookshelf_cells/IMG_2245.jpeg	2023-12-25 15:49:27.186292	2023-12-25 15:49:27.186292
9037cefe-6f89-4716-b299-f05770b0d424	Hitler's First War	Thomas Weber	\N	\N	\N	f	bookshelf_cells/IMG_2246.jpeg	2023-12-25 15:49:27.188302	2023-12-25 15:49:27.188302
73d83b47-7634-42e0-b04c-d9926a88be4b	Vietnam War Diary	Fred Leo Brown	\N	\N	\N	f	bookshelf_cells/IMG_2247.jpeg	2023-12-25 15:49:27.189963	2023-12-25 15:49:27.189963
253f39d6-bd69-4dc6-a3bc-a92ee820fc77	Men of Mathematics	E. T. Bell	\N	\N	\N	f	bookshelf_cells/IMG_2248.jpeg	2023-12-25 15:49:27.191475	2023-12-25 15:49:27.191475
05270e10-f17f-4976-97cc-377a84deca52	In the Realm of Hungry Ghosts	Gabor Maté	\N	\N	\N	f	bookshelf_cells/IMG_2249.jpeg	2023-12-25 15:49:27.192859	2023-12-25 15:49:27.192859
5eabbc11-eadb-4345-bab1-3ef7a7ebc5c9	A Mad Catastrophe	Geoffrey Wawro	\N	\N	\N	f	bookshelf_cells/IMG_2250.jpeg	2023-12-25 15:49:27.194299	2023-12-25 15:49:27.194299
149d8ea2-f498-47cf-9e49-662b2b162c5c	Antifragile	Nassim Nicholas Taleb	\N	\N	\N	f	bookshelf_cells/IMG_2251.jpeg	2023-12-25 15:49:27.195826	2023-12-25 15:49:27.195826
ed076b09-cc68-494a-a271-2e8bc4bf1006	The Complete Idiot's Guide to World War II	Mitchell G. Bard	\N	\N	\N	f	bookshelf_cells/IMG_2252.jpeg	2023-12-25 15:49:27.197292	2023-12-25 15:49:27.197292
0df36afa-1a11-4d7c-a2b8-8c3ab50c3b7c	Clean Code	Robert C. Martin	\N	\N	\N	f	bookshelf_cells/IMG_2253.jpeg	2023-12-25 15:49:27.198516	2023-12-25 15:49:27.198516
066426e9-5533-4799-9f85-51f8bd486c02	Effective Java	Joshua Bloch	\N	\N	\N	f	bookshelf_cells/IMG_2254.jpeg	2023-12-25 15:49:27.199698	2023-12-25 15:49:27.199698
81a86335-f6c6-45d1-843b-3d16967a7491	The Singularity is Near	Ray Kurzweil	\N	\N	\N	f	bookshelf_cells/IMG_2255.jpeg	2023-12-25 15:49:27.201439	2023-12-25 15:49:27.201439
bcfa5205-dcd6-48c8-beda-84cab8c1b84c	An Introduction to Linear Algebra & Tensors	M. A. Akivis	\N	\N	\N	f	bookshelf_cells/IMG_2256.jpeg	2023-12-25 15:49:27.202961	2023-12-25 15:49:27.202961
3b964f1d-c1fa-48c4-980d-454ba8bf5da2	Statistical Consequences of Fat Tails	Nassim Nicholas Taleb	\N	\N	\N	f	bookshelf_cells/IMG_2257.jpeg	2023-12-25 15:49:27.204297	2023-12-25 15:49:27.204297
dd75b065-64ba-4afe-b319-fb613eca17af	Staff Engineer	Will Larson	\N	\N	\N	f	bookshelf_cells/IMG_2261.jpeg	2023-12-25 15:49:44.65174	2023-12-25 15:49:44.65174
99e6c355-61be-495e-a098-0a05f4b145f5	Student's Solutions Manual Fundamentals of Physics	J. Richard Christman	\N	\N	\N	f	bookshelf_cells/IMG_2262.jpeg	2023-12-25 15:49:44.654107	2023-12-25 15:49:44.654107
b1e80b9d-442c-4dcc-83ae-24bdde90a391	American Splendor	Harvey Pekar	\N	\N	\N	f	bookshelf_cells/IMG_2263.jpeg	2023-12-25 15:49:44.655341	2023-12-25 15:49:44.655341
a2fd17e8-5c94-4078-96c8-09566eb178c8	The Spoils of War	Bruce Bueno de Mesquita, Alastair Smith	\N	\N	\N	f	bookshelf_cells/IMG_2264.jpeg	2023-12-25 15:49:44.656654	2023-12-25 15:49:44.656654
70845951-fd3f-4ea5-999b-88a3bbd7b5fd	Cycles of Time	Roger Penrose	\N	\N	\N	f	bookshelf_cells/IMG_2265.jpeg	2023-12-25 15:49:44.658252	2023-12-25 15:49:44.658252
d2857d7a-79f8-4de8-b87b-01ca1d923340	Fundamentals of Physics	David Halliday, Robert Resnick, Jearl Walker	\N	\N	\N	f	bookshelf_cells/IMG_2266.jpeg	2023-12-25 15:49:44.660699	2023-12-25 15:49:44.660699
e13f0cc2-e7fd-4007-8539-c6bba54503b5	Student Solutions Manual Boyce and DiPrima's Elementary Differential Equations and Boundary Value Problems	Charles W. Haines	\N	\N	\N	f	bookshelf_cells/IMG_2267.jpeg	2023-12-25 15:49:44.662012	2023-12-25 15:49:44.662012
fbfc56a4-56fb-4272-a290-7b900df4e72c	The Elegant Universe	Brian Greene	\N	\N	\N	f	bookshelf_cells/IMG_2268.jpeg	2023-12-25 15:49:44.662993	2023-12-25 15:49:44.662993
e3b6a295-2e4d-45d7-ad43-2df54590a5e6	Critical	Senator Tom Daschle	\N	\N	\N	f	bookshelf_cells/IMG_2269.jpeg	2023-12-25 15:49:44.664126	2023-12-25 15:49:44.664126
8942264f-fc9f-4e0d-90b0-cbafb3875f1d	Thereby Hangs a Tale	Charles Earle Funk	\N	\N	\N	f	bookshelf_cells/IMG_2270.jpeg	2023-12-25 15:49:44.665695	2023-12-25 15:49:44.665695
0c4204b9-da18-4b1e-951a-8fe4e65e34e3	Starship Troopers	Robert A. Heinlein	\N	\N	\N	f	bookshelf_cells/IMG_2271.jpeg	2023-12-25 15:49:44.667356	2023-12-25 15:49:44.667356
503e5b83-ad85-4250-ab94-f12f7d3dd71f	Klingsor's Last Summer	Hermann Hesse	\N	\N	\N	f	bookshelf_cells/IMG_2272.jpeg	2023-12-25 15:49:44.668439	2023-12-25 15:49:44.668439
09b858b9-1dc2-4d55-9ce4-7e9d75555adb	Olympos	Dan Simmons	\N	\N	\N	f	bookshelf_cells/IMG_2273.jpeg	2023-12-25 15:49:44.669663	2023-12-25 15:49:44.669663
cd6c5894-1abc-434a-bd01-24cebab72354	Going Downtown	Jack Broughton	\N	\N	\N	f	bookshelf_cells/IMG_2274.jpeg	2023-12-25 15:49:44.670651	2023-12-25 15:49:44.670651
7c3d3547-4eaa-4ab0-9106-f95538e4a109	Music Technology	Paul White	\N	\N	\N	f	bookshelf_cells/IMG_2275.jpeg	2023-12-25 15:49:44.671628	2023-12-25 15:49:44.671628
75aa49fe-68be-471c-8714-7ba412e73fa7	Battle Cry of Freedom	James M. McPherson	\N	\N	\N	f	bookshelf_cells/IMG_2276.jpeg	2023-12-25 15:49:44.672668	2023-12-25 15:49:44.672668
a1e391a6-820d-4c91-9719-3cde441eb0a0	Speaker Project	Juan Angel Chávez	\N	\N	\N	f	bookshelf_cells/IMG_2281.jpeg	2023-12-25 15:50:04.295796	2023-12-25 15:50:04.295796
b3d9654c-0912-48c0-846c-e6b21b85fa3b	Einstein: His Life and Universe	Walter Isaacson	\N	\N	\N	f	bookshelf_cells/IMG_2282.jpeg	2023-12-25 15:50:04.298449	2023-12-25 15:50:04.298449
d153dd39-f34d-4c98-9f3e-f6425ab719fc	An Inquiry into the Nature and Causes of the Wealth of Nations	Adam Smith	\N	\N	\N	f	bookshelf_cells/IMG_2283.jpeg	2023-12-25 15:50:04.300867	2023-12-25 15:50:04.300867
bc7fb767-4022-4a71-9e38-954a501aec35	The Idiot	Fyodor Dostoyevsky	\N	\N	\N	f	bookshelf_cells/IMG_2284.jpeg	2023-12-25 15:50:04.302737	2023-12-25 15:50:04.302737
cd35385d-b3b2-4fff-b8f7-e29a25be3426	Green Mars	Kim Stanley Robinson	\N	\N	\N	f	bookshelf_cells/IMG_2285.jpeg	2023-12-25 15:50:04.304229	2023-12-25 15:50:04.304229
d729a12c-6134-4891-942a-f993af6f794d	1493: Uncovering the New World Columbus Created	Charles C. Mann	\N	\N	\N	f	bookshelf_cells/IMG_2286.jpeg	2023-12-25 15:50:04.305858	2023-12-25 15:50:04.305858
b02406fb-18c9-41e8-a20f-96778985166d	The Wide Window	Lemony Snicket	\N	\N	\N	f	bookshelf_cells/IMG_2287.jpeg	2023-12-25 15:50:04.307264	2023-12-25 15:50:04.307264
7f0ae2ce-d691-44b4-9038-a1d1e3088f38	la carreta made a U-turn	Tato Laviera	\N	\N	\N	f	bookshelf_cells/IMG_2288.jpeg	2023-12-25 15:50:04.30869	2023-12-25 15:50:04.30869
496141df-e121-41a7-a297-42da47e99a59	Reconstructing Reality in the Courtroom	W. Lance Bennett & Martha S. Feldman	\N	\N	\N	f	bookshelf_cells/IMG_2289.jpeg	2023-12-25 15:50:04.310366	2023-12-25 15:50:04.310366
ccb1d348-6335-4ebf-8791-b30f87c2612a	Programming Kotlin	Stephen Samuel, Stefan Bocutiu	\N	\N	\N	f	bookshelf_cells/IMG_2290.jpeg	2023-12-25 15:50:04.311551	2023-12-25 15:50:04.311551
1a9ec3ac-06f0-4629-b725-bae421241bed	A History of Narrative Film	David A. Cook	\N	\N	\N	f	bookshelf_cells/IMG_2291.jpeg	2023-12-25 15:50:04.312661	2023-12-25 15:50:04.312661
fa3d0865-b3b9-486e-b7e3-82649576905b	Caitlin: Life with Dylan Thomas	Caitlin Thomas with George Tremlett	\N	\N	\N	f	bookshelf_cells/IMG_2292.jpeg	2023-12-25 15:50:04.313855	2023-12-25 15:50:04.313855
359e88cc-da43-424d-894b-5efbd9f2d730	Scanning Tunneling Microscopy and its Application	Chunli Bai	\N	\N	\N	f	bookshelf_cells/IMG_2293.jpeg	2023-12-25 15:50:04.315086	2023-12-25 15:50:04.315086
a43b1572-40c1-4689-a0a4-165815b857c8	The Bomb: a Life	Gerard J. DeGroot	\N	\N	\N	f	bookshelf_cells/IMG_2294.jpeg	2023-12-25 15:50:04.316216	2023-12-25 15:50:04.316216
a661f234-dc7e-4d31-b0bd-beb1145a4deb	Vincent Price: A Daughter's Biography	Victoria Price	\N	\N	\N	f	bookshelf_cells/IMG_2295.jpeg	2023-12-25 15:50:04.317377	2023-12-25 15:50:04.317377
577ebc00-70f7-415a-aa80-b0023c6dd31f	To the Distant Observer	Noel Burch	\N	\N	\N	f	bookshelf_cells/IMG_2296.jpeg	2023-12-25 15:50:04.318443	2023-12-25 15:50:04.318443
2c54de01-3d6e-4280-8d61-9afcb9f91169	Programming Ruby 1.9	Dave Thomas with Chad Fowler and Andy Hunt	\N	\N	\N	f	bookshelf_cells/IMG_2297.jpeg	2023-12-25 15:50:04.31942	2023-12-25 15:50:04.31942
b91ffb7f-21ed-439d-b1c6-dff89f721c58	Multitude	Chitra B. Divakaruni	\N	\N	\N	f	bookshelf_cells/IMG_2301.jpeg	2023-12-25 15:50:22.89196	2023-12-25 15:50:22.89196
092f6e80-e29f-461c-ac87-13a93ebad279	Israel's Attack on Osiraq: A Model for Future Preventive Strikes?	Peter S. Ford	\N	\N	\N	f	bookshelf_cells/IMG_2302.jpeg	2023-12-25 15:50:22.894292	2023-12-25 15:50:22.894292
d41a3f79-8ad0-479b-b936-09503098f367	International Security Negotiations: Lessons Learned from Negotiating with the Russians on Nuclear Arms	Michael O. Wheeler	\N	\N	\N	f	bookshelf_cells/IMG_2303.jpeg	2023-12-25 15:50:22.895629	2023-12-25 15:50:22.895629
172045df-4812-4d30-8fcd-c22435a69ed6	Cruel Shoes	Steve Martin	\N	\N	\N	f	bookshelf_cells/IMG_2304.jpeg	2023-12-25 15:50:22.897416	2023-12-25 15:50:22.897416
952b5f27-5299-4c08-b88f-93875a5e7f4f	Where the Red Fern Grows	Wilson Rawls	\N	\N	\N	f	bookshelf_cells/IMG_2305.jpeg	2023-12-25 15:50:22.898837	2023-12-25 15:50:22.898837
107bb07f-814e-48e5-ac76-a683c88912e1	Astrophysics for People in a Hurry	Neil deGrasse Tyson	\N	\N	\N	f	bookshelf_cells/IMG_2306.jpeg	2023-12-25 15:50:22.900487	2023-12-25 15:50:22.900487
236b9d40-1571-4ca7-b415-8730f235c0da	Eight Bells	and All's Well,Daniel V. Gallery	\N	\N	\N	f	bookshelf_cells/IMG_2307.jpeg	2023-12-25 15:50:22.902109	2023-12-25 15:50:22.902109
f4b46de5-d4d8-42f6-b9e3-a36f10694257	The Carving of Mount Rushmore	Rex Alan Smith	\N	\N	\N	f	bookshelf_cells/IMG_2308.jpeg	2023-12-25 15:50:22.903265	2023-12-25 15:50:22.903265
3c8a2470-af36-418e-9c2f-8c226228a542	Intelligence in War	John Keegan	\N	\N	\N	f	bookshelf_cells/IMG_2309.jpeg	2023-12-25 15:50:22.904217	2023-12-25 15:50:22.904217
c6be42a0-923b-4437-bdf8-1bc801644c03	The Genius of the Beast	Howard Bloom	\N	\N	\N	f	bookshelf_cells/IMG_2310.jpeg	2023-12-25 15:50:22.9051	2023-12-25 15:50:22.9051
40cd581a-8ead-429f-8615-0edde58cf86f	This Business of Music Marketing and Promotion	Tad Lathrop & Jim Pettigrew, Jr.	\N	\N	\N	f	bookshelf_cells/IMG_2311.jpeg	2023-12-25 15:50:22.905931	2023-12-25 15:50:22.905931
977a6efd-7e0f-4c43-9339-e8c1fa1b9af5	Junky	William S. Burroughs	\N	\N	\N	f	bookshelf_cells/IMG_2312.jpeg	2023-12-25 15:50:22.906817	2023-12-25 15:50:22.906817
2a0e42fa-e45c-4ec3-b7f9-55ca40659d20	Hollywood Babylon	Kenneth Anger	\N	\N	\N	f	bookshelf_cells/IMG_2313.jpeg	2023-12-25 15:50:22.908078	2023-12-25 15:50:22.908078
8c1d6e13-774a-4660-8743-4fe01fe7f5e7	Dare Not Linger	Nelson Mandela and Mandla Langa	\N	\N	\N	f	bookshelf_cells/IMG_2314.jpeg	2023-12-25 15:50:22.908976	2023-12-25 15:50:22.908976
0d49a4f1-3114-4f52-a995-251e36f29a20	Man's Search for Meaning	Viktor E. Frankl	\N	\N	\N	f	bookshelf_cells/IMG_2315.jpeg	2023-12-25 15:50:22.91002	2023-12-25 15:50:22.91002
d8da4ae4-4e2e-4b3e-994b-72b1b67328ec	Leonardo da Vinci	Walter Isaacson	\N	\N	\N	f	bookshelf_cells/IMG_2316.jpeg	2023-12-25 15:50:22.911104	2023-12-25 15:50:22.911104
65a2b220-0878-43d3-ac8e-befcb9b655d6	The Whole Shebang	Timothy Ferris	\N	\N	\N	f	bookshelf_cells/IMG_2317.jpeg	2023-12-25 15:50:22.912596	2023-12-25 15:50:22.912596
a5fcca1d-e728-4ff4-bca6-aa2364aeb344	11/22/63	Stephen King	\N	\N	\N	f	bookshelf_cells/IMG_2318.jpeg	2023-12-25 15:50:22.914051	2023-12-25 15:50:22.914051
7afa34b9-6e6f-402c-b1fa-388e0ba3442a	A Briefer History of Time	Stephen Hawking with Leonard Mlodinow	\N	\N	\N	f	bookshelf_cells/IMG_2323.jpeg	2023-12-25 15:50:43.796683	2023-12-25 15:50:43.796683
74d7fc75-841e-42ef-a086-3a4497a5c5e1	Palestine Peace Not Apartheid	Jimmy Carter	\N	\N	\N	f	bookshelf_cells/IMG_2324.jpeg	2023-12-25 15:50:43.801388	2023-12-25 15:50:43.801388
5f7afac6-90bb-433b-8e72-bcebe61787a4	Descent Into Hell	Charles Williams	\N	\N	\N	f	bookshelf_cells/IMG_2325.jpeg	2023-12-25 15:50:43.804161	2023-12-25 15:50:43.804161
fd8f2d07-c49d-4f4e-997a-507bde84efd7	The Tao of Physics	Fritjof Capra	\N	\N	\N	f	bookshelf_cells/IMG_2326.jpeg	2023-12-25 15:50:43.806847	2023-12-25 15:50:43.806847
d5363dab-2e7e-4dd5-962a-963ae3016bec	Zen and The Art of Motorcycle Maintenance	Robert M. Pirsig	\N	\N	\N	f	bookshelf_cells/IMG_2327.jpeg	2023-12-25 15:50:43.809234	2023-12-25 15:50:43.809234
d0718d53-8045-44a2-8483-b695520d0c30	Franklin and Winston	Jon Meacham	\N	\N	\N	f	bookshelf_cells/IMG_2328.jpeg	2023-12-25 15:50:43.810953	2023-12-25 15:50:43.810953
61815bad-a487-4da5-b00f-45eb1726c55c	Analysis Of Observed Chaotic Data	Henry D.I. Abarbanel	\N	\N	\N	f	bookshelf_cells/IMG_2329.jpeg	2023-12-25 15:50:43.812041	2023-12-25 15:50:43.812041
81fa4f8c-f9f5-438b-b4ce-3a3232463d05	The Dance of Anger	Harriet Lerner, Ph.D.	\N	\N	\N	f	bookshelf_cells/IMG_2330.jpeg	2023-12-25 15:50:43.813049	2023-12-25 15:50:43.813049
a3e1af7f-a88d-467b-9844-7666750bdf74	Differential Equations	Research & Education Association	\N	\N	\N	f	bookshelf_cells/IMG_2331.jpeg	2023-12-25 15:50:43.814894	2023-12-25 15:50:43.814894
a4d400c3-9ff5-4c4c-8e24-b2a95e5f5f54	Mechanics	Research & Education Association	\N	\N	\N	f	bookshelf_cells/IMG_2332.jpeg	2023-12-25 15:50:43.816808	2023-12-25 15:50:43.816808
849cd628-d197-4861-bddd-d18e04a89ea9	Table of Integrals	Series, and Products,I.S. Gradshteyn/I.M. Ryzhik	\N	\N	\N	f	bookshelf_cells/IMG_2333.jpeg	2023-12-25 15:50:43.818055	2023-12-25 15:50:43.818055
0bb71520-a11a-4503-ba2d-1c355826bc0b	Plasma Spectroscopy	E. Oks	\N	\N	\N	f	bookshelf_cells/IMG_2334.jpeg	2023-12-25 15:50:43.81925	2023-12-25 15:50:43.81925
79cb8794-ceec-4912-bcbc-b2f2faf76e3a	Desert Islands	Gilles Deleuze	\N	\N	\N	f	bookshelf_cells/IMG_2335.jpeg	2023-12-25 15:50:43.820275	2023-12-25 15:50:43.820275
94aac158-5325-415f-9dda-b380236645fe	Evening in Paradise	Lucia Berlin	\N	\N	\N	f	bookshelf_cells/IMG_2336.jpeg	2023-12-25 15:50:43.821156	2023-12-25 15:50:43.821156
02e9d99c-b816-491f-bd09-7270a5245b3f	The Art of Seduction	Robert Greene	\N	\N	\N	f	bookshelf_cells/IMG_2337.jpeg	2023-12-25 15:50:43.82211	2023-12-25 15:50:43.82211
b0f7625b-9994-4be3-9401-5575a72d81dc	Role Models	John Waters	\N	\N	\N	f	bookshelf_cells/IMG_2343.jpeg	2023-12-25 15:50:59.809695	2023-12-25 15:50:59.809695
b5782f2a-f372-41e1-9cfc-58180c53eaf6	The True Story of Oklahoma's Fabulous Flaming Lips Staring at Sound	Jim Derogatis	\N	\N	\N	f	bookshelf_cells/IMG_2344.jpeg	2023-12-25 15:50:59.813287	2023-12-25 15:50:59.813287
f5986758-e698-42b1-8139-d772214e266e	How the Scots Invented the Modern World	Arthur Herman	\N	\N	\N	f	bookshelf_cells/IMG_2345.jpeg	2023-12-25 15:50:59.81558	2023-12-25 15:50:59.81558
1f5a4515-b103-43bc-9f3c-1eff02781ad7	The Russians	Hedrick Smith	\N	\N	\N	f	bookshelf_cells/IMG_2346.jpeg	2023-12-25 15:50:59.817636	2023-12-25 15:50:59.817636
24d1751d-d58e-4742-b9b5-bde4341a65c2	The Battle of Alamein	John Bierman and Colin Smith	\N	\N	\N	f	bookshelf_cells/IMG_2347.jpeg	2023-12-25 15:50:59.819061	2023-12-25 15:50:59.819061
de0ac35e-8cb5-458f-ae9b-11c061b8de82	The Control Revolution	James R. Beniger	\N	\N	\N	f	bookshelf_cells/IMG_2348.jpeg	2023-12-25 15:50:59.820443	2023-12-25 15:50:59.820443
611e6932-34ea-4996-be06-8e5fee32f420	The Green Knight	Iris Murdoch	\N	\N	\N	f	bookshelf_cells/IMG_2349.jpeg	2023-12-25 15:50:59.821743	2023-12-25 15:50:59.821743
f32b25d7-ab7b-40b0-8c80-e63f7190b8ee	Mating in Captivity	Esther Perel	\N	\N	\N	f	bookshelf_cells/IMG_2350.jpeg	2023-12-25 15:50:59.823148	2023-12-25 15:50:59.823148
f5f3dd66-7a23-441b-ab2b-d4252594528d	McMindfulness	Ronald Purser	\N	\N	\N	f	bookshelf_cells/IMG_2351.jpeg	2023-12-25 15:50:59.824564	2023-12-25 15:50:59.824564
0791c080-c05f-404e-96e2-98fea5577e00	The Man Who Mistook His Wife for a Hat	Oliver Sacks	\N	\N	\N	f	bookshelf_cells/IMG_2352.jpeg	2023-12-25 15:50:59.825808	2023-12-25 15:50:59.825808
5b4a428e-4b17-464b-bb59-9d63a278deac	The Lady in Gold	Anne-Marie O'Connor	\N	\N	\N	f	bookshelf_cells/IMG_2353.jpeg	2023-12-25 15:50:59.826857	2023-12-25 15:50:59.826857
80bfec84-e23d-40ab-9699-d6abd430c645	Carsick	John Waters	\N	\N	\N	f	bookshelf_cells/IMG_2354.jpeg	2023-12-25 15:50:59.827896	2023-12-25 15:50:59.827896
347fe660-8ab8-43a5-9eac-7bb63ffaacee	Crime and Punishment	Fyodor Dostoevsky	\N	\N	\N	f	bookshelf_cells/IMG_2355.jpeg	2023-12-25 15:50:59.829358	2023-12-25 15:50:59.829358
570164d3-4705-4d3d-8ea1-8a5afc44c3a5	Stealing Rembrandts	Anthony M. Amore and Tom Mashberg	\N	\N	\N	f	bookshelf_cells/IMG_2356.jpeg	2023-12-25 15:50:59.830536	2023-12-25 15:50:59.830536
688c6674-2405-4cc3-9fd5-759712437478	Infinite Jest	David Foster Wallace	\N	\N	\N	f	bookshelf_cells/IMG_2357.jpeg	2023-12-25 15:50:59.831548	2023-12-25 15:50:59.831548
c7326289-d818-420e-874a-4d7dcd0dc47e	COMPANY C	John Sack	\N	\N	\N	f	bookshelf_cells/IMG_2135.jpeg	2023-12-25 16:02:13.233428	2023-12-25 16:02:13.233428
b7e8ae5b-5c48-4867-9cb2-ab6feb384bcb	DOING ABSOLUTELY NOTHING	Paul Wiersbinski	\N	\N	\N	f	bookshelf_cells/IMG_2138.jpeg	2023-12-25 16:02:13.237089	2023-12-25 16:02:13.237089
457a40b4-3fa6-433a-9379-cdf54a0f641c	Icarus	Bertrand Russell	\N	\N	\N	f	bookshelf_cells/IMG_2152.jpeg	2023-12-25 16:02:13.23892	2023-12-25 16:02:13.23892
f8d57df3-579c-49a3-b092-5b7e78c5d41f	Design Patterns	Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides	\N	\N	\N	f	bookshelf_cells/IMG_2155.jpeg	2023-12-25 16:02:13.240774	2023-12-25 16:02:13.240774
d9f7dabc-1a97-4186-9948-3b2bbbde38a3	The Anti-Aesthetic	Hal Foster	\N	\N	\N	f	bookshelf_cells/IMG_2173.jpeg	2023-12-25 16:02:13.244738	2023-12-25 16:02:13.244738
76a84775-9918-4e69-af25-0ae5925916c1	Brave New World	Aldous Huxley	\N	\N	\N	f	bookshelf_cells/IMG_2235.jpeg	2023-12-25 16:02:34.398878	2023-12-25 16:02:34.398878
e2ebb389-441f-4774-ad17-79ba5a81f1df	Truly Tasteless Jokes	Blanche Knott	\N	\N	\N	f	bookshelf_cells/IMG_2236.jpeg	2023-12-25 16:02:34.40088	2023-12-25 16:02:34.40088
6d1c1f2e-e5a8-4e78-bd7f-805686d4487b	Down the Rabbit Hole	Juan Pablo Villalobos	\N	\N	\N	f	bookshelf_cells/IMG_2237.jpeg	2023-12-25 16:02:34.402182	2023-12-25 16:02:34.402182
c92e58d8-267f-4678-8ecb-bd3f63e0e110	Vincent Price	Victoria Price	\N	\N	\N	f	bookshelf_cells/IMG_2278.jpeg	2023-12-25 16:02:34.408809	2023-12-25 16:02:34.408809
fca9406a-e435-45b6-94b5-d84980e2e4ec	Desert Islands and Other Texts 1953-1974	Gilles Deleuze	\N	\N	\N	f	bookshelf_cells/IMG_2339.jpeg	2023-12-25 16:02:46.240491	2023-12-25 16:02:46.240491
61a1e701-4e99-4ead-a140-024957d0cf08	the art of seduction	Robert Greene	\N	\N	\N	f	bookshelf_cells/IMG_2341.jpeg	2023-12-25 16:02:46.242467	2023-12-25 16:02:46.242467
a689218d-6dd2-4708-9a9b-7e9d03c8c28c	WEBSTER'S NEW WORLD THESAURUS	Charlton Laird	\N	\N	\N	f	bookshelf_cells/IMG_2154.jpeg	2023-12-25 16:06:36.471992	2023-12-25 16:06:36.471992
6bfe297c-12e7-43d0-9e19-023a14ec8611	The Book of Genesis	Illustrated by R. Crumb	\N	\N	\N	f	bookshelf_cells/IMG_2175.jpeg	2023-12-25 16:06:36.477237	2023-12-25 16:06:36.477237
869f3637-e47b-4171-a81c-516fbe127f42	RUNNING LEAN	Ash Maurya	\N	\N	\N	f	bookshelf_cells/IMG_2176.jpeg	2023-12-25 16:06:36.478776	2023-12-25 16:06:36.478776
01e728e6-2aad-4763-84ff-fe800e57100f	Lifemanship	Stephen Potter	\N	\N	\N	f	bookshelf_cells/IMG_2239.jpeg	2023-12-25 16:06:49.989648	2023-12-25 16:06:49.989648
d62481be-da8a-43ba-b31f-b2f787025c3b	Music Technology: A Survivor's Guide	Paul White	\N	\N	\N	f	bookshelf_cells/IMG_2277.jpeg	2023-12-25 16:06:49.99318	2023-12-25 16:06:49.99318
c8a1dda1-c925-480d-9d5b-b448d27c1331	Evening in Paradise: More Stories	Lucia Berlin	\N	\N	\N	f	bookshelf_cells/IMG_2319.jpeg	2023-12-25 16:06:49.996564	2023-12-25 16:06:49.996564
03a87dae-87fb-430f-b8f5-81d1e351df04	The Singularity Is Near	Ray Kurzweil	\N	\N	\N	f	bookshelf_cells/IMG_2197.jpeg	2023-12-25 16:10:57.513831	2023-12-25 16:10:57.513831
e2631c44-069f-47b4-8504-023481ab3f81	music technology	Paul White	\N	\N	\N	f	bookshelf_cells/IMG_2279.jpeg	2023-12-25 16:11:12.566479	2023-12-25 16:11:12.566479
aae3d9b6-458c-4d69-b8c8-4dd48cfe09ad	The Book of Questions	Gregory Stock, Ph.D.	\N	\N	\N	f	bookshelf_cells/IMG_2398.jpeg	2023-12-25 16:11:35.894394	2023-12-25 16:11:35.894394
4f51d1cd-7633-46d1-8f0b-1aa53ab1a219	An Atlas of Anatomy for Artists	Fritz Schider	\N	\N	\N	f	bookshelf_cells/IMG_2399.jpeg	2023-12-25 16:11:35.897882	2023-12-25 16:11:35.897882
bfd3f5d5-1eb7-44df-8fd4-b90eb4a04c46	Bukowski In Pictures	Howard Sounes	\N	\N	\N	f	bookshelf_cells/IMG_2400.jpeg	2023-12-25 16:11:35.90061	2023-12-25 16:11:35.90061
e33074f9-3faf-4244-a78a-2db1e78c5e65	The Iliad	Homer	\N	\N	\N	f	bookshelf_cells/IMG_2401.jpeg	2023-12-25 16:11:35.902178	2023-12-25 16:11:35.902178
1f3a6caa-3240-4cf5-9434-6d11dae3cfa5	Among the Thugs	Bill Buford	\N	\N	\N	f	bookshelf_cells/IMG_2402.jpeg	2023-12-25 16:11:35.903421	2023-12-25 16:11:35.903421
f574bf64-f1a1-46c2-a866-ca338cf72ecb	Hollywood Godfather	Gianni Russo	\N	\N	\N	f	bookshelf_cells/IMG_2403.jpeg	2023-12-25 16:11:35.904458	2023-12-25 16:11:35.904458
88040605-8550-4645-8663-48e4993dc8ba	Coreyography	Corey Feldman	\N	\N	\N	f	bookshelf_cells/IMG_2404.jpeg	2023-12-25 16:11:35.905685	2023-12-25 16:11:35.905685
cebd372e-e7be-43fc-ac2d-866d444204c2	Drugs Are Nice	Lisa Crystal Carver	\N	\N	\N	f	bookshelf_cells/IMG_2405.jpeg	2023-12-25 16:11:35.907185	2023-12-25 16:11:35.907185
a7103c31-b9e9-4ea5-b682-ba1abb997af3	The Zombie Survival Guide	Max Brooks	\N	\N	\N	f	bookshelf_cells/IMG_2406.jpeg	2023-12-25 16:11:35.908988	2023-12-25 16:11:35.908988
d9b3f151-f0ac-41ef-9913-2ad0a6e04ac0	Understanding Movies	Louis D. Giannetti	\N	\N	\N	f	bookshelf_cells/IMG_2407.jpeg	2023-12-25 16:11:35.911117	2023-12-25 16:11:35.911117
fbc93c88-fe17-47b3-9ebf-2726465e70d6	Notes from No Man's Land	Eula Biss	\N	\N	\N	f	bookshelf_cells/IMG_2408.jpeg	2023-12-25 16:11:35.912795	2023-12-25 16:11:35.912795
d7a85993-6852-4b16-8d5e-dc45bcaf898e	Rites of Spring	Modris Eksteins	\N	\N	\N	f	bookshelf_cells/IMG_2409.jpeg	2023-12-25 16:11:35.914061	2023-12-25 16:11:35.914061
04ec9229-bfd6-40ee-8976-a42eb8019247	Siddhartha	Hermann Hesse	\N	\N	\N	f	bookshelf_cells/IMG_2410.jpeg	2023-12-25 16:11:35.915324	2023-12-25 16:11:35.915324
e0fe487b-714e-4193-a4b7-a8ab730f700e	Graffiti Women	Nicholas Ganz	\N	\N	\N	f	bookshelf_cells/IMG_2418.jpeg	2023-12-25 16:11:55.582215	2023-12-25 16:11:55.582215
6fb581f4-85fb-4b13-8abc-ce8ff20b5cc4	American Gods	Neil Gaiman	\N	\N	\N	f	bookshelf_cells/IMG_2419.jpeg	2023-12-25 16:11:55.584747	2023-12-25 16:11:55.584747
655699e4-648d-4d16-bcd4-30a71b056335	Slaughterhouse-Five	Kurt Vonnegut	\N	\N	\N	f	bookshelf_cells/IMG_2420.jpeg	2023-12-25 16:11:55.58601	2023-12-25 16:11:55.58601
e4b1eddb-a858-4589-a03c-41454beef7ec	Wetlands	Charlotte Roche	\N	\N	\N	f	bookshelf_cells/IMG_2421.jpeg	2023-12-25 16:11:55.587274	2023-12-25 16:11:55.587274
ca2dc7d9-7854-4159-ae7b-8701461e9895	Lives of the Artists	Giorgio Vasari	\N	\N	\N	f	bookshelf_cells/IMG_2422.jpeg	2023-12-25 16:11:55.588842	2023-12-25 16:11:55.588842
f91cbf53-33c8-4a9b-9802-e323c5e708e7	The Book of Answers	Carol Bolt	\N	\N	\N	f	bookshelf_cells/IMG_2423.jpeg	2023-12-25 16:11:55.590824	2023-12-25 16:11:55.590824
430f719e-6e02-4faa-816f-e5a348f0d3ed	Design of the 20th Century	Charlotte & Peter Fiell	\N	\N	\N	f	bookshelf_cells/IMG_2424.jpeg	2023-12-25 16:11:55.592553	2023-12-25 16:11:55.592553
6de73a2c-e2ca-4559-8cab-08e61e16545c	The Collected Poems	Sylvia Plath	\N	\N	\N	f	bookshelf_cells/IMG_2425.jpeg	2023-12-25 16:11:55.593794	2023-12-25 16:11:55.593794
7bdf49d5-f151-4e23-942d-c4ab54eaece9	Soft Sculpture	Dona Z. Meilach	\N	\N	\N	f	bookshelf_cells/IMG_2426.jpeg	2023-12-25 16:11:55.595189	2023-12-25 16:11:55.595189
a5efbe0f-c2be-4ee5-b61d-bd84e4775411	Dancing Queen	Lisa Carver	\N	\N	\N	f	bookshelf_cells/IMG_2427.jpeg	2023-12-25 16:11:55.596534	2023-12-25 16:11:55.596534
a51d0b9d-aaa2-4ade-9800-8eaac35d8a5b	Early Work	Patti Smith	\N	\N	\N	f	bookshelf_cells/IMG_2428.jpeg	2023-12-25 16:11:55.597768	2023-12-25 16:11:55.597768
913728ba-38e3-48e2-8444-27bd9fcf8f1d	Hell's Angel	Ralph "Sonny" Barger	\N	\N	\N	f	bookshelf_cells/IMG_2429.jpeg	2023-12-25 16:11:55.599073	2023-12-25 16:11:55.599073
a5208350-173d-49af-8b79-3a88023ec47a	The Balloonists	Eula Biss	\N	\N	\N	f	bookshelf_cells/IMG_2430.jpeg	2023-12-25 16:11:55.600142	2023-12-25 16:11:55.600142
d972f0b7-a291-4257-90f5-28a68c7d7556	Wild Creations	Hilton Carter	\N	\N	\N	f	bookshelf_cells/IMG_2431.jpeg	2023-12-25 16:11:55.601174	2023-12-25 16:11:55.601174
d5cbbc76-f2c1-42cf-aa18-8759b2f3dd8b	Concerning the Spiritual in Art	Wassily Kandinsky	\N	\N	\N	f	bookshelf_cells/IMG_2432.jpeg	2023-12-25 16:11:55.602323	2023-12-25 16:11:55.602323
5198ee7c-a0db-4a36-850e-4ad2f48a8a94	The Immoralist	André Gide	\N	\N	\N	f	bookshelf_cells/IMG_2438.jpeg	2023-12-25 16:12:14.191795	2023-12-25 16:12:14.191795
90d4ffd5-58c4-46ee-84be-4d1fd0c40ddf	Sharp Objects	Gillian Flynn	\N	\N	\N	f	bookshelf_cells/IMG_2439.jpeg	2023-12-25 16:12:14.194383	2023-12-25 16:12:14.194383
15a672c7-cda8-4de6-94cd-5b8c9a991c4c	In Cold Blood	Truman Capote	\N	\N	\N	f	bookshelf_cells/IMG_2440.jpeg	2023-12-25 16:12:14.195632	2023-12-25 16:12:14.195632
f85a957d-13e2-410b-8990-e6fb6e6024d9	My Life in France	Julia Child	\N	\N	\N	f	bookshelf_cells/IMG_2441.jpeg	2023-12-25 16:12:14.196777	2023-12-25 16:12:14.196777
2784947f-c7fc-428f-9c42-88c78ad4f14d	My Life on the Road	Gloria Steinem	\N	\N	\N	f	bookshelf_cells/IMG_2442.jpeg	2023-12-25 16:12:14.19863	2023-12-25 16:12:14.19863
e0ae1c12-b405-440d-91b7-abafeb80942e	Bauhaus	Frank Whitford	\N	\N	\N	f	bookshelf_cells/IMG_2443.jpeg	2023-12-25 16:12:14.200239	2023-12-25 16:12:14.200239
b2b1854f-7086-4f10-82fa-ef36f1f1f512	Rocks Off	Bill Janovitz	\N	\N	\N	f	bookshelf_cells/IMG_2444.jpeg	2023-12-25 16:12:14.201658	2023-12-25 16:12:14.201658
65bc8fe7-8928-48f6-a305-ccdb800f4288	Body of Secrets	James Bamford	\N	\N	\N	f	bookshelf_cells/IMG_2445.jpeg	2023-12-25 16:12:14.20314	2023-12-25 16:12:14.20314
74f50896-35a2-499f-9b69-7e0156781af3	The Fortress of Solitude	Jonathan Lethem	\N	\N	\N	f	bookshelf_cells/IMG_2446.jpeg	2023-12-25 16:12:14.204566	2023-12-25 16:12:14.204566
a72047e9-225b-4f48-82d0-ab5dfbe74b69	Gravity's Rainbow	Thomas Pynchon	\N	\N	\N	f	bookshelf_cells/IMG_2447.jpeg	2023-12-25 16:12:14.206218	2023-12-25 16:12:14.206218
86e570c2-63e5-419a-a5df-7e0de8a6e346	The Undoing Project	Michael Lewis	\N	\N	\N	f	bookshelf_cells/IMG_2448.jpeg	2023-12-25 16:12:14.207034	2023-12-25 16:12:14.207034
680c692e-6ca2-49d6-8f5a-10e4a067cf5c	High Output Management	Andrew S. Grove	\N	\N	\N	f	bookshelf_cells/IMG_2449.jpeg	2023-12-25 16:12:14.20785	2023-12-25 16:12:14.20785
d2eab3e3-9a89-4b93-af63-89a892dec523	Kafka on the Shore	Haruki Murakami	\N	\N	\N	f	bookshelf_cells/IMG_2450.jpeg	2023-12-25 16:12:14.208632	2023-12-25 16:12:14.208632
988c83ab-f77a-41c6-ac01-853bc33679b9	Dhalgren	Samuel R. Delany	\N	\N	\N	f	bookshelf_cells/IMG_2451.jpeg	2023-12-25 16:12:14.209572	2023-12-25 16:12:14.209572
9cdbd8a1-709b-46ab-8e5b-9295a5c2333f	Hard-Boiled Wonderland and the End of the World	Haruki Murakami	\N	\N	\N	f	bookshelf_cells/IMG_2452.jpeg	2023-12-25 16:12:14.210621	2023-12-25 16:12:14.210621
78ad43e4-4bb5-4434-9ecc-3b5ef4f24b05	Everything Is Bullshit	Priceonomics	\N	\N	\N	f	bookshelf_cells/IMG_2453.jpeg	2023-12-25 16:12:14.21161	2023-12-25 16:12:14.21161
f726f34d-d0ea-4416-955c-d182649c62c4	A World Out of Time	Larry Niven	\N	\N	\N	f	bookshelf_cells/IMG_2454.jpeg	2023-12-25 16:12:14.212627	2023-12-25 16:12:14.212627
d51993ce-da69-490a-b17a-3b9e0181ce01	The Year 1000	Robert Lacey and Danny Danziger	\N	\N	\N	f	bookshelf_cells/IMG_2455.jpeg	2023-12-25 16:12:14.213605	2023-12-25 16:12:14.213605
05b2ecd6-be36-460c-96c0-17fe3d91fbb5	We	Eugene Zamiatin	\N	\N	\N	f	bookshelf_cells/IMG_2456.jpeg	2023-12-25 16:12:14.21455	2023-12-25 16:12:14.21455
3e42d075-1847-4914-b540-6d6e7c92151c	Feminism is for EVERYBODY	bell hooks	\N	\N	\N	f	bookshelf_cells/IMG_2458.jpeg	2023-12-25 16:12:32.422289	2023-12-25 16:12:32.422289
23923886-2126-4685-8dab-bcba92da6558	Neighborhood	Norbert Blei	\N	\N	\N	f	bookshelf_cells/IMG_2459.jpeg	2023-12-25 16:12:32.425906	2023-12-25 16:12:32.425906
4d4f1c0c-d9e1-4c25-8646-814bbae70353	Platform	Michel Houellebecq	\N	\N	\N	f	bookshelf_cells/IMG_2460.jpeg	2023-12-25 16:12:32.428387	2023-12-25 16:12:32.428387
1cd07632-bc5d-4916-9f40-dca93553faa5	The Third Chimpanzee	Jared Diamond	\N	\N	\N	f	bookshelf_cells/IMG_2461.jpeg	2023-12-25 16:12:32.430247	2023-12-25 16:12:32.430247
08388d3b-a3a0-4404-bb88-8bea7ce66f84	The Music of the Primes	Marcus du Sautoy	\N	\N	\N	f	bookshelf_cells/IMG_2462.jpeg	2023-12-25 16:12:32.432119	2023-12-25 16:12:32.432119
7766d693-de03-418f-8f17-e7e4f401e04e	The Logic of Scientific Discovery	Karl R. Popper	\N	\N	\N	f	bookshelf_cells/IMG_2463.jpeg	2023-12-25 16:12:32.433539	2023-12-25 16:12:32.433539
df0e5be2-a727-41db-8e7a-b847c9afdd35	The Disuniting of America	Arthur M. Schlesinger Jr.	\N	\N	\N	f	bookshelf_cells/IMG_2464.jpeg	2023-12-25 16:12:32.434704	2023-12-25 16:12:32.434704
1b330e43-1143-4600-abe6-d1d01f4f39a0	INSPIRED	Marty Cagan	\N	\N	\N	f	bookshelf_cells/IMG_2465.jpeg	2023-12-25 16:12:32.435823	2023-12-25 16:12:32.435823
f6cf2655-8a80-4409-9701-74adadb89b67	Learning Rails	Simon St. Laurent & Edd Dumbill	\N	\N	\N	f	bookshelf_cells/IMG_2466.jpeg	2023-12-25 16:12:32.436937	2023-12-25 16:12:32.436937
fd732978-1645-45c7-9f67-08fcc08ad569	Wave Packets and Their Bifurcations in Geophysical Fluid Dynamics	Hisashi Tanaka	\N	\N	\N	f	bookshelf_cells/IMG_2467.jpeg	2023-12-25 16:12:32.438043	2023-12-25 16:12:32.438043
a728ac8a-3d88-4e03-93fa-2fc5a2d852a0	Moment Map and Combinatorial Invariants of Hamiltonian T^n-spaces	Victor Guillemin	\N	\N	\N	f	bookshelf_cells/IMG_2468.jpeg	2023-12-25 16:12:32.439168	2023-12-25 16:12:32.439168
7ae8fea3-178c-4778-99c2-5ce744800152	The Signal and the Noise	Nate Silver	\N	\N	\N	f	bookshelf_cells/IMG_2469.jpeg	2023-12-25 16:12:32.440395	2023-12-25 16:12:32.440395
02e25d6c-76a9-40d9-a499-d51cc5933cd3	Applied Photographic Optics	Sidney F. Ray	\N	\N	\N	f	bookshelf_cells/IMG_2470.jpeg	2023-12-25 16:12:32.441446	2023-12-25 16:12:32.441446
f7e1c247-2b50-408c-a68f-b44bb0a1e6d5	Fear and Loathing	Paul Perry	\N	\N	\N	f	bookshelf_cells/IMG_2471.jpeg	2023-12-25 16:12:32.442391	2023-12-25 16:12:32.442391
fb73879d-5b23-4daf-a7c8-9d21eff3bb37	The American Revolution	Gordon S. Wood	\N	\N	\N	f	bookshelf_cells/IMG_2472.jpeg	2023-12-25 16:12:32.443234	2023-12-25 16:12:32.443234
e993248b-34b3-46a1-bad4-48491d21c09b	The Criminal	Jim Thompson	\N	\N	\N	f	bookshelf_cells/IMG_2473.jpeg	2023-12-25 16:12:32.444413	2023-12-25 16:12:32.444413
560482a6-9f0c-42cd-9766-4086d7d0accf	Beyond Malthus	Lester R. Brown, Gary Gardner, Brian Halweil	\N	\N	\N	f	bookshelf_cells/IMG_2474.jpeg	2023-12-25 16:12:32.445978	2023-12-25 16:12:32.445978
38709e25-93ea-4010-a612-f41b63ff2d99	Capable of Honor	Allen Drury	\N	\N	\N	f	bookshelf_cells/IMG_2475.jpeg	2023-12-25 16:12:32.447277	2023-12-25 16:12:32.447277
3bdae2e4-cdd7-4231-bb16-0fd840b75455	The World Until Yesterday	Jared Diamond	\N	\N	\N	f	bookshelf_cells/IMG_2476.jpeg	2023-12-25 16:12:32.448446	2023-12-25 16:12:32.448446
9ca6bd36-f09d-4fd0-b3f5-f3b70fbeef85	The Art of Action	Stephen Bungay	\N	\N	\N	f	bookshelf_cells/IMG_2477.jpeg	2023-12-25 16:12:32.44955	2023-12-25 16:12:32.44955
6f935e15-be70-4feb-b09a-01b235ca32f7	The Inner Reaches of Outer Space	Joseph Campbell	\N	\N	\N	f	bookshelf_cells/IMG_2478.jpeg	2023-12-25 16:12:52.694262	2023-12-25 16:12:52.694262
cddcdaa4-7bb6-4020-a750-c2a98e87801a	My Mother Madame Edwarda The Dead Man	Georges Bataille	\N	\N	\N	f	bookshelf_cells/IMG_2479.jpeg	2023-12-25 16:12:52.69652	2023-12-25 16:12:52.69652
9200a0f1-5e72-4450-b31f-931af6a36333	Dear Mr. President	Gabe Hudson	\N	\N	\N	f	bookshelf_cells/IMG_2480.jpeg	2023-12-25 16:12:52.69889	2023-12-25 16:12:52.69889
f873ad79-7e5b-4d0b-a5b2-f715930fc5f0	Lincoln: A Photobiography	Russell Freedman	\N	\N	\N	f	bookshelf_cells/IMG_2481.jpeg	2023-12-25 16:12:52.70139	2023-12-25 16:12:52.70139
ba44e283-5665-49db-929d-d55723834cdd	The Best War Ever	Michael C.C. Adams	\N	\N	\N	f	bookshelf_cells/IMG_2482.jpeg	2023-12-25 16:12:52.703529	2023-12-25 16:12:52.703529
79346204-643a-424d-bc35-bfa82d173220	The Lost City of Z	David Grann	\N	\N	\N	f	bookshelf_cells/IMG_2483.jpeg	2023-12-25 16:12:52.705612	2023-12-25 16:12:52.705612
b4a948eb-43fe-4533-93ab-902603441fa8	The Visual Display of Quantitative Information	Edward R. Tufte	\N	\N	\N	f	bookshelf_cells/IMG_2484.jpeg	2023-12-25 16:12:52.707316	2023-12-25 16:12:52.707316
955a9f07-d068-4847-a389-6196cbdb211e	The Coast of Chicago	Stuart Dybek	\N	\N	\N	f	bookshelf_cells/IMG_2485.jpeg	2023-12-25 16:12:52.70889	2023-12-25 16:12:52.70889
feba3f3e-8e0e-4229-b2e9-b331aeac5496	How Adam Smith Can Change Your Life	Russ Roberts	\N	\N	\N	f	bookshelf_cells/IMG_2486.jpeg	2023-12-25 16:12:52.710119	2023-12-25 16:12:52.710119
88b0d6c5-6d29-4cfa-ac2c-365191bfc318	Chicago	David Mamet	\N	\N	\N	f	bookshelf_cells/IMG_2487.jpeg	2023-12-25 16:12:52.711427	2023-12-25 16:12:52.711427
59ca590f-29f6-4733-ae80-16daff930c5b	A New Kind of Science	Stephen Wolfram	\N	\N	\N	f	bookshelf_cells/IMG_2488.jpeg	2023-12-25 16:12:52.712561	2023-12-25 16:12:52.712561
5dec4a41-70b2-432e-8f90-3e6dbc9bc533	Complete Tales & Poems	Edgar Allan Poe	\N	\N	\N	f	bookshelf_cells/IMG_2489.jpeg	2023-12-25 16:12:52.713801	2023-12-25 16:12:52.713801
b49bbb43-d7cf-4350-bcf2-12772cdbc51f	Laboratory Life	Bruno Latour, Steve Woolgar	\N	\N	\N	f	bookshelf_cells/IMG_2491.jpeg	2023-12-25 16:12:52.715423	2023-12-25 16:12:52.715423
433b6495-8a9e-4573-a675-b99708c2d2ae	The Innocent	David Baldacci	\N	\N	\N	f	bookshelf_cells/IMG_2509.jpeg	2023-12-25 16:12:52.716483	2023-12-25 16:12:52.716483
c0aea739-6c06-4df3-a47d-b94674ed94a9	My Ántonia	Willa Cather	\N	\N	\N	f	bookshelf_cells/IMG_2510.jpeg	2023-12-25 16:12:52.717601	2023-12-25 16:12:52.717601
d75cdb14-e36e-4475-b78f-6245d8b0660c	The FDR Years	William E. Leuchtenburg	\N	\N	\N	f	bookshelf_cells/IMG_2511.jpeg	2023-12-25 16:12:52.718585	2023-12-25 16:12:52.718585
9746d9d0-a669-4225-842a-c47a16c0b71a	Basic Writings	Martin Heidegger	\N	\N	\N	f	bookshelf_cells/IMG_2512.jpeg	2023-12-25 16:12:52.719548	2023-12-25 16:12:52.719548
0b5a9bf0-ad3f-4ada-baa4-ad9e72bc898f	The Philosophy of Mathematics	Stephan Körner	\N	\N	\N	f	bookshelf_cells/IMG_2513.jpeg	2023-12-25 16:12:52.720432	2023-12-25 16:12:52.720432
ce12d6c3-d8fb-4a9a-b1a9-c3f62cc7eba8	Fear and Loathing in Las Vegas	Hunter S. Thompson	\N	\N	\N	f	bookshelf_cells/IMG_2515.jpeg	2023-12-25 16:13:12.008188	2023-12-25 16:13:12.008188
ff7453b4-75a9-4da9-85c0-db857618a236	Global Inequality	Branko Milanovic	\N	\N	\N	f	bookshelf_cells/IMG_2516.jpeg	2023-12-25 16:13:12.012131	2023-12-25 16:13:12.012131
103c6454-0d30-4856-9ce4-c72717007958	The Karl Lagerfeld Diet	Dr. Jean-Claude Houdret	\N	\N	\N	f	bookshelf_cells/IMG_2517.jpeg	2023-12-25 16:13:12.01479	2023-12-25 16:13:12.01479
3a0f4d3e-69fb-4b67-89cc-913a162f60c7	The White Boy Shuffle	Paul Beatty	\N	\N	\N	f	bookshelf_cells/IMG_2518.jpeg	2023-12-25 16:13:12.017373	2023-12-25 16:13:12.017373
3b2a8ba7-3bc3-472e-ba38-62da7baeb229	Clojure for Finance	Timothy Washington	\N	\N	\N	f	bookshelf_cells/IMG_2519.jpeg	2023-12-25 16:13:12.019701	2023-12-25 16:13:12.019701
e5792bab-b557-4bf9-80a6-036289addeb0	Vivian Maier	Pamela Bannos	\N	\N	\N	f	bookshelf_cells/IMG_2520.jpeg	2023-12-25 16:13:12.02213	2023-12-25 16:13:12.02213
9f0b7520-b11d-46df-972d-9d04eeecd776	In the Studio with Michael Jackson	Bruce Swedien	\N	\N	\N	f	bookshelf_cells/IMG_2521.jpeg	2023-12-25 16:13:12.024248	2023-12-25 16:13:12.024248
3e559ba7-89c6-4a12-9b35-317a470f57c8	The Large	the Small and the Human Mind","Roger Penrose	\N	\N	\N	f	bookshelf_cells/IMG_2522.jpeg	2023-12-25 16:13:12.026192	2023-12-25 16:13:12.026192
dd2f173a-caba-414c-a3ed-73fcec10551b	But What If We're Wrong?	Chuck Klosterman	\N	\N	\N	f	bookshelf_cells/IMG_2523.jpeg	2023-12-25 16:13:12.028077	2023-12-25 16:13:12.028077
0ad6b3be-1f9f-4216-955a-e12210adb5f8	Time's Arrows	Richard Morris	\N	\N	\N	f	bookshelf_cells/IMG_2524.jpeg	2023-12-25 16:13:12.029635	2023-12-25 16:13:12.029635
b1204457-c934-4861-8ce5-311cfe68c17b	Only the Dead	Bear F. Braumoeller	\N	\N	\N	f	bookshelf_cells/IMG_2525.jpeg	2023-12-25 16:13:12.030621	2023-12-25 16:13:12.030621
41af3c44-19b0-4695-a5d6-4994cc477663	Switch	Chip Heath & Dan Heath	\N	\N	\N	f	bookshelf_cells/IMG_2526.jpeg	2023-12-25 16:13:12.031628	2023-12-25 16:13:12.031628
994503c6-1e85-4333-a842-09c3442d7e04	Spiritual Diary	Sergius Bulgakov	\N	\N	\N	f	bookshelf_cells/IMG_2527.jpeg	2023-12-25 16:13:12.032526	2023-12-25 16:13:12.032526
bc28d9b5-d021-4740-84a4-5d7f953b0b3b	Engineering Management for the Rest of Us	Sarah Drasner	\N	\N	\N	f	bookshelf_cells/IMG_2528.jpeg	2023-12-25 16:13:12.033512	2023-12-25 16:13:12.033512
d2b64b61-8890-43f4-b462-b1cad3aedee9	The Dawn of Everything	David Graeber and David Wengrow	\N	\N	\N	f	bookshelf_cells/IMG_2529.jpeg	2023-12-25 16:13:12.03493	2023-12-25 16:13:12.03493
ad5e5306-f422-4bc7-a58b-0ab1e50cc476	Chicago's Pilsen Neighborhood	Peter N. Pero	\N	\N	\N	f	bookshelf_cells/IMG_2530.jpeg	2023-12-25 16:13:12.036388	2023-12-25 16:13:12.036388
80f9ab49-8666-4090-b484-614f21a27cec	An Astronaut's Guide to Earth	Col. Chris Hadfield	\N	\N	\N	f	bookshelf_cells/IMG_2531.jpeg	2023-12-25 16:13:12.03775	2023-12-25 16:13:12.03775
14e61156-59d8-4ed8-b05f-0c296845ffa6	To Engineer is Human	Henry Petroski	\N	\N	\N	f	bookshelf_cells/IMG_2172.jpeg	2023-12-25 16:14:38.395003	2023-12-25 16:14:38.395003
c8efc61d-248d-49d5-b3ce-276ef3cb18cb	io ZINGARELLI minore	Nicola Zingarelli	\N	\N	\N	f	bookshelf_cells/IMG_2435.jpeg	2023-12-25 16:15:08.367913	2023-12-25 16:15:08.367913
1473bf45-f1c0-422c-a1c6-58e81d6ba6c0	WE	Eugene Zamiatin	\N	\N	\N	f	bookshelf_cells/IMG_2437.jpeg	2023-12-25 16:15:08.371366	2023-12-25 16:15:08.371366
3143326e-6293-464a-b773-070b4adf9d5e	An Astronaut's Guide to Life on Earth	Chris Hadfield	\N	\N	\N	f	bookshelf_cells/IMG_2533.jpeg	2023-12-25 16:15:08.377037	2023-12-25 16:15:08.377037
6697fc01-3aa1-4050-9d34-d8bd16fef0e4	Q is for Quantum	John Gribbin	\N	\N	\N	f	bookshelf_cells/IMG_2534.jpeg	2023-12-25 16:15:08.379239	2023-12-25 16:15:08.379239
bcda0d8b-5ed9-4665-9005-cc1cee11a774	Speakable and Unspeakable in Quantum Mechanics	J. S. Bell	\N	\N	\N	f	bookshelf_cells/IMG_2535.jpeg	2023-12-25 16:15:08.381015	2023-12-25 16:15:08.381015
8459bb5b-a2f9-43be-bda5-a0a4babd716f	Inside the Third Reich	Albert Speer	\N	\N	\N	f	bookshelf_cells/IMG_2536.jpeg	2023-12-25 16:15:08.383079	2023-12-25 16:15:08.383079
c19b4d71-af36-42bf-acca-33d68c814bf7	CHUCK KLOSTERMAN IV	Chuck Klosterman	\N	\N	\N	f	bookshelf_cells/IMG_2539.jpeg	2023-12-25 16:15:27.363787	2023-12-25 16:15:27.363787
8f277537-1d9f-45cd-b810-f35d42a6d03d	A SHORT GUIDE TO WRITING ABOUT HISTORY	THIRD EDITION",Richard Marius	\N	\N	\N	f	bookshelf_cells/IMG_2540.jpeg	2023-12-25 16:15:27.36637	2023-12-25 16:15:27.36637
e271f10a-9651-4e88-b7b8-d01f2873aa4b	ORIGINALS: AMERICAN WOMEN ARTISTS	Eleanor Munro	\N	\N	\N	f	bookshelf_cells/IMG_2541.jpeg	2023-12-25 16:15:27.369048	2023-12-25 16:15:27.369048
a0e20350-6af5-4a7d-bd83-b71305532aa7	THE SHORTEST HISTORY OF GERMANY	James Hawes	\N	\N	\N	f	bookshelf_cells/IMG_2542.jpeg	2023-12-25 16:15:27.37112	2023-12-25 16:15:27.37112
0a5dedb0-5d9a-4136-9878-2d31d608f7d7	THE SOUL OF A NEW MACHINE	Tracy Kidder	\N	\N	\N	f	bookshelf_cells/IMG_2543.jpeg	2023-12-25 16:15:27.373371	2023-12-25 16:15:27.373371
9034d498-fc14-463d-8eff-4022bc1afe09	THE GREAT LEVELER	Walter Scheidel	\N	\N	\N	f	bookshelf_cells/IMG_2544.jpeg	2023-12-25 16:15:27.375372	2023-12-25 16:15:27.375372
4938a4b4-07ea-4c17-afb9-1e364ac00c38	EXPLAINING HITLER	Ron Rosenbaum	\N	\N	\N	f	bookshelf_cells/IMG_2545.jpeg	2023-12-25 16:15:27.377154	2023-12-25 16:15:27.377154
037e9d95-96a1-4b18-af24-14cbec16d5ae	SAPIENS	Yuval Noah Harari	\N	\N	\N	f	bookshelf_cells/IMG_2546.jpeg	2023-12-25 16:15:27.380838	2023-12-25 16:15:27.380838
6d2b0713-9c70-4240-ad6c-d0a3992d6cd4	NOTHING LIKE IT IN THE WORLD	Stephen E. Ambrose	\N	\N	\N	f	bookshelf_cells/IMG_2547.jpeg	2023-12-25 16:15:27.383065	2023-12-25 16:15:27.383065
9ceddb19-5517-4d9d-b2d7-70e27e3cbb1a	PHYSICS FUN	AND BEYOND",Eduardo de Campos Valadares	\N	\N	\N	f	bookshelf_cells/IMG_2548.jpeg	2023-12-25 16:15:27.385111	2023-12-25 16:15:27.385111
26ceed95-4781-4d1e-910a-3d1b1a2f30f2	WELCOME TO THE MONKEY HOUSE	Kurt Vonnegut	\N	\N	\N	f	bookshelf_cells/IMG_2549.jpeg	2023-12-25 16:15:27.38679	2023-12-25 16:15:27.38679
197eac78-57a6-41c7-a50c-00f0ea108d41	TOTAL HARMONIC DISTORTION	Charles Rodrigues	\N	\N	\N	f	bookshelf_cells/IMG_2550.jpeg	2023-12-25 16:15:27.388237	2023-12-25 16:15:27.388237
ea69aa05-3d02-4ea1-a9b4-aa8a1aaf2334	HELIGOLAND	Carlo Rovelli	\N	\N	\N	f	bookshelf_cells/IMG_2551.jpeg	2023-12-25 16:15:27.389456	2023-12-25 16:15:27.389456
8513078b-e952-4713-beae-1675556ea31d	D.I.A.N.A COOPER	Philip Ziegler	\N	\N	\N	f	bookshelf_cells/IMG_2552.jpeg	2023-12-25 16:15:27.390597	2023-12-25 16:15:27.390597
882038bb-13df-4dab-a8a9-6001d23fc721	THE END OF POLICING	Alex S. Vitale	\N	\N	\N	f	bookshelf_cells/IMG_2553.jpeg	2023-12-25 16:15:27.391714	2023-12-25 16:15:27.391714
f540f991-a8f8-45bf-a795-3e90a563b0e0	PREVENTABLE	Andy Slavitt	\N	\N	\N	f	bookshelf_cells/IMG_2554.jpeg	2023-12-25 16:15:27.394021	2023-12-25 16:15:27.394021
6cd7dff6-1cad-47cf-ae4d-8ddec2b8ca43	A GAME OF THRONES	George R.R. Martin	\N	\N	\N	f	bookshelf_cells/IMG_2555.jpeg	2023-12-25 16:15:27.395834	2023-12-25 16:15:27.395834
560859e5-ac22-4cc4-b404-3c04b8fc9118	ART & FEAR	David Bayles & Ted Orland	\N	\N	\N	f	bookshelf_cells/IMG_2556.jpeg	2023-12-25 16:15:27.397375	2023-12-25 16:15:27.397375
f3ec8db4-b34d-42f4-8b6a-8f749c50d257	THE PEREGRINE	J. A. Baker	\N	\N	\N	f	bookshelf_cells/IMG_2557.jpeg	2023-12-25 16:15:27.398784	2023-12-25 16:15:27.398784
d25db9eb-4535-40b2-aedd-2b89fa9fc6eb	The Rime of the Ancient Mariner and Other Poems	Samuel Taylor Coleridge	\N	\N	\N	f	bookshelf_cells/IMG_2559.jpeg	2023-12-25 16:15:43.397226	2023-12-25 16:15:43.397226
2e23dfdd-d26a-4f48-adef-6deeea50e72e	The Industries of the Future	Alec Ross	\N	\N	\N	f	bookshelf_cells/IMG_2560.jpeg	2023-12-25 16:15:43.4003	2023-12-25 16:15:43.4003
b00dfb57-f4d6-456e-a198-13a10a949af0	The BIG SELL OUT	Dan Mokonyane	\N	\N	\N	f	bookshelf_cells/IMG_2561.jpeg	2023-12-25 16:15:43.402714	2023-12-25 16:15:43.402714
218a63ac-2b19-4c59-9d55-6da00453666a	Simulacra and Simulation	Jean Baudrillard	\N	\N	\N	f	bookshelf_cells/IMG_2562.jpeg	2023-12-25 16:15:43.405157	2023-12-25 16:15:43.405157
d0f25d59-d36b-4269-87b7-9fc033d69268	Women of the Klan: Racism and Gender in the 1920s	Kathleen M. Blee	\N	\N	\N	f	bookshelf_cells/IMG_2563.jpeg	2023-12-25 16:15:43.406707	2023-12-25 16:15:43.406707
9d3fc92b-3e13-42c5-995f-b9b0734d10af	Gods in Everyman: A New Psychology of Men’s Lives and Loves	Jean Shinoda Bolen, M.D.	\N	\N	\N	f	bookshelf_cells/IMG_2564.jpeg	2023-12-25 16:15:43.408216	2023-12-25 16:15:43.408216
8cdcf0fc-f290-4879-a4bd-2776f2042f43	Contact	Carl Sagan	\N	\N	\N	f	bookshelf_cells/IMG_2565.jpeg	2023-12-25 16:15:43.409812	2023-12-25 16:15:43.409812
fe61db38-f292-4665-b369-9644079b724b	Shakey	Jimmy McDonough	\N	\N	\N	f	bookshelf_cells/IMG_2566.jpeg	2023-12-25 16:15:43.412071	2023-12-25 16:15:43.412071
b1101e08-5400-49c6-9941-726771f9e6b1	The Code Book	Simon Singh	\N	\N	\N	f	bookshelf_cells/IMG_2567.jpeg	2023-12-25 16:15:43.413881	2023-12-25 16:15:43.413881
f376f846-2351-4e80-b18d-7f9ea31c2b33	American Nations: A History of the Eleven Rival Regional Cultures of North America	Colin Woodard	\N	\N	\N	f	bookshelf_cells/IMG_2568.jpeg	2023-12-25 16:15:43.415742	2023-12-25 16:15:43.415742
ce45cb0f-0e0e-4a3e-aa29-465f25c2c718	Mr. Gatling's Terrible Marvel	Julia Keller	\N	\N	\N	f	bookshelf_cells/IMG_2569.jpeg	2023-12-25 16:15:43.41748	2023-12-25 16:15:43.41748
b724d191-2163-443c-823f-cfbe567de387	The Woman Warrior	Maxine Hong Kingston	\N	\N	\N	f	bookshelf_cells/IMG_2570.jpeg	2023-12-25 16:15:43.419352	2023-12-25 16:15:43.419352
1fa5776f-c417-4e4e-bc45-4d039f609ac8	Nonlinear Dynamics and Chaos	Steven H. Strogatz	\N	\N	\N	f	bookshelf_cells/IMG_2571.jpeg	2023-12-25 16:15:43.421183	2023-12-25 16:15:43.421183
5408bdf8-5dab-4b4f-84eb-387170c77d5c	Mathematica for the Sciences	Richard E. Crandall	\N	\N	\N	f	bookshelf_cells/IMG_2572.jpeg	2023-12-25 16:15:43.422787	2023-12-25 16:15:43.422787
c677699c-bd75-4473-826c-80b00b1b1405	Kids These Days: Human Capital and the Making of Millennials	Malcolm Harris	\N	\N	\N	f	bookshelf_cells/IMG_2573.jpeg	2023-12-25 16:15:43.424152	2023-12-25 16:15:43.424152
4e694a84-efd2-4a0d-a266-c3b879378b8f	Ghost Fleet	P. W. Singer and August Cole	\N	\N	\N	f	bookshelf_cells/IMG_2579.jpeg	2023-12-25 16:16:06.642768	2023-12-25 16:16:06.642768
a95f88c6-3d7d-4238-b313-dcd85b9919a9	Hit Men	Fredric Dannen	\N	\N	\N	f	bookshelf_cells/IMG_2580.jpeg	2023-12-25 16:16:06.645648	2023-12-25 16:16:06.645648
d0345e40-7d3f-4c2f-930f-501a0222c29e	Apostrophes & Apocalypses	John Barnes	\N	\N	\N	f	bookshelf_cells/IMG_2581.jpeg	2023-12-25 16:16:06.648047	2023-12-25 16:16:06.648047
bbf22396-1f51-4f3b-a0dd-2c42342dd4ea	Grit	Angela Duckworth	\N	\N	\N	f	bookshelf_cells/IMG_2582.jpeg	2023-12-25 16:16:06.649693	2023-12-25 16:16:06.649693
df325875-f019-425b-ad55-07e34ba104eb	Purple Squirrel	Michael B. Junge	\N	\N	\N	f	bookshelf_cells/IMG_2583.jpeg	2023-12-25 16:16:06.650813	2023-12-25 16:16:06.650813
20b355b1-6472-4143-b5a3-fa1f6552b252	The Entrepreneur's Guide to Customer Development	Brant Cooper & Patrick Vlaskovits	\N	\N	\N	f	bookshelf_cells/IMG_2585.jpeg	2023-12-25 16:16:06.653591	2023-12-25 16:16:06.653591
b2e56183-c845-4ff0-9b96-ccd076bbbcfe	His Excellency	Joseph J. Ellis	\N	\N	\N	f	bookshelf_cells/IMG_2586.jpeg	2023-12-25 16:16:06.654853	2023-12-25 16:16:06.654853
8bd1d4e3-b52c-44a3-ab18-3b39332e0217	Gulag	Anne Applebaum	\N	\N	\N	f	bookshelf_cells/IMG_2587.jpeg	2023-12-25 16:16:06.655719	2023-12-25 16:16:06.655719
d36613f1-e8ff-47eb-8dac-d0819b9cc465	100 Questions Every First-Time Home Buyer Should Ask	Ilyce R. Glink	\N	\N	\N	f	bookshelf_cells/IMG_2588.jpeg	2023-12-25 16:16:06.656617	2023-12-25 16:16:06.656617
74368a83-395e-4b9d-bb9e-385ac5fbd40a	The Singularity Trap	Dennis E. Taylor	\N	\N	\N	f	bookshelf_cells/IMG_2589.jpeg	2023-12-25 16:16:06.657631	2023-12-25 16:16:06.657631
001365a9-2191-486b-ab5f-66456473b71d	Occupied Territory	Simon Balto	\N	\N	\N	f	bookshelf_cells/IMG_2590.jpeg	2023-12-25 16:16:06.658665	2023-12-25 16:16:06.658665
b75ea75b-9494-467b-b790-d30caa78a442	Asymptotic Methods for Relaxation Oscillations and Applications	Johan Grasman	\N	\N	\N	f	bookshelf_cells/IMG_2591.jpeg	2023-12-25 16:16:06.659578	2023-12-25 16:16:06.659578
e63dd082-389a-4ba6-a9c3-66a39440e9b4	Cancer Ward	Aleksandr Solzhenitsyn	\N	\N	\N	f	bookshelf_cells/IMG_2592.jpeg	2023-12-25 16:16:06.660562	2023-12-25 16:16:06.660562
9c8eaa51-812f-4658-be31-addb3e345c83	Structure and Interpretation of Computer Programs	Harold Abelson and Gerald Jay Sussman with Julie Sussman	\N	\N	\N	f	bookshelf_cells/IMG_2593.jpeg	2023-12-25 16:16:06.661796	2023-12-25 16:16:06.661796
b74b4851-7037-496a-8c8b-60aa663a33c0	Isadora	Fredrika Blair	\N	\N	\N	f	bookshelf_cells/IMG_2594.jpeg	2023-12-25 16:16:06.6629	2023-12-25 16:16:06.6629
f88677dd-1b3c-4170-b8b7-8d6b6a050136	Discrete Mathematics	Kenneth A. Ross & Charles R. B. Wright	\N	\N	\N	f	bookshelf_cells/IMG_2595.jpeg	2023-12-25 16:16:06.664842	2023-12-25 16:16:06.664842
4fcfe812-13ba-47c6-9889-0a06d601e360	Quantum Methods with Mathematica	James M. Feagin	\N	\N	\N	f	bookshelf_cells/IMG_2599.jpeg	2023-12-25 16:16:33.848099	2023-12-25 16:16:33.848099
89449841-3827-4bf1-be4f-bc8d000caad3	LISP	Patrick Henry Winston,Berthold Klaus Paul Horn	\N	\N	\N	f	bookshelf_cells/IMG_2600.jpeg	2023-12-25 16:16:33.850626	2023-12-25 16:16:33.850626
f6976799-6e3b-48d8-ad08-946bdf3d810e	Soft Skills	John Z. Sonmez	\N	\N	\N	f	bookshelf_cells/IMG_2601.jpeg	2023-12-25 16:16:33.85217	2023-12-25 16:16:33.85217
d0d0a224-5958-4bc7-8444-e2ae8947d889	A Short History of Nearly Everything	Bill Bryson	\N	\N	\N	f	bookshelf_cells/IMG_2602.jpeg	2023-12-25 16:16:33.853694	2023-12-25 16:16:33.853694
b6c282ca-d8c6-4759-ad75-2f0d17798eb8	An Introduction to Analysis	William R. Wade	\N	\N	\N	f	bookshelf_cells/IMG_2603.jpeg	2023-12-25 16:16:33.855532	2023-12-25 16:16:33.855532
dbd44000-99c2-4867-9355-558a7f610ee4	Nature's Metropolis	William Cronon	\N	\N	\N	f	bookshelf_cells/IMG_2604.jpeg	2023-12-25 16:16:33.856865	2023-12-25 16:16:33.856865
4ebe1901-5c55-4fe4-8c72-8dce6259e79c	Uncovering Soviet Disasters	James E. Oberg	\N	\N	\N	f	bookshelf_cells/IMG_2605.jpeg	2023-12-25 16:16:33.858277	2023-12-25 16:16:33.858277
99c8b1f5-130e-47e6-a38e-de904aaa1190	The Fall of Berlin 1945	Antony Beevor	\N	\N	\N	f	bookshelf_cells/IMG_2606.jpeg	2023-12-25 16:16:33.859666	2023-12-25 16:16:33.859666
fc7d707d-7f16-49f5-b0c0-6fc9692a78b2	A Pillar of Iron	Taylor Caldwell	\N	\N	\N	f	bookshelf_cells/IMG_2607.jpeg	2023-12-25 16:16:33.860877	2023-12-25 16:16:33.860877
903064ce-205e-4e25-b4a5-5d2de652f09f	Symmetry in Science	Joe Rosen	\N	\N	\N	f	bookshelf_cells/IMG_2608.jpeg	2023-12-25 16:16:33.861951	2023-12-25 16:16:33.861951
e3cb0929-9518-4ff2-8842-f833e4c6f80c	Summer for the Gods	Edward J. Larson	\N	\N	\N	f	bookshelf_cells/IMG_2609.jpeg	2023-12-25 16:16:33.863183	2023-12-25 16:16:33.863183
e60397a5-5040-4d38-b6ea-6a08d5024559	The Blair Handbook	Toby Fulwiler,Alan R. Hayakawa	\N	\N	\N	f	bookshelf_cells/IMG_2610.jpeg	2023-12-25 16:16:33.864166	2023-12-25 16:16:33.864166
ba2d1e1f-20dd-4d25-9a73-0fe01f4dda8e	Introduction to Quantum Mechanics	David J. Griffiths	\N	\N	\N	f	bookshelf_cells/IMG_2611.jpeg	2023-12-25 16:16:33.865129	2023-12-25 16:16:33.865129
b7cf4d63-51cc-4642-a37d-278aa21ae40d	The Killer Inside Me	Jim Thompson	\N	\N	\N	f	bookshelf_cells/IMG_2612.jpeg	2023-12-25 16:16:33.866058	2023-12-25 16:16:33.866058
01d550d5-6164-44e9-85db-c65da3344070	The Pantry Primer	Daisy Luther	\N	\N	\N	f	bookshelf_cells/IMG_2613.jpeg	2023-12-25 16:16:33.867	2023-12-25 16:16:33.867
c6537d36-7b92-4f59-8e16-56b702fd0aab	Love Poems	Anne Sexton	\N	\N	\N	f	bookshelf_cells/IMG_2614.jpeg	2023-12-25 16:16:33.867981	2023-12-25 16:16:33.867981
8ace2530-e91f-49de-abfd-3de38cc922d0	Rude Boys	G. Cabrera Infante	\N	\N	\N	f	bookshelf_cells/IMG_2615.jpeg	2023-12-25 16:16:33.868833	2023-12-25 16:16:33.868833
8772cefb-dbc0-4dc8-baaa-c6ab558eb496	The Comingled Code	Josh Lerner and Mark Schankerman	\N	\N	\N	f	bookshelf_cells/IMG_2616.jpeg	2023-12-25 16:16:33.869698	2023-12-25 16:16:33.869698
ce41892e-0066-4918-a8d9-df74127450d2	Modern Quantum Mechanics	J. J. Sakurai	\N	\N	\N	f	bookshelf_cells/IMG_2619.jpeg	2023-12-25 16:16:54.055448	2023-12-25 16:16:54.055448
2348314d-f0d1-4660-9f43-161dd4256766	Supercapitalism	Robert B. Reich	\N	\N	\N	f	bookshelf_cells/IMG_2620.jpeg	2023-12-25 16:16:54.057246	2023-12-25 16:16:54.057246
b71e9a0b-9bbb-4b43-8ac6-48761eaf236f	Things to Come	H. G. Wells	\N	\N	\N	f	bookshelf_cells/IMG_2621.jpeg	2023-12-25 16:16:54.059008	2023-12-25 16:16:54.059008
c907b587-288b-45ab-8813-524777d167b9	Understanding Computation	Tom Stuart	\N	\N	\N	f	bookshelf_cells/IMG_2622.jpeg	2023-12-25 16:16:54.060884	2023-12-25 16:16:54.060884
cb8b14b9-8fe1-4099-b4d2-4f7015d80da8	JavaScript: The Good Parts	Douglas Crockford	\N	\N	\N	f	bookshelf_cells/IMG_2623.jpeg	2023-12-25 16:16:54.062483	2023-12-25 16:16:54.062483
cc337c00-0fa8-479e-96b5-8a6a4895bd85	Junkbots	Bugbots, and Bots on Wheels","Dave Hrynkiw, Mark W. Tilden	\N	\N	\N	f	bookshelf_cells/IMG_2624.jpeg	2023-12-25 16:16:54.06336	2023-12-25 16:16:54.06336
8bd144b9-8e03-4de3-9aa7-4e874fc639f6	The Silk Roads	Peter Frankopan	\N	\N	\N	f	bookshelf_cells/IMG_2625.jpeg	2023-12-25 16:16:54.064192	2023-12-25 16:16:54.064192
f6b35bdd-5125-4d97-9ad2-e06d762ee78b	Refactoring	Martin Fowler	\N	\N	\N	f	bookshelf_cells/IMG_2626.jpeg	2023-12-25 16:16:54.065064	2023-12-25 16:16:54.065064
aef1afef-b59f-4667-8f15-ad024740a210	Atomic Design	Brad Frost	\N	\N	\N	f	bookshelf_cells/IMG_2627.jpeg	2023-12-25 16:16:54.066051	2023-12-25 16:16:54.066051
12711789-c805-4448-8226-d51b85af35bc	MobX Quick Start Guide	Pavan Podila, Michel Weststrate	\N	\N	\N	f	bookshelf_cells/IMG_2628.jpeg	2023-12-25 16:16:54.066993	2023-12-25 16:16:54.066993
d60fa129-0da7-4210-93fd-b8b5b97391fa	The Innovator's Solution	Clayton M. Christensen, Michael E. Raynor	\N	\N	\N	f	bookshelf_cells/IMG_2629.jpeg	2023-12-25 16:16:54.067868	2023-12-25 16:16:54.067868
5407d966-2ec8-43b0-a53a-d497a6b8258e	Clojure for the Brave and True	Daniel Higginbotham	\N	\N	\N	f	bookshelf_cells/IMG_2630.jpeg	2023-12-25 16:16:54.068681	2023-12-25 16:16:54.068681
3543b8aa-444a-4b96-aa56-9fb78211f7b0	Pale Blue Dot	Carl Sagan	\N	\N	\N	f	bookshelf_cells/IMG_2631.jpeg	2023-12-25 16:16:54.069554	2023-12-25 16:16:54.069554
b95e8d97-c543-48f1-9774-0d7653658525	The Pragmatic Programmer	Andrew Hunt, David Thomas	\N	\N	\N	f	bookshelf_cells/IMG_2632.jpeg	2023-12-25 16:16:54.070532	2023-12-25 16:16:54.070532
200a65d7-2e90-47de-82c0-beba2874132a	The World War II Quiz & Fact Book	Timothy B. Benford	\N	\N	\N	f	bookshelf_cells/IMG_2633.jpeg	2023-12-25 16:16:54.071391	2023-12-25 16:16:54.071391
a089ba97-75ef-442f-ab9a-4ca8640d5cde	New Directions in Japanese Architecture	Robin Boyd	\N	\N	\N	f	bookshelf_cells/IMG_2634.jpeg	2023-12-25 16:16:54.072283	2023-12-25 16:16:54.072283
67ab9b04-6669-4abe-a1f4-4d627c0f5afa	Quantum Physics of Atoms	Molecules, Solids, Nuclei, and Particles","Robert Eisberg, Robert Resnick	\N	\N	\N	f	bookshelf_cells/IMG_2635.jpeg	2023-12-25 16:16:54.082878	2023-12-25 16:16:54.082878
9f043df5-b399-424e-82ad-1b07657167b8	WAR	Sebastian Junger	\N	\N	\N	f	bookshelf_cells/IMG_2639.jpeg	2023-12-25 16:17:14.429606	2023-12-25 16:17:14.429606
957148b6-c058-415f-b886-ea16be1fdc51	Picasso's Picassos	David Douglas Duncan	\N	\N	\N	f	bookshelf_cells/IMG_2640.jpeg	2023-12-25 16:17:14.432195	2023-12-25 16:17:14.432195
72fe176e-7513-4388-b54a-74df6e983fd9	ANCIENT GREECE	Pomeroy, Burstein, Donlan, Roberts	\N	\N	\N	f	bookshelf_cells/IMG_2641.jpeg	2023-12-25 16:17:14.433485	2023-12-25 16:17:14.433485
f959e12f-2f97-4b05-bbc2-4948825feb11	TESTIMONY OF TWO MEN	Taylor Caldwell	\N	\N	\N	f	bookshelf_cells/IMG_2642.jpeg	2023-12-25 16:17:14.435856	2023-12-25 16:17:14.435856
7d21fe3d-bfa8-41e0-9386-8858ee253f7f	2010: Odyssey Two	Arthur C. Clarke	\N	\N	\N	f	bookshelf_cells/IMG_2643.jpeg	2023-12-25 16:17:14.437665	2023-12-25 16:17:14.437665
8b36ca0f-b726-41cc-8d7b-3e5e0f8eb77f	PRINCIPLES OF NEURAL SCIENCE	Eric R. Kandel, James H. Schwartz, Thomas M. Jessell	\N	\N	\N	f	bookshelf_cells/IMG_2644.jpeg	2023-12-25 16:17:14.43871	2023-12-25 16:17:14.43871
82646b9b-2501-415f-b7e7-8b09f7913b54	JavaScript The Definitive Guide	David Flanagan	\N	\N	\N	f	bookshelf_cells/IMG_2645.jpeg	2023-12-25 16:17:14.439715	2023-12-25 16:17:14.439715
cff1fa37-e884-46d4-9b13-93deb4a8136a	ELECTRICITY and MAGNETISM	Ralph P. Winch	\N	\N	\N	f	bookshelf_cells/IMG_2646.jpeg	2023-12-25 16:17:14.440702	2023-12-25 16:17:14.440702
91cd7ca6-3074-4d93-bc8b-0239490d2452	mechanics third edition	symon	\N	\N	\N	f	bookshelf_cells/IMG_2647.jpeg	2023-12-25 16:17:14.441686	2023-12-25 16:17:14.441686
429f6945-6cbb-4532-9d3b-9064971f9549	Calculus	Thomas Finney	\N	\N	\N	f	bookshelf_cells/IMG_2648.jpeg	2023-12-25 16:17:14.442528	2023-12-25 16:17:14.442528
d60ae1ba-53ec-4f85-8830-44c11f3282e6	The Complete Guide to High-End Audio	Robert Harley	\N	\N	\N	f	bookshelf_cells/IMG_2649.jpeg	2023-12-25 16:17:14.444133	2023-12-25 16:17:14.444133
503d4750-1e1a-4f2b-9696-c77a2e6244fd	Handbook of MODERN SENSORS	Jacob Fraden	\N	\N	\N	f	bookshelf_cells/IMG_2650.jpeg	2023-12-25 16:17:14.449775	2023-12-25 16:17:14.449775
42d73db3-6d56-4d68-a419-70936e2b41a9	Ghosts from the Nursery	Robin Karr-Morse and Meredith S. Wiley	\N	\N	\N	f	bookshelf_cells/IMG_2651.jpeg	2023-12-25 16:17:14.450772	2023-12-25 16:17:14.450772
a408edb1-fe79-48d1-9072-db9905074eb3	The Rainbow and the Worm	Mae-Wan Ho	\N	\N	\N	f	bookshelf_cells/IMG_2652.jpeg	2023-12-25 16:17:14.451719	2023-12-25 16:17:14.451719
a198c33a-0f1b-48a9-b04b-fe7d6d359935	Infinite Potential	F. David Peat	\N	\N	\N	f	bookshelf_cells/IMG_2653.jpeg	2023-12-25 16:17:14.452719	2023-12-25 16:17:14.452719
c286e2c0-6e84-4e5f-bc73-b3b6040e5e64	Modern Man In Search Of A Soul	C. G. Jung	\N	\N	\N	f	bookshelf_cells/IMG_2660.jpeg	2023-12-25 16:17:35.687591	2023-12-25 16:17:35.687591
cf3a1218-c1a7-44d7-aa11-59e0c26a2228	The Picture of Dorian Gray	Oscar Wilde	\N	\N	\N	f	bookshelf_cells/IMG_2661.jpeg	2023-12-25 16:17:35.690154	2023-12-25 16:17:35.690154
a3bfafe0-b233-4b80-89d1-21c66cb7cb9a	Titus Andronicus	William Shakespeare	\N	\N	\N	f	bookshelf_cells/IMG_2662.jpeg	2023-12-25 16:17:35.691716	2023-12-25 16:17:35.691716
d6987496-2f95-4539-a799-b460615e8549	Romeo and Juliet	William Shakespeare	\N	\N	\N	f	bookshelf_cells/IMG_2663.jpeg	2023-12-25 16:17:35.693252	2023-12-25 16:17:35.693252
6dc1eff1-4c49-4f3a-81ca-ba8246041fca	Ah	Wilderness!",Eugene O'Neill	\N	\N	\N	f	bookshelf_cells/IMG_2664.jpeg	2023-12-25 16:17:35.694582	2023-12-25 16:17:35.694582
6fcaaa4b-b67f-4ad4-b218-d686649296dc	Mary Stuart	Friedrich Schiller	\N	\N	\N	f	bookshelf_cells/IMG_2665.jpeg	2023-12-25 16:17:35.696102	2023-12-25 16:17:35.696102
b333e620-8038-41c8-b95d-e7f636a68338	All My Sons	Arthur Miller	\N	\N	\N	f	bookshelf_cells/IMG_2666.jpeg	2023-12-25 16:17:35.69778	2023-12-25 16:17:35.69778
2e5bb9e1-0e18-4ce1-b050-dc3c01e2a31c	Wit	Margaret Edson	\N	\N	\N	f	bookshelf_cells/IMG_2667.jpeg	2023-12-25 16:17:35.69938	2023-12-25 16:17:35.69938
a3f496de-06e9-4776-aeb7-4d1c294cf56b	The Importance of Being Earnest	Oscar Wilde	\N	\N	\N	f	bookshelf_cells/IMG_2668.jpeg	2023-12-25 16:17:35.700678	2023-12-25 16:17:35.700678
ad0e7ce5-072b-4066-a0a3-3f0a7103e5c6	Animals Out Of Paper	Rajiv Joseph	\N	\N	\N	f	bookshelf_cells/IMG_2669.jpeg	2023-12-25 16:17:35.702082	2023-12-25 16:17:35.702082
a1c65c77-628c-47dd-b79b-ba2e77549e83	reasons to be pretty	Neil LaBute	\N	\N	\N	f	bookshelf_cells/IMG_2670.jpeg	2023-12-25 16:17:35.703719	2023-12-25 16:17:35.703719
8950fa76-ecb2-4ec7-85ed-155c5a43252c	A Streetcar Named Desire	Tennessee Williams	\N	\N	\N	f	bookshelf_cells/IMG_2671.jpeg	2023-12-25 16:17:35.705444	2023-12-25 16:17:35.705444
0ef3bbeb-fd02-4000-88ef-10faf91a8210	The Piano Lesson	August Wilson	\N	\N	\N	f	bookshelf_cells/IMG_2672.jpeg	2023-12-25 16:17:35.707284	2023-12-25 16:17:35.707284
99c1cd63-5a62-450b-8951-031714ed27f8	Doubt A Parable	John Patrick Shanley	\N	\N	\N	f	bookshelf_cells/IMG_2673.jpeg	2023-12-25 16:17:35.709025	2023-12-25 16:17:35.709025
34f2b554-fc6d-49e2-9f52-b97dd2bb24cf	The Myth of Sisyphus and Other Essays	Albert Camus	\N	\N	\N	f	bookshelf_cells/IMG_2674.jpeg	2023-12-25 16:17:35.710756	2023-12-25 16:17:35.710756
6ce7690e-e9db-4737-9ca1-7dbb4e3aefbe	BAUER	Lauren Gunderson	\N	\N	\N	f	bookshelf_cells/IMG_2675.jpeg	2023-12-25 16:17:35.712178	2023-12-25 16:17:35.712178
61aa0ad8-81af-4594-94ee-d915eea6b36b	Libra	Don DeLillo	\N	\N	\N	f	bookshelf_cells/IMG_2676.jpeg	2023-12-25 16:17:35.713485	2023-12-25 16:17:35.713485
e7405362-279b-440c-8013-07f2f0397686	Hiroshima Mon Amour	Marguerite Duras	\N	\N	\N	f	bookshelf_cells/IMG_2677.jpeg	2023-12-25 16:17:35.714688	2023-12-25 16:17:35.714688
d06740a7-7e3e-4daa-8a77-f1e4d90d107d	1Q84	Haruki Murakami	\N	\N	\N	f	bookshelf_cells/IMG_2680.jpeg	2023-12-25 16:17:53.750214	2023-12-25 16:17:53.750214
60c7ee93-13f4-4f91-9928-a0204aacd9de	The Brothers Size	Tarell Alvin McCraney	\N	\N	\N	f	bookshelf_cells/IMG_2681.jpeg	2023-12-25 16:17:53.75464	2023-12-25 16:17:53.75464
796bb6b9-6ba6-458b-bb91-32ad6772d4d2	On the Technique of Acting	Michael Chekhov	\N	\N	\N	f	bookshelf_cells/IMG_2682.jpeg	2023-12-25 16:17:53.756285	2023-12-25 16:17:53.756285
15ad8578-e33e-4d36-bcb9-4a5280ef045e	'ART'	Yasmina Reza	\N	\N	\N	f	bookshelf_cells/IMG_2683.jpeg	2023-12-25 16:17:53.757611	2023-12-25 16:17:53.757611
fd68d6a8-7ad3-4785-b578-356b9dce14f8	Dom Juan	Molière	\N	\N	\N	f	bookshelf_cells/IMG_2684.jpeg	2023-12-25 16:17:53.758848	2023-12-25 16:17:53.758848
29f85f21-cd2d-4228-8239-e19af55c9cf4	On Tour	Gregory Burke	\N	\N	\N	f	bookshelf_cells/IMG_2685.jpeg	2023-12-25 16:17:53.759971	2023-12-25 16:17:53.759971
dbdc0abd-9e75-4bac-9c27-4bbbb8725076	Purity of Heart	Søren Kierkegaard	\N	\N	\N	f	bookshelf_cells/IMG_2687.jpeg	2023-12-25 16:17:53.761688	2023-12-25 16:17:53.761688
fc064aa9-ca35-4d23-a50b-0006c375c936	Nine Plays	Eugene O'Neill	\N	\N	\N	f	bookshelf_cells/IMG_2688.jpeg	2023-12-25 16:17:53.762711	2023-12-25 16:17:53.762711
4277e01a-4d3d-4ab2-a476-4d348b87d533	Physics	Paul A. Tipler	\N	\N	\N	f	bookshelf_cells/IMG_2689.jpeg	2023-12-25 16:17:53.763797	2023-12-25 16:17:53.763797
09d68c32-590c-4ef9-8827-7a8bdbefc64c	Armageddon	Max Hastings	\N	\N	\N	f	bookshelf_cells/IMG_2690.jpeg	2023-12-25 16:17:53.764807	2023-12-25 16:17:53.764807
d5a94f15-c293-43f1-a7bf-990b5df219e9	Nuclear War Survival Skills	Cresson H. Kearny	\N	\N	\N	f	bookshelf_cells/IMG_2691.jpeg	2023-12-25 16:17:53.76593	2023-12-25 16:17:53.76593
b82b1324-20ed-4eb1-92ed-cca123e029a6	The Complete Encyclopedia of Pistols and Revolvers	A.E. Hartink	\N	\N	\N	f	bookshelf_cells/IMG_2692.jpeg	2023-12-25 16:17:53.766859	2023-12-25 16:17:53.766859
4857f66c-2b78-4bdd-8cd9-5c573d36c9d3	Forbidden Photographs	Charles Gatewood	\N	\N	\N	f	bookshelf_cells/IMG_2693.jpeg	2023-12-25 16:17:53.767792	2023-12-25 16:17:53.767792
6977fc98-60e7-4946-ab61-f13336beba5f	Pinturas Flashes Bocetos VOL IV	Joe Ellis	\N	\N	\N	f	bookshelf_cells/IMG_2694.jpeg	2023-12-25 16:17:53.768832	2023-12-25 16:17:53.768832
92e40bd3-b3c6-4164-9869-3934672c17ad	Photoelectron Spectroscopy	Stefan Hüfner	\N	\N	\N	f	bookshelf_cells/IMG_2700.jpeg	2023-12-25 16:18:10.955224	2023-12-25 16:18:10.955224
4dbf7489-ab54-46c4-aa45-d0e6a37cb24a	History of the World War	Frank H. Simonds	\N	\N	\N	f	bookshelf_cells/IMG_2701.jpeg	2023-12-25 16:18:10.957492	2023-12-25 16:18:10.957492
0ec4fa2c-edf4-4712-a640-9f82c7f7718e	Crucial Conversations	Joseph Grenny, Kerry Patterson, Ron McMillan, Al Switzler, Emily Gregory	\N	\N	\N	f	bookshelf_cells/IMG_2702.jpeg	2023-12-25 16:18:10.959315	2023-12-25 16:18:10.959315
026415cc-3edf-4d5b-935b-9342ff65d5af	The Elements of Music	Jason Martineau	\N	\N	\N	f	bookshelf_cells/IMG_2703.jpeg	2023-12-25 16:18:10.961923	2023-12-25 16:18:10.961923
236c4cab-a1ae-4abe-b04d-f07f289fa0e8	The Lord of the Rings	J.R.R. Tolkien	\N	\N	\N	f	bookshelf_cells/IMG_2722.jpeg	2023-12-25 16:18:14.330168	2023-12-25 16:18:14.330168
81adb1b7-ec75-41be-a832-f8e4cfa0b9b7	Down The Rabbit Hole	Juan Pablo Villalobos	\N	\N	\N	f	bookshelf_cells/IMG_2195.jpeg	2023-12-25 16:19:33.699844	2023-12-25 16:19:33.699844
5fe8719d-7bdf-4b50-9f04-89b39b73aa65	understanding movies	Louis D. Giannetti	\N	\N	\N	f	bookshelf_cells/IMG_2359.jpeg	2023-12-25 16:19:52.91077	2023-12-25 16:19:52.91077
9acee201-eabf-45e0-9fff-ad4280193fb2	Caring for Your Baby and Young Child	American Academy of Pediatrics	\N	\N	\N	f	bookshelf_cells/IMG_2417.jpeg	2023-12-25 16:20:13.76586	2023-12-25 16:20:13.76586
4111669d-5555-49e6-b291-834389648e39	Speakable and unspeakable in quantum mechanics	J. S. Bell	\N	\N	\N	f	bookshelf_cells/IMG_2532.jpeg	2023-12-25 16:20:13.770925	2023-12-25 16:20:13.770925
5a8b210d-04fa-495d-ae5a-3f8a2931de54	The Peregrine	J. A. Baker	\N	\N	\N	f	bookshelf_cells/IMG_2538.jpeg	2023-12-25 16:20:13.772829	2023-12-25 16:20:13.772829
5aeb759f-352c-4645-b390-a5ebc8c1fda1	Dictionary of American Politics	Smith and Zurcher	\N	\N	\N	f	bookshelf_cells/IMG_2558.jpeg	2023-12-25 16:20:13.773931	2023-12-25 16:20:13.773931
4e5bd11f-b4fe-4d82-8d3e-12093c7e4c62	Kids These Days	Malcolm Harris	\N	\N	\N	f	bookshelf_cells/IMG_2576.jpeg	2023-12-25 16:20:13.775853	2023-12-25 16:20:13.775853
83c21aee-2bc6-4899-a0ea-400a0736c3bb	Crucial Conversations Third Edition	Joseph Grenny, Kerry Patterson, Ron McMillan, Al Switzler, Emily Gregory	\N	\N	\N	f	bookshelf_cells/IMG_2705.jpeg	2023-12-25 16:21:01.241616	2023-12-25 16:21:01.241616
b6454505-e14c-460f-95c0-f9030197b495	Lessons of AZIKIWELWA	Dan Mokonyane	\N	\N	\N	f	bookshelf_cells/IMG_2194.jpeg	2023-12-25 16:28:26.222867	2023-12-25 16:28:26.222867
2863054e-444f-48a2-adc1-9d920bdafd32	Nonlinear Dynamics And Chaos	Steven H. Strogatz	\N	\N	\N	f	bookshelf_cells/IMG_2537.jpeg	2023-12-25 16:28:58.508184	2023-12-25 16:28:58.508184
1aabcf11-cb28-4db2-8ab5-38e7b621be82	Problem Solvers Mechanics	Research & Education Association	\N	\N	\N	f	bookshelf_cells/IMG_2654.jpeg	2023-12-25 16:29:13.692555	2023-12-25 16:29:13.692555
170d0a71-64fd-4ce9-b7b9-2854b237bf8a	Infinite Potential: The Life and Times of David Bohm	F. David Peat	\N	\N	\N	f	bookshelf_cells/IMG_2658.jpeg	2023-12-25 16:29:13.696855	2023-12-25 16:29:13.696855
a9b0d3be-ee59-41d5-a9ed-84e26cba60f3	Lessons of AZIKWELWA	Dan Mokonyane	\N	\N	\N	f	bookshelf_cells/IMG_2196.jpeg	2023-12-25 16:42:16.498173	2023-12-25 16:42:16.498173
119ea2c7-5d17-4f63-b52c-dab529db24a5	Drinking with Bukowski	Daniel Weizmann	\N	\N	\N	f	bookshelf_cells/IMG_2358.jpeg	2023-12-25 16:42:32.680914	2023-12-25 16:42:32.680914
78ab9feb-a735-47ee-8c07-a74bbf4520ed	Quantum Physics	Robert Eisberg, Robert Resnick	\N	\N	\N	f	bookshelf_cells/IMG_2598.jpeg	2023-12-25 16:42:55.335295	2023-12-25 16:42:55.335295
5d9bd1b3-25df-4f63-a7bc-096c95a86409	King Henry IV Part 1	William Shakespeare	\N	\N	\N	f	bookshelf_cells/IMG_2659.jpeg	2023-12-25 16:43:12.432378	2023-12-25 16:43:12.432378
69f30d34-c200-406a-b922-21e73c4faf84	Vocabolario della Lingua Italiana	Nicola Zingarelli	\N	\N	\N	f	bookshelf_cells/IMG_2436.jpeg	2023-12-25 16:45:10.003243	2023-12-25 16:45:10.003243
a9354f25-523d-4c83-8e35-46b5446aeef0	Non-Flowering Plants	E. L. Kornfeld	\N	\N	\N	f	bookshelf_cells/IMG_2342.jpeg	2023-12-25 16:47:36.37611	2023-12-25 16:47:36.37611
d990f4de-5874-4ed9-8061-2b9eb66a3372	KIDS THESE DAYS	Malcolm Harris	\N	\N	\N	f	bookshelf_cells/IMG_2577.jpeg	2023-12-25 16:47:56.442146	2023-12-25 16:47:56.442146
d954f689-ba74-4458-8178-e15c74d92466	ISADORA	Fredrika Blair	\N	\N	\N	f	bookshelf_cells/IMG_2578.jpeg	2023-12-25 16:47:56.446148	2023-12-25 16:47:56.446148
6ab8c951-b80e-4a09-8e65-812308126851	QUANTUM PHYSICS	Robert Eisberg, Robert Resnick	\N	\N	\N	f	bookshelf_cells/IMG_2617.jpeg	2023-12-25 16:47:56.450801	2023-12-25 16:47:56.450801
bf2185c2-dff8-4a52-b461-67b572c46aab	Pinturas	Flashes, Bocetos Vol. IV","Joe Ellis	\N	\N	\N	f	bookshelf_cells/IMG_2698.jpeg	2023-12-25 16:48:17.024291	2023-12-25 16:48:17.024291
cbee697b-849e-46a7-9584-69c8cbebbddf	The Philosophy of Mathematics An Introductory Essay	Stephan Körner	\N	\N	\N	f	bookshelf_cells/IMG_2514.jpeg	2023-12-25 16:50:51.441391	2023-12-25 16:50:51.441391
22d02e09-da1e-49bd-9046-8e9a25806f3e	ISADORA Portrait of the Artist as a Woman	Frederika Blair	\N	\N	\N	f	bookshelf_cells/IMG_2575.jpeg	2023-12-25 16:50:51.446482	2023-12-25 16:50:51.446482
bc26be2d-4f6a-4998-a852-aab335742c31	QUANTUM PHYSICS of Atoms	Molecules, Solids, Nuclei, and Particles",Robert Eisberg and Robert Resnick	\N	\N	\N	f	bookshelf_cells/IMG_2618.jpeg	2023-12-25 16:50:51.450202	2023-12-25 16:50:51.450202
54be0ecf-530e-4b50-b973-5258624cc4e3	Pinturas Flashes Bocetos Vol. IV	Joe Ollis	\N	\N	\N	f	bookshelf_cells/IMG_2697.jpeg	2023-12-25 16:50:59.697498	2023-12-25 16:50:59.697498
0f053cd0-6acf-42ee-8c4d-387109a16103	Buildings	DK	\N	\N	\N	f	bookshelf_cells/IMG_2134.jpeg	2023-12-25 16:52:54.592762	2023-12-25 16:52:54.592762
5c1a4d23-0d64-4613-88e7-2890bd083609	Ghosts from the Nursery: Tracing the Roots of Violence	Robin Karr-Morse, Meredith S. Wiley	\N	\N	\N	f	bookshelf_cells/IMG_2638.jpeg	2023-12-25 16:54:00.121971	2023-12-25 16:54:00.121971
a849a943-6a17-46a1-bc48-1d8aefa115ef	The Rainbow and the Worm: The Physics of Organisms	Mae-Wan Ho	\N	\N	\N	f	bookshelf_cells/IMG_2655.jpeg	2023-12-25 16:54:00.123945	2023-12-25 16:54:00.123945
4fc33b41-e78a-43fb-bc6a-fd07938ea421	Pinturas - Flashes - Bocetos Vol. IV	Joe Ellis	\N	\N	\N	f	bookshelf_cells/IMG_2699.jpeg	2023-12-25 16:54:06.482301	2023-12-25 16:54:06.482301
6136c1c0-aed2-4161-a638-c4cbae828d8a	COMPANY	John Sack	\N	\N	\N	f	bookshelf_cells/IMG_2136.jpeg	2023-12-25 16:55:31.794053	2023-12-25 16:55:31.794053
2cd2fcdd-fdd3-4715-9372-e896d6604594	Doing Absolutely Nothing	Paul Wiersbinski	\N	\N	\N	f	bookshelf_cells/IMG_2151.jpeg	2023-12-25 17:02:11.226791	2023-12-25 17:02:11.226791
72f7b569-7c64-420d-9c81-03cd406cb292	Rocks and Minerals	Herbert S. Zim; Paul R. Shaffer	\N	\N	\N	f	bookshelf_cells/IMG_2394.jpeg	2023-12-25 17:02:44.829241	2023-12-25 17:02:44.829241
de98f771-4aca-4153-a0b9-1947867678ee	Drinking with Bukowski: Recollections of the Poet Laureate of Skid Row	Daniel Weizmann	\N	\N	\N	f	bookshelf_cells/IMG_2412.jpeg	2023-12-25 17:02:50.256605	2023-12-25 17:02:50.256605
371df4fb-dbff-4101-b15a-30529978ef7f	Notes from No Man's Land: American Essays	Eula Biss	\N	\N	\N	f	bookshelf_cells/IMG_2414.jpeg	2023-12-25 17:02:50.25972	2023-12-25 17:02:50.25972
a0d7585e-73c3-461e-a7ae-a645cfea421d	Rites of Spring: The Great War and the Birth of the Modern Age	Modris Eksteins	\N	\N	\N	f	bookshelf_cells/IMG_2415.jpeg	2023-12-25 17:02:50.261166	2023-12-25 17:02:50.261166
b9a614fa-a52b-4bf1-b56f-969d9456e0f9	The Rainbow and The Worm	Mae-Wan Ho	\N	\N	\N	f	bookshelf_cells/IMG_2636.jpeg	2023-12-25 17:03:05.754382	2023-12-25 17:03:05.754382
0f296d48-c075-4f27-9c32-be72c0ba69fc	Science-Fiction Studies	#54 Volume 18, Part 2	\N	\N	\N	f	bookshelf_cells/IMG_2711.jpeg	2023-12-25 17:03:19.489223	2023-12-25 17:03:19.489223
f4c7554f-ee8f-4573-b803-ad6033bf6977	STATES OF MIND	Lapham’s Quarterly	\N	\N	\N	f	bookshelf_cells/IMG_2712.jpeg	2023-12-25 17:03:19.492393	2023-12-25 17:03:19.492393
4b873aef-a033-41bc-bb8a-ed76c5aebfc0	RIVALRY & FEUD	Lapham’s Quarterly	\N	\N	\N	f	bookshelf_cells/IMG_2713.jpeg	2023-12-25 17:03:19.494825	2023-12-25 17:03:19.494825
ee3da1f6-e7e8-4116-8261-7119db0d09a3	FEAR	Lapham’s Quarterly	\N	\N	\N	f	bookshelf_cells/IMG_2714.jpeg	2023-12-25 17:03:19.497155	2023-12-25 17:03:19.497155
ea7c9a89-6e46-429b-bb05-de0c374139ab	DISCOVERY	Lapham’s Quarterly	\N	\N	\N	f	bookshelf_cells/IMG_2715.jpeg	2023-12-25 17:03:19.499472	2023-12-25 17:03:19.499472
f624b40f-9687-4182-b34c-174fd1d071ed	COMETBUS	#47","null	\N	\N	\N	f	bookshelf_cells/IMG_2177.jpeg	2023-12-25 19:54:07.618182	2023-12-25 19:54:07.618182
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
07806bc4-b41a-4c6b-a99e-c18000f46a05	bookshelf_cells/IMG_2105.jpeg	2023-12-25 15:47:55.292526
b3db14df-9e37-4d9a-ab9b-85662612919f	bookshelf_cells/IMG_2106.jpeg	2023-12-25 15:47:55.294098
9117a8ef-0cc2-43d6-be2d-9074f32a808d	bookshelf_cells/IMG_2107.jpeg	2023-12-25 15:47:55.29497
be59def2-00e7-42fd-b0a8-0b31d7b5d11a	bookshelf_cells/IMG_2108.jpeg	2023-12-25 15:47:55.295683
ea6fa7cd-b2b3-4a61-afce-fcc0c046d21f	bookshelf_cells/IMG_2109.jpeg	2023-12-25 15:47:55.296356
c4db0a6b-8fb1-4342-a931-6569034268c3	bookshelf_cells/IMG_2110.jpeg	2023-12-25 15:47:55.296952
c2244b1b-e254-463a-883a-0d980b14b54d	bookshelf_cells/IMG_2111.jpeg	2023-12-25 15:47:55.297506
06a6c312-a63f-4ea5-90f1-24464c902eb9	bookshelf_cells/IMG_2112.jpeg	2023-12-25 15:47:55.298167
c99fc018-9d1e-42d5-a5eb-f338fd7b8a17	bookshelf_cells/IMG_2113.jpeg	2023-12-25 15:47:55.299083
5ec0b8ca-d048-45c1-be41-0928219b5d56	bookshelf_cells/IMG_2114.jpeg	2023-12-25 15:47:55.299858
cad852f9-a78b-4254-ad9a-0d1fde144835	bookshelf_cells/IMG_2115.jpeg	2023-12-25 15:47:55.300486
a6fb9537-b8e5-4b11-a10e-d6deff2e1a22	bookshelf_cells/IMG_2121.jpeg	2023-12-25 15:47:55.301068
8c007f15-544c-4d84-ac13-bb80f18a0ce9	bookshelf_cells/IMG_2130.jpeg	2023-12-25 15:47:55.301785
4a90d3d6-8850-4fa8-a7ee-cd62129a2d21	bookshelf_cells/IMG_2131.jpeg	2023-12-25 15:47:55.302395
f0d97a06-097f-45e7-aee5-a84edf34d8c6	bookshelf_cells/IMG_2132.jpeg	2023-12-25 15:47:55.302991
ae2432ee-bd52-4d04-9a11-b352da2782f6	bookshelf_cells/IMG_2133.jpeg	2023-12-25 15:47:55.303576
5ad06467-e147-4b0d-a871-72e345023c12	bookshelf_cells/IMG_2139.jpeg	2023-12-25 15:48:10.543342
12b1904c-e96e-4084-a3a9-b81919e795d6	bookshelf_cells/IMG_2140.jpeg	2023-12-25 15:48:10.543928
adbc9658-46db-4bef-b89c-f21a7164e912	bookshelf_cells/IMG_2141.jpeg	2023-12-25 15:48:10.546663
390ffbfb-8fb5-48a2-9f11-7059c348bff8	bookshelf_cells/IMG_2142.jpeg	2023-12-25 15:48:10.547388
c897a0e9-7129-4489-8edc-9968773e6460	bookshelf_cells/IMG_2143.jpeg	2023-12-25 15:48:10.548088
a92e9ee1-d085-4a55-90a1-29cd28112a2a	bookshelf_cells/IMG_2144.jpeg	2023-12-25 15:48:10.548763
4257cd28-3ee9-467b-be7d-3bfa6e1f6541	bookshelf_cells/IMG_2145.jpeg	2023-12-25 15:48:10.549347
5cd2bc49-38ed-4553-903e-526cc0dec99a	bookshelf_cells/IMG_2146.jpeg	2023-12-25 15:48:10.550039
76b3666b-3fb2-440b-8b15-a9216098caad	bookshelf_cells/IMG_2147.jpeg	2023-12-25 15:48:10.550739
f0d73460-f467-4ca9-b381-36d4b7e5f799	bookshelf_cells/IMG_2148.jpeg	2023-12-25 15:48:10.551453
35a27a7d-b123-443d-b4a6-3d251f6e7bf2	bookshelf_cells/IMG_2149.jpeg	2023-12-25 15:48:10.552102
499918a0-e95d-42b2-9bab-7972f0f4a792	bookshelf_cells/IMG_2150.jpeg	2023-12-25 15:48:10.552711
24bb999d-0959-4a04-b996-fe28c51322ca	bookshelf_cells/IMG_2195.jpeg	2023-12-25 16:19:33.71646
1e6b7ba7-a8e6-4525-b915-4fea849abaec	bookshelf_cells/IMG_2711.jpeg	2023-12-25 17:03:19.500989
c9cd6c9a-9af1-4379-bf58-6dd17c4f1850	bookshelf_cells/IMG_2712.jpeg	2023-12-25 17:03:19.503265
9ad31781-67b9-4960-a10b-af45f93dfb9f	bookshelf_cells/IMG_2159.jpeg	2023-12-25 15:48:25.79639
bb1681b6-5bb5-4bf5-90cf-029e21d7d103	bookshelf_cells/IMG_2160.jpeg	2023-12-25 15:48:25.796931
5ba77108-d7bb-49f5-85e9-0becdc034e47	bookshelf_cells/IMG_2161.jpeg	2023-12-25 15:48:25.797445
550f23ef-e72a-4803-8f7a-83b63f8b4553	bookshelf_cells/IMG_2162.jpeg	2023-12-25 15:48:25.797945
2760f3d2-9a55-425e-a6b0-fef68dc52e7e	bookshelf_cells/IMG_2163.jpeg	2023-12-25 15:48:25.798434
666086cd-3830-45f9-8d8e-4c3a5883b38f	bookshelf_cells/IMG_2164.jpeg	2023-12-25 15:48:25.798954
4c5ab45e-1546-405d-8cf0-3688d4031bb1	bookshelf_cells/IMG_2165.jpeg	2023-12-25 15:48:25.799432
b1da75d0-4b54-4ecc-9882-59a808a086db	bookshelf_cells/IMG_2166.jpeg	2023-12-25 15:48:25.800024
90f7401d-ef36-4e71-bc09-0d67a40248f1	bookshelf_cells/IMG_2167.jpeg	2023-12-25 15:48:25.800683
44ca3f4f-72dd-4543-9f4b-31e77cd7705a	bookshelf_cells/IMG_2168.jpeg	2023-12-25 15:48:25.801224
59a26db0-7bcb-4071-8c84-36019e03cef3	bookshelf_cells/IMG_2169.jpeg	2023-12-25 15:48:25.801746
8f22ef7f-8fbb-4472-b29c-34743eebce9d	bookshelf_cells/IMG_2170.jpeg	2023-12-25 15:48:25.802243
3e7b7f7c-6ace-457a-adae-ab72597f333a	bookshelf_cells/IMG_2713.jpeg	2023-12-25 17:03:19.505102
9b094cdc-94b3-4b23-a1b0-df2d2e75a351	bookshelf_cells/IMG_2197.jpeg	2023-12-25 16:10:57.525594
8e5218d9-7ea7-4b25-ac9e-75710c414b56	bookshelf_cells/IMG_2714.jpeg	2023-12-25 17:03:19.506693
0d0319a8-0778-4a9d-a32d-3b4c991f2452	bookshelf_cells/IMG_2715.jpeg	2023-12-25 17:03:19.508249
b1e03f69-2d5c-4df5-b3f0-b58252b8eabe	bookshelf_cells/IMG_2178.jpeg	2023-12-25 15:48:43.361174
e6a49398-48b5-45d8-a26a-94441667caee	bookshelf_cells/IMG_2179.jpeg	2023-12-25 15:48:43.361801
fdaf2525-002d-4c7c-8fdc-7c937d576742	bookshelf_cells/IMG_2180.jpeg	2023-12-25 15:48:43.362567
9d64eb6b-51bf-4e4e-a20c-c03e84e3c6d2	bookshelf_cells/IMG_2181.jpeg	2023-12-25 15:48:43.363797
38787fc1-4cd1-4818-9d1a-c13fdc972951	bookshelf_cells/IMG_2182.jpeg	2023-12-25 15:48:43.364714
cbf518de-ddd0-43c2-8962-c08aaff4d203	bookshelf_cells/IMG_2183.jpeg	2023-12-25 15:48:43.365408
a15bb6c5-102a-4916-8641-5ef21fb0679a	bookshelf_cells/IMG_2184.jpeg	2023-12-25 15:48:43.366116
6008ffe9-d256-41fe-8ca3-62138c4e82a4	bookshelf_cells/IMG_2185.jpeg	2023-12-25 15:48:43.366776
7880126b-0690-447b-9b7f-3fa5b51aeecd	bookshelf_cells/IMG_2186.jpeg	2023-12-25 15:48:43.367348
c86f7204-1229-46ef-b5c0-9e3ecaf52a5a	bookshelf_cells/IMG_2187.jpeg	2023-12-25 15:48:43.367883
b14ebc7d-5bb7-4969-8607-4105b1fadedf	bookshelf_cells/IMG_2188.jpeg	2023-12-25 15:48:43.368421
ed7d1c10-7590-46e3-ac8f-c70f61f6dc9e	bookshelf_cells/IMG_2189.jpeg	2023-12-25 15:48:43.368988
cfe0c52b-b137-49d1-824d-fdae8f6bba61	bookshelf_cells/IMG_2190.jpeg	2023-12-25 15:48:43.369597
617791be-b10d-4cf8-a6ee-41ce0f3193ff	bookshelf_cells/IMG_2191.jpeg	2023-12-25 15:48:43.370109
8047576b-16a1-47a8-b0ce-39e1a2a31608	bookshelf_cells/IMG_2192.jpeg	2023-12-25 15:48:43.370731
2abbc4ba-1502-48bc-b489-1ec696340ed7	bookshelf_cells/IMG_2193.jpeg	2023-12-25 15:48:43.37142
23481e9e-3c38-43fb-805e-3913e0cf62de	bookshelf_cells/IMG_2279.jpeg	2023-12-25 16:11:12.572453
2227db57-c031-4959-b242-e37230ad344e	bookshelf_cells/IMG_2436.jpeg	2023-12-25 16:45:10.016198
a264f0cc-294e-4f7b-8245-0388ebba4891	bookshelf_cells/IMG_2198.jpeg	2023-12-25 15:49:06.180612
00b909ea-90dc-4f84-9786-af6d63649a24	bookshelf_cells/IMG_2199.jpeg	2023-12-25 15:49:06.181228
4460255a-05d8-4d3a-97de-a49cd77cb122	bookshelf_cells/IMG_2200.jpeg	2023-12-25 15:49:06.181864
12ab135b-eee0-4706-805e-b73b3bdf034e	bookshelf_cells/IMG_2201.jpeg	2023-12-25 15:49:06.182535
7c51ab7b-fcac-4820-88c3-30ef1580d35a	bookshelf_cells/IMG_2202.jpeg	2023-12-25 15:49:06.183255
33a61f58-e7c4-4b28-84f9-1158cc011163	bookshelf_cells/IMG_2203.jpeg	2023-12-25 15:49:06.183913
0e5d89e0-f876-46d1-9ca4-a0b0039921fb	bookshelf_cells/IMG_2204.jpeg	2023-12-25 15:49:06.184534
75031670-e2e6-4364-964c-02e9ecf26522	bookshelf_cells/IMG_2205.jpeg	2023-12-25 15:49:06.185148
be3dddcb-dbe2-4687-aeb8-6aea66a04e2c	bookshelf_cells/IMG_2206.jpeg	2023-12-25 15:49:06.185729
e9715624-5363-4b4a-bde1-08d8cf62816f	bookshelf_cells/IMG_2207.jpeg	2023-12-25 15:49:06.186264
0559abf6-d061-481a-a4d6-7bb6a28b0249	bookshelf_cells/IMG_2208.jpeg	2023-12-25 15:49:06.186758
09a1d12b-4524-48fb-b5bc-73364f7bed5c	bookshelf_cells/IMG_2209.jpeg	2023-12-25 15:49:06.187478
c52ff2dd-b50f-4680-bcb4-0e9ffe16216a	bookshelf_cells/IMG_2210.jpeg	2023-12-25 15:49:06.188241
96e4f27d-0072-4033-afda-b3b6b60b8505	bookshelf_cells/IMG_2342.jpeg	2023-12-25 16:47:36.388629
91687136-a42a-478a-929c-dae8596bbf39	bookshelf_cells/IMG_2359.jpeg	2023-12-25 16:19:52.921249
934383ab-ed2a-43d0-90d5-b98f9f2ced59	bookshelf_cells/IMG_2241.jpeg	2023-12-25 15:49:27.205049
35c9d63a-48c6-4fde-ac01-4152c64ed207	bookshelf_cells/IMG_2242.jpeg	2023-12-25 15:49:27.205696
34e2b040-b741-4dcb-b655-8517386c5770	bookshelf_cells/IMG_2243.jpeg	2023-12-25 15:49:27.206274
0f05e5a7-3efb-4c88-80d9-e32826026708	bookshelf_cells/IMG_2244.jpeg	2023-12-25 15:49:27.206866
8f1a25bf-e6fb-4af5-b463-92494bd5544a	bookshelf_cells/IMG_2245.jpeg	2023-12-25 15:49:27.207414
e415a534-8c58-4153-b2f7-76e5575e2f23	bookshelf_cells/IMG_2246.jpeg	2023-12-25 15:49:27.207994
f58d0cb0-c25b-4ff8-a114-7caa433320e8	bookshelf_cells/IMG_2247.jpeg	2023-12-25 15:49:27.208629
b9dc17cc-b94a-454d-a1c5-d711227b505e	bookshelf_cells/IMG_2248.jpeg	2023-12-25 15:49:27.2093
a2f65cde-1292-435e-be21-e45083fe57d6	bookshelf_cells/IMG_2249.jpeg	2023-12-25 15:49:27.20999
d28a2364-4f1f-406e-ae56-e124540d2ed9	bookshelf_cells/IMG_2250.jpeg	2023-12-25 15:49:27.210728
b232accc-de01-4b63-8fb7-bdc0e6bb9c72	bookshelf_cells/IMG_2251.jpeg	2023-12-25 15:49:27.211346
4dc7a1fa-9903-46e5-9f66-1edf23b2acd3	bookshelf_cells/IMG_2252.jpeg	2023-12-25 15:49:27.211941
8059c7db-3b34-41ba-95e7-c1491aaf249d	bookshelf_cells/IMG_2253.jpeg	2023-12-25 15:49:27.212561
4a5d4de3-5a3e-40ce-9449-0ad9c0fa6695	bookshelf_cells/IMG_2254.jpeg	2023-12-25 15:49:27.213188
091b05ba-544d-4693-8bc4-a7345ee9140f	bookshelf_cells/IMG_2255.jpeg	2023-12-25 15:49:27.213815
6b2e7f83-bc9e-4fcd-850a-2cb935ddd9ce	bookshelf_cells/IMG_2256.jpeg	2023-12-25 15:49:27.214418
b7d37ec9-5559-4f61-9aba-350de7f78bdf	bookshelf_cells/IMG_2257.jpeg	2023-12-25 15:49:27.215055
9ba36c23-29b7-4bdf-9bc0-37dc42ab1ca9	bookshelf_cells/IMG_2261.jpeg	2023-12-25 15:49:44.673502
babe8dc7-b3cf-4039-9784-d7883ec88b1b	bookshelf_cells/IMG_2262.jpeg	2023-12-25 15:49:44.674768
8c62c264-190d-4455-b19c-596245314255	bookshelf_cells/IMG_2263.jpeg	2023-12-25 15:49:44.675512
5ef03802-3472-4058-aa52-b8c45cbafc1b	bookshelf_cells/IMG_2264.jpeg	2023-12-25 15:49:44.676048
3461f4e6-153e-4a2f-965a-4adae0564de8	bookshelf_cells/IMG_2265.jpeg	2023-12-25 15:49:44.676669
8d966dd6-7eb8-453a-8ed7-bd4c340b60ba	bookshelf_cells/IMG_2266.jpeg	2023-12-25 15:49:44.677272
f093f84d-4f30-4d61-a20a-df210a31240e	bookshelf_cells/IMG_2267.jpeg	2023-12-25 15:49:44.677899
11bb660a-2cb8-4b18-b535-a93db4706591	bookshelf_cells/IMG_2268.jpeg	2023-12-25 15:49:44.678668
b837f3e7-efd1-4065-9984-cc3f48a3bbad	bookshelf_cells/IMG_2269.jpeg	2023-12-25 15:49:44.679282
b6db7aec-6c38-4578-a9f5-3bff091b58d5	bookshelf_cells/IMG_2270.jpeg	2023-12-25 15:49:44.679751
5f996da8-7a93-4e84-8a5d-98284507633d	bookshelf_cells/IMG_2271.jpeg	2023-12-25 15:49:44.680244
f0b26eef-a00c-4ab9-aa1e-310260fd2e1f	bookshelf_cells/IMG_2272.jpeg	2023-12-25 15:49:44.680719
681b2c56-619e-47d9-8962-edf86f3bf7de	bookshelf_cells/IMG_2273.jpeg	2023-12-25 15:49:44.681155
09db65de-4f8b-46ca-9af5-0a9a9b13b72a	bookshelf_cells/IMG_2274.jpeg	2023-12-25 15:49:44.681616
f5142e78-507e-4ba1-94b3-8e65fc02928a	bookshelf_cells/IMG_2275.jpeg	2023-12-25 15:49:44.682064
d5091b7c-498e-47c3-b01f-5d76f427817b	bookshelf_cells/IMG_2177.jpeg	2023-12-25 19:54:07.624687
a7665ce4-cc8a-47b4-9809-12648f5fd0ea	bookshelf_cells/IMG_2281.jpeg	2023-12-25 15:50:04.320358
01088ae6-56f8-4ba0-8dfb-fbc0a75113e7	bookshelf_cells/IMG_2282.jpeg	2023-12-25 15:50:04.32165
1ba960a5-92cf-47ed-8957-eef245f3cecc	bookshelf_cells/IMG_2283.jpeg	2023-12-25 15:50:04.322659
bd1fdac6-8058-4cd5-b1ee-3c3dce45db71	bookshelf_cells/IMG_2284.jpeg	2023-12-25 15:50:04.32335
f0fb05c7-9f16-4fa3-8382-487e3a8d5ed2	bookshelf_cells/IMG_2285.jpeg	2023-12-25 15:50:04.323996
d02b8a91-54e5-4216-a1aa-7e91b92b32d9	bookshelf_cells/IMG_2286.jpeg	2023-12-25 15:50:04.324563
da346921-3255-4546-bd10-30d89f53020a	bookshelf_cells/IMG_2287.jpeg	2023-12-25 15:50:04.325074
310cbe00-dcf8-4bdb-8328-8b8a37617d54	bookshelf_cells/IMG_2288.jpeg	2023-12-25 15:50:04.325596
ebb2da04-dcab-4d9c-8fe8-c4c0beff5567	bookshelf_cells/IMG_2289.jpeg	2023-12-25 15:50:04.326102
6e56af3b-b4a5-4d1a-b215-0240156b3be1	bookshelf_cells/IMG_2290.jpeg	2023-12-25 15:50:04.326587
20447b73-3084-4306-8bc3-ed5ff8a5e619	bookshelf_cells/IMG_2291.jpeg	2023-12-25 15:50:04.327071
29271fcc-d092-4895-b397-24a3f6719a96	bookshelf_cells/IMG_2292.jpeg	2023-12-25 15:50:04.327542
d9083204-50bb-4814-8ea3-cf8eb45806c2	bookshelf_cells/IMG_2293.jpeg	2023-12-25 15:50:04.328016
0ffd643c-baaa-4fee-978a-3f29ab76aca3	bookshelf_cells/IMG_2294.jpeg	2023-12-25 15:50:04.328591
fd9e86fd-5046-443e-9fce-c1f69fd22870	bookshelf_cells/IMG_2295.jpeg	2023-12-25 15:50:04.329185
bf8741d8-9331-41e4-a33f-63d57daf6918	bookshelf_cells/IMG_2296.jpeg	2023-12-25 15:50:04.329678
f2bbcc15-0f35-426d-abc0-c812faf747c2	bookshelf_cells/IMG_2297.jpeg	2023-12-25 15:50:04.330136
e4e408d1-ee1f-46e3-bedc-128c5f335f40	bookshelf_cells/IMG_2196.jpeg	2023-12-25 16:42:16.51334
a86cfcfb-6187-495e-acb2-3111eb803c07	bookshelf_cells/IMG_2301.jpeg	2023-12-25 15:50:22.914883
7989d72d-ae74-43db-99b1-1d1a8db2a7b4	bookshelf_cells/IMG_2302.jpeg	2023-12-25 15:50:22.915676
199acd19-a1c6-4511-99c5-a0a956d30ff2	bookshelf_cells/IMG_2303.jpeg	2023-12-25 15:50:22.916357
3ba76ac9-ca00-4d0f-9f03-1e41a7d31796	bookshelf_cells/IMG_2304.jpeg	2023-12-25 15:50:22.917093
0af03f88-4ce3-4475-8958-749242fdd9bd	bookshelf_cells/IMG_2305.jpeg	2023-12-25 15:50:22.917846
2657bdb6-bf92-45ad-8706-3393ae952820	bookshelf_cells/IMG_2306.jpeg	2023-12-25 15:50:22.918499
874f7192-d8f1-4abf-827c-59d17ac38424	bookshelf_cells/IMG_2307.jpeg	2023-12-25 15:50:22.919021
3c7623cd-61a0-4bc2-ab1a-dff3b920f6a2	bookshelf_cells/IMG_2308.jpeg	2023-12-25 15:50:22.9195
f888e169-7b4c-48e6-a51f-454867f8eca5	bookshelf_cells/IMG_2309.jpeg	2023-12-25 15:50:22.919978
226efb9d-7741-43ee-80e1-5b8e1e876cb0	bookshelf_cells/IMG_2310.jpeg	2023-12-25 15:50:22.920457
2a8145b0-6129-430d-952e-6b3b4b8f76db	bookshelf_cells/IMG_2311.jpeg	2023-12-25 15:50:22.921003
62b1cc33-44df-433f-9039-425d4e21069f	bookshelf_cells/IMG_2312.jpeg	2023-12-25 15:50:22.921491
85c15c39-750f-41b2-b5c1-8c10c4b61689	bookshelf_cells/IMG_2313.jpeg	2023-12-25 15:50:22.922008
7164cdab-63c8-47f9-8570-68c99e06238f	bookshelf_cells/IMG_2314.jpeg	2023-12-25 15:50:22.92307
1e4815bf-6c6d-420a-8187-bed56f589645	bookshelf_cells/IMG_2315.jpeg	2023-12-25 15:50:22.924138
4a8afed2-8e15-4241-90cc-2d84b9bab6a0	bookshelf_cells/IMG_2316.jpeg	2023-12-25 15:50:22.924963
25c6471a-c8d5-469e-9d76-bd387cb4ce74	bookshelf_cells/IMG_2317.jpeg	2023-12-25 15:50:22.925958
5ce21345-659b-4eb7-8c36-ce4850986d39	bookshelf_cells/IMG_2318.jpeg	2023-12-25 15:50:22.926585
c56955a3-766d-419a-8fa4-4473aeb52e44	bookshelf_cells/IMG_2323.jpeg	2023-12-25 15:50:43.82291
64a481b0-c1f9-4827-9e26-1157b8c00d53	bookshelf_cells/IMG_2324.jpeg	2023-12-25 15:50:43.823654
0cc0c84e-13b8-4f8a-8ae4-d9b8942fd2f9	bookshelf_cells/IMG_2325.jpeg	2023-12-25 15:50:43.824341
203212d4-f078-4b82-801e-c675cd58b5e5	bookshelf_cells/IMG_2326.jpeg	2023-12-25 15:50:43.82504
4cdffaa4-44cd-4084-957a-360b3e3ebc02	bookshelf_cells/IMG_2327.jpeg	2023-12-25 15:50:43.825788
69b83d0a-cbcb-4e01-ac76-bd0e1bf72f7c	bookshelf_cells/IMG_2328.jpeg	2023-12-25 15:50:43.826732
66dbb7db-a1ce-4f93-98df-40df97067c87	bookshelf_cells/IMG_2329.jpeg	2023-12-25 15:50:43.828344
c4abc79d-c436-4bd7-b7de-dbba3f06ccad	bookshelf_cells/IMG_2330.jpeg	2023-12-25 15:50:43.828973
6f4b2868-9893-4069-b9fd-4acfc78bb2b6	bookshelf_cells/IMG_2331.jpeg	2023-12-25 15:50:43.829636
2559869f-a396-46d8-9543-69454ae8a0f6	bookshelf_cells/IMG_2332.jpeg	2023-12-25 15:50:43.830136
82570a57-67cf-4cfd-8631-253b823c7e47	bookshelf_cells/IMG_2333.jpeg	2023-12-25 15:50:43.830575
c698ad2d-3723-4e9a-b29a-0070359ce2ee	bookshelf_cells/IMG_2334.jpeg	2023-12-25 15:50:43.830999
26938b6d-d010-4e7f-8ebd-f19c318fe5ee	bookshelf_cells/IMG_2335.jpeg	2023-12-25 15:50:43.831411
bd4dba81-3590-405f-8368-2da6284b8d59	bookshelf_cells/IMG_2336.jpeg	2023-12-25 15:50:43.831831
183afa5d-b9cf-4ac3-b5e1-f3db16a210f8	bookshelf_cells/IMG_2172.jpeg	2023-12-25 16:14:38.408056
09fb9178-748f-4234-9eb5-3e4dc4e570a6	bookshelf_cells/IMG_2337.jpeg	2023-12-25 15:50:43.832219
755671c0-488f-4d96-9540-4be5146a79e8	bookshelf_cells/IMG_2398.jpeg	2023-12-25 16:11:35.916078
9cbe9ced-78e1-47cd-87fe-92670131b578	bookshelf_cells/IMG_2399.jpeg	2023-12-25 16:11:35.917135
1556ac28-90fb-48ff-a4a8-fec929a7a530	bookshelf_cells/IMG_2400.jpeg	2023-12-25 16:11:35.918109
bc78e287-ccef-4478-a278-bf1b26d95319	bookshelf_cells/IMG_2401.jpeg	2023-12-25 16:11:35.918752
89034ee8-2566-4de8-8091-f8051b0b9bd9	bookshelf_cells/IMG_2402.jpeg	2023-12-25 16:11:35.919417
f659e3e7-2298-4a79-b344-68e88d8c8e4b	bookshelf_cells/IMG_2343.jpeg	2023-12-25 15:50:59.832248
4f9914a9-abb9-4d4e-bc69-b997c6b031b4	bookshelf_cells/IMG_2344.jpeg	2023-12-25 15:50:59.833115
462911e5-bcbd-44a5-b1df-447535c97ea4	bookshelf_cells/IMG_2345.jpeg	2023-12-25 15:50:59.834422
8a9b6cd9-bef2-40b8-b14e-0083b177cd81	bookshelf_cells/IMG_2346.jpeg	2023-12-25 15:50:59.835322
19d43eee-1b86-42ef-8753-98da72d27dea	bookshelf_cells/IMG_2347.jpeg	2023-12-25 15:50:59.836271
fb83201a-4dab-44bf-a35a-8c77e2ad97e8	bookshelf_cells/IMG_2348.jpeg	2023-12-25 15:50:59.837064
2109c949-d1e5-425d-b1e9-3b649b3df429	bookshelf_cells/IMG_2349.jpeg	2023-12-25 15:50:59.837849
39bd0e8e-60b0-4949-baec-2779a9d89eb4	bookshelf_cells/IMG_2350.jpeg	2023-12-25 15:50:59.838611
b84154d6-f3c3-45f2-87e5-65231da48823	bookshelf_cells/IMG_2351.jpeg	2023-12-25 15:50:59.839228
00b016cd-f2c5-433b-9c6b-032bbc671624	bookshelf_cells/IMG_2352.jpeg	2023-12-25 15:50:59.839866
3783a429-a81d-49ea-a635-9300814c40b8	bookshelf_cells/IMG_2353.jpeg	2023-12-25 15:50:59.840473
0b87c411-549e-4e3f-9444-f65da63ae108	bookshelf_cells/IMG_2354.jpeg	2023-12-25 15:50:59.841055
76646415-07aa-4fce-ae1d-be13e11dad79	bookshelf_cells/IMG_2355.jpeg	2023-12-25 15:50:59.841662
19a3ed5d-db41-4a09-8d88-5ffc08f38e9d	bookshelf_cells/IMG_2356.jpeg	2023-12-25 15:50:59.842569
a2365042-6f55-401b-b6a9-e7177c07f873	bookshelf_cells/IMG_2357.jpeg	2023-12-25 15:50:59.843145
d4277e59-d275-4a26-9f3f-63d52084bf18	bookshelf_cells/IMG_2403.jpeg	2023-12-25 16:11:35.920077
379b1ede-2ac0-4e81-8ade-5381c499e477	bookshelf_cells/IMG_2404.jpeg	2023-12-25 16:11:35.921042
b6459de3-791f-430d-a8cd-566699f2ed4c	bookshelf_cells/IMG_2405.jpeg	2023-12-25 16:11:35.922454
694fb1fc-3a47-49d5-83e7-8c778317ed87	bookshelf_cells/IMG_2135.jpeg	2023-12-25 16:02:13.24761
83f36a31-a702-4df9-afaf-eaa4751886a4	bookshelf_cells/IMG_2406.jpeg	2023-12-25 16:11:35.923747
148bb776-9e22-496e-a1d3-4398561344b4	bookshelf_cells/IMG_2407.jpeg	2023-12-25 16:11:35.924681
729cbfe7-ea7f-4a5b-a45b-0e07c47750a5	bookshelf_cells/IMG_2138.jpeg	2023-12-25 16:02:13.249557
89bc19d4-760e-40f2-95bb-da693348045f	bookshelf_cells/IMG_2408.jpeg	2023-12-25 16:11:35.92544
9373ac98-7a33-4373-9720-708dda23901b	bookshelf_cells/IMG_2152.jpeg	2023-12-25 16:02:13.250868
143e389c-ae77-41c4-91e8-7ffea992edf2	bookshelf_cells/IMG_2409.jpeg	2023-12-25 16:11:35.926326
290161ba-23fd-475e-be82-41521e9e02c2	bookshelf_cells/IMG_2410.jpeg	2023-12-25 16:11:35.927061
281aff9c-7afd-4129-b2f9-ab53a39dff67	bookshelf_cells/IMG_2155.jpeg	2023-12-25 16:02:13.253222
078eaa11-5bf0-43a5-bf5a-d2314edbecde	bookshelf_cells/IMG_2638.jpeg	2023-12-25 16:54:00.126448
ba0bc9b0-3c9c-4835-8c50-308f7f12473a	bookshelf_cells/IMG_2158.jpeg	2023-12-25 16:02:13.256683
6da75d3d-9182-46af-8d89-802d6ff9dd21	bookshelf_cells/IMG_2655.jpeg	2023-12-25 16:54:00.127109
7631f0fd-c8a2-4a79-b353-a608ffcd040b	bookshelf_cells/IMG_2417.jpeg	2023-12-25 16:20:13.778587
e4c82fd1-41e5-493e-b64c-e4039e887460	bookshelf_cells/IMG_2173.jpeg	2023-12-25 16:02:13.258743
756fb93c-76fb-482e-8abe-3f963f760b54	bookshelf_cells/IMG_2418.jpeg	2023-12-25 16:11:55.603211
cdb7c3c7-1ad9-43a4-aad3-335b71324719	bookshelf_cells/IMG_2419.jpeg	2023-12-25 16:11:55.60384
75fabf80-a615-4c6c-8806-3a047404f7fb	bookshelf_cells/IMG_2420.jpeg	2023-12-25 16:11:55.604605
fbae7176-ec9d-4080-bd0b-5db3f91545d1	bookshelf_cells/IMG_2421.jpeg	2023-12-25 16:11:55.605788
1f7da29d-c53d-454c-9f75-e58f95d94a85	bookshelf_cells/IMG_2422.jpeg	2023-12-25 16:11:55.60664
6cb52ddc-a100-4899-b5f4-4ec4790b7a40	bookshelf_cells/IMG_2423.jpeg	2023-12-25 16:11:55.60744
2dbf327d-e2e2-427e-9a21-367a526d33cf	bookshelf_cells/IMG_2235.jpeg	2023-12-25 16:02:34.412516
59a78f9a-9a1d-4026-9b4b-03b3fb89ce9f	bookshelf_cells/IMG_2236.jpeg	2023-12-25 16:02:34.412975
ee00807e-43aa-45d8-a80c-3271778fe9e7	bookshelf_cells/IMG_2237.jpeg	2023-12-25 16:02:34.413486
298eed43-efc2-4d00-8aec-8216c77a59fc	bookshelf_cells/IMG_2424.jpeg	2023-12-25 16:11:55.608148
dbf52b7c-c911-499f-a73a-52a87d0a6900	bookshelf_cells/IMG_2425.jpeg	2023-12-25 16:11:55.608814
ae7dde9d-7a1d-4458-9cb6-2cb7a4c06ed6	bookshelf_cells/IMG_2426.jpeg	2023-12-25 16:11:55.609731
40118d58-7333-4fb9-8766-cb3e7d31179a	bookshelf_cells/IMG_2427.jpeg	2023-12-25 16:11:55.610529
cb83973d-522d-4987-b537-62cbb01760f6	bookshelf_cells/IMG_2428.jpeg	2023-12-25 16:11:55.611174
f7de94ae-8eb0-41b3-a5c7-fc0136e36909	bookshelf_cells/IMG_2429.jpeg	2023-12-25 16:11:55.611983
f0ec6bb8-5eec-4070-843a-0716fce40112	bookshelf_cells/IMG_2276.jpeg	2023-12-25 16:02:34.417701
c238fd7d-6603-4767-8602-6a63b820a6e1	bookshelf_cells/IMG_2430.jpeg	2023-12-25 16:11:55.612742
99fcc02c-2124-49a1-ad9f-26db8f026071	bookshelf_cells/IMG_2278.jpeg	2023-12-25 16:02:34.418763
7b16f2df-b409-4952-8abc-787750a8b746	bookshelf_cells/IMG_2431.jpeg	2023-12-25 16:11:55.613477
f0d3423b-46d2-429b-a03e-97d9c07f6596	bookshelf_cells/IMG_2432.jpeg	2023-12-25 16:11:55.614079
685e82c5-2f0d-42b1-b762-1e078c29b467	bookshelf_cells/IMG_2532.jpeg	2023-12-25 16:20:13.783056
62ebb5e4-d505-43d2-b1e5-9e48b61918b9	bookshelf_cells/IMG_2577.jpeg	2023-12-25 16:47:56.472493
184ba33f-88af-4210-b8b4-70f70c7b19f7	bookshelf_cells/IMG_2438.jpeg	2023-12-25 16:12:14.215093
c07a6cde-3eb8-4859-8e2a-2bfab7da4860	bookshelf_cells/IMG_2339.jpeg	2023-12-25 16:02:46.247884
d06bc996-4004-40a0-9dda-fc752c196b16	bookshelf_cells/IMG_2439.jpeg	2023-12-25 16:12:14.215522
24deb1bb-6772-4c3c-a39c-c06a070389de	bookshelf_cells/IMG_2341.jpeg	2023-12-25 16:02:46.249144
b6944cdd-d28d-4393-b7a8-ac62485d2195	bookshelf_cells/IMG_2440.jpeg	2023-12-25 16:12:14.215908
f772cafe-edbc-499f-9d37-04a4d5f2c046	bookshelf_cells/IMG_2441.jpeg	2023-12-25 16:12:14.21632
f60112ba-acf4-49ca-91d5-bc813d91f9bc	bookshelf_cells/IMG_2442.jpeg	2023-12-25 16:12:14.216785
e3f1dd2e-1f94-49a4-90a6-b16c4bdb2400	bookshelf_cells/IMG_2443.jpeg	2023-12-25 16:12:14.217253
c7847117-6b50-4044-a19e-3e0a05713434	bookshelf_cells/IMG_2444.jpeg	2023-12-25 16:12:14.217688
bd7860aa-3423-42d3-a90f-86dbfdec26a3	bookshelf_cells/IMG_2445.jpeg	2023-12-25 16:12:14.218094
408a81ed-4e34-41bd-966d-23e89bee94ca	bookshelf_cells/IMG_2446.jpeg	2023-12-25 16:12:14.21854
40457b05-d103-4e58-b369-29dd72a07e80	bookshelf_cells/IMG_2447.jpeg	2023-12-25 16:12:14.21893
99cc63c9-c835-4500-aef7-75a30c81affd	bookshelf_cells/IMG_2154.jpeg	2023-12-25 16:06:36.486545
1aeaaaec-1831-462f-bc8d-78a384d55142	bookshelf_cells/IMG_2448.jpeg	2023-12-25 16:12:14.219303
0ef6cd69-e8b6-4a5d-bc31-9fbab380118c	bookshelf_cells/IMG_2449.jpeg	2023-12-25 16:12:14.21967
4315d2fd-0ec5-4ece-abc3-361a8ee3cc84	bookshelf_cells/IMG_2450.jpeg	2023-12-25 16:12:14.220039
c8e6ec00-c77b-4f58-9105-f83ae0a4054b	bookshelf_cells/IMG_2451.jpeg	2023-12-25 16:12:14.220414
9df093bb-a6f1-401b-8a93-ff245e0db78e	bookshelf_cells/IMG_2452.jpeg	2023-12-25 16:12:14.221144
ae417a20-707e-46ba-ba88-eb7b3de92e10	bookshelf_cells/IMG_2175.jpeg	2023-12-25 16:06:36.490278
816c34c8-d426-4646-bfef-b73dfd50371f	bookshelf_cells/IMG_2176.jpeg	2023-12-25 16:06:36.490844
cd8ef2e6-1e33-4867-92d6-8d5511a2ca57	bookshelf_cells/IMG_2453.jpeg	2023-12-25 16:12:14.221915
e5769b49-f5d7-4668-a5f3-9e6ba4cde415	bookshelf_cells/IMG_2454.jpeg	2023-12-25 16:12:14.222421
f891a9db-d04e-4c2f-ac9b-0c888b0bc794	bookshelf_cells/IMG_2455.jpeg	2023-12-25 16:12:14.222885
f1012ad2-709a-4537-827e-abbe99be087e	bookshelf_cells/IMG_2456.jpeg	2023-12-25 16:12:14.223301
6a8925c2-016f-46f1-b915-3aa8e5f9a1d1	bookshelf_cells/IMG_2538.jpeg	2023-12-25 16:20:13.784209
7e3963a7-b540-42c0-9b8a-10c9f9a46b23	bookshelf_cells/IMG_2458.jpeg	2023-12-25 16:12:32.450277
b60ebc1c-759f-488f-a670-68d231e925b5	bookshelf_cells/IMG_2459.jpeg	2023-12-25 16:12:32.450982
20e6fd30-f7ed-4536-a9cf-6e40a84dc254	bookshelf_cells/IMG_2239.jpeg	2023-12-25 16:06:49.998025
4897d6b2-b797-46c2-8563-a923fb40214f	bookshelf_cells/IMG_2460.jpeg	2023-12-25 16:12:32.451593
1da82423-4271-4953-849e-9b1aa2a99d8e	bookshelf_cells/IMG_2461.jpeg	2023-12-25 16:12:32.452239
71bef36b-2a23-4428-9f10-28a9c210378b	bookshelf_cells/IMG_2462.jpeg	2023-12-25 16:12:32.452819
e0bb07b4-78cc-4bfb-ba78-3b960ffad600	bookshelf_cells/IMG_2463.jpeg	2023-12-25 16:12:32.453431
910da96e-5d52-480a-9287-87f3d8666737	bookshelf_cells/IMG_2277.jpeg	2023-12-25 16:06:50.001319
ec999b88-84f9-485a-a39e-cf519239606a	bookshelf_cells/IMG_2464.jpeg	2023-12-25 16:12:32.45406
9b1ca9fd-7920-4089-b459-bfcea25d57f5	bookshelf_cells/IMG_2465.jpeg	2023-12-25 16:12:32.454557
47736311-4f3b-4ca9-bf37-25c919a13728	bookshelf_cells/IMG_2466.jpeg	2023-12-25 16:12:32.455071
d61fdcd9-ed3b-43f2-806a-9a29a65816c8	bookshelf_cells/IMG_2467.jpeg	2023-12-25 16:12:32.455942
c1f2c641-963b-4e99-afe9-5566b99ce5ff	bookshelf_cells/IMG_2468.jpeg	2023-12-25 16:12:32.456501
f6005f3e-8c5c-43a9-a54f-c3c4bfba15b6	bookshelf_cells/IMG_2319.jpeg	2023-12-25 16:06:50.004182
9a16c1cf-a2d0-4e1c-af68-149cdbc5ecb5	bookshelf_cells/IMG_2469.jpeg	2023-12-25 16:12:32.457023
cd6e6577-fc99-49c0-a9ee-a63061aa734d	bookshelf_cells/IMG_2470.jpeg	2023-12-25 16:12:32.457597
2af6b77a-4ab8-4c56-9b18-7289274ca716	bookshelf_cells/IMG_2471.jpeg	2023-12-25 16:12:32.458155
95b2ff96-8579-4619-ac94-ac5639b37ff0	bookshelf_cells/IMG_2472.jpeg	2023-12-25 16:12:32.458667
06d25303-5aba-4788-bf0f-08780bac6fbc	bookshelf_cells/IMG_2473.jpeg	2023-12-25 16:12:32.459175
aa926895-7a1b-47be-89ea-47fce79707af	bookshelf_cells/IMG_2474.jpeg	2023-12-25 16:12:32.459675
a5d1c17e-9b04-4af7-bcfe-a4935aabc9c1	bookshelf_cells/IMG_2475.jpeg	2023-12-25 16:12:32.460256
1aa09368-b199-4e5a-9c0b-0c767a2c9965	bookshelf_cells/IMG_2476.jpeg	2023-12-25 16:12:32.46086
3aac3d8c-b14f-49d4-9098-b0343419317d	bookshelf_cells/IMG_2477.jpeg	2023-12-25 16:12:32.461446
2d9dbf4f-bc29-462f-af74-f10db9d3cdbc	bookshelf_cells/IMG_2478.jpeg	2023-12-25 16:12:52.721066
dd989e46-76df-46ad-a880-75ba434c4469	bookshelf_cells/IMG_2479.jpeg	2023-12-25 16:12:52.721791
93cd18b3-2f57-4dab-9080-a482530d014e	bookshelf_cells/IMG_2480.jpeg	2023-12-25 16:12:52.722407
09b76831-30de-4cc8-bc19-9396475793e2	bookshelf_cells/IMG_2481.jpeg	2023-12-25 16:12:52.722943
b03e239d-2ac9-42b1-bdf8-26d9279a5ec9	bookshelf_cells/IMG_2482.jpeg	2023-12-25 16:12:52.723448
27b72216-502b-4d89-9c2d-28b5a9152649	bookshelf_cells/IMG_2483.jpeg	2023-12-25 16:12:52.723936
dfec9c1e-9759-4653-be29-c6a605e9de1c	bookshelf_cells/IMG_2484.jpeg	2023-12-25 16:12:52.724356
76c25424-14a7-4903-8a48-75d744932cfa	bookshelf_cells/IMG_2485.jpeg	2023-12-25 16:12:52.724752
3ee0b6d3-4ddd-4618-a575-f58104245347	bookshelf_cells/IMG_2486.jpeg	2023-12-25 16:12:52.7252
a46c9ce6-bec2-447f-86d9-0debef013b12	bookshelf_cells/IMG_2487.jpeg	2023-12-25 16:12:52.725702
26549b13-37ba-40cc-bfe5-e4c201177bc3	bookshelf_cells/IMG_2488.jpeg	2023-12-25 16:12:52.726346
3f0e3122-0264-46d0-ad4f-61d7e8bc0a6b	bookshelf_cells/IMG_2489.jpeg	2023-12-25 16:12:52.726849
ba729255-9136-425e-8fcd-e0aa4565dfa5	bookshelf_cells/IMG_2558.jpeg	2023-12-25 16:20:13.784856
90519d4e-f70f-4f08-92c1-18a338faf7eb	bookshelf_cells/IMG_2491.jpeg	2023-12-25 16:12:52.727986
95a812f8-2471-4b4a-b4e0-90062708a529	bookshelf_cells/IMG_2509.jpeg	2023-12-25 16:12:52.728857
70c6097d-edc5-4f8e-91b8-bb961dd339eb	bookshelf_cells/IMG_2510.jpeg	2023-12-25 16:12:52.729457
f1de8989-c3c3-48d8-992f-b0d503eaa7ac	bookshelf_cells/IMG_2511.jpeg	2023-12-25 16:12:52.730085
947ceb07-655c-41a1-a21e-3951a774e9be	bookshelf_cells/IMG_2512.jpeg	2023-12-25 16:12:52.730716
6bb69b45-76fb-4ac6-9041-fd53e9aabbe8	bookshelf_cells/IMG_2513.jpeg	2023-12-25 16:12:52.731634
c176d34c-bf03-4905-bd46-642b231b5a4a	bookshelf_cells/IMG_2578.jpeg	2023-12-25 16:47:56.473287
24692b68-d27a-4aa2-871f-4cefdc5494fb	bookshelf_cells/IMG_2515.jpeg	2023-12-25 16:13:12.038616
39a96c82-1cf2-41fd-b94d-e470fff31821	bookshelf_cells/IMG_2516.jpeg	2023-12-25 16:13:12.039292
aa474993-cb3c-4181-a57e-51f9d51d1109	bookshelf_cells/IMG_2517.jpeg	2023-12-25 16:13:12.039907
1111d19d-884d-4a26-8fb1-49d987302567	bookshelf_cells/IMG_2518.jpeg	2023-12-25 16:13:12.040545
fc77b71c-f201-49dc-8a30-0e60d8362dbb	bookshelf_cells/IMG_2519.jpeg	2023-12-25 16:13:12.041147
87cac8e4-c9ad-47ee-b7ce-438147aa1141	bookshelf_cells/IMG_2520.jpeg	2023-12-25 16:13:12.041674
eb9a43a2-7edf-4491-bead-fcbefcaf5809	bookshelf_cells/IMG_2521.jpeg	2023-12-25 16:13:12.042222
9387ece6-cd19-45bc-9297-422a19b2116b	bookshelf_cells/IMG_2522.jpeg	2023-12-25 16:13:12.04273
81622ec0-db86-4600-b7bb-670b839e86f6	bookshelf_cells/IMG_2523.jpeg	2023-12-25 16:13:12.043232
45e4b90a-56a0-4ed5-8116-24871f264e53	bookshelf_cells/IMG_2524.jpeg	2023-12-25 16:13:12.043777
377faae0-e9af-45c4-a448-b5e18122c6a0	bookshelf_cells/IMG_2525.jpeg	2023-12-25 16:13:12.044351
4b358426-9fdc-4c9f-8069-97a0d911be15	bookshelf_cells/IMG_2526.jpeg	2023-12-25 16:13:12.044859
c985d470-6a60-44d6-b1c6-6825cc38231e	bookshelf_cells/IMG_2527.jpeg	2023-12-25 16:13:12.045322
d31f870d-5b68-4836-9655-f74ec5a5b0f9	bookshelf_cells/IMG_2528.jpeg	2023-12-25 16:13:12.045788
f5ecbb71-1e9b-4b55-809c-7b1a2859ca2b	bookshelf_cells/IMG_2529.jpeg	2023-12-25 16:13:12.046367
bbed8c38-2d3b-4e0d-9c9f-c544d63e8c20	bookshelf_cells/IMG_2530.jpeg	2023-12-25 16:13:12.046995
922c89c1-b6de-4932-9eae-0a091b76d973	bookshelf_cells/IMG_2531.jpeg	2023-12-25 16:13:12.047574
f36db575-1383-41d0-a29b-0dd02624717b	bookshelf_cells/IMG_2699.jpeg	2023-12-25 16:54:06.487489
e6bd3529-65f3-4f62-a148-4c89adaa73d6	bookshelf_cells/IMG_2576.jpeg	2023-12-25 16:20:13.786672
994875b8-bff1-4648-9755-e745de362972	bookshelf_cells/IMG_2358.jpeg	2023-12-25 16:42:32.6886
0df7d911-7369-4914-a907-1c9880aa2e1f	bookshelf_cells/IMG_2617.jpeg	2023-12-25 16:47:56.475785
ebf7b4c2-ffd0-40b5-8246-3de053c4d6fb	bookshelf_cells/IMG_2194.jpeg	2023-12-25 16:28:26.239165
589f8aed-d51b-488c-9804-647079035954	bookshelf_cells/IMG_2698.jpeg	2023-12-25 16:48:17.030351
12bbe06f-c313-4105-8bee-fcfcd5772468	bookshelf_cells/IMG_2151.jpeg	2023-12-25 17:02:11.233816
cd669db8-1248-4085-a795-33d4fbf91e36	bookshelf_cells/IMG_2598.jpeg	2023-12-25 16:42:55.344757
4afb8746-c21a-412d-91b7-305c95a44fe6	bookshelf_cells/IMG_2435.jpeg	2023-12-25 16:15:08.39413
642fbac0-f438-44ef-b139-f69f662a34cc	bookshelf_cells/IMG_2437.jpeg	2023-12-25 16:15:08.396196
bbb1a2ff-a470-4515-9329-d32c137c2213	bookshelf_cells/IMG_2134.jpeg	2023-12-25 16:52:54.599143
74996933-3148-4d69-a42b-82a0df622b23	bookshelf_cells/IMG_2394.jpeg	2023-12-25 17:02:44.831889
31a0e724-610b-42b0-b750-323182a097eb	bookshelf_cells/IMG_2412.jpeg	2023-12-25 17:02:50.262307
29e0b64e-bc74-4adb-aa0a-1c9ae2de63ae	bookshelf_cells/IMG_2533.jpeg	2023-12-25 16:15:08.40193
a9674249-4bbe-4114-88a8-b2e4b9e331b8	bookshelf_cells/IMG_2534.jpeg	2023-12-25 16:15:08.402868
d7d99681-df49-4d8e-b5c1-1f570b7286a6	bookshelf_cells/IMG_2535.jpeg	2023-12-25 16:15:08.403494
529ea36d-bcd0-41b8-b7f8-31ace8f4cad1	bookshelf_cells/IMG_2536.jpeg	2023-12-25 16:15:08.405098
641fdc76-dc6d-4a54-9b15-c1dfe5577433	bookshelf_cells/IMG_2659.jpeg	2023-12-25 16:43:12.44079
c6063f6c-3ba0-4999-aa10-43c732baa3ac	bookshelf_cells/IMG_2136.jpeg	2023-12-25 16:55:31.79697
f9abec0c-b619-4e8b-a471-c8dd899143b1	bookshelf_cells/IMG_2539.jpeg	2023-12-25 16:15:27.399631
b9c22684-e9f7-4394-8991-2b7f8c850828	bookshelf_cells/IMG_2540.jpeg	2023-12-25 16:15:27.400383
3fd92657-9d4b-4003-a7fa-760281b85675	bookshelf_cells/IMG_2541.jpeg	2023-12-25 16:15:27.401111
32628c6f-d4f0-4629-afb5-30a5786948c2	bookshelf_cells/IMG_2542.jpeg	2023-12-25 16:15:27.40191
44801502-15f5-4a0c-8f58-9884e63f85dd	bookshelf_cells/IMG_2543.jpeg	2023-12-25 16:15:27.402607
72fd5040-2834-4e51-804d-25c8e36223c6	bookshelf_cells/IMG_2544.jpeg	2023-12-25 16:15:27.403385
e3ec3382-eb1d-412e-bc21-9a5c62be6cf4	bookshelf_cells/IMG_2545.jpeg	2023-12-25 16:15:27.404281
e9b96cfe-984a-4b26-8040-c395aff6eea7	bookshelf_cells/IMG_2546.jpeg	2023-12-25 16:15:27.405106
dd7b27e2-f7f1-4a91-abd8-67fd26499590	bookshelf_cells/IMG_2547.jpeg	2023-12-25 16:15:27.405746
993c4927-b7ec-4af2-a9b7-a79333530007	bookshelf_cells/IMG_2548.jpeg	2023-12-25 16:15:27.406415
abcc4e2f-72d9-44e4-977b-20de38004b20	bookshelf_cells/IMG_2549.jpeg	2023-12-25 16:15:27.407092
82157782-f9e1-4c7c-8323-3c937fda8f15	bookshelf_cells/IMG_2550.jpeg	2023-12-25 16:15:27.407683
30985598-a3e5-4746-9df9-18734da6e904	bookshelf_cells/IMG_2551.jpeg	2023-12-25 16:15:27.40832
8b4227ca-1de6-4287-a819-80f4a8729221	bookshelf_cells/IMG_2552.jpeg	2023-12-25 16:15:27.408836
861ee902-3e94-4fbd-a36d-9c7cdafc4208	bookshelf_cells/IMG_2553.jpeg	2023-12-25 16:15:27.409753
8d884750-3c65-4034-9a98-625118e1eba9	bookshelf_cells/IMG_2554.jpeg	2023-12-25 16:15:27.410266
67745200-c4c1-4f39-9ab2-058cc59f8f5d	bookshelf_cells/IMG_2555.jpeg	2023-12-25 16:15:27.410769
5697755e-d170-4aa8-98b3-0bf558905f25	bookshelf_cells/IMG_2556.jpeg	2023-12-25 16:15:27.41144
68eaebd7-ff99-4f0e-b795-84c2df3adc50	bookshelf_cells/IMG_2557.jpeg	2023-12-25 16:15:27.412034
1837b9d7-e1a1-421f-b958-02501c0bfe2c	bookshelf_cells/IMG_2559.jpeg	2023-12-25 16:15:43.424971
d5a01df9-b6f5-474e-9c13-d3ec3253c5c7	bookshelf_cells/IMG_2560.jpeg	2023-12-25 16:15:43.425784
a9fe78d4-28a4-4147-b122-029e8585f139	bookshelf_cells/IMG_2561.jpeg	2023-12-25 16:15:43.426383
e4d10e63-a602-4ff2-bd69-5d2d77066e5b	bookshelf_cells/IMG_2562.jpeg	2023-12-25 16:15:43.426988
b94173ec-e284-4c2f-a51c-535a4633f146	bookshelf_cells/IMG_2563.jpeg	2023-12-25 16:15:43.427971
50db1944-41b2-479b-85ac-57359d4d5aec	bookshelf_cells/IMG_2564.jpeg	2023-12-25 16:15:43.428885
cbd055e2-2b13-4b5c-a794-0f32dbf60caa	bookshelf_cells/IMG_2565.jpeg	2023-12-25 16:15:43.429666
bebd9dc6-b330-4b02-9ad4-97c7ff8b876a	bookshelf_cells/IMG_2566.jpeg	2023-12-25 16:15:43.430392
a9fee0ef-d6fd-4cef-b97e-8db7493dc940	bookshelf_cells/IMG_2567.jpeg	2023-12-25 16:15:43.431271
01608ae0-de62-490d-8c29-6a9e6a1093c6	bookshelf_cells/IMG_2568.jpeg	2023-12-25 16:15:43.431942
f5d4463b-a481-4e9c-b60c-f2a9b3aeef17	bookshelf_cells/IMG_2569.jpeg	2023-12-25 16:15:43.432546
e70b2b7e-0e98-4b1b-9c20-3a1826c97350	bookshelf_cells/IMG_2570.jpeg	2023-12-25 16:15:43.433168
525d0010-51cc-4dbe-8406-6947a968e558	bookshelf_cells/IMG_2571.jpeg	2023-12-25 16:15:43.433761
205dabf6-4fa4-481b-97ec-ece2d25c9960	bookshelf_cells/IMG_2572.jpeg	2023-12-25 16:15:43.434391
c2377c67-4bfb-470e-8f35-c881c0d07d69	bookshelf_cells/IMG_2573.jpeg	2023-12-25 16:15:43.434978
8827150e-1ebb-432d-a9f4-928a21be4940	bookshelf_cells/IMG_2579.jpeg	2023-12-25 16:16:06.66754
c3e30570-4a70-4ec6-acd9-25f7ca470dcd	bookshelf_cells/IMG_2580.jpeg	2023-12-25 16:16:06.668194
06494a40-2a85-4b5f-9384-7b229cc1d4d5	bookshelf_cells/IMG_2581.jpeg	2023-12-25 16:16:06.668865
b16df60c-8174-4cf7-8a5b-07a826a896d2	bookshelf_cells/IMG_2582.jpeg	2023-12-25 16:16:06.669447
a60e76c6-3066-4b60-b43f-85b47314f821	bookshelf_cells/IMG_2583.jpeg	2023-12-25 16:16:06.669882
9e85ce64-d323-4181-b5de-c6eb4a698cbb	bookshelf_cells/IMG_2584.jpeg	2023-12-25 16:16:06.67031
26041ffc-3f4a-40e6-bd21-948a205e56d0	bookshelf_cells/IMG_2585.jpeg	2023-12-25 16:16:06.670687
37af2c0e-9823-4cf2-8d68-e9990e445aa2	bookshelf_cells/IMG_2586.jpeg	2023-12-25 16:16:06.671067
c9e34e27-d49f-41e8-876a-49cea826d377	bookshelf_cells/IMG_2587.jpeg	2023-12-25 16:16:06.671578
a1da7e0b-27cf-48e8-922b-b4924eae2c8c	bookshelf_cells/IMG_2588.jpeg	2023-12-25 16:16:06.671991
32526f10-0f99-4dcb-b15d-7e5b0677fec3	bookshelf_cells/IMG_2589.jpeg	2023-12-25 16:16:06.672378
34ce44ed-ce7d-4ec2-88c2-d08cfb0e01b3	bookshelf_cells/IMG_2590.jpeg	2023-12-25 16:16:06.672797
9ea0d009-f292-414b-a640-37287b52d16e	bookshelf_cells/IMG_2591.jpeg	2023-12-25 16:16:06.673177
1b53fd3d-5aac-41e4-8f55-0c5fa7577e90	bookshelf_cells/IMG_2592.jpeg	2023-12-25 16:16:06.673586
2f173968-2b8f-4983-b1e6-432e26b13775	bookshelf_cells/IMG_2593.jpeg	2023-12-25 16:16:06.673928
fefa1a2d-e615-4b3d-92ed-742f111876af	bookshelf_cells/IMG_2594.jpeg	2023-12-25 16:16:06.674286
c3352cd6-90b3-4aed-b2db-08dd29a85f47	bookshelf_cells/IMG_2595.jpeg	2023-12-25 16:16:06.674634
d745a99d-1705-44fe-bcb2-9ce4ab879613	bookshelf_cells/IMG_2599.jpeg	2023-12-25 16:16:33.870309
c8d2a56c-2dc1-48c6-829f-d13f501297c4	bookshelf_cells/IMG_2600.jpeg	2023-12-25 16:16:33.871327
5664cb61-7d28-4f3e-8afa-339d91ce19f6	bookshelf_cells/IMG_2601.jpeg	2023-12-25 16:16:33.872014
47e2341b-9170-46a0-b549-76305681cdc7	bookshelf_cells/IMG_2602.jpeg	2023-12-25 16:16:33.872956
e682f445-9f99-4c09-aa28-552fc43996ff	bookshelf_cells/IMG_2603.jpeg	2023-12-25 16:16:33.873522
1e770422-95e6-4d12-bc85-5c1475df370c	bookshelf_cells/IMG_2604.jpeg	2023-12-25 16:16:33.874015
eb4632c4-ccd1-48d5-a515-c577a15f0245	bookshelf_cells/IMG_2605.jpeg	2023-12-25 16:16:33.874461
075dfc68-f091-4040-aec8-c0f296b2ffc0	bookshelf_cells/IMG_2606.jpeg	2023-12-25 16:16:33.874886
ed01f7a8-aa6f-4997-bbae-665f9166c24f	bookshelf_cells/IMG_2607.jpeg	2023-12-25 16:16:33.875585
69dfbb1f-3c74-416e-b8d6-c4c3b81114e0	bookshelf_cells/IMG_2608.jpeg	2023-12-25 16:16:33.875968
5187a39e-2f8b-4c5a-9571-88135b5e733f	bookshelf_cells/IMG_2609.jpeg	2023-12-25 16:16:33.876325
eea07c34-98a3-4c92-9e33-1b44bba6cb91	bookshelf_cells/IMG_2610.jpeg	2023-12-25 16:16:33.876686
8b65e912-b7c2-43d1-870c-0a7bfb335971	bookshelf_cells/IMG_2611.jpeg	2023-12-25 16:16:33.877039
92e91d66-8a61-4673-8e8f-a0e0f396b3d5	bookshelf_cells/IMG_2612.jpeg	2023-12-25 16:16:33.877407
1064e41e-e61d-431e-85bf-6dcbf8a9d777	bookshelf_cells/IMG_2613.jpeg	2023-12-25 16:16:33.877776
3847b618-e15c-4997-8e8f-1b967e3f660d	bookshelf_cells/IMG_2614.jpeg	2023-12-25 16:16:33.87813
345dd254-03b3-4796-accd-3ee11d673f3c	bookshelf_cells/IMG_2615.jpeg	2023-12-25 16:16:33.878484
4b48ca3e-fe47-40d4-a8df-705af459531b	bookshelf_cells/IMG_2616.jpeg	2023-12-25 16:16:33.878884
887b5980-5d77-4d1b-b37a-7d214434ea28	bookshelf_cells/IMG_2619.jpeg	2023-12-25 16:16:54.083968
6b7ea7f6-d12c-480e-ae5d-f3a89c3dbd19	bookshelf_cells/IMG_2620.jpeg	2023-12-25 16:16:54.084851
598056eb-a023-4a48-b1b9-9b0be45371e5	bookshelf_cells/IMG_2621.jpeg	2023-12-25 16:16:54.085588
96b4d141-36bb-494d-b6a8-585b0bd20b63	bookshelf_cells/IMG_2622.jpeg	2023-12-25 16:16:54.08641
12b0a43a-300c-40c2-a6b1-7c88f70f8231	bookshelf_cells/IMG_2623.jpeg	2023-12-25 16:16:54.087154
b8cc8bfd-9e17-4492-8e23-ee81ee583771	bookshelf_cells/IMG_2624.jpeg	2023-12-25 16:16:54.087795
483afd8f-2bc7-4ce4-87d1-6dfa9b7b0148	bookshelf_cells/IMG_2625.jpeg	2023-12-25 16:16:54.088521
b2467ca8-4938-4dec-a3a1-1b2db8364697	bookshelf_cells/IMG_2626.jpeg	2023-12-25 16:16:54.089083
4a4d2303-6af9-42e4-a41d-1fcb57ab3ffb	bookshelf_cells/IMG_2627.jpeg	2023-12-25 16:16:54.089693
39b94297-60b8-4334-ae15-ceb1a167c1eb	bookshelf_cells/IMG_2628.jpeg	2023-12-25 16:16:54.090258
70d60ae5-d508-4c1c-a4bf-5ca1958dac34	bookshelf_cells/IMG_2629.jpeg	2023-12-25 16:16:54.090781
7e651ddf-a8af-44aa-a16c-e3ccea0a23ba	bookshelf_cells/IMG_2630.jpeg	2023-12-25 16:16:54.091308
5fd75034-6cee-4290-a051-37f6418673c2	bookshelf_cells/IMG_2631.jpeg	2023-12-25 16:16:54.092119
aae8ce97-1f4a-4896-bb97-58a91ea8bf6f	bookshelf_cells/IMG_2632.jpeg	2023-12-25 16:16:54.092688
ff6e12bb-e21c-4f3a-a725-b19c39bef084	bookshelf_cells/IMG_2633.jpeg	2023-12-25 16:16:54.093175
a054147e-2173-4c83-ab99-31333bf802dc	bookshelf_cells/IMG_2634.jpeg	2023-12-25 16:16:54.093672
998e10be-99e1-43a4-a4a5-7626df2e4ef7	bookshelf_cells/IMG_2635.jpeg	2023-12-25 16:16:54.094178
a0cd9c24-ab4b-46b7-8bb9-b3d4570bcfee	bookshelf_cells/IMG_2639.jpeg	2023-12-25 16:17:14.453349
3f1e6bc9-fc07-47eb-8663-b8b575233639	bookshelf_cells/IMG_2640.jpeg	2023-12-25 16:17:14.454004
5da05b94-1600-4cdc-b77a-d7381454aa42	bookshelf_cells/IMG_2641.jpeg	2023-12-25 16:17:14.454577
90774260-4d48-4454-af24-9d9e986697f4	bookshelf_cells/IMG_2642.jpeg	2023-12-25 16:17:14.455142
688a0ab4-ae29-4f95-a342-343e8a0dc7a0	bookshelf_cells/IMG_2643.jpeg	2023-12-25 16:17:14.45567
1a0485f9-a8bc-47ef-8811-e9e6f1a70298	bookshelf_cells/IMG_2644.jpeg	2023-12-25 16:17:14.456228
4ea076b1-9e9f-4adb-a95f-510c0426b8b4	bookshelf_cells/IMG_2645.jpeg	2023-12-25 16:17:14.456845
d679a872-70c1-4e9a-919d-43d45fd9f4d2	bookshelf_cells/IMG_2646.jpeg	2023-12-25 16:17:14.457482
57aadeaf-82cc-4f08-a2b2-75f5a68c1fac	bookshelf_cells/IMG_2647.jpeg	2023-12-25 16:17:14.458031
7227e350-a350-410f-94a8-5c90314256eb	bookshelf_cells/IMG_2648.jpeg	2023-12-25 16:17:14.458522
045cc5e2-298f-4d2b-a5dc-e754fa5fef9d	bookshelf_cells/IMG_2649.jpeg	2023-12-25 16:17:14.459059
e2ad64e7-a689-4df3-a344-692ca531a562	bookshelf_cells/IMG_2650.jpeg	2023-12-25 16:17:14.459578
46fc6027-74cc-4211-986c-baf2ff3ed7e5	bookshelf_cells/IMG_2651.jpeg	2023-12-25 16:17:14.460112
1c75bf54-3d93-40a8-a44b-0f0fb5446b80	bookshelf_cells/IMG_2652.jpeg	2023-12-25 16:17:14.460699
10125124-de13-4ebe-b7bb-b08de4426215	bookshelf_cells/IMG_2653.jpeg	2023-12-25 16:17:14.46126
c561b4aa-6e67-4495-996e-0618ca053eaf	bookshelf_cells/IMG_2705.jpeg	2023-12-25 16:21:01.245329
5bbd408f-5b4a-42bc-9275-e35d8ff3b485	bookshelf_cells/IMG_2660.jpeg	2023-12-25 16:17:35.71551
e13bc953-b9d7-499c-8091-6947c4b6fe76	bookshelf_cells/IMG_2661.jpeg	2023-12-25 16:17:35.716257
b9d508c8-cce8-4c38-b6e0-af3c14cc3a60	bookshelf_cells/IMG_2662.jpeg	2023-12-25 16:17:35.717065
3f08cbc7-a319-41de-9014-7b0651de955c	bookshelf_cells/IMG_2663.jpeg	2023-12-25 16:17:35.717866
645e5f96-b899-4529-84f9-c37293a51840	bookshelf_cells/IMG_2664.jpeg	2023-12-25 16:17:35.71888
a33d7215-50b7-4381-a30f-98fb1e2b1fac	bookshelf_cells/IMG_2665.jpeg	2023-12-25 16:17:35.719699
6d6f8f00-823e-4286-b0e9-34b9c2d09c2a	bookshelf_cells/IMG_2666.jpeg	2023-12-25 16:17:35.720975
788414d2-3c3a-44ba-9e35-f99ce247ae09	bookshelf_cells/IMG_2667.jpeg	2023-12-25 16:17:35.72228
5af8e18b-1e89-4e3f-97de-fc95f18e9f7b	bookshelf_cells/IMG_2668.jpeg	2023-12-25 16:17:35.723147
1ffa0a82-b785-4c60-89c6-980af578448f	bookshelf_cells/IMG_2669.jpeg	2023-12-25 16:17:35.723944
58882b31-2d17-49a6-bccb-fec52341fc26	bookshelf_cells/IMG_2670.jpeg	2023-12-25 16:17:35.72461
1482f298-d003-447b-b8ce-88ef9a3f8a5f	bookshelf_cells/IMG_2671.jpeg	2023-12-25 16:17:35.725307
fb5dc337-d5aa-48d1-a255-9e11682b7f43	bookshelf_cells/IMG_2672.jpeg	2023-12-25 16:17:35.725971
23e17d3f-9b49-4e27-a18e-a8dc0df68d17	bookshelf_cells/IMG_2673.jpeg	2023-12-25 16:17:35.726547
a688b995-cc46-4195-8e75-f4d7d9fdf338	bookshelf_cells/IMG_2674.jpeg	2023-12-25 16:17:35.727115
127a2dbf-65ff-4f55-8ae8-be8abbf3adfa	bookshelf_cells/IMG_2675.jpeg	2023-12-25 16:17:35.727658
4f0e790b-2375-4dcf-a747-d77509cbae38	bookshelf_cells/IMG_2676.jpeg	2023-12-25 16:17:35.728215
6d2aaf69-3ee5-435d-ad93-4967596cb7ac	bookshelf_cells/IMG_2677.jpeg	2023-12-25 16:17:35.728855
6274a118-6d6f-4185-a047-8d950224dfae	bookshelf_cells/IMG_2680.jpeg	2023-12-25 16:17:53.769568
0ea88b0d-3574-4ccf-b2c9-0949969d980b	bookshelf_cells/IMG_2681.jpeg	2023-12-25 16:17:53.770046
3377fad7-7cca-463c-b3b1-aeb79fec5cfe	bookshelf_cells/IMG_2682.jpeg	2023-12-25 16:17:53.77053
4b1a89c2-d1e2-4194-a10f-94da30fd2054	bookshelf_cells/IMG_2683.jpeg	2023-12-25 16:17:53.770957
df4a3cf7-2d2a-406c-b016-cda4b2bb0b34	bookshelf_cells/IMG_2684.jpeg	2023-12-25 16:17:53.771344
ee9130bb-9dfa-48a5-af1a-047fbf9e838e	bookshelf_cells/IMG_2685.jpeg	2023-12-25 16:17:53.771729
b7670955-91cb-4569-8b8b-bb7073da82f6	bookshelf_cells/IMG_2687.jpeg	2023-12-25 16:17:53.772628
4fcb7e25-0120-409b-8451-c1f8887356a7	bookshelf_cells/IMG_2688.jpeg	2023-12-25 16:17:53.773168
af08db69-7dab-4b41-b80b-d6ef4c3c91d1	bookshelf_cells/IMG_2689.jpeg	2023-12-25 16:17:53.77369
28ac3eeb-acbb-4eb3-b2dd-152ea9c17730	bookshelf_cells/IMG_2690.jpeg	2023-12-25 16:17:53.774209
81020782-c3f8-49cb-8f1e-b4bd955aa71f	bookshelf_cells/IMG_2691.jpeg	2023-12-25 16:17:53.774749
4251293a-f8ec-48aa-b7df-fa68a90db615	bookshelf_cells/IMG_2692.jpeg	2023-12-25 16:17:53.775209
9c1f9044-0a34-4e2f-8ecb-1a0fbb0e689e	bookshelf_cells/IMG_2693.jpeg	2023-12-25 16:17:53.775693
13f26dc7-aeac-4a88-b8ab-9f9776877d5a	bookshelf_cells/IMG_2694.jpeg	2023-12-25 16:17:53.776436
44169906-114c-49c9-82ac-08f0ed1dbbd6	bookshelf_cells/IMG_2700.jpeg	2023-12-25 16:18:10.962956
203bf48b-7775-40fe-9f37-a5b7afcdd7ef	bookshelf_cells/IMG_2701.jpeg	2023-12-25 16:18:10.963949
30cecb49-1ca5-4bcf-b391-1b3bc7c53e6e	bookshelf_cells/IMG_2702.jpeg	2023-12-25 16:18:10.965299
d1a1f865-a1af-45db-9271-0637f66891b8	bookshelf_cells/IMG_2703.jpeg	2023-12-25 16:18:10.966199
cd799093-36d6-4bf2-8539-63d2afc29824	bookshelf_cells/IMG_2722.jpeg	2023-12-25 16:18:14.331698
8fcfdeb3-da59-4903-9867-c9464250019a	bookshelf_cells/IMG_2514.jpeg	2023-12-25 16:50:51.452291
1f830e72-1ab2-4c85-ab3b-d04b92347af9	bookshelf_cells/IMG_2575.jpeg	2023-12-25 16:50:51.454176
65ac8dcf-d248-49f6-9c61-1c1f13f155b3	bookshelf_cells/IMG_2537.jpeg	2023-12-25 16:28:58.522403
42f442a6-6801-44eb-93d3-1fa3caf13fb0	bookshelf_cells/IMG_2618.jpeg	2023-12-25 16:50:51.457132
80080a34-0d2b-40d7-843d-c4a593120b8b	bookshelf_cells/IMG_2654.jpeg	2023-12-25 16:29:13.702621
f8fec70f-4685-4128-8049-a47668ddd0d9	bookshelf_cells/IMG_2697.jpeg	2023-12-25 16:50:59.709417
9bafb776-a445-4205-ada5-65f793bd14bb	bookshelf_cells/IMG_2658.jpeg	2023-12-25 16:29:13.705117
5e342aae-6fc4-4633-a6a3-894510641bfe	bookshelf_cells/IMG_2414.jpeg	2023-12-25 17:02:50.263878
7439150f-d606-44a8-bf82-7adcf6644718	bookshelf_cells/IMG_2415.jpeg	2023-12-25 17:02:50.264539
1f48c3cd-003f-49c3-87b8-fcea7636929c	bookshelf_cells/IMG_2636.jpeg	2023-12-25 17:03:05.757296
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

