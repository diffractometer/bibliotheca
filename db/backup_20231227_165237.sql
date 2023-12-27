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
    title character varying(255),
    author character varying(255),
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
48350694-a975-4a02-b152-039d37ad6285	WHAT TO EXPECT THE FIRST YEAR	Heidi Murkoff	\N	\N	\N	f	bookshelf_cells/IMG_2105.jpeg	2023-12-26 23:39:46.664069	2023-12-26 23:39:46.664069
96b238dc-8756-4670-812d-e110371025c0	THE DEATH AND LIFE OF GREAT AMERICAN CITIES	Jane Jacobs	\N	\N	\N	f	bookshelf_cells/IMG_2107.jpeg	2023-12-26 23:39:46.668778	2023-12-26 23:39:46.668778
beae4134-31a5-4137-81cc-2474e8760e60	HIERONYMUS BOSCH	Stefan Fischer	\N	\N	\N	f	bookshelf_cells/IMG_2108.jpeg	2023-12-26 23:39:46.671073	2023-12-26 23:39:46.671073
10ad2aba-97f8-4af8-94b8-58f5e7229e23	WILD PROBLEMS	Russ Roberts	\N	\N	\N	f	bookshelf_cells/IMG_2109.jpeg	2023-12-26 23:39:46.673043	2023-12-26 23:39:46.673043
28d2c404-7244-4c7a-a9d7-c49767200805	What Is ChatGPT Doing...	Stephen Wolfram	\N	\N	\N	f	bookshelf_cells/IMG_2110.jpeg	2023-12-26 23:39:46.674903	2023-12-26 23:39:46.674903
2cc74848-63b7-4dd2-ab38-fce186a11f0b	VINCENT VAN GOGH	\N	\N	\N	\N	f	bookshelf_cells/IMG_2111.jpeg	2023-12-26 23:39:46.676932	2023-12-26 23:39:46.676932
6b6406ee-edfb-4289-9c01-95b164b05f41	DAEMON	Daniel Suarez	\N	\N	\N	f	bookshelf_cells/IMG_2112.jpeg	2023-12-26 23:39:46.678572	2023-12-26 23:39:46.678572
a7871ec7-458a-432f-8fa9-0f91a64dc0fc	KOMMANDO	James Lucas	\N	\N	\N	f	bookshelf_cells/IMG_2113.jpeg	2023-12-26 23:39:46.680089	2023-12-26 23:39:46.680089
4d16d0b6-80ea-446a-b52f-a53a66c1ed9a	HYPERION	Dan Simmons	\N	\N	\N	f	bookshelf_cells/IMG_2114.jpeg	2023-12-26 23:39:46.681504	2023-12-26 23:39:46.681504
a3b0e319-26f1-475a-b8d6-fc775b41c11a	EAT TO WIN	Dr. Robert Haas	\N	\N	\N	f	bookshelf_cells/IMG_2115.jpeg	2023-12-26 23:39:46.682874	2023-12-26 23:39:46.682874
06446e6d-a1c8-4c78-a8ec-be40e4d01d76	BAN THE BOMB	\N	\N	\N	\N	f	bookshelf_cells/IMG_2121.jpeg	2023-12-26 23:39:46.684191	2023-12-26 23:39:46.684191
aab5cf5f-5118-434b-b8de-2362871e7a70	LITHUANIANS IN MULTI-ETHNIC CHICAGO	\N	\N	\N	\N	f	bookshelf_cells/IMG_2130.jpeg	2023-12-26 23:39:46.685727	2023-12-26 23:39:46.685727
2030a24b-8b06-4870-bcc3-a04d55a78cce	TALES FROM THE LOOP	Simon Stålenhag	\N	\N	\N	f	bookshelf_cells/IMG_2131.jpeg	2023-12-26 23:39:46.687052	2023-12-26 23:39:46.687052
2328d2e4-d1e2-4c22-abb5-453d4ef42e96	MODERN PHYSICS	Ronald Gautreau,William Savin	\N	\N	\N	f	bookshelf_cells/IMG_2132.jpeg	2023-12-26 23:39:46.688253	2023-12-26 23:39:46.688253
cd226b17-9d0b-49d6-bf36-46007d4b9ba4	THE JOAN BAEZ SONGBOOK	\N	\N	\N	\N	f	bookshelf_cells/IMG_2133.jpeg	2023-12-26 23:39:46.689368	2023-12-26 23:39:46.689368
9ca40908-6a9d-4a9a-9a75-06a56bb8301f	BUILDINGS	\N	\N	\N	\N	f	bookshelf_cells/IMG_2134.jpeg	2023-12-26 23:39:46.690395	2023-12-26 23:39:46.690395
5b25b106-830b-4690-b1f2-b8d68977aacc	A BRIEF INTRODUCTION TO MODERN PHILOSOPHY	Arthur Kenyon Rogers	\N	\N	\N	f	bookshelf_cells/IMG_2135.jpeg	2023-12-26 23:39:46.69152	2023-12-26 23:39:46.69152
b81b520b-1358-4d8e-a866-90b205bce536	COMPANY	John Sack	\N	\N	\N	f	bookshelf_cells/IMG_2136.jpeg	2023-12-26 23:39:46.692672	2023-12-26 23:39:46.692672
f8b2db29-a41b-4ca7-9ca6-eb8409b4105f	PERMUTATION CITY	Greg Egan	\N	\N	\N	f	bookshelf_cells/IMG_2137.jpeg	2023-12-26 23:39:46.693869	2023-12-26 23:39:46.693869
468e2ef0-2c1c-4e49-98c1-626766df7a87	HOW TO LOSE A WAR	\N	\N	\N	\N	f	bookshelf_cells/IMG_2138.jpeg	2023-12-26 23:39:46.695029	2023-12-26 23:39:46.695029
d1c61bbd-8a45-4228-9444-5d531ee85f78	Why Is Sex Fun?	Jared Diamond	\N	\N	\N	f	bookshelf_cells/IMG_2139.jpeg	2023-12-26 23:39:46.696114	2023-12-26 23:39:46.696114
81e73aef-56c4-4f2e-beb5-8af2da2c0358	JOURNEY TO THE END OF THE NIGHT	Céline	\N	\N	\N	f	bookshelf_cells/IMG_2140.jpeg	2023-12-26 23:39:46.697229	2023-12-26 23:39:46.697229
3b030a37-846e-4eaf-a082-92ffbbb4ad44	DON'T SLEEP	THERE ARE SNAKES,Daniel L. Everett	\N	\N	\N	f	bookshelf_cells/IMG_2141.jpeg	2023-12-26 23:39:46.698399	2023-12-26 23:39:46.698399
99f58b13-100d-4784-b9ab-4c22ef5a7645	THE PLAGUE OF FANTASIES	Slavoj Žižek	\N	\N	\N	f	bookshelf_cells/IMG_2142.jpeg	2023-12-26 23:39:46.699487	2023-12-26 23:39:46.699487
16ef113b-48cf-4f44-8936-fd51837c1050	WORLD WAR Z	Max Brooks	\N	\N	\N	f	bookshelf_cells/IMG_2143.jpeg	2023-12-26 23:39:46.700646	2023-12-26 23:39:46.700646
54da335b-7ee4-4118-8f87-382ee9a3973a	INFLUENCE	Robert B. Cialdini	\N	\N	\N	f	bookshelf_cells/IMG_2144.jpeg	2023-12-26 23:39:46.701855	2023-12-26 23:39:46.701855
71cb5b9e-a219-4902-a9c5-46b97c56fbef	EVERYTHING IS ILLUMINATED	Jonathan Sa	\N	\N	\N	f	bookshelf_cells/IMG_2145.jpeg	2023-12-26 23:39:46.702988	2023-12-26 23:39:46.702988
041d390e-6b64-4539-b131-98420c8bcd7a	Behind The Oval Office	Dick Morris	\N	\N	\N	f	bookshelf_cells/IMG_2146.jpeg	2023-12-26 23:41:21.09865	2023-12-26 23:41:21.09865
afd03ed0-168e-485b-8ee1-8cbe331c4762	On Bullshit	Harry G. Frankfurt	\N	\N	\N	f	bookshelf_cells/IMG_2147.jpeg	2023-12-26 23:41:21.10203	2023-12-26 23:41:21.10203
33739dd0-cb3a-4093-8b39-60b664797b33	Betraying Ambition	\N	\N	\N	\N	f	bookshelf_cells/IMG_2148.jpeg	2023-12-26 23:41:21.104374	2023-12-26 23:41:21.104374
af9033c1-3e30-4dee-a094-a428f44711d5	A Game of Thrones	George R.R. Martin	\N	\N	\N	f	bookshelf_cells/IMG_2556.jpeg	2023-12-27 00:55:17.239697	2023-12-27 00:55:17.239697
e2d81e3b-8203-4089-8733-c1ca0f3b2d38	Essays On Physical Practice	nik kosmas	\N	\N	\N	f	bookshelf_cells/IMG_2150.jpeg	2023-12-26 23:41:21.108501	2023-12-26 23:41:21.108501
7b083010-508e-41c5-a2dd-3e49bfc2f6d3	Doing Absolutely Nothing	Paul Wiersbinski	\N	\N	\N	f	bookshelf_cells/IMG_2151.jpeg	2023-12-26 23:41:21.110067	2023-12-26 23:41:21.110067
3a5b8587-e83e-48cf-8638-4d9721dc7907	Wild Seed	Octavia Butler	\N	\N	\N	f	bookshelf_cells/IMG_2152.jpeg	2023-12-26 23:41:21.111462	2023-12-26 23:41:21.111462
9998028f-5aca-4143-8efb-ee2b0e10c99e	TITIAN	\N	\N	\N	\N	f	bookshelf_cells/IMG_2154.jpeg	2023-12-26 23:41:21.113779	2023-12-26 23:41:21.113779
64d571e7-9edf-49d8-b972-47c2cc3d0dd9	ICARUS or THE FUTURE OF SCIENCE	Bertrand Russell	\N	\N	\N	f	bookshelf_cells/IMG_2155.jpeg	2023-12-26 23:41:21.117024	2023-12-26 23:41:21.117024
32ad64c9-a773-4320-b2a3-fb19c34adfc2	Night Moves	Jessica Hopper	\N	\N	\N	f	bookshelf_cells/IMG_2156.jpeg	2023-12-26 23:41:21.119854	2023-12-26 23:41:21.119854
4fe33f6f-c5c9-447c-8b5e-78df04a2fca5	Man and Citizen	Thomas Hobbes	\N	\N	\N	f	bookshelf_cells/IMG_2157.jpeg	2023-12-26 23:41:21.122491	2023-12-26 23:41:21.122491
b491f850-211d-4d26-b626-5618cfc5d638	Design Patterns	Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides	\N	\N	\N	f	bookshelf_cells/IMG_2158.jpeg	2023-12-26 23:41:21.124836	2023-12-26 23:41:21.124836
b30820a0-d188-44ee-a8ef-b14c352f2723	Deception 2.0 for dummies	\N	\N	\N	\N	f	bookshelf_cells/IMG_2159.jpeg	2023-12-26 23:41:21.127032	2023-12-26 23:41:21.127032
cc5eff68-e106-4cfa-a8d9-29294ba8739d	colombia cent'anni di solitudine	\N	\N	\N	\N	f	bookshelf_cells/IMG_2160.jpeg	2023-12-26 23:41:21.129096	2023-12-26 23:41:21.129096
04738f92-de2c-44f3-8876-91dd16e5ad01	Dune Messiah	Frank Herbert	\N	\N	\N	f	bookshelf_cells/IMG_2161.jpeg	2023-12-26 23:41:21.131122	2023-12-26 23:41:21.131122
b2588069-ec39-4f03-a154-eace949ac916	Soviet Science Fiction	\N	\N	\N	\N	f	bookshelf_cells/IMG_2162.jpeg	2023-12-26 23:41:21.132959	2023-12-26 23:41:21.132959
ca4c3bb5-14d6-4275-b2a8-8129de5fe7b6	Words from the Myths	Isaac Asimov	\N	\N	\N	f	bookshelf_cells/IMG_2163.jpeg	2023-12-26 23:41:21.134561	2023-12-26 23:41:21.134561
2ebb495c-e75f-421a-acbb-362891a1287e	Short Story Masterpieces	\N	\N	\N	\N	f	bookshelf_cells/IMG_2164.jpeg	2023-12-26 23:41:21.135995	2023-12-26 23:41:21.135995
78277da8-d761-45d6-8f93-47fc1006bfd1	The Martian Chronicles	Ray Bradbury	\N	\N	\N	f	bookshelf_cells/IMG_2165.jpeg	2023-12-26 23:41:21.13744	2023-12-26 23:41:21.13744
cbbfa05b-bc3e-4617-96f6-578de795629f	Herzog	Saul Bellow	\N	\N	\N	f	bookshelf_cells/IMG_2166.jpeg	2023-12-26 23:41:21.138886	2023-12-26 23:41:21.138886
f5146db7-d515-4483-8698-69ef8dd88dba	The Velvet Rage	Alan Downs, Ph.D	\N	\N	\N	f	bookshelf_cells/IMG_2167.jpeg	2023-12-26 23:41:21.141733	2023-12-26 23:41:21.141733
f95fae19-b761-42d4-bde9-80a40e0c5bb9	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2397.jpeg	2023-12-27 01:06:17.588206	2023-12-27 01:06:17.588206
441b0bf6-b3ee-414f-aa04-5020133f5aa8	The Fall of Hyperion	Dan Simmons	\N	\N	\N	f	bookshelf_cells/IMG_2169.jpeg	2023-12-26 23:41:21.14541	2023-12-26 23:41:21.14541
1e293383-dd3d-4bd6-988a-45280f41ace0	Dune	Frank Herbert	\N	\N	\N	f	bookshelf_cells/IMG_2170.jpeg	2023-12-26 23:41:21.147522	2023-12-26 23:41:21.147522
0499b54f-d67d-4e83-b1c9-6712049c8fd5	Webster's New World Thesaurus	Charlton Laird	\N	\N	\N	f	bookshelf_cells/IMG_2171.jpeg	2023-12-26 23:41:21.149425	2023-12-26 23:41:21.149425
2115ba5c-d524-4512-90af-ccb41108e83d	The Algorithm Design Manual	Steven S. Skiena	\N	\N	\N	f	bookshelf_cells/IMG_2172.jpeg	2023-12-26 23:41:21.151306	2023-12-26 23:41:21.151306
0c1f986f-e76d-4748-a584-b766f48a93a1	Cut The Knot	Alexander Bogomoly	\N	\N	\N	f	bookshelf_cells/IMG_2173.jpeg	2023-12-26 23:41:21.153081	2023-12-26 23:41:21.153081
ef774367-3030-4171-9297-3288ce82dd5b	Building Microservices	Sam Newman	\N	\N	\N	f	bookshelf_cells/IMG_2174.jpeg	2023-12-26 23:41:21.154753	2023-12-26 23:41:21.154753
c6885438-784a-4fcb-91b2-080d1a9067bf	Cracking the Coding Interview	Gayle Laakmann McDowell	\N	\N	\N	f	bookshelf_cells/IMG_2175.jpeg	2023-12-26 23:41:21.161754	2023-12-26 23:41:21.161754
47af9f37-c6d8-482d-8c5c-8059dda5439e	The Anti-Aesthetic	\N	\N	\N	\N	f	bookshelf_cells/IMG_2176.jpeg	2023-12-26 23:41:21.163237	2023-12-26 23:41:21.163237
9f499318-5fee-4c5d-a99e-71a413090876	Cometbus	\N	\N	\N	\N	f	bookshelf_cells/IMG_2177.jpeg	2023-12-26 23:41:21.164739	2023-12-26 23:41:21.164739
0d309331-5825-44c0-898d-e3c8af37ff0b	Kill Decision	Daniel Suarez	\N	\N	\N	f	bookshelf_cells/IMG_2178.jpeg	2023-12-26 23:41:21.166166	2023-12-26 23:41:21.166166
020dfd09-9e47-4eaa-8b53-2438ae40856b	Health Insurance	Michael A. Morrisey	\N	\N	\N	f	bookshelf_cells/IMG_2179.jpeg	2023-12-26 23:41:21.16763	2023-12-26 23:41:21.16763
a335fd3b-4f70-4557-99b6-fdeb5973bc0f	Elementary Differential Equations	William E.	\N	\N	\N	f	bookshelf_cells/IMG_2180.jpeg	2023-12-26 23:41:21.169129	2023-12-26 23:41:21.169129
5f024c5c-28f8-4437-9050-b5af58d5b87e	State of Denial	Bob Woodward	\N	\N	\N	f	bookshelf_cells/IMG_2181.jpeg	2023-12-26 23:42:40.973129	2023-12-26 23:42:40.973129
bf2e6ceb-e7e1-457f-92dd-68734619d78e	No Ordinary Time	Doris Kearns Goodwin	\N	\N	\N	f	bookshelf_cells/IMG_2182.jpeg	2023-12-26 23:42:40.976876	2023-12-26 23:42:40.976876
fd8d8f88-7d89-4304-978c-1ddf6b749055	The RSpec Book	David Chelimsky	\N	\N	\N	f	bookshelf_cells/IMG_2183.jpeg	2023-12-26 23:42:40.97964	2023-12-26 23:42:40.97964
461ce67e-d1ab-4cd1-b45d-634510bfcba7	Prometheus Rising	Robert Anton Wilson	\N	\N	\N	f	bookshelf_cells/IMG_2184.jpeg	2023-12-26 23:42:40.982843	2023-12-26 23:42:40.982843
b31afa28-b991-4b96-a0ab-688737f5d705	Art & Fear	David Bayles & Ted Orland	\N	\N	\N	f	bookshelf_cells/IMG_2557.jpeg	2023-12-27 00:55:17.242997	2023-12-27 00:55:17.242997
c610d26b-e28b-4b88-90f8-af4d59a6165d	The Peregrine	J. A. Baker	\N	\N	\N	f	bookshelf_cells/IMG_2558.jpeg	2023-12-27 00:55:17.246351	2023-12-27 00:55:17.246351
69af83b6-2869-4299-8d34-fd7ce1f44209	The Best of Walden and Civil Disobedience	Henry David Thoreau	\N	\N	\N	f	bookshelf_cells/IMG_2187.jpeg	2023-12-26 23:42:40.990017	2023-12-26 23:42:40.990017
adacd325-ddb5-4025-bfc3-e245b79db14d	Eloquent Ruby	Russ Olsen	\N	\N	\N	f	bookshelf_cells/IMG_2188.jpeg	2023-12-26 23:42:40.992388	2023-12-26 23:42:40.992388
70753baf-28f3-468a-a94a-80157579f9cb	The Rime of the Ancient Mariner	Samuel Taylor Coleridge	\N	\N	\N	f	bookshelf_cells/IMG_2559.jpeg	2023-12-27 00:55:17.24896	2023-12-27 00:55:17.24896
ee289088-bfa5-4405-aa43-0f4f3846e1bd	Lucian Freud Paintings	\N	\N	\N	\N	f	bookshelf_cells/IMG_2190.jpeg	2023-12-26 23:42:40.997411	2023-12-26 23:42:40.997411
cec36fdd-611e-475b-a856-624a0e902189	Understanding Vincent Van Gogh	Frederick Dawe	\N	\N	\N	f	bookshelf_cells/IMG_2191.jpeg	2023-12-26 23:42:41.000498	2023-12-26 23:42:41.000498
594af89c-1903-45b7-a49e-f2e8da7a282f	The Gathering of the Juggalos	Daniel Cronin	\N	\N	\N	f	bookshelf_cells/IMG_2192.jpeg	2023-12-26 23:42:41.003414	2023-12-26 23:42:41.003414
6dd576b4-9413-45f7-96f4-9ca6f6999ae6	Pictures of a Life	Klaus Wagenbach	\N	\N	\N	f	bookshelf_cells/IMG_2193.jpeg	2023-12-26 23:42:41.006165	2023-12-26 23:42:41.006165
530ed5be-82c8-4d9c-b40f-41d807989d74	To Engineer Is Human	Henry Petroski	\N	\N	\N	f	bookshelf_cells/IMG_2194.jpeg	2023-12-26 23:42:41.00854	2023-12-26 23:42:41.00854
4e63078b-7923-4060-8545-051b785a99df	The Civil War	Geoffrey C. Ward with Ric Burns and Ken Burns	\N	\N	\N	f	bookshelf_cells/IMG_2195.jpeg	2023-12-26 23:42:41.010708	2023-12-26 23:42:41.010708
22397aa4-bc10-4a52-b185-4acae18d3fd0	The Book of Genesis Illustrated by R. Crumb	R. Crumb	\N	\N	\N	f	bookshelf_cells/IMG_2196.jpeg	2023-12-26 23:42:41.012738	2023-12-26 23:42:41.012738
7f5b66bc-49ef-470f-b7fb-7aeef1345295	The Onion Book of Known Knowledge	\N	\N	\N	\N	f	bookshelf_cells/IMG_2197.jpeg	2023-12-26 23:42:41.014937	2023-12-26 23:42:41.014937
12a56366-898c-4e5a-96ea-7529283b9eea	Mr. Scott's Guide to the Enterprise	Shane Johnson	\N	\N	\N	f	bookshelf_cells/IMG_2198.jpeg	2023-12-26 23:42:41.017018	2023-12-26 23:42:41.017018
3261d5ac-9553-4331-9952-1f6312916518	From Star Wars to Indiana Jones	Mark Cotta Vaz and Shinji Hata	\N	\N	\N	f	bookshelf_cells/IMG_2199.jpeg	2023-12-26 23:42:41.01933	2023-12-26 23:42:41.01933
34b45c7a-85ec-4800-b770-ad9082c3b39f	Chemistry The Central Science	Brown LeMay Bursten	\N	\N	\N	f	bookshelf_cells/IMG_2200.jpeg	2023-12-26 23:42:41.021906	2023-12-26 23:42:41.021906
88dbe419-63e1-4ea1-a936-fabe5c851011	How to Prepare for the GRE Test	Sharon Weiner Green and Ira Wolf	\N	\N	\N	f	bookshelf_cells/IMG_2201.jpeg	2023-12-26 23:42:41.024271	2023-12-26 23:42:41.024271
e843f103-27c8-4b2d-979e-c53d61c5c16d	Cracking the GRE 2006 Edition	Karen Lurie, Magda Pecsenye, and Adam Robinson	\N	\N	\N	f	bookshelf_cells/IMG_2202.jpeg	2023-12-26 23:42:41.026495	2023-12-26 23:42:41.026495
dc330c3f-22f3-400c-b529-a99e1999dca5	Cracking the GRE Math Test	Steven A. Leduc	\N	\N	\N	f	bookshelf_cells/IMG_2203.jpeg	2023-12-26 23:42:41.028337	2023-12-26 23:42:41.028337
c7d64eb3-8f5a-4766-a4d5-90c3846ee727	Cracking the GRE Math Subject Test	\N	\N	\N	\N	f	bookshelf_cells/IMG_2204.jpeg	2023-12-26 23:42:41.029749	2023-12-26 23:42:41.029749
1ace0a0c-30a0-4234-b4fb-3bab1a76b88f	Syntactic Structures	Noam Chomsky	\N	\N	\N	f	bookshelf_cells/IMG_2205.jpeg	2023-12-26 23:42:41.031151	2023-12-26 23:42:41.031151
5f966442-f667-48a3-bb81-b01fd29606b7	Geometry for Dummies	Mark Ryan	\N	\N	\N	f	bookshelf_cells/IMG_2206.jpeg	2023-12-26 23:42:41.032517	2023-12-26 23:42:41.032517
aa4fac50-2903-45b5-8182-1717d9aac5c9	Ina May's Guide	\N	\N	\N	\N	f	bookshelf_cells/IMG_2207.jpeg	2023-12-26 23:42:41.033899	2023-12-26 23:42:41.033899
2eccda76-f8c7-40fd-8e47-73bc558f1358	No Good Men Among the Living	Anand Gopal	\N	\N	\N	f	bookshelf_cells/IMG_2208.jpeg	2023-12-26 23:44:10.576534	2023-12-26 23:44:10.576534
49f7828f-ceb1-4a31-ac8c-a56df2a8bc47	Vegetarian	\N	\N	\N	\N	f	bookshelf_cells/IMG_2209.jpeg	2023-12-26 23:44:10.579484	2023-12-26 23:44:10.579484
0ad3a318-8468-470e-b12b-afb267d93903	Inspector Mouse	Bernard Stone,Ralph Steadman	\N	\N	\N	f	bookshelf_cells/IMG_2210.jpeg	2023-12-26 23:44:10.581181	2023-12-26 23:44:10.581181
21e8aa60-f5a9-4104-ab8d-d3111b24efa6	Running Lean	Ash Maurya	\N	\N	\N	f	bookshelf_cells/IMG_2211.jpeg	2023-12-26 23:44:10.582628	2023-12-26 23:44:10.582628
7acf4f18-2c51-44b6-a8a0-24c2461ba808	The Armed Society	Tristram Coffin	\N	\N	\N	f	bookshelf_cells/IMG_2235.jpeg	2023-12-26 23:44:10.584058	2023-12-26 23:44:10.584058
37cc3593-f534-42af-9a11-68fa7e45e689	Brave New World	Aldous Huxley	\N	\N	\N	f	bookshelf_cells/IMG_2236.jpeg	2023-12-26 23:44:10.586084	2023-12-26 23:44:10.586084
79f8b995-4dfb-464a-ad4f-673e7942ecca	Truly Tasteless Jokes	Blanche Knott	\N	\N	\N	f	bookshelf_cells/IMG_2237.jpeg	2023-12-26 23:44:10.588914	2023-12-26 23:44:10.588914
f7f1dfc2-ec33-4492-8b7c-84865f39548c	Down the Rabbit Hole	Juan Pablo Villalobos	\N	\N	\N	f	bookshelf_cells/IMG_2238.jpeg	2023-12-26 23:44:10.591002	2023-12-26 23:44:10.591002
b5dd9a2f-c798-4c64-a44f-a4d7212af38a	Lessons of Azikwelwa	Dan Mokonyane	\N	\N	\N	f	bookshelf_cells/IMG_2240.jpeg	2023-12-26 23:44:10.595077	2023-12-26 23:44:10.595077
04ca571c-adcd-4b69-aba3-7275afdada86	Studies in Classic American Literature	D. H. Lawrence	\N	\N	\N	f	bookshelf_cells/IMG_2241.jpeg	2023-12-26 23:44:10.597154	2023-12-26 23:44:10.597154
e04c411e-396b-4cb0-8259-babdd7dffea4	Love in the Time of Cholera	Gabriel Garcia Marquez	\N	\N	\N	f	bookshelf_cells/IMG_2242.jpeg	2023-12-26 23:44:10.599164	2023-12-26 23:44:10.599164
20bac937-fd19-40e1-9518-098fcd7d4d93	Where Does the Weirdness Go?	David Lindley	\N	\N	\N	f	bookshelf_cells/IMG_2243.jpeg	2023-12-26 23:44:10.60103	2023-12-26 23:44:10.60103
6517248a-958c-41ae-8636-fc0e1eed79f2	The History of Corporal Punishment	George Ryley Scott	\N	\N	\N	f	bookshelf_cells/IMG_2244.jpeg	2023-12-26 23:44:10.602613	2023-12-26 23:44:10.602613
bd014aea-0cce-417f-9b5f-29f833a0e2ad	Khrushchev: A Career	\N	\N	\N	\N	f	bookshelf_cells/IMG_2245.jpeg	2023-12-26 23:44:10.604248	2023-12-26 23:44:10.604248
3707bbab-d4ea-44a4-b74f-4097c0771b58	The Antisocial Personalities	David T. Lykken	\N	\N	\N	f	bookshelf_cells/IMG_2246.jpeg	2023-12-26 23:44:10.605767	2023-12-26 23:44:10.605767
50aa7d5f-b6d4-447f-a1f9-bc5342af5f6c	The Rails 3 Way	Obie Fernandez with Durrant Johnson, Jon Larkowski, Xavier Noria, and Tim Pope	\N	\N	\N	f	bookshelf_cells/IMG_2247.jpeg	2023-12-26 23:44:10.607143	2023-12-26 23:44:10.607143
ecb896f2-3608-4f8a-90b5-21ee75c96f80	The Enlightened Heart	Stephen Mitchell	\N	\N	\N	f	bookshelf_cells/IMG_2248.jpeg	2023-12-26 23:44:10.6092	2023-12-26 23:44:10.6092
e4566d22-e5e3-429e-b134-a955daa2e45a	Hitler's First War	Thomas Weber	\N	\N	\N	f	bookshelf_cells/IMG_2249.jpeg	2023-12-26 23:44:10.611232	2023-12-26 23:44:10.611232
fc3e858e-91ff-40a7-9a04-1b3b34fddd3e	Vietnam War Diary	Fred Leo Brown	\N	\N	\N	f	bookshelf_cells/IMG_2250.jpeg	2023-12-26 23:44:10.612828	2023-12-26 23:44:10.612828
308f9dd0-ecf9-4d97-a316-5d68d5adf184	Men of Mathematics	E. T. Bell	\N	\N	\N	f	bookshelf_cells/IMG_2251.jpeg	2023-12-26 23:44:10.614693	2023-12-26 23:44:10.614693
941fe88c-38ae-482d-8f8e-f3c2db3640cf	In the Realm of Hungry Ghosts	Gabor Maté, MD	\N	\N	\N	f	bookshelf_cells/IMG_2252.jpeg	2023-12-26 23:44:10.616473	2023-12-26 23:44:10.616473
16ee70da-a2a9-4c0f-92e5-bbdae46d1f35	A Mad Catastrophe	Geoffrey Wawro	\N	\N	\N	f	bookshelf_cells/IMG_2253.jpeg	2023-12-26 23:44:10.618087	2023-12-26 23:44:10.618087
676bc95f-c5c4-4275-80bb-99e684bffbdb	Antifragile	Nassim Nicholas Taleb	\N	\N	\N	f	bookshelf_cells/IMG_2254.jpeg	2023-12-26 23:44:10.619529	2023-12-26 23:44:10.619529
2b1fea8c-75c5-4285-8767-db98b481ad05	The Complete Idiot's Guide to World War II	Mitchell G. Bard, Ph.D.	\N	\N	\N	f	bookshelf_cells/IMG_2255.jpeg	2023-12-26 23:44:10.62103	2023-12-26 23:44:10.62103
f4fdc8df-48b9-4538-b101-4824e6f07688	Clean Code	Robert	\N	\N	\N	f	bookshelf_cells/IMG_2256.jpeg	2023-12-26 23:44:10.622441	2023-12-26 23:44:10.622441
61a732d7-d6be-4a8b-b8de-955a5a3300e6	Effective Java	Joshua Bloch	\N	\N	\N	f	bookshelf_cells/IMG_2257.jpeg	2023-12-27 00:51:54.611286	2023-12-27 00:51:54.611286
5dc9f516-de65-4a14-a3f8-9e5646be3576	The Singularity Is Near	Ray Kurzweil	\N	\N	\N	f	bookshelf_cells/IMG_2258.jpeg	2023-12-27 00:51:54.615599	2023-12-27 00:51:54.615599
a1e09d24-b504-4fc6-a246-e6fec62a3cd1	An Introduction to Linear Algebra & Tensors	M.A. Akivis, V.V. Goldberg	\N	\N	\N	f	bookshelf_cells/IMG_2259.jpeg	2023-12-27 00:51:54.618451	2023-12-27 00:51:54.618451
05a0c429-7d15-49a5-a96f-deec9f9d744e	Statistical Consequences of Fat Tails	Nassim Nicholas Taleb	\N	\N	\N	f	bookshelf_cells/IMG_2260.jpeg	2023-12-27 00:51:54.620911	2023-12-27 00:51:54.620911
ee1fbe18-4a8a-46fe-9933-6cf9f6593cee	Staff Engineer	Will Larson	\N	\N	\N	f	bookshelf_cells/IMG_2261.jpeg	2023-12-27 00:51:54.623214	2023-12-27 00:51:54.623214
59718fc8-872f-4270-8133-527af6bf099b	The Industries of the Future	Alec Ross	\N	\N	\N	f	bookshelf_cells/IMG_2560.jpeg	2023-12-27 00:55:17.251212	2023-12-27 00:55:17.251212
bb0aaefb-672b-4f4a-bf35-d5feb9e4797b	The BIG SELL OUT	Dan Mokonyane	\N	\N	\N	f	bookshelf_cells/IMG_2561.jpeg	2023-12-27 00:55:17.255102	2023-12-27 00:55:17.255102
c4d2b840-0962-4353-9fdd-9fdb4c7cc7b9	Korea	Security Pivot in Northeast Asia,null	\N	\N	\N	f	bookshelf_cells/IMG_2562.jpeg	2023-12-27 00:55:17.258006	2023-12-27 00:55:17.258006
a312c2ef-8146-4edb-947a-b1f6d6c4a1b8	The Spoils of War	Bruce Bueno de Mesquita, Alastair Smith	\N	\N	\N	f	bookshelf_cells/IMG_2265.jpeg	2023-12-27 00:51:54.629584	2023-12-27 00:51:54.629584
5fa47d4b-d567-4925-867a-006747bdd54d	Simulacra and Simulation	Jean Baudrillard	\N	\N	\N	f	bookshelf_cells/IMG_2563.jpeg	2023-12-27 00:55:17.260378	2023-12-27 00:55:17.260378
b3aaf9a0-5a18-457f-962b-c5604381fb26	Women of the Klan	Kathleen M. Blee	\N	\N	\N	f	bookshelf_cells/IMG_2564.jpeg	2023-12-27 00:55:17.263962	2023-12-27 00:55:17.263962
1cf1f22f-eeb1-4afa-8481-9290656a55dc	Gods in Everyman	Jean Shinoda Bolen, M.D.	\N	\N	\N	f	bookshelf_cells/IMG_2565.jpeg	2023-12-27 00:55:17.266726	2023-12-27 00:55:17.266726
04adf377-1dca-471e-854a-206876f2cadd	Contact	Carl Sagan	\N	\N	\N	f	bookshelf_cells/IMG_2566.jpeg	2023-12-27 00:55:17.269895	2023-12-27 00:55:17.269895
8c109090-d6e3-4abd-96b5-14c635da83e7	Shakey	Jimmy McDonough	\N	\N	\N	f	bookshelf_cells/IMG_2567.jpeg	2023-12-27 00:55:17.274408	2023-12-27 00:55:17.274408
7a6955e5-1188-4ee9-8606-1bc48aeb6924	The Code Book	Simon Singh	\N	\N	\N	f	bookshelf_cells/IMG_2568.jpeg	2023-12-27 00:55:17.278289	2023-12-27 00:55:17.278289
5513fb25-a25d-4935-b5fa-515813f5c979	American Nations	Colin Woodard	\N	\N	\N	f	bookshelf_cells/IMG_2569.jpeg	2023-12-27 00:55:17.281156	2023-12-27 00:55:17.281156
3ceb39e4-ebc6-4a14-b3a2-a564344dece3	Outrageously Yours	\N	\N	\N	\N	f	bookshelf_cells/IMG_2570.jpeg	2023-12-27 00:55:17.283524	2023-12-27 00:55:17.283524
908fd66c-375c-4243-8199-51a9b216a51d	Mr. Gatling's Terrible Marvel	Julia Keller	\N	\N	\N	f	bookshelf_cells/IMG_2572.jpeg	2023-12-27 00:55:17.287145	2023-12-27 00:55:17.287145
dd14ea39-bab3-416c-8e9e-9359cd8e8c90	The Woman Warrior	Maxine Hong Kingston	\N	\N	\N	f	bookshelf_cells/IMG_2573.jpeg	2023-12-27 00:55:17.289864	2023-12-27 00:55:17.289864
2b87518e-eb4e-42a6-b76a-02748f466b7b	Dictionary of American Politics	\N	\N	\N	\N	f	bookshelf_cells/IMG_2574.jpeg	2023-12-27 00:55:17.29306	2023-12-27 00:55:17.29306
e74c7bc1-57a7-40db-936c-0029f59515d7	Nonlinear Dynamics and Chaos	Steven H. Strogatz	\N	\N	\N	f	bookshelf_cells/IMG_2575.jpeg	2023-12-27 00:55:17.295787	2023-12-27 00:55:17.295787
e073311c-597c-4dae-9266-ddb2c1187daa	Thirty Seconds Over Tokyo	\N	\N	\N	\N	f	bookshelf_cells/IMG_2576.jpeg	2023-12-27 00:55:17.298778	2023-12-27 00:55:17.298778
728ba3d1-4364-4c12-8cf5-8bda5cff09da	Mathematica for the Sciences	Richard E. Crandall	\N	\N	\N	f	bookshelf_cells/IMG_2577.jpeg	2023-12-27 00:55:17.301805	2023-12-27 00:55:17.301805
7e3a469d-0d9a-4c89-b23e-4cd0f187d34c	Kids These Days	Malcolm Harris	\N	\N	\N	f	bookshelf_cells/IMG_2578.jpeg	2023-12-27 00:55:17.303918	2023-12-27 00:55:17.303918
9c7e558d-031a-49f6-96f4-72fdcf74f5ae	Ghost Fleet	P.W. Singer & August Cole	\N	\N	\N	f	bookshelf_cells/IMG_2579.jpeg	2023-12-27 00:55:17.306284	2023-12-27 00:55:17.306284
23e34f40-1217-4015-bffa-1964422658b3	Hit Men	Fredric Dannen	\N	\N	\N	f	bookshelf_cells/IMG_2580.jpeg	2023-12-27 00:55:17.308766	2023-12-27 00:55:17.308766
ab03cce9-2e57-4e98-842b-2c6f3e0448ec	Apostrophes & Apocalypses	John Barnes	\N	\N	\N	f	bookshelf_cells/IMG_2581.jpeg	2023-12-27 00:55:17.310845	2023-12-27 00:55:17.310845
3b468eef-a920-43bf-a9ba-06078d8985a0	Selected Poems	Osip Mandelstam	\N	\N	\N	f	bookshelf_cells/IMG_2582.jpeg	2023-12-27 00:55:17.312437	2023-12-27 00:55:17.312437
a9391bab-550d-4433-b338-e0b1a6fbdc60	Grit	Angela Duckworth	\N	\N	\N	f	bookshelf_cells/IMG_2583.jpeg	2023-12-27 00:55:17.314478	2023-12-27 00:55:17.314478
b88ee267-cbc2-4dd5-8be4-9c90b12c99f0	Purple Squirrel	Michael B. Junge	\N	\N	\N	f	bookshelf_cells/IMG_2584.jpeg	2023-12-27 00:55:17.317452	2023-12-27 00:55:17.317452
802aed32-818f-482f-b4c4-3b160635f0b9	Conspiracy	Ryan Holiday	\N	\N	\N	f	bookshelf_cells/IMG_2585.jpeg	2023-12-27 00:55:17.319599	2023-12-27 00:55:17.319599
670e2698-f371-4ef1-97e8-5c54be11cffe	The Entrepreneur's Guide to	\N	\N	\N	\N	f	bookshelf_cells/IMG_2587.jpeg	2023-12-27 00:55:17.321231	2023-12-27 00:55:17.321231
e5c1f047-165c-4bc9-9357-81d0e1e4680d	The Fall of Berlin 1945	Antony Beevor	\N	\N	\N	f	bookshelf_cells/IMG_2607.jpeg	2023-12-27 00:56:00.85238	2023-12-27 00:56:00.85238
c1bda296-9501-46b1-afff-b1f7fddb90c8	A Pillar of Iron	Taylor Caldwell	\N	\N	\N	f	bookshelf_cells/IMG_2608.jpeg	2023-12-27 00:56:00.856378	2023-12-27 00:56:00.856378
330ab77a-b074-496d-8667-e0a2ea584688	U.S. Civil-Military Relations	Don M. Snider, Miranda A. Carlton-Carew	\N	\N	\N	f	bookshelf_cells/IMG_2609.jpeg	2023-12-27 00:56:00.859312	2023-12-27 00:56:00.859312
c173ff23-30f9-483d-b34e-53194a8c299d	Symmetry in Science	Joe Rosen	\N	\N	\N	f	bookshelf_cells/IMG_2610.jpeg	2023-12-27 00:56:00.861772	2023-12-27 00:56:00.861772
440b844f-96aa-4717-a235-51f51af6e36b	Summer for the Gods	Edward J. Larson	\N	\N	\N	f	bookshelf_cells/IMG_2611.jpeg	2023-12-27 00:56:00.86407	2023-12-27 00:56:00.86407
f6d7f536-7871-47ee-aa21-f4c85411aeea	The Blair Handbook	Toby Fulwiler, Alan R. Hayakawa	\N	\N	\N	f	bookshelf_cells/IMG_2612.jpeg	2023-12-27 00:56:00.866327	2023-12-27 00:56:00.866327
e2e787d1-ba53-4dc2-b756-ca284f966f99	Eight Bells and All's Well	Daniel V. Gallery	\N	\N	\N	f	bookshelf_cells/IMG_2307.jpeg	2023-12-27 00:52:37.367039	2023-12-27 00:52:37.367039
a605fbe2-3b21-4641-9ad1-3119e50a3c93	The Carving of Mount Rushmore	Rex Alan Smith	\N	\N	\N	f	bookshelf_cells/IMG_2308.jpeg	2023-12-27 00:52:37.371931	2023-12-27 00:52:37.371931
d8c877b7-4524-4740-b073-0dec478c9f53	Intelligence in War	John Keegan	\N	\N	\N	f	bookshelf_cells/IMG_2309.jpeg	2023-12-27 00:52:37.373951	2023-12-27 00:52:37.373951
70ce43cd-0daf-46bf-9781-fec5c4d52e5a	The Genius of the Beast	Howard Bloom	\N	\N	\N	f	bookshelf_cells/IMG_2310.jpeg	2023-12-27 00:52:37.37668	2023-12-27 00:52:37.37668
e729c6b3-02cb-4a2e-9107-42f73f69fada	This Business of Music Marketing and Promotion	Tad Lathrop & Jim Pettigrew, Jr.	\N	\N	\N	f	bookshelf_cells/IMG_2311.jpeg	2023-12-27 00:52:37.379795	2023-12-27 00:52:37.379795
5326e7b8-67db-42f8-81a4-de099151ceb9	Junky	William S. Burroughs	\N	\N	\N	f	bookshelf_cells/IMG_2312.jpeg	2023-12-27 00:52:37.381421	2023-12-27 00:52:37.381421
84885951-185b-40d4-a84e-626c727a9333	High-Pressure Shock Compression of Solids II	\N	\N	\N	\N	f	bookshelf_cells/IMG_2313.jpeg	2023-12-27 00:52:37.383389	2023-12-27 00:52:37.383389
3a85bd4d-ca57-4b74-858c-4fe9c1f06950	POP. 1280	Jim Thompson	\N	\N	\N	f	bookshelf_cells/IMG_2314.jpeg	2023-12-27 00:52:37.385697	2023-12-27 00:52:37.385697
9b0a3842-a3d4-43a4-b00f-d95f10f0a0ed	Hollywood Babylon	Kenneth Anger	\N	\N	\N	f	bookshelf_cells/IMG_2315.jpeg	2023-12-27 00:52:37.387679	2023-12-27 00:52:37.387679
498b38c6-a81b-4e40-86b5-7211befd1a83	Dare Not Linger	Nelson Mandela and Mandla Langa	\N	\N	\N	f	bookshelf_cells/IMG_2316.jpeg	2023-12-27 00:52:37.389311	2023-12-27 00:52:37.389311
09a0be45-6660-4c3a-88a7-d69a56c2a7d8	Man's Search for Meaning	Viktor E. Frankl	\N	\N	\N	f	bookshelf_cells/IMG_2317.jpeg	2023-12-27 00:52:37.391124	2023-12-27 00:52:37.391124
6d407838-27ed-4ed2-88fc-64208001f958	Leonardo da Vinci	Walter Isaacson	\N	\N	\N	f	bookshelf_cells/IMG_2318.jpeg	2023-12-27 00:52:37.392977	2023-12-27 00:52:37.392977
6a1b294d-ba43-4d6f-a680-098afa9cfb5d	The Whole Shebang	Timothy Ferris	\N	\N	\N	f	bookshelf_cells/IMG_2319.jpeg	2023-12-27 00:52:37.394768	2023-12-27 00:52:37.394768
07067098-dafe-44fd-8f35-10282bd6e8eb	11/22/63	Stephen King	\N	\N	\N	f	bookshelf_cells/IMG_2322.jpeg	2023-12-27 00:52:37.396724	2023-12-27 00:52:37.396724
1a9d8083-bd94-4001-bdec-25e4cbcf9175	A Briefer History of Time	Stephen Hawking with Leonard Mlodinow	\N	\N	\N	f	bookshelf_cells/IMG_2323.jpeg	2023-12-27 00:52:37.398377	2023-12-27 00:52:37.398377
1cc68ae6-c1ac-4f67-83b9-ac6d3bea0a93	Palestine	Jimmy Carter	\N	\N	\N	f	bookshelf_cells/IMG_2324.jpeg	2023-12-27 00:52:37.400003	2023-12-27 00:52:37.400003
c55d20cc-5c71-445e-94b8-d0ecaea39ebc	Descent into Hell	Charles Williams	\N	\N	\N	f	bookshelf_cells/IMG_2325.jpeg	2023-12-27 00:52:37.401607	2023-12-27 00:52:37.401607
a1bc4650-cde3-4b5e-a123-a04c45e3e212	Nebula Awards Showcase 2000	edited by Gregory Benford	\N	\N	\N	f	bookshelf_cells/IMG_2326.jpeg	2023-12-27 00:52:37.404085	2023-12-27 00:52:37.404085
9a75a1f6-b74c-4ee3-b28f-f387f6496a09	The Tao of Physics	Fritjof Capra	\N	\N	\N	f	bookshelf_cells/IMG_2327.jpeg	2023-12-27 00:52:37.406243	2023-12-27 00:52:37.406243
7e50115a-614b-437c-ad56-01d9bb646d9a	SEX	Harry Maurer	\N	\N	\N	f	bookshelf_cells/IMG_2328.jpeg	2023-12-27 00:52:37.407924	2023-12-27 00:52:37.407924
86782fa3-6369-48b9-a9c5-e3a1457298d8	Zen and the Art of Motorcycle Maintenance	Robert M. Pirsig	\N	\N	\N	f	bookshelf_cells/IMG_2329.jpeg	2023-12-27 00:52:37.409369	2023-12-27 00:52:37.409369
f4bfa670-dce4-44b7-ba3b-16dfffa86e41	Franklin and Winston	Jon Meacham	\N	\N	\N	f	bookshelf_cells/IMG_2330.jpeg	2023-12-27 00:52:37.410994	2023-12-27 00:52:37.410994
aa941f9c-d388-4b4f-8e20-27617cea63b9	Analysis of Observed Chaotic Data	Henry D.I. Abarbanel	\N	\N	\N	f	bookshelf_cells/IMG_2331.jpeg	2023-12-27 00:52:37.412629	2023-12-27 00:52:37.412629
1b6a87b9-656a-42b2-801c-10b7128f34e7	The Dance of Anger	Harriet Lerner, Ph.D.	\N	\N	\N	f	bookshelf_cells/IMG_2332.jpeg	2023-12-27 00:52:37.414166	2023-12-27 00:52:37.414166
302ec20a-d75c-49c5-918f-9844ccc03b99		\N	\N	\N	\N	f	bookshelf_cells/IMG_2333.jpeg	2023-12-27 00:52:37.415718	2023-12-27 00:52:37.415718
2162dde2-6506-400b-b01e-25bf9da3dcfe	Infinite Jest	David Foster Wallace	\N	\N	\N	f	bookshelf_cells/IMG_2359.jpeg	2023-12-27 00:53:16.752875	2023-12-27 00:53:16.752875
23ca6946-d107-4e59-95b2-9955c23b12c4	Non-Flowered Plants	\N	\N	\N	\N	f	bookshelf_cells/IMG_2390.jpeg	2023-12-27 00:53:16.754895	2023-12-27 00:53:16.754895
d5253e2f-f1f6-4238-953a-9ed9dc997d48	Introduction to Quantum Mechanics	David J. Griffiths	\N	\N	\N	f	bookshelf_cells/IMG_2613.jpeg	2023-12-27 00:56:00.868076	2023-12-27 00:56:00.868076
f1b2a87b-fcfd-4133-937b-45d6304d5375	The Killer Inside Me	Jim Thompson	\N	\N	\N	f	bookshelf_cells/IMG_2614.jpeg	2023-12-27 00:56:00.869905	2023-12-27 00:56:00.869905
c9a29c95-3601-4436-8890-2a5429ef69f4	The Pantry Primer	Daisy Luther	\N	\N	\N	f	bookshelf_cells/IMG_2615.jpeg	2023-12-27 00:56:00.871618	2023-12-27 00:56:00.871618
3f1bc318-b9eb-4fd5-ba2c-56566741c0f6	Rocks and Minerals	\N	\N	\N	\N	f	bookshelf_cells/IMG_2394.jpeg	2023-12-27 00:53:16.761027	2023-12-27 00:53:16.761027
aa694bdf-3570-46ff-96a2-a3ceec99e39e	Love Poems	Anne Sexton	\N	\N	\N	f	bookshelf_cells/IMG_2616.jpeg	2023-12-27 00:56:00.873316	2023-12-27 00:56:00.873316
520cd59e-a47b-4d92-b904-a35e1a6d013c	Rude Boys	\N	\N	\N	\N	f	bookshelf_cells/IMG_2617.jpeg	2023-12-27 00:56:00.87536	2023-12-27 00:56:00.87536
c826399f-7933-443d-8c7e-3a37797fa4c8	The Commingled Code	Josh Lerner, Mark Schankerman	\N	\N	\N	f	bookshelf_cells/IMG_2618.jpeg	2023-12-27 00:56:00.877205	2023-12-27 00:56:00.877205
f4565855-c8aa-42b4-9601-063adf6534b2	The Travel Book	Josh Hall	\N	\N	\N	f	bookshelf_cells/IMG_2398.jpeg	2023-12-27 00:53:16.766613	2023-12-27 00:53:16.766613
7e1d959a-4742-4618-9802-af023577bbf5	Reverse Cowgirl	\N	\N	\N	\N	f	bookshelf_cells/IMG_2399.jpeg	2023-12-27 00:53:16.768159	2023-12-27 00:53:16.768159
1a6d367e-fd74-462e-ad4c-bed77c561aaf	On-The-Fringe	\N	\N	\N	\N	f	bookshelf_cells/IMG_2400.jpeg	2023-12-27 00:53:16.769663	2023-12-27 00:53:16.769663
cda7238b-f601-4f53-8950-00f5896ff61c	Reverence	\N	\N	\N	\N	f	bookshelf_cells/IMG_2401.jpeg	2023-12-27 00:53:16.77105	2023-12-27 00:53:16.77105
bfaf59d7-8b23-4e9e-b337-699c2701d12c	An Atlas of Anatomy for Artists	Fritz Schider	\N	\N	\N	f	bookshelf_cells/IMG_2402.jpeg	2023-12-27 00:53:16.772407	2023-12-27 00:53:16.772407
3520707d-7085-4969-9cf0-dd701a610b78	Bukowski In Pictures	Howard Sounes	\N	\N	\N	f	bookshelf_cells/IMG_2403.jpeg	2023-12-27 00:53:16.774029	2023-12-27 00:53:16.774029
fa2fc275-8a11-42bc-a9a3-ea22ccbbf49e	The Complete Poems of Emily Dickinson	Thomas H. Johnson	\N	\N	\N	f	bookshelf_cells/IMG_2404.jpeg	2023-12-27 00:53:16.775651	2023-12-27 00:53:16.775651
ceb2487d-c0f9-4bd0-a115-5553a37ed27c	The Iliad	Homer	\N	\N	\N	f	bookshelf_cells/IMG_2405.jpeg	2023-12-27 00:53:16.776793	2023-12-27 00:53:16.776793
9d768bc2-9d96-4e84-b398-6732cb5f9a2d	Among the Thugs	Bill Buford	\N	\N	\N	f	bookshelf_cells/IMG_2406.jpeg	2023-12-27 00:53:16.777874	2023-12-27 00:53:16.777874
7371464e-e0d1-4489-8567-07258724b873	Hollywood Godfather	Gianni Russo	\N	\N	\N	f	bookshelf_cells/IMG_2407.jpeg	2023-12-27 00:53:16.778802	2023-12-27 00:53:16.778802
55f1d7ea-3b5f-49c5-ac78-ae58908fcef9	Coreyography	Corey Feldman	\N	\N	\N	f	bookshelf_cells/IMG_2408.jpeg	2023-12-27 00:53:16.779595	2023-12-27 00:53:16.779595
112f157a-679f-48b4-92b1-eec42e1af57d	Drugs Are Nice	Lisa Crystal Carver	\N	\N	\N	f	bookshelf_cells/IMG_2409.jpeg	2023-12-27 00:53:16.780557	2023-12-27 00:53:16.780557
44d0fb9d-e305-4398-aff8-a7a3a3d7bfa9	The Zombie Survival Guide	Max Brooks	\N	\N	\N	f	bookshelf_cells/IMG_2410.jpeg	2023-12-27 00:53:16.781383	2023-12-27 00:53:16.781383
9bee4e5e-9952-42b6-9748-efb24d80d97d	Modern Quantum Mechanics	J. J. Sakurai	\N	\N	\N	f	bookshelf_cells/IMG_2619.jpeg	2023-12-27 00:56:00.879173	2023-12-27 00:56:00.879173
fb9661e4-cfe8-42ab-a68a-701fc5231e2c	Understanding Movies	Louis D. Giannetti	\N	\N	\N	f	bookshelf_cells/IMG_2412.jpeg	2023-12-27 00:53:16.782858	2023-12-27 00:53:16.782858
7af9e702-e641-48df-ab60-54489adcaa0e	Notes from No Man's Land	Eula Biss	\N	\N	\N	f	bookshelf_cells/IMG_2413.jpeg	2023-12-27 00:53:16.783579	2023-12-27 00:53:16.783579
6e016b22-b33d-406c-8e18-a711d7ab5876	Rites of Spring	Modris Eksteins	\N	\N	\N	f	bookshelf_cells/IMG_2414.jpeg	2023-12-27 00:53:16.784349	2023-12-27 00:53:16.784349
7f23489a-bc23-419b-8351-9b9bb39f6439	Siddhartha	Hermann Hesse	\N	\N	\N	f	bookshelf_cells/IMG_2415.jpeg	2023-12-27 00:53:16.785119	2023-12-27 00:53:16.785119
5eab8134-e2b9-48d0-9c01-fe5c73066c1d	Caring for Your Baby and Young Child	\N	\N	\N	\N	f	bookshelf_cells/IMG_2416.jpeg	2023-12-27 00:53:16.785862	2023-12-27 00:53:16.785862
265f5bb2-8df3-456a-8559-a4771363915b	Graffiti Women	Nicholas Ganz	\N	\N	\N	f	bookshelf_cells/IMG_2417.jpeg	2023-12-27 00:53:16.78669	2023-12-27 00:53:16.78669
82218b78-b32f-4f37-be1a-eb7ab42710b1	American Gods	Neil Gaiman	\N	\N	\N	f	bookshelf_cells/IMG_2418.jpeg	2023-12-27 00:53:16.787386	2023-12-27 00:53:16.787386
3d729fb7-cd1d-45df-953b-10b76e41d035	Slaughterhouse-Five	Kurt Vonnegut	\N	\N	\N	f	bookshelf_cells/IMG_2419.jpeg	2023-12-27 00:53:16.788118	2023-12-27 00:53:16.788118
2a8ee21d-63f2-48ef-8fa3-3cc867034c76	Wetlands	Charlotte Roche	\N	\N	\N	f	bookshelf_cells/IMG_2420.jpeg	2023-12-27 00:53:16.788934	2023-12-27 00:53:16.788934
5bf640a5-bda3-42ce-949c-3a4c139d2483	Lives of the Artists	Giorgio Vasari	\N	\N	\N	f	bookshelf_cells/IMG_2421.jpeg	2023-12-27 00:53:16.789795	2023-12-27 00:53:16.789795
be9902e8-d4a1-439f-8b4c-dad0b8d86e73	4 Dada Suicides	\N	\N	\N	\N	f	bookshelf_cells/IMG_2422.jpeg	2023-12-27 00:53:16.7906	2023-12-27 00:53:16.7906
675df308-fa32-4cb5-a4ef-f4736ce30626	The Book of Answers	Carol Bolt	\N	\N	\N	f	bookshelf_cells/IMG_2423.jpeg	2023-12-27 00:53:16.791415	2023-12-27 00:53:16.791415
7c324ffc-5d36-4d70-a31c-6e25b63896cb	Design of the 20th Century	Charlotte & Peter Fiell	\N	\N	\N	f	bookshelf_cells/IMG_2424.jpeg	2023-12-27 00:53:16.792185	2023-12-27 00:53:16.792185
c514a24a-2bf1-4538-a636-766bb7149fc9	FreshFruits	\N	\N	\N	\N	f	bookshelf_cells/IMG_2425.jpeg	2023-12-27 00:53:16.792929	2023-12-27 00:53:16.792929
5abf7ce5-236a-4252-b57f-da3e9d244a53	The Collected Poems	Sylvia Plath	\N	\N	\N	f	bookshelf_cells/IMG_2426.jpeg	2023-12-27 00:53:16.793735	2023-12-27 00:53:16.793735
fe5be742-2565-44ff-aefd-4cab98521b4d	Soft Sculpt	\N	\N	\N	\N	f	bookshelf_cells/IMG_2427.jpeg	2023-12-27 00:53:16.79454	2023-12-27 00:53:16.79454
98bf389e-0776-4fd1-a325-d1a83fadb58c	Sharp Objects	Gillian Flynn	\N	\N	\N	f	bookshelf_cells/IMG_2439.jpeg	2023-12-27 00:53:58.237038	2023-12-27 00:53:58.237038
2f5ed72b-560c-459f-96d9-b1c777c0df83	In Cold Blood	Truman Capote	\N	\N	\N	f	bookshelf_cells/IMG_2440.jpeg	2023-12-27 00:53:58.240251	2023-12-27 00:53:58.240251
72bb9372-9b1a-4d0f-829f-7426b53bb57a	My Life in France	Julia Child	\N	\N	\N	f	bookshelf_cells/IMG_2441.jpeg	2023-12-27 00:53:58.242704	2023-12-27 00:53:58.242704
0da9b084-730b-4f8e-8c34-55c2d8eb7360	Bauhaus	Frank Whitford	\N	\N	\N	f	bookshelf_cells/IMG_2443.jpeg	2023-12-27 00:53:58.247414	2023-12-27 00:53:58.247414
0c94fd26-c9b4-45c4-be8f-89bb750ffe9c	Rocks Off	Bill Janovitz	\N	\N	\N	f	bookshelf_cells/IMG_2444.jpeg	2023-12-27 00:53:58.249628	2023-12-27 00:53:58.249628
ec438805-f153-4e83-a8eb-e19f49722163	Body of Secrets	James Bamford	\N	\N	\N	f	bookshelf_cells/IMG_2446.jpeg	2023-12-27 00:53:58.254265	2023-12-27 00:53:58.254265
0a62858b-259b-4343-a571-9e6d07906b93	The Fortress of Solitude	Jonathan Lethem	\N	\N	\N	f	bookshelf_cells/IMG_2447.jpeg	2023-12-27 00:53:58.256822	2023-12-27 00:53:58.256822
952e032a-810a-40fe-b94d-a513217cfc4c	Gravity's Rainbow	Thomas Pynchon	\N	\N	\N	f	bookshelf_cells/IMG_2448.jpeg	2023-12-27 00:53:58.259248	2023-12-27 00:53:58.259248
116e7cf7-c18d-4516-88ee-bf2980ea805f	The Undoing Project	Michael Lewis	\N	\N	\N	f	bookshelf_cells/IMG_2449.jpeg	2023-12-27 00:53:58.261423	2023-12-27 00:53:58.261423
02e0980e-a453-4c10-907b-0dbfce2fa157	High Output Management	Andrew S. Grove	\N	\N	\N	f	bookshelf_cells/IMG_2450.jpeg	2023-12-27 00:53:58.263727	2023-12-27 00:53:58.263727
56c79346-86c7-4f81-9f18-8fbe7895330f	Kafka on the Shore	Haruki Murakami	\N	\N	\N	f	bookshelf_cells/IMG_2451.jpeg	2023-12-27 00:53:58.26614	2023-12-27 00:53:58.26614
147ef30d-5d14-4af9-b9ca-f75dfa5243fc	Dhalgren	Samuel R. Delany	\N	\N	\N	f	bookshelf_cells/IMG_2452.jpeg	2023-12-27 00:53:58.269735	2023-12-27 00:53:58.269735
4982269b-c827-4551-822d-534dc1976700	Hard-Boiled Wonderland and the End of the World	Haruki Murakami	\N	\N	\N	f	bookshelf_cells/IMG_2453.jpeg	2023-12-27 00:53:58.272252	2023-12-27 00:53:58.272252
bd057084-22c0-43c2-87da-f30c9ed20a68	A World Out of Time	Larry Niven	\N	\N	\N	f	bookshelf_cells/IMG_2455.jpeg	2023-12-27 00:53:58.276254	2023-12-27 00:53:58.276254
ab309734-c64d-467d-8fc8-c2fd43746e6a	The Year 1000	Robert Lacey and Danny Danziger	\N	\N	\N	f	bookshelf_cells/IMG_2456.jpeg	2023-12-27 00:53:58.27824	2023-12-27 00:53:58.27824
02721f48-3fa7-41b4-8c02-4292d5ad9e6b	WE	Eugene Zamyatin	\N	\N	\N	f	bookshelf_cells/IMG_2457.jpeg	2023-12-27 00:53:58.28046	2023-12-27 00:53:58.28046
b3f99212-15c8-4dad-b8dd-b30364ee010d	Feminism is for Everybody	bell hooks	\N	\N	\N	f	bookshelf_cells/IMG_2458.jpeg	2023-12-27 00:53:58.283427	2023-12-27 00:53:58.283427
831b716c-ed66-4347-bc25-ffd67425bd5a	Neighborhood	Norbert Blei	\N	\N	\N	f	bookshelf_cells/IMG_2459.jpeg	2023-12-27 00:53:58.286377	2023-12-27 00:53:58.286377
79c46397-70cd-47ea-8971-d33b34572d3e	Platform	Michel Houellebecq	\N	\N	\N	f	bookshelf_cells/IMG_2460.jpeg	2023-12-27 00:53:58.288597	2023-12-27 00:53:58.288597
1fd4ed97-b53a-4857-97a5-6ada12f08b42	The Third Chimpanzee	Jared Diamond	\N	\N	\N	f	bookshelf_cells/IMG_2461.jpeg	2023-12-27 00:53:58.290705	2023-12-27 00:53:58.290705
91faed33-dc09-4851-82fa-d6f369d13424	The Music of the Primes	Marcus du Sautoy	\N	\N	\N	f	bookshelf_cells/IMG_2462.jpeg	2023-12-27 00:53:58.293109	2023-12-27 00:53:58.293109
ac773996-3900-4ce1-a4a5-3e769dbe096f	The Logic of Scientific Discovery	Karl R. Popper	\N	\N	\N	f	bookshelf_cells/IMG_2463.jpeg	2023-12-27 00:53:58.295141	2023-12-27 00:53:58.295141
4dc9bddd-87ff-41d8-8ca8-6694175f143d	The Disuniting of America	Arthur M. Schlesinger, Jr.	\N	\N	\N	f	bookshelf_cells/IMG_2464.jpeg	2023-12-27 00:53:58.29725	2023-12-27 00:53:58.29725
e1ce930f-09b1-45a7-99de-aa12e07c11c1	Inspired	Marty Cagan	\N	\N	\N	f	bookshelf_cells/IMG_2465.jpeg	2023-12-27 00:53:58.299044	2023-12-27 00:53:58.299044
d4cd7bef-e900-467a-8710-36decc3afc7e	Learning Rails	Simon St. Laurent & Edd Dumbill	\N	\N	\N	f	bookshelf_cells/IMG_2466.jpeg	2023-12-27 00:53:58.301061	2023-12-27 00:53:58.301061
cd5b0d6a-751e-4db3-9c2f-04c45bc97245	Wave Packets and Their Bifurcations in Geophysical Fluid Dynamics	Huijun Yang	\N	\N	\N	f	bookshelf_cells/IMG_2467.jpeg	2023-12-27 00:53:58.3052	2023-12-27 00:53:58.3052
035a356c-0a8a-49b6-936c-2e64c4175944	Moment Map and Combinatorial Invariants of Hamiltonian T	\N	\N	\N	\N	f	bookshelf_cells/IMG_2468.jpeg	2023-12-27 00:53:58.308196	2023-12-27 00:53:58.308196
1534a70d-a7f7-4a26-b1a9-fe9f96576c58	A New Kind of Science	Stephen Wolfram	\N	\N	\N	f	bookshelf_cells/IMG_2489.jpeg	2023-12-27 00:54:36.602339	2023-12-27 00:54:36.602339
4f3fb0a3-92a0-46be-a6a6-7109b88e6a3c	Complete Tales & Poems	Edgar Allan Poe	\N	\N	\N	f	bookshelf_cells/IMG_2490.jpeg	2023-12-27 00:54:36.605933	2023-12-27 00:54:36.605933
d598ffee-6c50-40fc-9216-a1baef0b04ed	The Visual Display of Quantitative Information	Edward R. Tufte	\N	\N	\N	f	bookshelf_cells/IMG_2491.jpeg	2023-12-27 00:54:36.607913	2023-12-27 00:54:36.607913
f3a50578-121c-466b-bbf5-39b511f76973	Supercapitalism	Robert B. Reich	\N	\N	\N	f	bookshelf_cells/IMG_2620.jpeg	2023-12-27 00:56:00.881149	2023-12-27 00:56:00.881149
563fdd37-d024-4669-9934-4d8b8d21bdb2	The Innocent	David Baldacci	\N	\N	\N	f	bookshelf_cells/IMG_2510.jpeg	2023-12-27 00:54:36.612176	2023-12-27 00:54:36.612176
8a9d76fa-a957-4598-b5b4-fd84de6f806c	My Ántonia	Willa Cather	\N	\N	\N	f	bookshelf_cells/IMG_2511.jpeg	2023-12-27 00:54:36.614388	2023-12-27 00:54:36.614388
f47040fd-2f16-450d-8542-0e750414c871	The FDR Years	William E. Leuchtenburg	\N	\N	\N	f	bookshelf_cells/IMG_2512.jpeg	2023-12-27 00:54:36.616068	2023-12-27 00:54:36.616068
97616285-1a75-48c1-a916-c30b047bf78b	Basic Writings	Martin Heidegger	\N	\N	\N	f	bookshelf_cells/IMG_2513.jpeg	2023-12-27 00:54:36.6178	2023-12-27 00:54:36.6178
6a5bf881-14ec-4fb8-96ac-721f8f356910	The Philosophy of Mathematics	Stephan Körner	\N	\N	\N	f	bookshelf_cells/IMG_2514.jpeg	2023-12-27 00:54:36.619377	2023-12-27 00:54:36.619377
fc4c776f-2610-4cbf-9878-83243713dcc6	Elementary Quantum Mechanics	\N	\N	\N	\N	f	bookshelf_cells/IMG_2621.jpeg	2023-12-27 00:56:00.882947	2023-12-27 00:56:00.882947
549626d4-0038-4a53-b740-8bcc68b5ba47	Global Inequality	Branko Milanovic	\N	\N	\N	f	bookshelf_cells/IMG_2516.jpeg	2023-12-27 00:54:36.623194	2023-12-27 00:54:36.623194
5b642339-e210-4fe6-9a0c-fae10cb7c8aa	Things to Come	H.G. Wells	\N	\N	\N	f	bookshelf_cells/IMG_2622.jpeg	2023-12-27 00:56:00.884475	2023-12-27 00:56:00.884475
17192a46-a30f-46ce-8ca5-7754d6a435f4	Understanding Computation	Tom Stuart	\N	\N	\N	f	bookshelf_cells/IMG_2623.jpeg	2023-12-27 00:56:00.885958	2023-12-27 00:56:00.885958
73757463-3286-4d50-9289-81376fdd92b5	JavaScript: The Good Parts	Douglas Crockford	\N	\N	\N	f	bookshelf_cells/IMG_2624.jpeg	2023-12-27 00:56:00.887347	2023-12-27 00:56:00.887347
857c6976-79e9-4f29-a92f-c36fbefec9a3	Junkbots	Bugbots & Bots on Wheels, Dave Hrynkiw, Mark W. Tilden	\N	\N	\N	f	bookshelf_cells/IMG_2625.jpeg	2023-12-27 00:56:00.888761	2023-12-27 00:56:00.888761
ff46591d-0447-4a13-b9c2-d30e042506c3	The Silk Roads	Peter Frankopan	\N	\N	\N	f	bookshelf_cells/IMG_2626.jpeg	2023-12-27 00:56:00.890112	2023-12-27 00:56:00.890112
e4269ae3-c8b7-4f4b-82ab-8691408b87b4	Refactoring	Martin Fowler	\N	\N	\N	f	bookshelf_cells/IMG_2627.jpeg	2023-12-27 00:56:00.891446	2023-12-27 00:56:00.891446
69d48cac-8526-4511-b6c2-5973a581ac20	Atomic Design	Brad Frost	\N	\N	\N	f	bookshelf_cells/IMG_2628.jpeg	2023-12-27 00:56:00.893078	2023-12-27 00:56:00.893078
8554f407-5550-4372-8fba-0c9c85115908	MobX Quick Start Guide	Pavan Podila, Michel Weststrate	\N	\N	\N	f	bookshelf_cells/IMG_2629.jpeg	2023-12-27 00:56:00.894492	2023-12-27 00:56:00.894492
5f72b90d-38a4-4c0e-9683-9d6c3cc41287	The Innovator's Solution	Clayton M. Christensen, Michael E. Raynor	\N	\N	\N	f	bookshelf_cells/IMG_2630.jpeg	2023-12-27 00:56:00.895876	2023-12-27 00:56:00.895876
67f3b432-6298-41cf-818d-22a03375e220	Clojure for the Brave and True	Daniel Higginbotham	\N	\N	\N	f	bookshelf_cells/IMG_2631.jpeg	2023-12-27 00:56:00.89718	2023-12-27 00:56:00.89718
97b5db52-7254-494e-8cd9-3c8b0db2e877	The Warrior Who Would Rule Russia	Benjamin S. Lambeth	\N	\N	\N	f	bookshelf_cells/IMG_2632.jpeg	2023-12-27 00:56:00.898408	2023-12-27 00:56:00.898408
62df5fd2-b474-48c9-83d1-ccb6722bb158	Pale Blue Dot	Carl	\N	\N	\N	f	bookshelf_cells/IMG_2633.jpeg	2023-12-27 00:56:00.900022	2023-12-27 00:56:00.900022
11c4e9ae-b92f-400a-b279-28c612f4b1d2	Infinite Potential	F. David Peat	\N	\N	\N	f	bookshelf_cells/IMG_2658.jpeg	2023-12-27 00:56:44.152618	2023-12-27 00:56:44.152618
a1bb9501-3aaf-42b7-9d20-7c7580f52f63	King Henry IV Part I	\N	\N	\N	\N	f	bookshelf_cells/IMG_2659.jpeg	2023-12-27 00:56:44.155454	2023-12-27 00:56:44.155454
823d0ba8-35c5-4c42-b82d-6c4e3efa1077	Modern Man in Search of a Soul	C. G. Jung	\N	\N	\N	f	bookshelf_cells/IMG_2660.jpeg	2023-12-27 00:56:44.157553	2023-12-27 00:56:44.157553
8245d549-4499-4b00-aaa1-40e100c36062	The Picture of Dorian Gray	Oscar Wilde	\N	\N	\N	f	bookshelf_cells/IMG_2661.jpeg	2023-12-27 00:56:44.159294	2023-12-27 00:56:44.159294
77dcbd38-65ed-4439-a5d8-e518fdec097e	Titus Andronicus	\N	\N	\N	\N	f	bookshelf_cells/IMG_2662.jpeg	2023-12-27 00:56:44.160984	2023-12-27 00:56:44.160984
2ffc5358-190d-4c67-9012-7f3b0873eb2a	Pacific Historical Review	\N	\N	\N	\N	f	bookshelf_cells/IMG_2663.jpeg	2023-12-27 00:56:44.162428	2023-12-27 00:56:44.162428
b9cb6a1c-5f95-4d35-8fd1-0f441a03a36c	Romeo and Juliet	William Shakespeare	\N	\N	\N	f	bookshelf_cells/IMG_2664.jpeg	2023-12-27 00:56:44.164889	2023-12-27 00:56:44.164889
93a54b11-6783-4aba-8ad4-645fc559a9a9	Ah	Wilderness!, Eugene O'Neill	\N	\N	\N	f	bookshelf_cells/IMG_2665.jpeg	2023-12-27 00:56:44.167541	2023-12-27 00:56:44.167541
d07981b3-2000-4b73-99b6-0c8746ddf456	Mary Stuart	Friedrich Schiller	\N	\N	\N	f	bookshelf_cells/IMG_2666.jpeg	2023-12-27 00:56:44.169637	2023-12-27 00:56:44.169637
94ce3927-8217-445d-bc66-b34f39bed436	All My Sons	Arthur Miller	\N	\N	\N	f	bookshelf_cells/IMG_2667.jpeg	2023-12-27 00:56:44.17109	2023-12-27 00:56:44.17109
77a10746-6d3d-4026-8265-56601cb5a672	Wit	Margaret Edson	\N	\N	\N	f	bookshelf_cells/IMG_2668.jpeg	2023-12-27 00:56:44.172625	2023-12-27 00:56:44.172625
05275ee5-fbda-4a0d-8c7c-18d6528cb326	The Importance of Being Earnest	Oscar Wilde	\N	\N	\N	f	bookshelf_cells/IMG_2669.jpeg	2023-12-27 00:56:44.174037	2023-12-27 00:56:44.174037
493a584e-05b4-4d17-bbf3-0b8df6deb0ab	Animals Out of Paper	Rajiv Joseph	\N	\N	\N	f	bookshelf_cells/IMG_2670.jpeg	2023-12-27 00:56:44.175356	2023-12-27 00:56:44.175356
bce87dc8-3efc-4d1b-820d-48a042b5048b	reasons to be pretty	Neil LaBute	\N	\N	\N	f	bookshelf_cells/IMG_2671.jpeg	2023-12-27 00:56:44.1775	2023-12-27 00:56:44.1775
040f81de-b9fb-4e5e-830a-95cf336ba14c	A Streetcar Named Desire	Tennessee Williams	\N	\N	\N	f	bookshelf_cells/IMG_2672.jpeg	2023-12-27 00:56:44.179285	2023-12-27 00:56:44.179285
04bead1a-194e-4ecc-9572-c582e10d28d4	The Piano Lesson	August Wilson	\N	\N	\N	f	bookshelf_cells/IMG_2673.jpeg	2023-12-27 00:56:44.180799	2023-12-27 00:56:44.180799
e4359287-82f8-49fd-ae24-656be1f264e1	Doubt A Parable	John Patrick Shanley	\N	\N	\N	f	bookshelf_cells/IMG_2674.jpeg	2023-12-27 00:56:44.181856	2023-12-27 00:56:44.181856
ece4c53a-f2e0-4986-8baf-6dde796af135	The Myth of Sisyphus and Other Essays	Albert Camus	\N	\N	\N	f	bookshelf_cells/IMG_2675.jpeg	2023-12-27 00:56:44.182793	2023-12-27 00:56:44.182793
6bba900c-4e34-4336-a922-32fd99fb72d7	The Penguin Historical Atlas of the Vikings	\N	\N	\N	\N	f	bookshelf_cells/IMG_2676.jpeg	2023-12-27 00:56:44.183973	2023-12-27 00:56:44.183973
a08ec98a-8c6e-4730-9be7-a708f442f84f	Bauer	Lauren Gunderson	\N	\N	\N	f	bookshelf_cells/IMG_2677.jpeg	2023-12-27 00:56:44.18503	2023-12-27 00:56:44.18503
5975363e-2887-4825-9b08-47b8ad2b122d	Libra	Don DeLillo	\N	\N	\N	f	bookshelf_cells/IMG_2678.jpeg	2023-12-27 00:56:44.185984	2023-12-27 00:56:44.185984
43e7d881-1f00-42b9-9732-4a7aee03b6fb	Hiroshima Mon Amour	Marguerite Duras	\N	\N	\N	f	bookshelf_cells/IMG_2679.jpeg	2023-12-27 00:56:44.186887	2023-12-27 00:56:44.186887
23ec1f51-d3dd-4b3f-9c7d-8eb7d87f82f1	1Q84	Haruki Murakami	\N	\N	\N	f	bookshelf_cells/IMG_2680.jpeg	2023-12-27 00:56:44.188027	2023-12-27 00:56:44.188027
78cad771-1ef6-4f08-b180-bc0bccdbbd9c	The Brothers Size	Tarell Alvin McCraney	\N	\N	\N	f	bookshelf_cells/IMG_2681.jpeg	2023-12-27 00:56:44.18935	2023-12-27 00:56:44.18935
87c4a743-2b93-4d2b-886c-5600d42a08bc	On the Technique of Acting	Michael Chekhov	\N	\N	\N	f	bookshelf_cells/IMG_2682.jpeg	2023-12-27 00:56:44.19043	2023-12-27 00:56:44.19043
587d2cac-c5fb-4602-988c-a9adecb23795	'ART'	Yasmina Reza	\N	\N	\N	f	bookshelf_cells/IMG_2683.jpeg	2023-12-27 00:56:44.191379	2023-12-27 00:56:44.191379
b43f310a-3a32-4ed0-b02a-6af2be49f375	The Portable Thoreau	\N	\N	\N	\N	f	bookshelf_cells/IMG_2684.jpeg	2023-12-27 00:56:44.192289	2023-12-27 00:56:44.192289
208c62a9-5ce6-45aa-a546-0361e5afaa45	Dom Juan	Molière	\N	\N	\N	f	bookshelf_cells/IMG_2685.jpeg	2023-12-27 00:56:44.193278	2023-12-27 00:56:44.193278
cddddc94-bd9d-4903-b16c-d5a4906fa344	The Comedies of William Shakespeare	\N	\N	\N	\N	f	bookshelf_cells/IMG_2686.jpeg	2023-12-27 00:56:44.194245	2023-12-27 00:56:44.194245
1bf523f5-f768-45eb-b5d7-6ad7e2d4e0ba	On Tour	Gregory Burke	\N	\N	\N	f	bookshelf_cells/IMG_2687.jpeg	2023-12-27 00:56:44.195529	2023-12-27 00:56:44.195529
4ad858e8-4d0f-4d5d-8ae9-45bf2380b3fd	Purity of Heart is to Will One Thing	Søren K	\N	\N	\N	f	bookshelf_cells/IMG_2689.jpeg	2023-12-27 00:56:44.197466	2023-12-27 00:56:44.197466
e2524cd1-e5ff-4665-9dba-fd59138acb0c	FEAR	\N	\N	\N	\N	f	bookshelf_cells/IMG_2714.jpeg	2023-12-27 00:56:53.688543	2023-12-27 00:56:53.688543
db34a31c-4e43-41d6-a436-2540946b89ad	DISCOVERY	\N	\N	\N	\N	f	bookshelf_cells/IMG_2715.jpeg	2023-12-27 00:56:53.692438	2023-12-27 00:56:53.692438
5828269e-6504-4fcf-a753-93f541df4f82	WATER	\N	\N	\N	\N	f	bookshelf_cells/IMG_2716.jpeg	2023-12-27 00:56:53.694778	2023-12-27 00:56:53.694778
b8bcf9b5-88a5-41d5-907c-0654cc846af4	MUSIC	\N	\N	\N	\N	f	bookshelf_cells/IMG_2717.jpeg	2023-12-27 00:56:53.697681	2023-12-27 00:56:53.697681
e335aa44-b4d4-4ea2-a491-c393c889d804	RULE OF LAW	\N	\N	\N	\N	f	bookshelf_cells/IMG_2718.jpeg	2023-12-27 00:56:53.700723	2023-12-27 00:56:53.700723
4d137c60-92d8-4753-b81a-d2a915ee941d	MAGIC SHOWS	\N	\N	\N	\N	f	bookshelf_cells/IMG_2719.jpeg	2023-12-27 00:56:53.703433	2023-12-27 00:56:53.703433
8d21360c-648a-412f-bfb5-070c5e33ec44	YOUTH	\N	\N	\N	\N	f	bookshelf_cells/IMG_2720.jpeg	2023-12-27 00:56:53.705917	2023-12-27 00:56:53.705917
cc399ebc-79e0-487e-93f6-e12069d7202c	ENCYCLOPEDIA OF WORLD HISTORY	\N	\N	\N	\N	f	bookshelf_cells/IMG_2722.jpeg	2023-12-27 00:56:53.707859	2023-12-27 00:56:53.707859
3171b3db-8c4b-4533-80d5-dfe06ca5eae8	The Lord of the Rings	J.R.R. Tolkien	\N	\N	\N	f	bookshelf_cells/IMG_2723.jpeg	2023-12-27 00:56:53.709208	2023-12-27 00:56:53.709208
f152ae21-f19b-4972-8f15-d3dfcf472339	Principles of Magnetic Resonance	C. P. Slichter	\N	\N	\N	f	bookshelf_cells/IMG_2149.jpeg	2023-12-27 00:58:18.987457	2023-12-27 00:58:18.987457
b52da453-c92a-458f-9e30-3b1056171091	Divine Assassin	Bob Reiss	\N	\N	\N	f	bookshelf_cells/IMG_2168.jpeg	2023-12-27 00:58:18.991254	2023-12-27 00:58:18.991254
e301858b-5fd1-4220-8026-59fa4a7bca4e	Gustav Klimt	Egon Schiele,null	\N	\N	\N	f	bookshelf_cells/IMG_2185.jpeg	2023-12-27 00:58:18.993941	2023-12-27 00:58:18.993941
9efd37b1-b699-4bef-90c7-bfd28d5837cc	Lifemanship	Stephen Potter	\N	\N	\N	f	bookshelf_cells/IMG_2186.jpeg	2023-12-27 00:58:18.99675	2023-12-27 00:58:18.99675
24efc025-9b43-43f3-bd12-0a5ef043a312	Fundamentals of Physics	David Halliday, Robert Resnick, Jearl Walker	\N	\N	\N	f	bookshelf_cells/IMG_2189.jpeg	2023-12-27 00:58:18.999189	2023-12-27 00:58:18.999189
0bfbf979-11c1-4481-889a-0e5deb917b90	American Splendor: The Life and Times of Harvey Pekar	Harvey Pekar	\N	\N	\N	f	bookshelf_cells/IMG_2239.jpeg	2023-12-27 00:58:19.001137	2023-12-27 00:58:19.001137
5716cf64-bb61-46b5-938b-dc535aee8221	Star Wars: The Roleplaying Game	\N	\N	\N	\N	f	bookshelf_cells/IMG_2262.jpeg	2023-12-27 00:58:19.003154	2023-12-27 00:58:19.003154
0b265b70-6f57-4d9f-aced-e5aff1231698	Lapham's Quarterly: Night	\N	\N	\N	\N	f	bookshelf_cells/IMG_2263.jpeg	2023-12-27 00:58:19.004927	2023-12-27 00:58:19.004927
052275fe-7c51-4e77-adc9-2eba6bfa775a	Cycles of Time: An Extraordinary New View of the Universe	Roger Penrose	\N	\N	\N	f	bookshelf_cells/IMG_2264.jpeg	2023-12-27 00:58:19.006552	2023-12-27 00:58:19.006552
b143d2ef-60ff-4151-80a3-ebaf683c9239	Elementary Differential Equations and Boundary Value Problems: Student Solutions Manual	Charles W. Haines	\N	\N	\N	f	bookshelf_cells/IMG_2267.jpeg	2023-12-27 00:58:19.009356	2023-12-27 00:58:19.009356
a3c5fe8b-a816-456c-a5a2-87a27d20e1d2	Applications of Synchrotron Radiation	Wolfgang Eberhardt	\N	\N	\N	f	bookshelf_cells/IMG_2268.jpeg	2023-12-27 00:58:19.011141	2023-12-27 00:58:19.011141
690db78d-84b1-4055-b444-a478117601e6	The Elegant Universe	Brian Greene	\N	\N	\N	f	bookshelf_cells/IMG_2269.jpeg	2023-12-27 00:58:19.012458	2023-12-27 00:58:19.012458
409c1601-a12e-4e5f-b172-1506d36c45f3	Critical: What We Can Do About the Health-Care Crisis	Tom Daschle, Scott S. Greenberger, Jeanne M. Lambrew	\N	\N	\N	f	bookshelf_cells/IMG_2270.jpeg	2023-12-27 00:58:19.013928	2023-12-27 00:58:19.013928
14bdb2c6-d29a-46e8-8f38-b72c8714021e	Thereby Hangs a Tale	Charles Earle Funk	\N	\N	\N	f	bookshelf_cells/IMG_2271.jpeg	2023-12-27 00:58:19.015181	2023-12-27 00:58:19.015181
448174f8-0253-4935-97f5-a78dee3cffd6	Starship Troopers	Robert A. Heinlein	\N	\N	\N	f	bookshelf_cells/IMG_2272.jpeg	2023-12-27 00:58:19.016403	2023-12-27 00:58:19.016403
4090c441-adf9-4807-b742-dbc595c7d7e3	Klingsor's Last Summer	Hermann Hesse	\N	\N	\N	f	bookshelf_cells/IMG_2273.jpeg	2023-12-27 00:58:19.017575	2023-12-27 00:58:19.017575
174f3103-349c-4619-802a-8644d08237c1	Welcome Back to Pleasant Hill	\N	\N	\N	\N	f	bookshelf_cells/IMG_2274.jpeg	2023-12-27 00:58:19.019012	2023-12-27 00:58:19.019012
0ae3f96e-0a94-4ac0-80e1-6995b39b3fc1	Olympos	Dan Simmons	\N	\N	\N	f	bookshelf_cells/IMG_2275.jpeg	2023-12-27 00:58:19.020404	2023-12-27 00:58:19.020404
d2817067-bfc5-4923-bcc0-72ca4fd9a7f9	Going Downtown: The War against Hanoi and Washington	Jack Broughton	\N	\N	\N	f	bookshelf_cells/IMG_2276.jpeg	2023-12-27 00:58:19.02168	2023-12-27 00:58:19.02168
048bdf4f-1215-497a-a07c-18b0a9609f92	Music Technology: A Survivor's Guide	Paul White	\N	\N	\N	f	bookshelf_cells/IMG_2277.jpeg	2023-12-27 00:58:19.022834	2023-12-27 00:58:19.022834
a9de8a2d-e32c-43b3-bf91-2a8e26da9745	Battle Cry of Freedom	James M. McPherson	\N	\N	\N	f	bookshelf_cells/IMG_2278.jpeg	2023-12-27 00:58:19.023953	2023-12-27 00:58:19.023953
5f7a407e-fe50-4a17-b042-61364518fc58	Speaker Project	J	\N	\N	\N	f	bookshelf_cells/IMG_2279.jpeg	2023-12-27 00:58:19.025125	2023-12-27 00:58:19.025125
2699e836-a211-411e-8889-8eeba428961c	Mechanics	Research & Education Association	\N	\N	\N	f	bookshelf_cells/IMG_2334.jpeg	2023-12-27 00:58:55.07871	2023-12-27 00:58:55.07871
c71e2a5e-a327-4878-9ea1-1a1c1578fdec	Victory Through Air Power	Alexander P. de Seversky	\N	\N	\N	f	bookshelf_cells/IMG_2335.jpeg	2023-12-27 00:58:55.0824	2023-12-27 00:58:55.0824
9467fa7e-74f0-48ff-9469-443393db6799	Geometry	\N	\N	\N	\N	f	bookshelf_cells/IMG_2336.jpeg	2023-12-27 00:58:55.085992	2023-12-27 00:58:55.085992
e36eb469-cc5f-49bb-a2de-788db2bb4a53	Table of Integrals	Series, and Products,I. S. Gradshteyn/I. M. Ryzhik	\N	\N	\N	f	bookshelf_cells/IMG_2337.jpeg	2023-12-27 00:58:55.089042	2023-12-27 00:58:55.089042
583830b2-997b-461f-a802-126cfc9597f1	Plasma Spectroscopy	E. Oks	\N	\N	\N	f	bookshelf_cells/IMG_2338.jpeg	2023-12-27 00:58:55.092146	2023-12-27 00:58:55.092146
bf1f1252-b84a-4428-bfe1-926b76b3035b	Desert Islands and Other Texts 1953-1974	Gilles Deleuze	\N	\N	\N	f	bookshelf_cells/IMG_2339.jpeg	2023-12-27 00:58:55.094662	2023-12-27 00:58:55.094662
723804aa-dabe-4937-9f8f-724ccb780e97	Evening in Paradise	More Lucia Berlin	\N	\N	\N	f	bookshelf_cells/IMG_2340.jpeg	2023-12-27 00:58:55.097004	2023-12-27 00:58:55.097004
c9490fd2-e813-4781-8d1c-344fb888f797	Little Women	Louisa May Alcott	\N	\N	\N	f	bookshelf_cells/IMG_2341.jpeg	2023-12-27 00:58:55.099521	2023-12-27 00:58:55.099521
558aedc6-f8b1-4b07-bfa2-5ded57d5b563	The Art of Seduction	Robert Greene	\N	\N	\N	f	bookshelf_cells/IMG_2342.jpeg	2023-12-27 00:58:55.101635	2023-12-27 00:58:55.101635
40d40781-4c8f-4a5a-ae17-966d81a60705	Role Models	John Waters	\N	\N	\N	f	bookshelf_cells/IMG_2343.jpeg	2023-12-27 00:58:55.103517	2023-12-27 00:58:55.103517
e795d3b8-b59f-43cb-9960-6769e04c0a8b	Staring At Sound	Jim DeRogatis	\N	\N	\N	f	bookshelf_cells/IMG_2344.jpeg	2023-12-27 00:58:55.105476	2023-12-27 00:58:55.105476
1fd4e4c5-cbff-4f47-b017-955b90a0ce8b	The Poetic Edda	Lee M. Hollander	\N	\N	\N	f	bookshelf_cells/IMG_2345.jpeg	2023-12-27 00:58:55.108219	2023-12-27 00:58:55.108219
c428323e-c5df-4bab-908e-8b0b892c54cf	How the Scots Invented the Modern World	Arthur Herman	\N	\N	\N	f	bookshelf_cells/IMG_2346.jpeg	2023-12-27 00:58:55.11006	2023-12-27 00:58:55.11006
2d360558-2550-4d7f-b828-31d3fcb074eb	The Russians	Hedrick Smith	\N	\N	\N	f	bookshelf_cells/IMG_2347.jpeg	2023-12-27 00:58:55.112396	2023-12-27 00:58:55.112396
cd195852-9c6e-4d80-84eb-f89f0026c0ed	The Battle of Alamein	John Bierman and Colin Smith	\N	\N	\N	f	bookshelf_cells/IMG_2348.jpeg	2023-12-27 00:58:55.114041	2023-12-27 00:58:55.114041
130546d7-418a-4ada-948c-4a740e1462f3	The Control Revolution	James R. Beniger	\N	\N	\N	f	bookshelf_cells/IMG_2349.jpeg	2023-12-27 00:58:55.115496	2023-12-27 00:58:55.115496
5f0b2174-394d-487d-bf5c-65f73fe68518	The Green Knight	Iris Murdoch	\N	\N	\N	f	bookshelf_cells/IMG_2350.jpeg	2023-12-27 00:58:55.116833	2023-12-27 00:58:55.116833
b0a28d56-6900-4291-b8a1-f6c3d85485d8	Mating in Captivity	Esther Perel	\N	\N	\N	f	bookshelf_cells/IMG_2351.jpeg	2023-12-27 00:58:55.118368	2023-12-27 00:58:55.118368
ebe8ef7c-b153-4e8f-a196-10fb7a8263be	McMindfulness	Ronald Purser	\N	\N	\N	f	bookshelf_cells/IMG_2352.jpeg	2023-12-27 00:58:55.119734	2023-12-27 00:58:55.119734
b6f65b05-a349-44bc-8fad-f3a032d29259	The Man Who Mistook His Wife for a Hat	Oliver Sacks	\N	\N	\N	f	bookshelf_cells/IMG_2353.jpeg	2023-12-27 00:58:55.121498	2023-12-27 00:58:55.121498
19279a7a-a526-453c-8ede-621b8acaddc6	The Lady in Gold	Anne-Marie O'Connor	\N	\N	\N	f	bookshelf_cells/IMG_2354.jpeg	2023-12-27 00:58:55.123051	2023-12-27 00:58:55.123051
e9b6c14c-99cf-4c57-8a6e-1ce0fca0d106	Carsick	John Waters	\N	\N	\N	f	bookshelf_cells/IMG_2355.jpeg	2023-12-27 00:58:55.124517	2023-12-27 00:58:55.124517
8ec4e264-8618-4a3d-9cc8-f54c3665efea	Crime and Punishment	Fyodor Dostoevsky	\N	\N	\N	f	bookshelf_cells/IMG_2356.jpeg	2023-12-27 00:58:55.126117	2023-12-27 00:58:55.126117
e8491cd9-8586-4b53-b682-dc391d3bf300	Stealing Rembrandts	Anthony M. Amore and Tom Mashberg	\N	\N	\N	f	bookshelf_cells/IMG_2357.jpeg	2023-12-27 00:58:55.127666	2023-12-27 00:58:55.127666
c5d07553-53e4-4c6d-944f-f7b6480bcccb	The Outlaw Bible of American Literature	\N	\N	\N	\N	f	bookshelf_cells/IMG_2358.jpeg	2023-12-27 00:58:55.129118	2023-12-27 00:58:55.129118
0bb8385b-b3b9-43ba-a146-5defbb616257	Flowers	\N	\N	\N	\N	f	bookshelf_cells/IMG_2391.jpeg	2023-12-27 00:58:55.130683	2023-12-27 00:58:55.130683
65b6ded6-427a-4665-9a13-793d2113f6ae	Fresh Water Fish	\N	\N	\N	\N	f	bookshelf_cells/IMG_2392.jpeg	2023-12-27 00:58:55.132433	2023-12-27 00:58:55.132433
01e63411-8619-463d-a96a-6f952e6aaab2	Reptiles and Amphibians	\N	\N	\N	\N	f	bookshelf_cells/IMG_2393.jpeg	2023-12-27 00:58:55.134041	2023-12-27 00:58:55.134041
d1663a7d-091c-49c6-ae15-ee001fafe50f	Insects	\N	\N	\N	\N	f	bookshelf_cells/IMG_2395.jpeg	2023-12-27 00:58:55.13555	2023-12-27 00:58:55.13555
53b8897a-e41d-4d0a-b600-d3ff9392389c	The Criminal	\N	\N	\N	\N	f	bookshelf_cells/IMG_2473.jpeg	2023-12-27 00:59:41.679391	2023-12-27 00:59:41.679391
d9e11354-7c45-4e92-b151-2696d1795de0	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2474.jpeg	2023-12-27 00:59:41.682674	2023-12-27 00:59:41.682674
6c4bd6e9-2cde-4d43-81cd-7f3ea1ae641c	Capable Of Honor	Allen Drury	\N	\N	\N	f	bookshelf_cells/IMG_2475.jpeg	2023-12-27 00:59:41.685447	2023-12-27 00:59:41.685447
715618fd-14bc-404c-91c4-48afb4564071	Until Yesterday	Jared Diamond	\N	\N	\N	f	bookshelf_cells/IMG_2476.jpeg	2023-12-27 00:59:41.6877	2023-12-27 00:59:41.6877
96ccaa2a-aac1-4982-87c3-62e6dde4eb35	The Art of Action	Stephen Bungay	\N	\N	\N	f	bookshelf_cells/IMG_2477.jpeg	2023-12-27 00:59:41.689762	2023-12-27 00:59:41.689762
50fb0b9b-f248-4109-a828-80d531861fad	2600 The Hacker Quarterly	\N	\N	\N	\N	f	bookshelf_cells/IMG_2478.jpeg	2023-12-27 00:59:41.691551	2023-12-27 00:59:41.691551
3b396c0c-a659-43b8-9315-cd9ca2a651a4	The Inner Reaches Of Outer Space	Joseph Campbell	\N	\N	\N	f	bookshelf_cells/IMG_2479.jpeg	2023-12-27 00:59:41.693247	2023-12-27 00:59:41.693247
b8491b06-bbe1-48b4-80e3-e06eac5116c0	My Mother Madame Edwarda The Dead Man	Georges Bataille	\N	\N	\N	f	bookshelf_cells/IMG_2480.jpeg	2023-12-27 00:59:41.695226	2023-12-27 00:59:41.695226
561a018d-4508-4b8c-8542-df17dd6b7858	Dear Mr. President	Gabe Hudson	\N	\N	\N	f	bookshelf_cells/IMG_2481.jpeg	2023-12-27 00:59:41.697368	2023-12-27 00:59:41.697368
105726c6-656b-4b56-8ee7-2531ffaca26b	Lincoln A Photobiography	Russell Freedman	\N	\N	\N	f	bookshelf_cells/IMG_2482.jpeg	2023-12-27 00:59:41.69967	2023-12-27 00:59:41.69967
09ba1e4a-6427-4ca4-b474-295c341869fb	The Best War Ever	Michael C.C. Adams	\N	\N	\N	f	bookshelf_cells/IMG_2483.jpeg	2023-12-27 00:59:41.701915	2023-12-27 00:59:41.701915
52654680-d8a5-49e3-86f3-b79c72e8604b	The Lost City of Z	David Grann	\N	\N	\N	f	bookshelf_cells/IMG_2484.jpeg	2023-12-27 00:59:41.704241	2023-12-27 00:59:41.704241
5b75e7b3-bc04-4b12-8594-e36cdaad94a3	The Coast of Chicago	Stuart Dybek	\N	\N	\N	f	bookshelf_cells/IMG_2486.jpeg	2023-12-27 00:59:41.707763	2023-12-27 00:59:41.707763
c05918af-940e-4534-9b75-f5cdd736292f	How Adam Smith Can Change Your Life	Russ Roberts	\N	\N	\N	f	bookshelf_cells/IMG_2487.jpeg	2023-12-27 00:59:41.710175	2023-12-27 00:59:41.710175
514022ef-b497-4368-abee-c80541b1bfcb	Chicago	David Mamet	\N	\N	\N	f	bookshelf_cells/IMG_2488.jpeg	2023-12-27 00:59:41.713228	2023-12-27 00:59:41.713228
48dd9719-cc7c-4906-86bc-5242837babab	Laboratory Life	Bruno Latour	\N	\N	\N	f	bookshelf_cells/IMG_2509.jpeg	2023-12-27 00:59:41.715365	2023-12-27 00:59:41.715365
d90145a1-bceb-46f0-9d4a-b2d6977760a2	Fear and Loathing	\N	\N	\N	\N	f	bookshelf_cells/IMG_2515.jpeg	2023-12-27 00:59:41.717738	2023-12-27 00:59:41.717738
033e7a65-855c-47fb-9d3a-7c0ee9299780	On the Good Ship Lollipop	\N	\N	\N	\N	f	bookshelf_cells/IMG_2517.jpeg	2023-12-27 00:59:41.720775	2023-12-27 00:59:41.720775
733c045b-f66e-42f8-8fc3-5fae7cf15dfd	The Karl Lagerfeld Diet	Dr. Jean-Claude Houdret	\N	\N	\N	f	bookshelf_cells/IMG_2518.jpeg	2023-12-27 00:59:41.723226	2023-12-27 00:59:41.723226
52c7c2b4-4564-46a8-a98c-fd8e217bcd79	The White Boy Shuffle	Paul Beatty	\N	\N	\N	f	bookshelf_cells/IMG_2519.jpeg	2023-12-27 00:59:41.726989	2023-12-27 00:59:41.726989
529709fe-1106-4e1f-8848-6592b24baba9	Clout Mayor Daley and His City	\N	\N	\N	\N	f	bookshelf_cells/IMG_2520.jpeg	2023-12-27 00:59:41.730062	2023-12-27 00:59:41.730062
e11c0bf2-c3bd-4d64-888f-c49f30f062a7	Clojure for Finance	Timothy Washington	\N	\N	\N	f	bookshelf_cells/IMG_2521.jpeg	2023-12-27 00:59:41.733111	2023-12-27 00:59:41.733111
511389f7-2775-4d63-8a0e-fb1bb37db625	Vivian Maier	Pamela Bannos	\N	\N	\N	f	bookshelf_cells/IMG_2522.jpeg	2023-12-27 00:59:41.735816	2023-12-27 00:59:41.735816
ce04aaac-f9ff-4f78-a70f-75fbf5caf2b5	In the Studio with Michael Jackson	Bruce Swedien	\N	\N	\N	f	bookshelf_cells/IMG_2523.jpeg	2023-12-27 00:59:41.738854	2023-12-27 00:59:41.738854
868e495c-396f-40fc-8b3a-12486d2ea744	The Large	The Small and the Human Mind,Roger Penrose	\N	\N	\N	f	bookshelf_cells/IMG_2524.jpeg	2023-12-27 00:59:41.74215	2023-12-27 00:59:41.74215
2ec84815-7acd-4196-91b0-9a8829871772	But What If We’re Wrong?	Chuck Klosterman	\N	\N	\N	f	bookshelf_cells/IMG_2525.jpeg	2023-12-27 00:59:41.747791	2023-12-27 00:59:41.747791
533036c4-0125-4400-a7e5-193b10d5f793	Time's Arrows	Richard Morris	\N	\N	\N	f	bookshelf_cells/IMG_2526.jpeg	2023-12-27 00:59:41.750989	2023-12-27 00:59:41.750989
4da9ce05-f717-4bcc-ae24-5d9c96ab217b	Only The Dead	Bear F. Braumoeller	\N	\N	\N	f	bookshelf_cells/IMG_2527.jpeg	2023-12-27 00:59:41.754162	2023-12-27 00:59:41.754162
a1d3d5b5-1c34-49df-a943-ed3a584f5ce9	Switch	Chip Heath & Dan Heath	\N	\N	\N	f	bookshelf_cells/IMG_2528.jpeg	2023-12-27 00:59:41.756798	2023-12-27 00:59:41.756798
1e186ca3-2284-45fb-8066-e670205f0c37	Spiritual Diary	Serg	\N	\N	\N	f	bookshelf_cells/IMG_2529.jpeg	2023-12-27 00:59:41.759161	2023-12-27 00:59:41.759161
a99702f1-3aa3-4932-8ecf-284f339aecb2	Purity of Heart	\N	\N	\N	\N	f	bookshelf_cells/IMG_2690.jpeg	2023-12-27 01:00:29.19494	2023-12-27 01:00:29.19494
530db3d8-782a-4d35-9d2d-344fbe3d6927	Nine Plays	Eugene O'Neill	\N	\N	\N	f	bookshelf_cells/IMG_2691.jpeg	2023-12-27 01:00:29.196911	2023-12-27 01:00:29.196911
14f7eb90-8a8b-4827-84fc-2ce02292c483	Physics	Paul A. Tipler	\N	\N	\N	f	bookshelf_cells/IMG_2692.jpeg	2023-12-27 01:00:29.198695	2023-12-27 01:00:29.198695
116751e9-447b-4354-b100-0bf12a571cdb	Armageddon	Max Hastings	\N	\N	\N	f	bookshelf_cells/IMG_2693.jpeg	2023-12-27 01:00:29.201551	2023-12-27 01:00:29.201551
0711533a-76e5-4661-b8d5-0de29e32a995	Problem Solvers Differential Equations	\N	\N	\N	\N	f	bookshelf_cells/IMG_2694.jpeg	2023-12-27 01:00:29.204289	2023-12-27 01:00:29.204289
b5828305-9b61-469c-b4ab-d0d67063aa53	Nuclear War Survival Skills	Cresson H. Kearny	\N	\N	\N	f	bookshelf_cells/IMG_2695.jpeg	2023-12-27 01:00:29.207073	2023-12-27 01:00:29.207073
40d77f3d-30b9-487b-81e2-28c84dc778e9	The Complete Encyclopedia of Pistols and Revolvers	A. E. Hartink	\N	\N	\N	f	bookshelf_cells/IMG_2696.jpeg	2023-12-27 01:00:29.209255	2023-12-27 01:00:29.209255
5513d135-fc56-4b0d-a736-5100f3dfd446	Color Treasury of Crystals	\N	\N	\N	\N	f	bookshelf_cells/IMG_2697.jpeg	2023-12-27 01:00:29.210772	2023-12-27 01:00:29.210772
d07b73d2-d948-4e90-8845-bfff63ed8eda	Forbidden Photographs	Charles Gatewood	\N	\N	\N	f	bookshelf_cells/IMG_2698.jpeg	2023-12-27 01:00:29.21249	2023-12-27 01:00:29.21249
2bdd3b34-bd3a-4c21-8fd4-de5a8537f4e8	Tradicion IV	Joe Ellis	\N	\N	\N	f	bookshelf_cells/IMG_2699.jpeg	2023-12-27 01:00:29.214021	2023-12-27 01:00:29.214021
bf5d2bbd-bdab-42c7-abf7-63601e40f3f4	Photoelectron Spectroscopy	Stefan Hüfner	\N	\N	\N	f	bookshelf_cells/IMG_2703.jpeg	2023-12-27 01:00:29.215752	2023-12-27 01:00:29.215752
57eb064e-2248-4757-87af-017783286336	History of the World War	Frank H. Simonds	\N	\N	\N	f	bookshelf_cells/IMG_2704.jpeg	2023-12-27 01:00:29.217415	2023-12-27 01:00:29.217415
3b220c0e-a006-4fed-9a3f-8bbcafce8c58	Crucial Conversations	\N	\N	\N	\N	f	bookshelf_cells/IMG_2707.jpeg	2023-12-27 01:00:29.21897	2023-12-27 01:00:29.21897
ac1112df-35c3-4004-8244-751043510e9f	The Elements of Music	Jason Martineau	\N	\N	\N	f	bookshelf_cells/IMG_2709.jpeg	2023-12-27 01:00:29.220404	2023-12-27 01:00:29.220404
5291c185-b20b-4ccf-8aaf-7d37b8c3983b	Science-Fiction Studies	\N	\N	\N	\N	f	bookshelf_cells/IMG_2710.jpeg	2023-12-27 01:00:29.221759	2023-12-27 01:00:29.221759
4f09b764-c045-4f81-9c60-e6de87bc5a1a	Lapham's Quarterly	\N	\N	\N	\N	f	bookshelf_cells/IMG_2711.jpeg	2023-12-27 01:00:29.223374	2023-12-27 01:00:29.223374
c96b0483-ea85-496f-a208-bd00c718a24d	NIGHT	\N	\N	\N	\N	f	bookshelf_cells/IMG_2266.jpeg	2023-12-27 01:02:23.516602	2023-12-27 01:02:23.516602
4e28de0c-7cb9-41bd-988d-a41f6954a3f0	Fundamental Problems in Quantum Theory	\N	\N	\N	\N	f	bookshelf_cells/IMG_2282.jpeg	2023-12-27 01:02:23.530206	2023-12-27 01:02:23.530206
3dba47c6-84b0-463b-98e2-d7d04eefdab3	Einstein	Walter Isaacson	\N	\N	\N	f	bookshelf_cells/IMG_2283.jpeg	2023-12-27 01:02:23.534482	2023-12-27 01:02:23.534482
ca8cd6bc-9b52-45e6-9f73-ab4d3fcb7f9d	The Wealth of Nations	Adam Smith	\N	\N	\N	f	bookshelf_cells/IMG_2284.jpeg	2023-12-27 01:02:23.537147	2023-12-27 01:02:23.537147
9f2d5777-9a97-4bb5-87ea-37f0aedcd241	The Idiot	Fyodor Dostoyevsky	\N	\N	\N	f	bookshelf_cells/IMG_2285.jpeg	2023-12-27 01:02:23.539352	2023-12-27 01:02:23.539352
1427ae5a-a9df-4180-bbf9-a000c484656a	Green Mars	Kim Stanley Robinson	\N	\N	\N	f	bookshelf_cells/IMG_2286.jpeg	2023-12-27 01:02:23.541262	2023-12-27 01:02:23.541262
110aed24-bdc9-4212-8b07-2d22f3e83662	1493	Charles C. Mann	\N	\N	\N	f	bookshelf_cells/IMG_2287.jpeg	2023-12-27 01:02:23.543245	2023-12-27 01:02:23.543245
e4f531fb-d622-4874-be26-62fc1f4155e3	Sociopolis	\N	\N	\N	\N	f	bookshelf_cells/IMG_2288.jpeg	2023-12-27 01:02:23.545289	2023-12-27 01:02:23.545289
6b9227b9-556c-41eb-9343-99ada696d059	The Wide Window	Lemony Snicket	\N	\N	\N	f	bookshelf_cells/IMG_2289.jpeg	2023-12-27 01:02:23.547142	2023-12-27 01:02:23.547142
6fa3f18b-f994-4266-826e-7f0b4ed5b96a	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2290.jpeg	2023-12-27 01:02:23.548529	2023-12-27 01:02:23.548529
e7b8a0c7-7d19-4243-b145-d2eb214f3c4c	la carreta made a U-turn	Tato Laviera	\N	\N	\N	f	bookshelf_cells/IMG_2291.jpeg	2023-12-27 01:02:23.550531	2023-12-27 01:02:23.550531
09437931-d026-4c74-aba6-fac91e7b5c9d	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2396.jpeg	2023-12-27 01:06:17.585851	2023-12-27 01:06:17.585851
d08d53f8-4184-4690-a8d8-fff06c97bd68	Reconstructing Reality in the Courtroom	W. Lance Bennett & Martha S. Feldman	\N	\N	\N	f	bookshelf_cells/IMG_2292.jpeg	2023-12-27 01:02:23.552184	2023-12-27 01:02:23.552184
220f9bb5-5776-48a7-bcad-cc0f228e95c0	Programming Kotlin	Stephen Samuel, Stefan Bocutiu	\N	\N	\N	f	bookshelf_cells/IMG_2293.jpeg	2023-12-27 01:02:23.553686	2023-12-27 01:02:23.553686
66d95868-6211-48ee-8618-0ae7ab5f209a	A History of Narrative Film	David A. Cook	\N	\N	\N	f	bookshelf_cells/IMG_2294.jpeg	2023-12-27 01:02:23.554953	2023-12-27 01:02:23.554953
3f09cee2-0198-41e6-988d-014b005fec97	CAITLIN	Caitlin Thomas with George Tremlett	\N	\N	\N	f	bookshelf_cells/IMG_2295.jpeg	2023-12-27 01:02:23.556156	2023-12-27 01:02:23.556156
d4803bbf-0f4f-4ca8-aa2f-616eab39d491	Scanning Tunneling Microscopy and its Application	Chunli Bai	\N	\N	\N	f	bookshelf_cells/IMG_2296.jpeg	2023-12-27 01:02:23.557341	2023-12-27 01:02:23.557341
8cd10dbd-9896-43f0-9289-a2f9facd8de3	The Bomb	Gerard J. DeGroot	\N	\N	\N	f	bookshelf_cells/IMG_2297.jpeg	2023-12-27 01:02:23.558499	2023-12-27 01:02:23.558499
7b58c972-cbdb-4691-90c3-a785ff0f8952	VINCENT PRICE	Victoria Price	\N	\N	\N	f	bookshelf_cells/IMG_2298.jpeg	2023-12-27 01:02:23.559603	2023-12-27 01:02:23.559603
12d825c1-6fbe-4aa2-b278-a52052b56a7c	To the Distant Observer	Noël Burch	\N	\N	\N	f	bookshelf_cells/IMG_2299.jpeg	2023-12-27 01:02:23.560784	2023-12-27 01:02:23.560784
c53973b2-c6c9-4646-a8bf-85828c32de10	Programming Ruby	Dave Thomas with Chad Fowler and Andy Hunt	\N	\N	\N	f	bookshelf_cells/IMG_2300.jpeg	2023-12-27 01:02:23.561954	2023-12-27 01:02:23.561954
82ce614d-df64-4992-8846-25938b978fb4	Multitude	Chitra B. Divakaruni	\N	\N	\N	f	bookshelf_cells/IMG_2301.jpeg	2023-12-27 01:02:23.563076	2023-12-27 01:02:23.563076
7f746696-2ddf-4988-8347-951b1e045ef0	Israel's Attack on Osiraq: A Model for Future Preventive Strikes?	Peter S. Ford	\N	\N	\N	f	bookshelf_cells/IMG_2302.jpeg	2023-12-27 01:02:23.56423	2023-12-27 01:02:23.56423
ab49295e-6fbb-4436-9c82-86588410f510	International Security Negotiations: Lessons Learned from Negotiating with the Russians on Nuclear Arms	Michael O. Wheeler	\N	\N	\N	f	bookshelf_cells/IMG_2303.jpeg	2023-12-27 01:02:23.565381	2023-12-27 01:02:23.565381
3c300ec4-d83e-46c4-b281-4d6eb92dbe3c	Cruel Shoes	Steve Martin	\N	\N	\N	f	bookshelf_cells/IMG_2304.jpeg	2023-12-27 01:02:23.566485	2023-12-27 01:02:23.566485
3a5cd946-ad30-40a0-8ccd-2d01180923d7	Where the Red Fern Grows	Wilson Rawls	\N	\N	\N	f	bookshelf_cells/IMG_2305.jpeg	2023-12-27 01:02:23.567609	2023-12-27 01:02:23.567609
8a0ad154-1ed6-458c-98b5-4d2df42ffff7	Astrophysics for People in a Hurry	Neil de	\N	\N	\N	f	bookshelf_cells/IMG_2306.jpeg	2023-12-27 01:02:23.568699	2023-12-27 01:02:23.568699
dcc653b0-a45a-46f1-8112-358208890595	Engineering Management for the Rest of Us	Sarah Drasner	\N	\N	\N	f	bookshelf_cells/IMG_2530.jpeg	2023-12-27 01:02:57.779923	2023-12-27 01:02:57.779923
ba41f100-0851-4ec9-80be-707dd86be4c0	Symbol	\N	\N	\N	\N	f	bookshelf_cells/IMG_2531.jpeg	2023-12-27 01:02:57.782336	2023-12-27 01:02:57.782336
f4e52623-8f88-4308-9674-25504b0513d9	The Dawn of Everything	David Graeber and David Wengrow	\N	\N	\N	f	bookshelf_cells/IMG_2532.jpeg	2023-12-27 01:02:57.784294	2023-12-27 01:02:57.784294
02c2215b-b3d3-4d30-825c-bfbf00ddb54e	Chicago's Pilsen Neighborhood	Peter N. Pero	\N	\N	\N	f	bookshelf_cells/IMG_2533.jpeg	2023-12-27 01:02:57.786312	2023-12-27 01:02:57.786312
94538ba3-d99c-4344-80c2-ff16bffddac7	An Astronaut's Guide to Life on Earth	Col. Chris Hadfield	\N	\N	\N	f	bookshelf_cells/IMG_2534.jpeg	2023-12-27 01:02:57.788315	2023-12-27 01:02:57.788315
a3a8e917-e5ef-4e4f-b032-e83ed33db36f	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2535.jpeg	2023-12-27 01:02:57.790019	2023-12-27 01:02:57.790019
e7460692-cfed-410a-89a2-9140e128efaa	Q is for Quantum	John Gribbin	\N	\N	\N	f	bookshelf_cells/IMG_2536.jpeg	2023-12-27 01:02:57.792089	2023-12-27 01:02:57.792089
30180d48-3d4f-4601-869a-df85565e3e2b	Speakable and unspeakable in quantum mechanics	J. S. Bell	\N	\N	\N	f	bookshelf_cells/IMG_2537.jpeg	2023-12-27 01:02:57.794288	2023-12-27 01:02:57.794288
960f503f-e485-47b5-8cb5-e3874cdaf7a8	Inside the Third Reich	Albert Speer	\N	\N	\N	f	bookshelf_cells/IMG_2538.jpeg	2023-12-27 01:02:57.796371	2023-12-27 01:02:57.796371
5bc1ccd9-71c6-468f-8762-13351f089cd1	CHUCK KLOSTERMAN IV	Chuck Klosterman	\N	\N	\N	f	bookshelf_cells/IMG_2539.jpeg	2023-12-27 01:02:57.799072	2023-12-27 01:02:57.799072
3b27fe9e-81e0-44b2-a8e5-a7d10338f46f	A Short Guide to Writing about History	Richard Marius	\N	\N	\N	f	bookshelf_cells/IMG_2540.jpeg	2023-12-27 01:02:57.801347	2023-12-27 01:02:57.801347
714e8264-6631-47ab-809f-b8d4acb0dd59	Originals: American Women Artists	Eleanor Munro	\N	\N	\N	f	bookshelf_cells/IMG_2541.jpeg	2023-12-27 01:02:57.803951	2023-12-27 01:02:57.803951
c88bc1b3-ca44-433e-ba10-665acb6a3225	The Shortest History of Germany	James Hawes	\N	\N	\N	f	bookshelf_cells/IMG_2542.jpeg	2023-12-27 01:02:57.80718	2023-12-27 01:02:57.80718
42fad22b-0fc6-4639-b885-a9d8ef1ac315	The Soul of A New Machine	Tracy Kidder	\N	\N	\N	f	bookshelf_cells/IMG_2543.jpeg	2023-12-27 01:02:57.811127	2023-12-27 01:02:57.811127
880878d0-59e2-4f9d-a835-6da131b0a16f	The Great Leveler	Walter Scheidel	\N	\N	\N	f	bookshelf_cells/IMG_2544.jpeg	2023-12-27 01:02:57.813682	2023-12-27 01:02:57.813682
8a1eb2cd-d33b-4b7c-a618-793fe3e9148f	Explaining Hitler	Ron Rosenbaum	\N	\N	\N	f	bookshelf_cells/IMG_2545.jpeg	2023-12-27 01:02:57.81553	2023-12-27 01:02:57.81553
20946a33-4aa5-4569-88f8-415d38033be8	Sapiens	Yuval Noah Harari	\N	\N	\N	f	bookshelf_cells/IMG_2546.jpeg	2023-12-27 01:02:57.817734	2023-12-27 01:02:57.817734
56330e43-e02a-4dc5-aece-01d5257339ec	Nothing Like It In the World	Stephen E. Ambrose	\N	\N	\N	f	bookshelf_cells/IMG_2547.jpeg	2023-12-27 01:02:57.81963	2023-12-27 01:02:57.81963
f525f305-697d-44a6-a8ea-d66959763c97	Physics Fun	and Beyond,Eduardo de Campos Valadares	\N	\N	\N	f	bookshelf_cells/IMG_2548.jpeg	2023-12-27 01:02:57.821752	2023-12-27 01:02:57.821752
23233331-86ee-4922-afac-066f4996e2db	Welcome to the Monkey House	Kurt Vonnegut	\N	\N	\N	f	bookshelf_cells/IMG_2549.jpeg	2023-12-27 01:02:57.823654	2023-12-27 01:02:57.823654
a2cb0045-8439-4c9c-884d-c6fdd949e097	Total Harmonic Distortion	Charles Rodrigues	\N	\N	\N	f	bookshelf_cells/IMG_2550.jpeg	2023-12-27 01:02:57.825596	2023-12-27 01:02:57.825596
95a30d7e-0146-4f28-bc86-9615e87a77b5	Helgoland	Carlo Rovelli	\N	\N	\N	f	bookshelf_cells/IMG_2551.jpeg	2023-12-27 01:02:57.827676	2023-12-27 01:02:57.827676
31d1078c-5366-475b-9d51-aee40c3325c7	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2552.jpeg	2023-12-27 01:02:57.829413	2023-12-27 01:02:57.829413
206d866a-775c-4826-9880-e6f3189f0346	Diana Cooper	Philip Ziegler	\N	\N	\N	f	bookshelf_cells/IMG_2553.jpeg	2023-12-27 01:02:57.83132	2023-12-27 01:02:57.83132
046bdd2e-2971-4480-b00e-8f53eba7a40a	The End of Policing	Alex S. Vitale	\N	\N	\N	f	bookshelf_cells/IMG_2554.jpeg	2023-12-27 01:02:57.834281	2023-12-27 01:02:57.834281
af5af0b0-65d5-4f49-8d29-e1a7c0be0f0a	Preventable	Andy Slavitt	\N	\N	\N	f	bookshelf_cells/IMG_2555.jpeg	2023-12-27 01:02:57.837347	2023-12-27 01:02:57.837347
12d5bfce-37ed-4c14-a4ec-6270f2fefd06	His Excellency	Joseph J. Ellis	\N	\N	\N	f	bookshelf_cells/IMG_2588.jpeg	2023-12-27 01:02:57.840848	2023-12-27 01:02:57.840848
84159d47-64d5-478a-8afe-8b2a901ef385	Gulag	Anne Applebaum	\N	\N	\N	f	bookshelf_cells/IMG_2589.jpeg	2023-12-27 01:02:57.843184	2023-12-27 01:02:57.843184
042e4eb2-ef7c-4970-be7e-b9a84a3eb035	100 Questions Every First	\N	\N	\N	\N	f	bookshelf_cells/IMG_2590.jpeg	2023-12-27 01:02:57.846217	2023-12-27 01:02:57.846217
e5b18912-03e0-4dd5-8357-e3f6f63cf10b	QUANTUM PHYSICS	Robert Eisberg; Robert Resnick	\N	\N	\N	f	bookshelf_cells/IMG_2638.jpeg	2023-12-27 01:03:19.316137	2023-12-27 01:03:19.316137
b63b972b-6551-4cee-b6b6-0dd191dda57a	Merrill Informal Geometry	\N	\N	\N	\N	f	bookshelf_cells/IMG_2639.jpeg	2023-12-27 01:03:19.318794	2023-12-27 01:03:19.318794
c06b8688-f8ee-466c-acb5-fe8fae79d2df	WAR	Sebastian Junger	\N	\N	\N	f	bookshelf_cells/IMG_2640.jpeg	2023-12-27 01:03:19.320559	2023-12-27 01:03:19.320559
9bee824b-a0ba-40c6-a389-62665b6b4616	Writers INC	\N	\N	\N	\N	f	bookshelf_cells/IMG_2641.jpeg	2023-12-27 01:03:19.322159	2023-12-27 01:03:19.322159
60b4e901-a887-4844-a895-dbf07f59e800	Picasso's Picassos	David Douglas Duncan	\N	\N	\N	f	bookshelf_cells/IMG_2642.jpeg	2023-12-27 01:03:19.323605	2023-12-27 01:03:19.323605
aa15c58e-8187-47f8-8d86-863cd36346dd	ANCIENT GREECE	Pomeroy; Burstein; Donlan; Roberts	\N	\N	\N	f	bookshelf_cells/IMG_2643.jpeg	2023-12-27 01:03:19.325147	2023-12-27 01:03:19.325147
cf50b572-9a80-4e92-9619-a75a91aeea90	TESTIMONY OF TWO MEN	Taylor Caldwell	\N	\N	\N	f	bookshelf_cells/IMG_2644.jpeg	2023-12-27 01:03:19.326798	2023-12-27 01:03:19.326798
6d816f83-d904-4fe4-b140-98b8176a8caf	2010: ODYSSEY TWO	Arthur C. Clarke	\N	\N	\N	f	bookshelf_cells/IMG_2645.jpeg	2023-12-27 01:03:19.328312	2023-12-27 01:03:19.328312
13233968-05d7-47d4-a741-ed007dc31a79	PRINCIPLES OF NEURAL SCIENCE	Eric R. Kandel; James H. Schwartz; Thomas M. Jessell	\N	\N	\N	f	bookshelf_cells/IMG_2646.jpeg	2023-12-27 01:03:19.329907	2023-12-27 01:03:19.329907
3af22537-151d-4c06-a454-5c61949e1f4f	JavaScript: The Definitive Guide	David Flanagan	\N	\N	\N	f	bookshelf_cells/IMG_2647.jpeg	2023-12-27 01:03:19.331426	2023-12-27 01:03:19.331426
ade0b59a-cc39-4c2f-bb97-f1274ffe9db9	ELECTRICITY and MAGNETISM	Ralph P. Winch	\N	\N	\N	f	bookshelf_cells/IMG_2648.jpeg	2023-12-27 01:03:19.332952	2023-12-27 01:03:19.332952
a4a82a09-dcc4-489f-aee3-88e38bafe804	Calculus	\N	\N	\N	\N	f	bookshelf_cells/IMG_2650.jpeg	2023-12-27 01:03:19.335425	2023-12-27 01:03:19.335425
021c041e-93b2-4b2d-a5e0-1759c1de611e	The Complete Guide to High-End Audio	Robert Harley	\N	\N	\N	f	bookshelf_cells/IMG_2651.jpeg	2023-12-27 01:03:19.337168	2023-12-27 01:03:19.337168
0f0560e6-40b0-4d3b-87d0-af731d781d87	Handbook of Modern Sensors	Jacob Fraden	\N	\N	\N	f	bookshelf_cells/IMG_2652.jpeg	2023-12-27 01:03:19.338829	2023-12-27 01:03:19.338829
980fd1af-3859-4777-9ce7-e4684513c8d0	Webster's New World Dictionary	\N	\N	\N	\N	f	bookshelf_cells/IMG_2653.jpeg	2023-12-27 01:03:19.34055	2023-12-27 01:03:19.34055
bb401b5d-9e3e-4443-8c0a-cc69fdd9eced	REA's Problem Solvers	\N	\N	\N	\N	f	bookshelf_cells/IMG_2654.jpeg	2023-12-27 01:03:19.342102	2023-12-27 01:03:19.342102
9973870a-6ac9-469d-956c-3fe1ca7666aa	Ghosts from the Nursery	Robin Karr-Morse and Meredith S.Wiley	\N	\N	\N	f	bookshelf_cells/IMG_2655.jpeg	2023-12-27 01:03:19.344176	2023-12-27 01:03:19.344176
8289d36e-e103-4c13-8f35-f52fbbd61272	The RAINBOW and The WORM	Mae-Wan Ho	\N	\N	\N	f	bookshelf_cells/IMG_2656.jpeg	2023-12-27 01:03:19.346195	2023-12-27 01:03:19.346195
ff782491-76c8-4501-a655-5ac184091f11	Soft Sculpture and Other Soft Art Forms	Dona Z. Meilach	\N	\N	\N	f	bookshelf_cells/IMG_2428.jpeg	2023-12-27 01:06:17.591531	2023-12-27 01:06:17.591531
e01ed4bb-8309-434c-8ff4-6a00a7c49c9e	Fresh	Dave Naz	\N	\N	\N	f	bookshelf_cells/IMG_2429.jpeg	2023-12-27 01:06:17.593878	2023-12-27 01:06:17.593878
6377c65c-304c-4fef-97b7-77c4b1c05181	Dancing Queen	Lisa Carver	\N	\N	\N	f	bookshelf_cells/IMG_2430.jpeg	2023-12-27 01:06:17.59527	2023-12-27 01:06:17.59527
2339da06-d695-407b-a9d2-90aefd28b491	Early Work	Patti Smith	\N	\N	\N	f	bookshelf_cells/IMG_2431.jpeg	2023-12-27 01:06:17.5966	2023-12-27 01:06:17.5966
8e37f580-3467-4d81-944b-85d52c060963	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2432.jpeg	2023-12-27 01:06:17.597929	2023-12-27 01:06:17.597929
ec986d6b-817c-4671-b0c5-6aad2c724bce	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2433.jpeg	2023-12-27 01:06:17.599204	2023-12-27 01:06:17.599204
8a061434-a56d-457f-8e79-43563bd91025	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2434.jpeg	2023-12-27 01:06:17.600319	2023-12-27 01:06:17.600319
28e10c1f-d9f3-4225-81ac-53a7add261c2	The Balloonists	Eula Biss	\N	\N	\N	f	bookshelf_cells/IMG_2435.jpeg	2023-12-27 01:06:17.601805	2023-12-27 01:06:17.601805
5dc2cddb-5a95-4070-9941-4a2babb25f30	Wild Creations	Hilton Carter	\N	\N	\N	f	bookshelf_cells/IMG_2436.jpeg	2023-12-27 01:06:17.603396	2023-12-27 01:06:17.603396
21c414bf-f730-4162-badf-7e266648547a	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2437.jpeg	2023-12-27 01:06:17.604725	2023-12-27 01:06:17.604725
2922fbc9-dcd6-4598-a78d-cea177cff197	Concerning the Spiritual in Art	Wassily Kandinsky	\N	\N	\N	f	bookshelf_cells/IMG_2438.jpeg	2023-12-27 01:06:17.606208	2023-12-27 01:06:17.606208
d3a9a545-aa6a-419e-b453-34e23c8f2706	The Immoralist	André Gide	\N	\N	\N	f	bookshelf_cells/IMG_2442.jpeg	2023-12-27 01:06:17.607374	2023-12-27 01:06:17.607374
3edd1f1f-b236-418e-9cc4-cae21fb57c0a	My Life on the Road	Gloria Steinem	\N	\N	\N	f	bookshelf_cells/IMG_2445.jpeg	2023-12-27 01:06:17.608499	2023-12-27 01:06:17.608499
7ec14d90-3536-41d0-8f15-7386bebe8310	Beethoven	\N	\N	\N	\N	f	bookshelf_cells/IMG_2454.jpeg	2023-12-27 01:06:17.609471	2023-12-27 01:06:17.609471
f690812f-05f7-4878-90f4-1f8c67e45e3c	Everything is Bullshit	\N	\N	\N	\N	f	bookshelf_cells/IMG_2469.jpeg	2023-12-27 01:06:17.610495	2023-12-27 01:06:17.610495
f2016e66-7004-4366-872d-87d28b59e77e	The Signal and the Noise	Nate Silver	\N	\N	\N	f	bookshelf_cells/IMG_2470.jpeg	2023-12-27 01:06:17.611513	2023-12-27 01:06:17.611513
427b23dc-18cb-44fa-92c5-b6cc96e821da	Applied Photographic Optics	Sidney F. Ray	\N	\N	\N	f	bookshelf_cells/IMG_2471.jpeg	2023-12-27 01:06:17.612538	2023-12-27 01:06:17.612538
dbdba9d4-5898-4890-8e53-0cf9b077ecba	The American Revolution	Gordon S. Wood	\N	\N	\N	f	bookshelf_cells/IMG_2485.jpeg	2023-12-27 01:06:17.614041	2023-12-27 01:06:17.614041
8a577e98-d2c4-4c48-9514-df4915a5c90e	The Singularity Trap	Dennis E. Taylor	\N	\N	\N	f	bookshelf_cells/IMG_2592.jpeg	2023-12-27 01:06:17.616085	2023-12-27 01:06:17.616085
7ed432a2-c34a-4650-bb43-3714f50071a6	Occupied Territory	Simon Balto	\N	\N	\N	f	bookshelf_cells/IMG_2593.jpeg	2023-12-27 01:06:17.617113	2023-12-27 01:06:17.617113
8b791c25-32c9-43d4-a187-d216f60e4ddd	Asymptotic Methods for Relaxation Oscillations and Applications	Johan Grasman	\N	\N	\N	f	bookshelf_cells/IMG_2594.jpeg	2023-12-27 01:06:17.618118	2023-12-27 01:06:17.618118
f4d98cc4-9cde-476a-88b0-838c0b29090c	Cancer Ward	Aleksandr Solzhenitsyn	\N	\N	\N	f	bookshelf_cells/IMG_2595.jpeg	2023-12-27 01:06:17.619047	2023-12-27 01:06:17.619047
b9bbe9f7-0d6b-4f79-a3f5-e296a5ce758d	Structure and Interpretation of Computer Programs	Harold Abelson and Gerald Jay Sussman with Julie Sussman	\N	\N	\N	f	bookshelf_cells/IMG_2596.jpeg	2023-12-27 01:06:17.619967	2023-12-27 01:06:17.619967
497e5201-9038-45d2-b8b3-60fe2126e8f3	McGraw-Hill Dictionary of Physics	\N	\N	\N	\N	f	bookshelf_cells/IMG_2597.jpeg	2023-12-27 01:06:17.621079	2023-12-27 01:06:17.621079
64b640dd-5419-466c-8658-c77fcf0f0560	Isadora	Fredrika Blair	\N	\N	\N	f	bookshelf_cells/IMG_2598.jpeg	2023-12-27 01:06:17.622278	2023-12-27 01:06:17.622278
eb90298f-ac6f-4cee-82b9-c3d5a5407776	Discrete Mathematics	Kenn	\N	\N	\N	f	bookshelf_cells/IMG_2599.jpeg	2023-12-27 01:06:17.623391	2023-12-27 01:06:17.623391
e5910f73-80e8-4a24-83b7-66a1eed34db4	LISP	Patrick Henry Winston, Berthold Klaus Paul Horn	\N	\N	\N	f	bookshelf_cells/IMG_2600.jpeg	2023-12-27 01:06:59.962843	2023-12-27 01:06:59.962843
092310c5-601f-4792-9147-fcb103444653	Soft Skills	John Z. Sonmez	\N	\N	\N	f	bookshelf_cells/IMG_2601.jpeg	2023-12-27 01:06:59.965825	2023-12-27 01:06:59.965825
80a53908-71be-4d8f-b5fc-dfb4705583a1	A Short History of Nearly Everything	Bill Bryson	\N	\N	\N	f	bookshelf_cells/IMG_2602.jpeg	2023-12-27 01:06:59.967987	2023-12-27 01:06:59.967987
18467c3e-c7c7-456f-8102-387d71da17cb	An Introduction to Analysis	William R. Wade	\N	\N	\N	f	bookshelf_cells/IMG_2603.jpeg	2023-12-27 01:06:59.969955	2023-12-27 01:06:59.969955
756504c7-e049-4baf-9ed1-b85429b857a5	CRC Standard Mathematical Tables	\N	\N	\N	\N	f	bookshelf_cells/IMG_2604.jpeg	2023-12-27 01:06:59.972096	2023-12-27 01:06:59.972096
43835de8-fc4c-4424-8278-4223e4ffe76e	Nature's Metropolis	William Cronon	\N	\N	\N	f	bookshelf_cells/IMG_2605.jpeg	2023-12-27 01:06:59.974256	2023-12-27 01:06:59.974256
3f70f544-0f03-4215-96a0-ca44368f00df	Uncovering Soviet Disasters	James E. Oberg	\N	\N	\N	f	bookshelf_cells/IMG_2606.jpeg	2023-12-27 01:06:59.976302	2023-12-27 01:06:59.976302
93c87683-dc93-4e25-b9a6-9abcaeff7949	The Pragmatic Programmer	Andrew Hunt, David Thomas	\N	\N	\N	f	bookshelf_cells/IMG_2634.jpeg	2023-12-27 01:06:59.977813	2023-12-27 01:06:59.977813
a90879c3-543b-47f0-b904-28c838a31dd5	The World War II Quiz & Fact Book	Timothy B. Benford	\N	\N	\N	f	bookshelf_cells/IMG_2635.jpeg	2023-12-27 01:06:59.97917	2023-12-27 01:06:59.97917
b74ce098-3ab9-4c98-a242-d2346fa0b5aa	New Directions in Japanese Architecture	Robin Boyd	\N	\N	\N	f	bookshelf_cells/IMG_2636.jpeg	2023-12-27 01:06:59.980684	2023-12-27 01:06:59.980684
ee24857b-9676-4e58-aad1-f140bd0316b6	Handbook of Chemistry and Physics	\N	\N	\N	\N	f	bookshelf_cells/IMG_2637.jpeg	2023-12-27 01:06:59.98194	2023-12-27 01:06:59.98194
c19a05f9-9a1d-4584-9f3d-cc5e25f7e856	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2712.jpeg	2023-12-27 01:10:19.846808	2023-12-27 01:10:19.846808
3c703084-2098-4850-8ea1-7db933c0b655	\N	\N	\N	\N	\N	f	bookshelf_cells/IMG_2713.jpeg	2023-12-27 01:10:19.850617	2023-12-27 01:10:19.850617
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

