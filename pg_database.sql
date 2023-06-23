--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2022-07-29 18:37:46

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
-- TOC entry 14 (class 2615 OID 45806)
-- Name: sisdp; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sisdp;


ALTER SCHEMA sisdp OWNER TO postgres;

--
-- TOC entry 12 (class 2615 OID 45803)
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO postgres;

--
-- TOC entry 13 (class 2615 OID 45804)
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO postgres;

--
-- TOC entry 11 (class 2615 OID 45805)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- TOC entry 4681 (class 0 OID 0)
-- Dependencies: 11
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- TOC entry 2 (class 3079 OID 45807)
-- Name: address_standardizer; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS address_standardizer WITH SCHEMA public;


--
-- TOC entry 4682 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION address_standardizer; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION address_standardizer IS 'Used to parse an address into constituent elements. Generally used to support geocoding address normalization step.';


--
-- TOC entry 3 (class 3079 OID 45814)
-- Name: address_standardizer_data_us; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS address_standardizer_data_us WITH SCHEMA public;


--
-- TOC entry 4683 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION address_standardizer_data_us; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION address_standardizer_data_us IS 'Address Standardizer US dataset example';


--
-- TOC entry 4 (class 3079 OID 45857)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 4684 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 5 (class 3079 OID 45868)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4685 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- TOC entry 6 (class 3079 OID 46870)
-- Name: postgis_sfcgal; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_sfcgal WITH SCHEMA public;


--
-- TOC entry 4686 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION postgis_sfcgal; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_sfcgal IS 'PostGIS SFCGAL functions';


--
-- TOC entry 7 (class 3079 OID 46890)
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- TOC entry 4687 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- TOC entry 8 (class 3079 OID 47317)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 4688 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- TOC entry 1868 (class 1247 OID 47462)
-- Name: additionalinfodetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.additionalinfodetails AS (
	surveyor_name text,
	hh_code text,
	last_updated_on text,
	address text,
	landmark text
);


ALTER TYPE sisdp.additionalinfodetails OWNER TO postgres;

--
-- TOC entry 1871 (class 1247 OID 47465)
-- Name: allbusinessdetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allbusinessdetails AS (
	occ_type text,
	occ_location text
);


ALTER TYPE sisdp.allbusinessdetails OWNER TO postgres;

--
-- TOC entry 1874 (class 1247 OID 47468)
-- Name: alldashboardpointgeom; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.alldashboardpointgeom AS (
	pointjson text,
	house_own text
);


ALTER TYPE sisdp.alldashboardpointgeom OWNER TO postgres;

--
-- TOC entry 1877 (class 1247 OID 47471)
-- Name: alldashboardvalues; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.alldashboardvalues AS (
	pointjson text,
	house_own bigint
);


ALTER TYPE sisdp.alldashboardvalues OWNER TO postgres;

--
-- TOC entry 1880 (class 1247 OID 47474)
-- Name: allenergydetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allenergydetails AS (
	lpg text,
	kerosene text,
	firewood text,
	biogass text,
	cowdung text,
	energy_oth text,
	energy_sch text
);


ALTER TYPE sisdp.allenergydetails OWNER TO postgres;

--
-- TOC entry 1883 (class 1247 OID 47477)
-- Name: allfamilydetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allfamilydetails AS (
	name text,
	age integer,
	sex text,
	married text,
	qualifcation text,
	occupation text,
	location text,
	mode_of_transport text,
	digital_literacy text,
	change_in_occupation text,
	since_when_and_reason text
);


ALTER TYPE sisdp.allfamilydetails OWNER TO postgres;

--
-- TOC entry 1886 (class 1247 OID 47480)
-- Name: allhealthdetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allhealthdetails AS (
	vaccination text,
	disease text,
	hosp_visit text,
	hosp_near text,
	hosp_fees text,
	hosp_travel text
);


ALTER TYPE sisdp.allhealthdetails OWNER TO postgres;

--
-- TOC entry 1889 (class 1247 OID 47483)
-- Name: allhhcolumns; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allhhcolumns AS (
	pointjson text,
	id integer,
	hh_code character varying(12),
	resp_name character varying(50),
	religion character varying(20),
	caste character varying(20),
	address character varying(100),
	landmark character varying(50),
	statecode character varying(2),
	distcode character varying(4),
	blkcode character varying(50),
	villcode character varying(100),
	resi_since character varying(4),
	house_own character varying(4),
	house_rent integer,
	bplcard boolean,
	rationcard boolean,
	fam_members integer,
	land_khasra character varying(20),
	land_area numeric(10,2),
	land_since character varying(4),
	land_cultiv boolean,
	land_fallow boolean,
	house_type character varying(20),
	house_roof character varying(20),
	house_wall character varying(20),
	house_ht character varying(10),
	house_sch boolean,
	house_age character varying(10),
	house_cond character varying(20),
	water_supp character varying(30),
	water_supp_dur integer,
	solid_waste_coll character varying(30),
	elec_supp boolean,
	elec_supp_dur integer,
	elec_use character varying(20),
	transportation character varying(20),
	toilet_avail boolean,
	toilet_type character varying(20),
	toilet_use boolean,
	toilet_sch character varying(20),
	toilet_amt integer,
	monthly_food integer,
	monthly_edu integer,
	monthly_tpt integer,
	monthly_health integer,
	monthly_rent integer,
	monthly_leisure integer,
	monthly_exp numeric(10,2),
	monthly_int boolean,
	monthly_int_amt numeric(10,2),
	monthly_int_since character varying(4),
	vaccination boolean,
	disease boolean,
	hosp_visit integer,
	hosp_near character varying(20),
	hosp_fees numeric(10,2),
	hosp_travel character varying(20),
	cow_buffalo boolean,
	ox boolean,
	goat boolean,
	chicken boolean,
	horse boolean,
	donkey boolean,
	other_livestock character varying(20),
	radio boolean,
	telephone boolean,
	solar boolean,
	tv boolean,
	computer boolean,
	stove boolean,
	lpg boolean,
	kerosene boolean,
	firewood boolean,
	biogass boolean,
	cowdung boolean,
	energy_oth character varying(20),
	energy_sch boolean,
	voc_trng_cntr character varying(200),
	issues character varying(100),
	expectations character varying(200),
	suggestions character varying(200),
	loc_geom public.geometry,
	loc_geom1 public.geometry,
	loc_geom2 public.geometry,
	accuracy1 numeric(5,2),
	accuracy2 numeric(5,2),
	photo1 text,
	photo1_time timestamp without time zone,
	photo2 text,
	photo2_time timestamp without time zone,
	last_updated_by character varying(20),
	last_updated_on timestamp without time zone,
	obs_date timestamp without time zone,
	surveyor_name character varying(30),
	surveyor_id character varying(10),
	disease_det character varying(20),
	anyremarks character varying(200),
	surveyor_mobile numeric(10,0),
	cow_livestock_num integer,
	cow_livestock_disease character varying(20),
	cow_commercial_use character varying(20),
	ox_livestock_num integer,
	ox_livestock_disease character varying(20),
	ox_commercial_use character varying(20),
	goat_livestock_num integer,
	goat_livestock_disease character varying(20),
	goat_commercial_use character varying(20),
	chicken_livestock_num integer,
	chicken_livestock_disease character varying(20),
	chicken_commercial_use character varying(20),
	horse_livestock_num integer,
	horse_livestock_disease character varying(20),
	horse_commercial_use character varying(20),
	donkey_livestock_num integer,
	donkey_livestock_disease character varying(20),
	donkey_commercial_use character varying(20),
	other_livestock_num integer,
	other_livestock_disease character varying(20),
	other_commercial_use character varying(20),
	latitude numeric(10,8),
	accuracy numeric(5,2),
	latitude1 numeric(10,8),
	latitude2 numeric(10,8),
	longitude numeric(10,8),
	longitude1 numeric(10,8),
	longitude2 numeric(10,8),
	gp_code integer,
	land_holding boolean,
	num_img integer,
	id_fam integer,
	hh_code_fam character varying(12),
	member_name character varying(20),
	age integer,
	sex character varying(20),
	maritalstatus character varying(20),
	qualification character varying(20),
	digital_literacy boolean,
	occupation character varying(30),
	occupation_id character varying(3),
	occ_location character varying(20),
	mode_transport character varying(20),
	occ_change boolean,
	occ_prev character varying(20),
	occ_change_since character varying(4),
	occ_change_reason character varying(30),
	last_updated_by_fam character varying(20),
	last_updated_on_fam timestamp without time zone,
	occ_type character varying(20),
	occ_mode_travel character varying(20),
	agri_num_pers integer,
	agri_own character varying(20),
	agri_area numeric(10,0),
	agri_soil_type character varying(20),
	agri_crop_type character varying(20),
	agri_crop_freq character varying(20),
	agri_crop_change character varying(20),
	agri_crop_produce integer,
	agri_seed_avail character varying(20),
	agri_store_loc character varying(20),
	agri_sell_loc character varying(20),
	agri_irr_source boolean,
	agri_irr_sch character varying(20),
	lab_marginal character varying(20),
	lab_wage integer,
	serv_salary integer,
	migrant boolean,
	business_income integer,
	service_salary integer,
	occ_remarks character varying(50),
	relationship character varying(20),
	mobile numeric(10,0),
	agri_crop_chng_det character varying(30)
);


ALTER TYPE sisdp.allhhcolumns OWNER TO postgres;

--
-- TOC entry 1892 (class 1247 OID 47486)
-- Name: allhhmcolumns; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allhhmcolumns AS (
	pointjson text,
	id integer,
	hh_code character varying(12),
	resp_name character varying(50),
	religion character varying(20),
	caste character varying(20),
	address character varying(100),
	landmark character varying(50),
	statecode character varying(2),
	distcode character varying(4),
	blkcode character varying(50),
	villcode character varying(100),
	resi_since character varying(4),
	house_own character varying(4),
	house_rent integer,
	bplcard boolean,
	rationcard boolean,
	fam_members integer,
	land_khasra character varying(20),
	land_area numeric(10,2),
	land_since character varying(4),
	land_cultiv boolean,
	land_fallow boolean,
	house_type character varying(20),
	house_roof character varying(20),
	house_wall character varying(20),
	house_ht character varying(10),
	house_sch boolean,
	house_age character varying(10),
	house_cond character varying(20),
	water_supp character varying(30),
	water_supp_dur integer,
	solid_waste_coll character varying(30),
	elec_supp boolean,
	elec_supp_dur integer,
	elec_use character varying(20),
	transportation character varying(20),
	toilet_avail boolean,
	toilet_type character varying(20),
	toilet_use boolean,
	toilet_sch character varying(20),
	toilet_amt integer,
	monthly_food integer,
	monthly_edu integer,
	monthly_tpt integer,
	monthly_health integer,
	monthly_rent integer,
	monthly_leisure integer,
	monthly_exp numeric(10,2),
	monthly_int boolean,
	monthly_int_amt numeric(10,2),
	monthly_int_since character varying(4),
	vaccination boolean,
	disease boolean,
	hosp_visit integer,
	hosp_near character varying(20),
	hosp_fees numeric(10,2),
	hosp_travel character varying(20),
	cow_buffalo boolean,
	ox boolean,
	goat boolean,
	chicken boolean,
	horse boolean,
	donkey boolean,
	other_livestock character varying(20),
	radio boolean,
	telephone boolean,
	solar boolean,
	tv boolean,
	computer boolean,
	stove boolean,
	lpg boolean,
	kerosene boolean,
	firewood boolean,
	biogass boolean,
	cowdung boolean,
	energy_oth character varying(20),
	energy_sch boolean,
	voc_trng_cntr character varying(200),
	issues character varying(100),
	expectations character varying(200),
	suggestions character varying(200),
	loc_geom public.geometry,
	loc_geom1 public.geometry,
	loc_geom2 public.geometry,
	accuracy1 numeric(5,2),
	accuracy2 numeric(5,2),
	photo1 text,
	photo1_time timestamp without time zone,
	photo2 text,
	photo2_time timestamp without time zone,
	last_updated_by character varying(20),
	last_updated_on timestamp without time zone,
	obs_date timestamp without time zone,
	surveyor_name character varying(30),
	surveyor_id character varying(10),
	disease_det character varying(20),
	anyremarks character varying(200),
	surveyor_mobile numeric(10,0),
	cow_livestock_num integer,
	cow_livestock_disease character varying(20),
	cow_commercial_use character varying(20),
	ox_livestock_num integer,
	ox_livestock_disease character varying(20),
	ox_commercial_use character varying(20),
	goat_livestock_num integer,
	goat_livestock_disease character varying(20),
	goat_commercial_use character varying(20),
	chicken_livestock_num integer,
	chicken_livestock_disease character varying(20),
	chicken_commercial_use character varying(20),
	horse_livestock_num integer,
	horse_livestock_disease character varying(20),
	horse_commercial_use character varying(20),
	donkey_livestock_num integer,
	donkey_livestock_disease character varying(20),
	donkey_commercial_use character varying(20),
	other_livestock_num integer,
	other_livestock_disease character varying(20),
	other_commercial_use character varying(20),
	latitude numeric(10,8),
	accuracy numeric(5,2),
	latitude1 numeric(10,8),
	latitude2 numeric(10,8),
	longitude numeric(10,8),
	longitude1 numeric(10,8),
	longitude2 numeric(10,8),
	gp_code integer,
	land_holding boolean,
	num_img integer
);


ALTER TYPE sisdp.allhhmcolumns OWNER TO postgres;

--
-- TOC entry 1895 (class 1247 OID 47489)
-- Name: allhousingdetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allhousingdetails AS (
	house_type text,
	house_roof text,
	house_wall text,
	house_ht text,
	house_sch text,
	house_age text,
	house_cond text
);


ALTER TYPE sisdp.allhousingdetails OWNER TO postgres;

--
-- TOC entry 1898 (class 1247 OID 47492)
-- Name: alllabourdetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.alllabourdetails AS (
	occ_type text,
	occ_location text,
	occ_mode_travel text,
	lab_marginal text,
	lab_wage text
);


ALTER TYPE sisdp.alllabourdetails OWNER TO postgres;

--
-- TOC entry 1901 (class 1247 OID 47495)
-- Name: alllanddetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.alllanddetails AS (
	land_khasra text,
	land_area text,
	land_since text,
	land_cultiv text,
	land_fallow text
);


ALTER TYPE sisdp.alllanddetails OWNER TO postgres;

--
-- TOC entry 1904 (class 1247 OID 47498)
-- Name: alllivestockdetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.alllivestockdetails AS (
	cow_livestock_num text,
	cow_livestock_disease text,
	cow_commercial_use text,
	ox_livestock_num text,
	ox_livestock_disease text,
	ox_commercial_use text,
	goat_livestock_num text,
	goat_livestock_disease text,
	goat_commercial_use text,
	chicken_livestock_num text,
	chicken_livestock_disease text,
	chicken_commercial_use text,
	horse_livestock_num text,
	horse_livestock_disease text,
	horse_commercial_use text,
	donkey_livestock_num text,
	donkey_livestock_disease text,
	donkey_commercial_use text,
	other_livestock_num text,
	other_livestock_disease text,
	other_commercial_use text
);


ALTER TYPE sisdp.alllivestockdetails OWNER TO postgres;

--
-- TOC entry 1907 (class 1247 OID 47501)
-- Name: allloccservicedetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allloccservicedetails AS (
	occ_type text,
	occ_location text,
	occ_mode_travel text,
	service_salary text
);


ALTER TYPE sisdp.allloccservicedetails OWNER TO postgres;

--
-- TOC entry 1910 (class 1247 OID 47504)
-- Name: allmonthlydetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allmonthlydetails AS (
	monthly_food text,
	monthly_edu text,
	monthly_tpt text,
	monthly_health text,
	monthly_rent text,
	monthly_leisure text,
	monthly_exp text,
	monthly_int_amt text,
	monthly_int_since text
);


ALTER TYPE sisdp.allmonthlydetails OWNER TO postgres;

--
-- TOC entry 1913 (class 1247 OID 47507)
-- Name: alloccupationdetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.alloccupationdetails AS (
	agri_num_pers text,
	agri_area text,
	occ_location text,
	agri_soil_type text,
	agri_own text,
	agri_crop_type text,
	agri_crop_freq text,
	agri_irr_source text,
	agri_irr_sch text,
	agri_seed_avail text,
	agri_crop_change text,
	agri_store_loc text,
	agri_sell_loc text,
	agri_crop_produce text
);


ALTER TYPE sisdp.alloccupationdetails OWNER TO postgres;

--
-- TOC entry 1916 (class 1247 OID 47510)
-- Name: allotherassets; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allotherassets AS (
	radio text,
	telephone text,
	solar text,
	stove text,
	tv text,
	computer text
);


ALTER TYPE sisdp.allotherassets OWNER TO postgres;

--
-- TOC entry 1919 (class 1247 OID 47513)
-- Name: allservices; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allservices AS (
	water_supp text,
	water_supp_dur text,
	solid_waste_coll text,
	elec_supp text,
	elec_supp_dur text,
	elec_use text,
	transportation text
);


ALTER TYPE sisdp.allservices OWNER TO postgres;

--
-- TOC entry 1922 (class 1247 OID 47516)
-- Name: allsurveypersonal; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allsurveypersonal AS (
	resp_name text,
	religion text,
	caste text,
	resi_since text,
	house_own text,
	house_rent text,
	bplcard text,
	rationcard text
);


ALTER TYPE sisdp.allsurveypersonal OWNER TO postgres;

--
-- TOC entry 1925 (class 1247 OID 47519)
-- Name: alltoiletdetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.alltoiletdetails AS (
	toilet_avail text,
	toilet_type text,
	toilet_use text,
	toilet_sch text,
	toilet_amt text
);


ALTER TYPE sisdp.alltoiletdetails OWNER TO postgres;

--
-- TOC entry 1928 (class 1247 OID 47522)
-- Name: allvocational; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.allvocational AS (
	voc_trng_cntr text,
	issues text,
	expectations text,
	suggestions text
);


ALTER TYPE sisdp.allvocational OWNER TO postgres;

--
-- TOC entry 1931 (class 1247 OID 47525)
-- Name: downloadcsv1; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.downloadcsv1 AS (
	id integer,
	hh_code character varying,
	member_name character varying,
	age integer,
	sex character varying,
	maritalstatus character varying,
	digital_literacy boolean,
	occupation character varying,
	occupation_id character varying,
	occ_location character varying,
	mode_transport character varying,
	occ_change boolean,
	occ_prev character varying,
	occ_change_since character varying,
	occ_change_reason character varying,
	last_updated_by character varying,
	last_updated_on timestamp without time zone,
	occ_type character varying,
	occ_mode_travel character varying,
	agri_num_pers integer,
	agri_own character varying,
	agri_area numeric,
	agri_soil_type character varying,
	agri_crop_type character varying,
	agri_crop_freq character varying,
	agri_crop_change character varying,
	agri_crop_produce integer,
	agri_seed_avail character varying,
	agri_store_loc character varying,
	agri_sell_loc character varying,
	agri_irr_source boolean,
	agri_irr_sch character varying,
	lab_marginal boolean,
	lab_wage integer,
	serv_salary integer,
	migrant boolean,
	mobile numeric,
	business_income numeric,
	service_salary numeric,
	occ_remarks character varying,
	relationship character varying
);


ALTER TYPE sisdp.downloadcsv1 OWNER TO postgres;

--
-- TOC entry 1934 (class 1247 OID 47528)
-- Name: familytype; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.familytype AS (
	id integer,
	hh_code character varying,
	member_name character varying,
	age integer,
	sex character varying,
	maritalstatus character varying,
	qualification character varying,
	digital_literacy boolean,
	occupation character varying,
	occupation_id character varying,
	occ_location character varying,
	mode_transport character varying,
	occ_change boolean,
	occ_prev character varying,
	occ_change_since character varying,
	occ_change_reason character varying,
	last_updated_by character varying,
	last_updated_on timestamp without time zone,
	occ_type character varying,
	occ_mode_travel character varying,
	agri_num_pers integer,
	agri_own character varying,
	agri_area numeric,
	agri_soil_type character varying,
	agri_crop_type character varying,
	agri_crop_freq character varying,
	agri_crop_change character varying,
	agri_crop_produce integer,
	agri_seed_avail character varying,
	agri_store_loc character varying,
	agri_sell_loc character varying,
	agri_irr_source boolean,
	agri_irr_sch character varying,
	lab_marginal character varying,
	lab_wage integer,
	serv_salary integer,
	migrant boolean,
	business_income integer,
	service_salary integer,
	occ_remarks character varying,
	relationship character varying,
	mobile numeric,
	agri_crop_chng_det character varying
);


ALTER TYPE sisdp.familytype OWNER TO postgres;

--
-- TOC entry 1937 (class 1247 OID 47531)
-- Name: familytype1; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.familytype1 AS (
	id integer,
	hh_code character varying,
	member_name character varying,
	age integer,
	sex character varying,
	relationship character varying,
	maritalstatus character varying,
	qualification character varying,
	digital_literacy boolean,
	occupation character varying,
	occ_location character varying,
	mode_transport character varying,
	occ_change boolean,
	occ_prev character varying,
	occ_change_since character varying,
	occ_change_reason character varying,
	occ_type character varying,
	occ_mode_travel character varying,
	agri_num_pers integer,
	agri_own character varying,
	agri_area numeric,
	agri_soil_type character varying,
	agri_crop_type character varying,
	agri_crop_freq character varying,
	agri_crop_change character varying,
	agri_crop_produce integer,
	agri_seed_avail character varying,
	agri_store_loc character varying,
	agri_sell_loc character varying,
	agri_irr_source boolean,
	agri_irr_sch character varying,
	lab_marginal character varying,
	lab_wage integer,
	serv_salary integer,
	migrant boolean,
	business_income integer,
	service_salary integer,
	occ_remarks character varying,
	mobile numeric,
	agri_crop_chng_det character varying
);


ALTER TYPE sisdp.familytype1 OWNER TO postgres;

--
-- TOC entry 1940 (class 1247 OID 47534)
-- Name: livestockvariable; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.livestockvariable AS (
	cow_livestock_num text,
	cow_livestock_disease text,
	cow_commercial_use text,
	ox_livestock_num text,
	ox_livestock_disease text,
	ox_commercial_use text,
	goat_livestock_num text,
	goat_livestock_disease text,
	goat_commercial_use text,
	chicken_livestock_num text,
	chicken_livestock_disease text,
	chicken_commercial_use text,
	horse_livestock_num text,
	horse_livestock_disease text,
	horse_commercial_use text,
	donkey_livestock_num text,
	donkey_livestock_disease text,
	donkey_commercial_use text,
	other_livestock_num text,
	other_livestock_disease text,
	other_commercial_use text
);


ALTER TYPE sisdp.livestockvariable OWNER TO postgres;

--
-- TOC entry 1943 (class 1247 OID 47537)
-- Name: mastertype; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.mastertype AS (
	id integer,
	hh_code character varying,
	resp_name character varying,
	religion character varying,
	caste character varying,
	address character varying,
	landmark character varying,
	statecode character varying,
	distcode character varying,
	blkcode character varying,
	villcode character varying,
	resi_since character varying,
	house_own character varying,
	house_rent integer,
	bplcard boolean,
	rationcard boolean,
	fam_members integer,
	land_khasra character varying,
	land_area numeric,
	land_since character varying,
	land_cultiv boolean,
	land_fallow boolean,
	house_type character varying,
	house_roof character varying,
	house_wall character varying,
	house_ht character varying,
	house_sch boolean,
	house_age character varying,
	house_cond character varying,
	water_supp character varying,
	water_supp_dur integer,
	solid_waste_coll character varying,
	elec_supp boolean,
	elec_supp_dur integer,
	elec_use character varying,
	transportation character varying,
	toilet_avail boolean,
	toilet_type character varying,
	toilet_use boolean,
	toilet_sch character varying,
	toilet_amt integer,
	monthly_food integer,
	monthly_edu integer,
	monthly_tpt integer,
	monthly_health integer,
	monthly_rent integer,
	monthly_leisure integer,
	monthly_exp numeric,
	monthly_int boolean,
	monthly_int_amt numeric,
	monthly_int_since character varying,
	vaccination boolean,
	disease boolean,
	hosp_visit integer,
	hosp_near character varying,
	hosp_fees numeric,
	hosp_travel character varying,
	cow_buffalo boolean,
	ox boolean,
	goat boolean,
	chicken boolean,
	horse boolean,
	donkey boolean,
	other_livestock character varying,
	radio boolean,
	telephone boolean,
	solar boolean,
	tv boolean,
	computer boolean,
	stove boolean,
	lpg boolean,
	kerosene boolean,
	firewood boolean,
	biogass boolean,
	cowdung boolean,
	energy_oth character varying,
	energy_sch boolean,
	voc_trng_cntr character varying,
	issues character varying,
	expectations character varying,
	suggestions character varying,
	loc_geom public.geometry,
	loc_geom1 public.geometry,
	loc_geom2 public.geometry,
	accuracy1 numeric,
	accuracy2 numeric,
	last_updated_by character varying,
	last_updated_on timestamp without time zone,
	obs_date timestamp without time zone,
	surveyor_name character varying,
	surveyor_id character varying,
	disease_det character varying,
	anyremarks character varying,
	surveyor_mobile numeric,
	cow_livestock_num integer,
	cow_livestock_disease character varying,
	cow_commercial_use character varying,
	ox_livestock_num integer,
	ox_livestock_disease character varying,
	ox_commercial_use character varying,
	goat_livestock_num integer,
	goat_livestock_disease character varying,
	goat_commercial_use character varying,
	chicken_livestock_num integer,
	chicken_livestock_disease character varying,
	chicken_commercial_use character varying,
	horse_livestock_num integer,
	horse_livestock_disease character varying,
	horse_commercial_use character varying,
	donkey_livestock_num integer,
	donkey_livestock_disease character varying,
	donkey_commercial_use character varying,
	other_livestock_num integer,
	other_livestock_disease character varying,
	other_commercial_use character varying,
	latitude numeric,
	accuracy numeric,
	latitude1 numeric,
	latitude2 numeric,
	longitude numeric,
	longitude1 numeric,
	longitude2 numeric,
	gp_code integer,
	land_holding boolean,
	num_img integer
);


ALTER TYPE sisdp.mastertype OWNER TO postgres;

--
-- TOC entry 1946 (class 1247 OID 47540)
-- Name: mastertype1; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.mastertype1 AS (
	gp_code integer,
	hh_code character varying,
	resp_name character varying,
	religion character varying,
	caste character varying,
	address character varying,
	landmark character varying,
	statecode character varying,
	distcode character varying,
	blkcode character varying,
	villcode character varying,
	resi_since character varying,
	house_own character varying,
	house_rent integer,
	bplcard boolean,
	rationcard boolean,
	fam_members integer,
	land_khasra character varying,
	land_area numeric,
	land_since character varying,
	land_cultiv boolean,
	land_fallow boolean,
	house_type character varying,
	house_roof character varying,
	house_wall character varying,
	house_ht character varying,
	house_sch boolean,
	house_age character varying,
	house_cond character varying,
	water_supp character varying,
	water_supp_dur integer,
	solid_waste_coll character varying,
	elec_supp boolean,
	elec_supp_dur integer,
	elec_use character varying,
	transportation character varying,
	toilet_avail boolean,
	toilet_type character varying,
	toilet_use boolean,
	toilet_sch character varying,
	toilet_amt integer,
	monthly_food integer,
	monthly_edu integer,
	monthly_tpt integer,
	monthly_health integer,
	monthly_rent integer,
	monthly_leisure integer,
	monthly_exp numeric,
	monthly_int boolean,
	monthly_int_amt numeric,
	monthly_int_since character varying,
	vaccination boolean,
	disease boolean,
	hosp_visit integer,
	hosp_near character varying,
	hosp_fees numeric,
	hosp_travel character varying,
	cow_buffalo boolean,
	ox boolean,
	goat boolean,
	chicken boolean,
	horse boolean,
	donkey boolean,
	other_livestock character varying,
	radio boolean,
	telephone boolean,
	solar boolean,
	tv boolean,
	computer boolean,
	stove boolean,
	lpg boolean,
	kerosene boolean,
	firewood boolean,
	biogass boolean,
	cowdung boolean,
	energy_oth character varying,
	energy_sch boolean,
	voc_trng_cntr character varying,
	issues character varying,
	expectations character varying,
	suggestions character varying,
	last_updated_by character varying,
	last_updated_on timestamp without time zone,
	obs_date timestamp without time zone,
	surveyor_name character varying,
	surveyor_id character varying,
	disease_det character varying,
	anyremarks character varying,
	surveyor_mobile numeric,
	cow_livestock_num integer,
	cow_livestock_disease character varying,
	cow_commercial_use character varying,
	ox_livestock_num integer,
	ox_livestock_disease character varying,
	ox_commercial_use character varying,
	goat_livestock_num integer,
	goat_livestock_disease character varying,
	goat_commercial_use character varying,
	chicken_livestock_num integer,
	chicken_livestock_disease character varying,
	chicken_commercial_use character varying,
	horse_livestock_num integer,
	horse_livestock_disease character varying,
	horse_commercial_use character varying,
	donkey_livestock_num integer,
	donkey_livestock_disease character varying,
	donkey_commercial_use character varying,
	other_livestock_num integer,
	other_livestock_disease character varying,
	other_commercial_use character varying,
	latitude numeric,
	accuracy numeric,
	longitude numeric,
	land_holding boolean
);


ALTER TYPE sisdp.mastertype1 OWNER TO postgres;

--
-- TOC entry 1949 (class 1247 OID 47543)
-- Name: photodetails; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.photodetails AS (
	photo1 text,
	photo2 text,
	suggestions text
);


ALTER TYPE sisdp.photodetails OWNER TO postgres;

--
-- TOC entry 1952 (class 1247 OID 47546)
-- Name: surveymastertype; Type: TYPE; Schema: sisdp; Owner: postgres
--

CREATE TYPE sisdp.surveymastertype AS (
	id integer,
	hh_code character varying(12),
	resp_name character varying(50),
	religion character varying(10),
	caste character varying(10),
	address character varying(100),
	landmark character varying(50),
	statecode character varying(2),
	distcode character varying(4),
	blkcode character varying(50),
	gpcode character varying(50),
	villcode character varying(100),
	resi_since character varying(4),
	house_own character varying(4),
	house_rent integer,
	bplcard boolean,
	rationcard boolean,
	fam_members integer,
	land_khasra character varying(20),
	land_area numeric(10,2),
	land_since character varying(4),
	land_cultiv boolean,
	land_fallow boolean,
	house_type character varying(20),
	house_roof character varying(20),
	house_wall character varying(20),
	house_ht character varying(10),
	house_sch boolean,
	house_age character varying(10),
	house_cond character varying(10),
	water_supp character varying(10),
	water_supp_dur integer,
	solid_waste_coll character varying(10),
	elec_supp boolean,
	elec_supp_dur integer,
	elec_use character varying(10),
	transportation character varying(20),
	toilet_avail boolean,
	toilet_type character varying(20),
	toilet_use boolean,
	toilet_sch character varying(20),
	toilet_amt integer,
	monthly_food integer,
	monthly_edu integer,
	monthly_tpt integer,
	monthly_health integer,
	monthly_rent integer,
	monthly_leisure integer,
	monthly_exp numeric(10,2),
	monthly_int boolean,
	monthly_int_amt numeric(10,2),
	monthly_int_since character varying(4),
	vaccination boolean,
	disease boolean,
	hosp_visit integer,
	hosp_near character varying(20),
	hosp_fees numeric(10,2),
	hosp_travel character varying(20),
	cow_buffalo boolean,
	ox boolean,
	goat boolean,
	chicken boolean,
	horse boolean,
	donkey boolean,
	other_livestock character varying(10),
	radio boolean,
	telephone boolean,
	solar boolean,
	tv boolean,
	computer boolean,
	stove boolean,
	lpg boolean,
	kerosene boolean,
	firewood boolean,
	biogass boolean,
	cowdung boolean,
	energy_oth character varying(20),
	energy_sch boolean,
	voc_trng_cntr character varying(200),
	issues character varying(100),
	expectations character varying(200),
	suggestions character varying(200),
	loc_geom public.geometry,
	loc_geom1 public.geometry,
	loc_geom2 public.geometry,
	accuracy1 numeric(5,2),
	accuracy2 numeric(5,2),
	photo1 bytea,
	photo1_time timestamp without time zone,
	photo2 bytea,
	photo2_time timestamp without time zone,
	last_updated_by character varying(20),
	last_updated_on timestamp without time zone,
	obs_date timestamp without time zone,
	surveyor_name character varying(30),
	surveyor_id character varying(10),
	surveyor_email character varying(50),
	loc_geojson text,
	disease_det character varying(20),
	anyremarks character varying(200),
	surveyor_mobile numeric(10,0),
	cow_livestock_num integer,
	cow_livestock_disease character varying(20),
	cow_commercial_use character varying(20),
	ox_livestock_num integer,
	ox_livestock_disease character varying(20),
	ox_commercial_use character varying(20),
	goat_livestock_num integer,
	goat_livestock_disease character varying(20),
	goat_commercial_use character varying(20),
	chicken_livestock_num integer,
	chicken_livestock_disease character varying(20),
	chicken_commercial_use character varying(20),
	horse_livestock_num integer,
	horse_livestock_disease character varying(20),
	horse_commercial_use character varying(20),
	donkey_livestock_num integer,
	donkey_livestock_disease character varying(20),
	donkey_commercial_use character varying(20),
	other_livestock_num integer,
	other_livestock_disease character varying(20),
	other_commercial_use character varying(20),
	land_holding boolean,
	num_img integer,
	latitude numeric(10,8),
	accuracy numeric(5,2),
	latitude1 numeric(10,8),
	latitude2 numeric(10,8),
	longitude numeric(10,8),
	longitude1 numeric(10,8),
	longitude2 numeric(10,8)
);


ALTER TYPE sisdp.surveymastertype OWNER TO postgres;

--
-- TOC entry 1183 (class 1255 OID 47547)
-- Name: allfields(integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.allfields(gpcode1 integer) RETURNS SETOF sisdp.allhhcolumns
    LANGUAGE plpgsql STABLE
    AS $$
begin
	return query 
		select
		ST_ASGEoJSON(loc_geom),* FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
	gpcode1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) ;
end
$$;


ALTER FUNCTION sisdp.allfields(gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1184 (class 1255 OID 47548)
-- Name: allfieldsm(integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.allfieldsm(gpcode1 integer) RETURNS SETOF sisdp.allhhmcolumns
    LANGUAGE plpgsql STABLE
    AS $$
begin
	return query 
		select
		ST_ASGEoJSON(loc_geom),* FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=
	gpcode1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) ;
end
$$;


ALTER FUNCTION sisdp.allfieldsm(gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1185 (class 1255 OID 47549)
-- Name: dashboardpointgeom(integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.dashboardpointgeom(gpcode1 integer) RETURNS SETOF text
    LANGUAGE plpgsql STABLE
    AS $$
begin
 return query 
		select
		ST_ASGEoJSON(loc_geom) FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=
	gpcode1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) ;
	END
$$;


ALTER FUNCTION sisdp.dashboardpointgeom(gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1186 (class 1255 OID 47550)
-- Name: dashboardpointgeom1(character varying, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.dashboardpointgeom1(atrribute character varying, gpcode1 integer) RETURNS SETOF sisdp.alldashboardpointgeom
    LANGUAGE plpgsql STABLE
    AS $$
begin
 CASE 
		WHEN atrribute='ownership' THEN
 				return query select ST_ASGEoJSON(loc_geom),house_own::text FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=gpcode1 
				and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) ;
		WHEN atrribute='bpl card' THEN
				return query select ST_ASGEoJSON(loc_geom),CASE  WHEN bplcard::BOOLEAN=true THEN 'Yes'
								WHEN bplcard::BOOLEAN =false THEN 'No'
								WHEN bplcard::TEXT='' THEN 'Input not provided'
								WHEN bplcard is NULL THEN 'Input not provided'
								else bplcard::TEXT
								END AS bplcard FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=gpcode1 
				and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) ;
		WHEN atrribute='ration card' THEN
				return query select ST_ASGEoJSON(loc_geom),CASE  WHEN rationcard::BOOLEAN=true THEN 'Yes'
								WHEN rationcard::BOOLEAN =false THEN 'No'
								WHEN rationcard::TEXT='' THEN 'Input not provided'
								WHEN rationcard is NULL THEN 'Input not provided'
								else rationcard::TEXT
								END AS rationcard FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=gpcode1 
				and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) ;
	    WHEN atrribute='toilet' THEN
				return query select ST_ASGEoJSON(loc_geom),CASE  WHEN toilet_avail::BOOLEAN=true THEN 'Yes'
								WHEN toilet_avail::BOOLEAN =false THEN 'No'
								WHEN toilet_avail::TEXT='' THEN 'Input not provided'
								WHEN toilet_avail is NULL THEN 'Input not provided'
								else toilet_avail::TEXT
								END AS toilet_avail FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=gpcode1 
				and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) ;
		WHEN atrribute='height' then
			return query select ST_ASGEoJSON(loc_geom),CASE WHEN sm.house_ht::TEXT='' THEN 'Input not provided'
								WHEN sm.house_ht is NULL THEN 'Input not provided'
								WHEN sm.house_ht = 'G' THEN 'Ground Floor'
								WHEN sm.house_ht ='G+1' THEN 'First Floor'
								WHEN sm.house_ht ='G+2' THEN 'Second Floor'
								else sm.house_ht::TEXT
								END AS house_ht FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=gpcode1 
				and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) ;
        WHEN atrribute='monthly expenditure' then
			return query  select ST_ASGEoJSON(loc_geom),'Food' FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and monthly_food=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) 
  						  union select ST_ASGEoJSON(loc_geom),'Education'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_edu=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ))
  						  union select ST_ASGEoJSON(loc_geom),'Transport' FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_tpt=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ))
  						  union select ST_ASGEoJSON(loc_geom),'Health' FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_health=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ))
  						  union select ST_ASGEoJSON(loc_geom),'Leisure'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_leisure=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ))
  						  union select ST_ASGEoJSON(loc_geom),'Rent' FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_rent=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ));
  		WHEN atrribute='qualification' then 
			return query  select ST_ASGEoJSON(loc_geom),qualification::text FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						gpcode1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) group by sm.loc_geom ,fm.qualification;
		WHEN atrribute='occupation' then
  			return query select ST_ASGEoJSON(loc_geom),occupation::text FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						gpcode1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) group by sm.loc_geom ,fm.occupation;
			  END CASE;
	END
$$;


ALTER FUNCTION sisdp.dashboardpointgeom1(atrribute character varying, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1187 (class 1255 OID 47551)
-- Name: dashboardpointgeom2(character varying, character varying, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.dashboardpointgeom2(housetype character varying, atrribute character varying, gpcode1 integer) RETURNS SETOF sisdp.alldashboardpointgeom
    LANGUAGE plpgsql STABLE
    AS $$
declare
queryclause character varying;
begin

CASE
	WHEN housetype='All' THEN
	queryclause='';
	WHEN housetype='Pucca' THEN
	queryclause='and sm.house_type='||quote_literal('Pucca');
	WHEN housetype='Kachcha' THEN
	queryclause='and sm.house_type='||quote_literal('Kachcha');
	WHEN housetype='SemiPucca' THEN
	queryclause='and sm.house_type='||quote_literal('SemiPucca');
	WHEN housetype='Other'THEN
	queryclause='and sm.house_type='||quote_literal('Other');
END CASE;

 CASE 
		WHEN atrribute='ownership' THEN
		return query EXECUTE format('select ST_ASGEoJSON(loc_geom),house_own::text FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=%s 
				and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s',gpcode1,gpcode1,queryclause ) ;		
		WHEN atrribute='bpl card' THEN
			return query EXECUTE format('select ST_ASGEoJSON(loc_geom),CASE  WHEN bplcard::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN bplcard::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN bplcard::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN bplcard is NULL THEN '||quote_literal('Input not provided')||'
								else bplcard::TEXT
								END AS bplcard FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ',gpcode1,gpcode1,queryclause );
		WHEN atrribute='ration card' THEN
			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),CASE  WHEN rationcard::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN rationcard::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN rationcard::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN rationcard is NULL THEN '||quote_literal('Input not provided')||'
								else rationcard::TEXT
								END AS rationcard FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ',gpcode1,gpcode1,queryclause );
		WHEN atrribute='toilet' THEN
			return query  EXECUTE format('select  ST_ASGEoJSON(loc_geom),CASE  WHEN toilet_avail::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN toilet_avail::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN toilet_avail::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN toilet_avail is NULL THEN '||quote_literal('Input not provided')||'
								else toilet_avail::TEXT
								END AS toilet_avail FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ',gpcode1,gpcode1,queryclause );
		WHEN atrribute='height' then
			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom), CASE WHEN sm.house_ht::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN sm.house_ht is NULL THEN '||quote_literal('Input not provided')||'
								WHEN sm.house_ht = '||quote_literal('G')||' THEN '||quote_literal('Ground Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+1')||' THEN '||quote_literal('First Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+2')||' THEN '||quote_literal('Second Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+3')||' THEN '||quote_literal('Third Floor')||'
								WHEN sm.house_ht ='||quote_literal('>G+3')||' THEN '||quote_literal('More than three floors')||'
								else sm.house_ht::TEXT
								END AS house_ht FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s',gpcode1,gpcode1,queryclause );
		--WHEN atrribute='residencesince' then
  			--return query  EXECUTE format('select resi_since::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				--st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s',gpcode1,gpcode1,queryclause );
		WHEN atrribute='residence since' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),t.resi_since  from 
													( select loc_geom,case when X.resi_since between 0 and 10 then '||quote_literal('0 to 10')||'
 																  when  X.resi_since between 11 and 20 then '||quote_literal('10 to 20')||'
    															  when  X.resi_since between 21 and 30 then '||quote_literal('20 to 30')||'
  																  when  X.resi_since > 31 then '||quote_literal('30 and above')||'
  																  when  X.resi_since::text='||quote_literal('')||' then' ||quote_literal('Input not provided')||'
  																  when  X.resi_since is NULL then ' ||quote_literal('Input not provided')||' 
																end as  resi_since from 
											(select loc_geom,case when length(trim(resi_since))= 4 then  2020-resi_since::integer  else resi_since::integer end  as resi_since  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s 
											and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s ) X ) t 
											ORDER BY t.resi_since desc',gpcode1,gpcode1,queryclause );
        WHEN atrribute='land holding area' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),t.land_area::text FROM (select loc_geom,case 
												  when land_area between 0.00 and 0.50 then  '||quote_literal('0.00-0.50')||'
												  when land_area between 0.51 and 1.00 then '||quote_literal('0.51-1.00')||' 
												  when land_area between 1.01 and 1.50 then  '||quote_literal('1.01-1.50')||' 
												  when land_area between 1.51 and 2.00 then '||quote_literal('1.51-2.00')||' 
												  when land_area between 2.01 and 2.50 then  '||quote_literal('2.01-2.50')||'  
												  when land_area between 2.51 and 3.00 then '||quote_literal('2.51-3.00')||' 
												  when land_area::text='||quote_literal('')||' then' ||quote_literal('Input not provided')||'
												  WHEN land_area is NULL then ' ||quote_literal('Input not provided')||' 	
													end as land_area FROM
												  sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s )  t   ',gpcode1,gpcode1,queryclause );
		WHEN atrribute='water supply' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),water_supp::text FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ',gpcode1,gpcode1,queryclause );	
		WHEN atrribute='house condition' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),house_cond::text FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ',gpcode1,gpcode1,queryclause );	
		WHEN atrribute='solid waste collection' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),solid_waste_coll::text FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ',gpcode1,gpcode1,queryclause );	
		WHEN atrribute='vaccination' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),CASE  WHEN vaccination::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN vaccination::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN vaccination::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN vaccination is NULL THEN '||quote_literal('Input not provided')||'
								else vaccination::TEXT
								END AS vaccination FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s',gpcode1,gpcode1,queryclause );	
		WHEN atrribute='monthly expenditure' then
			return query  EXECUTE format(' select ST_ASGEoJSON(loc_geom), '||quote_literal('Food')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and monthly_food=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s 
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Education')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_edu=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Transport')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_tpt=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Health')||' FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_health=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Leisure')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_leisure=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Rent')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_rent=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s',
										 gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause);
  		WHEN atrribute='qualification' then 
			return query  EXECUTE format(' select ST_ASGEoJSON(loc_geom),qualification::text FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ',gpcode1,gpcode1,queryclause);
		WHEN atrribute='all' then 
			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),'||quote_literal('Total Households')||'::text FROM sisdp_hh.hh_survey_master sm where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ',gpcode1,gpcode1,queryclause);
		WHEN atrribute='occupation' then
  			return query EXECUTE format(' select ST_ASGEoJSON(loc_geom),occupation::text FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s',gpcode1,gpcode1,queryclause); 	
	  END CASE;
	END
$$;


ALTER FUNCTION sisdp.dashboardpointgeom2(housetype character varying, atrribute character varying, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1188 (class 1255 OID 47553)
-- Name: dashboardpointgeom3(integer, integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.dashboardpointgeom3(stcode1 integer, dtcode1 integer, bpcode1 integer, housetype character varying, atrribute character varying, gpcode1 integer) RETURNS SETOF sisdp.alldashboardpointgeom
    LANGUAGE plpgsql STABLE
    AS $$
declare
queryclause character varying;
begin

CASE
	WHEN housetype='All' THEN
	queryclause='';
	WHEN housetype='Pucca' THEN
	queryclause='and sm.house_type='||quote_literal('Pucca');
	WHEN housetype='Kachcha' THEN
	queryclause='and sm.house_type='||quote_literal('Kachcha');
	WHEN housetype='SemiPucca' THEN
	queryclause='and sm.house_type='||quote_literal('SemiPucca');
	WHEN housetype='Other'THEN
	queryclause='and sm.house_type='||quote_literal('Other');
END CASE;

 CASE 
 		WHEN atrribute='house types' THEN
		return query EXECUTE format('select ST_ASGEoJSON(loc_geom),house_type::text FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=%s 
				and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s )) %s',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause ) ;
		WHEN atrribute='ownership' THEN
		return query EXECUTE format('select ST_ASGEoJSON(loc_geom),house_own::text FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=%s 
				and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s )) %s',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause ) ;		
		WHEN atrribute='bpl card' THEN
			return query EXECUTE format('select ST_ASGEoJSON(loc_geom),CASE  WHEN bplcard::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN bplcard::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN bplcard::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN bplcard is NULL THEN '||quote_literal('Input not provided')||'
								else bplcard::TEXT
								END AS bplcard FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s ',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='ration card' THEN
			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),CASE  WHEN rationcard::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN rationcard::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN rationcard::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN rationcard is NULL THEN '||quote_literal('Input not provided')||'
								else rationcard::TEXT
								END AS rationcard FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s ',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='toilet' THEN
			return query  EXECUTE format('select  ST_ASGEoJSON(loc_geom),CASE  WHEN toilet_avail::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN toilet_avail::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN toilet_avail::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN toilet_avail is NULL THEN '||quote_literal('Input not provided')||'
								else toilet_avail::TEXT
								END AS toilet_avail FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s ',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='height' then
			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom), CASE WHEN sm.house_ht::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN sm.house_ht is NULL THEN '||quote_literal('Input not provided')||'
								WHEN sm.house_ht = '||quote_literal('G')||' THEN '||quote_literal('Ground Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+1')||' THEN '||quote_literal('First Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+2')||' THEN '||quote_literal('Second Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+3')||' THEN '||quote_literal('Third Floor')||'
								WHEN sm.house_ht ='||quote_literal('>G+3')||' THEN '||quote_literal('More than three floors')||'
								else sm.house_ht::TEXT
								END AS house_ht FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		--WHEN atrribute='residencesince' then
  			--return query  EXECUTE format('select resi_since::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				--st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s',gpcode1,gpcode1,queryclause );
		WHEN atrribute='residence since' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),t.resi_since  from 
													( select loc_geom,case when X.resi_since between 0 and 10 then '||quote_literal('0 to 10')||'
 																  when  X.resi_since between 11 and 20 then '||quote_literal('10 to 20')||'
    															  when  X.resi_since between 21 and 30 then '||quote_literal('20 to 30')||'
  																  when  X.resi_since > 30 then '||quote_literal('31 years and above')||'
  																  when  X.resi_since::text='||quote_literal('')||' then' ||quote_literal('Input not provided')||'
  																  when  X.resi_since is NULL then ' ||quote_literal('Input not provided')||' 
																end as  resi_since from 
											(select loc_geom,case when length(trim(resi_since))= 4 then  2020-resi_since::integer  else resi_since::integer end  as resi_since  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s 
											and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s ) X ) t 
											ORDER BY t.resi_since desc',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
        WHEN atrribute='land holding area' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),t.land_area::text FROM (select loc_geom,case 
												  when land_area between 0.00 and 0.50 then  '||quote_literal('0.00-0.50')||'
												  when land_area between 0.51 and 1.00 then '||quote_literal('0.51-1.00')||' 
												  when land_area between 1.01 and 1.50 then  '||quote_literal('1.01-1.50')||' 
												  when land_area between 1.51 and 2.00 then '||quote_literal('1.51-2.00')||' 
												  when land_area between 2.01 and 2.50 then  '||quote_literal('2.01-2.50')||'  
												  when land_area between 2.51 and 3.00 then '||quote_literal('2.51-3.00')||' 
												  when land_area::text='||quote_literal('')||' then' ||quote_literal('Input not provided')||'
												  WHEN land_area is NULL then ' ||quote_literal('Input not provided')||' 	
													end as land_area FROM
												  sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s )) %s )
										 t   ',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='water supply' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),water_supp::text FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s ',
										 gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );	
		WHEN atrribute='house condition' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),house_cond::text FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s ',
										 gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );	
		WHEN atrribute='solid waste collection' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),solid_waste_coll::text FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s ',
										 gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );	
		WHEN atrribute='vaccination' then
  			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),CASE  WHEN vaccination::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN vaccination::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN vaccination::TEXT='||quote_literal('')||' THEN '||quote_literal('Input not provided')||'
								WHEN vaccination is NULL THEN '||quote_literal('Input not provided')||'
								else vaccination::TEXT
								END AS vaccination FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s',
										 gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );	
		WHEN atrribute='monthly expenditure' then
			return query  EXECUTE format(' select ST_ASGEoJSON(loc_geom), '||quote_literal('Food')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and monthly_food=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s 
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Education')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_edu=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Transport')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_tpt=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Health')||' FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_health=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Leisure')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_leisure=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s
  						  union select ST_ASGEoJSON(loc_geom), '||quote_literal('Rent')||'  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_rent=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s',
										 gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause,gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause,gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause,gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause,gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause,gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause);
  		WHEN atrribute='qualification' then 
			return query  EXECUTE format(' select ST_ASGEoJSON(loc_geom),qualification::text FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s)) %s ',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause);
		WHEN atrribute='all' then 
			return query  EXECUTE format('select ST_ASGEoJSON(loc_geom),'||quote_literal('Total Households')||'::text FROM sisdp_hh.hh_survey_master sm where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s )) %s ',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause);
		WHEN atrribute='occupation' then
  			return query EXECUTE format(' select ST_ASGEoJSON(loc_geom),occupation::text FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and stcode=%s  and dtcode=%s and bpcode=%s )) %s',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause); 	
	  END CASE;
	END
$$;


ALTER FUNCTION sisdp.dashboardpointgeom3(stcode1 integer, dtcode1 integer, bpcode1 integer, housetype character varying, atrribute character varying, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1189 (class 1255 OID 47555)
-- Name: dashboardvalues(character varying, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.dashboardvalues(atrribute character varying, gpcode1 integer) RETURNS SETOF sisdp.alldashboardvalues
    LANGUAGE plpgsql STABLE
    AS $$
begin
 CASE 
		WHEN atrribute='ownership' THEN
			return query select house_own::text,count(*) FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) group by house_own;
		WHEN atrribute='bpl card' THEN
			return query select CASE  WHEN bplcard::BOOLEAN=true THEN 'Yes'
								WHEN bplcard::BOOLEAN =false THEN 'No'
								WHEN bplcard::TEXT='' THEN 'Input not provided'
								WHEN bplcard is NULL THEN 'Input not provided'
								else bplcard::TEXT
								END AS bplcard,count(*) FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) group by bplcard;
		WHEN atrribute='ration card' THEN
			return query select CASE  WHEN rationcard::BOOLEAN=true THEN 'Yes'
								WHEN rationcard::BOOLEAN =false THEN 'No'
								WHEN rationcard::TEXT='' THEN 'Input not provided'
								WHEN rationcard is NULL THEN 'Input not provided'
								else rationcard::TEXT
								END AS rationcard,count(*) FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) group by rationcard;
		WHEN atrribute='toilet' THEN
			return query select CASE  WHEN toilet_avail::BOOLEAN=true THEN 'Yes'
								WHEN toilet_avail::BOOLEAN =false THEN 'No'
								WHEN toilet_avail::TEXT='' THEN 'Input not provided'
								WHEN toilet_avail is NULL THEN 'Input not provided'
								else toilet_avail::TEXT
								END AS toilet_avail,count(*) FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) group by toilet_avail;
		WHEN atrribute='height' then
			return query select 	CASE WHEN sm.house_ht::TEXT='' THEN 'Input not provided'
								WHEN sm.house_ht is NULL THEN 'Input not provided'
								WHEN sm.house_ht = 'G' THEN 'Ground Floor'
								WHEN sm.house_ht ='G+1' THEN 'First Floor'
								WHEN sm.house_ht ='G+2' THEN 'Second Floor'
								else sm.house_ht::TEXT
								END AS house_ht,count(*) FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) group by house_ht;
        WHEN atrribute='monthly expenditure' then
			return query  select 'Food',count(*)  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and monthly_food=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) 
  						  union select 'Education',count(*)  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_edu=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ))
  						  union select 'Transport',count(*)  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_tpt=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ))
  						  union select 'Health',count(*)  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_health=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ))
  						  union select 'Leisure',count(*)  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_leisure=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ))
  						  union select 'Rent',count(*)  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=gpcode1 and  monthly_rent=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 ));
  		WHEN atrribute='qualification' then 
			return query  select qualification::text,count(*) FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						gpcode1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) group by qualification;
		WHEN atrribute='occupation' then
  			return query select occupation::text,count(*) FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						gpcode1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 )) group by occupation;
	
	  END CASE;
	END
$$;


ALTER FUNCTION sisdp.dashboardvalues(atrribute character varying, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1190 (class 1255 OID 47556)
-- Name: dashboardvalues1(character varying, character varying, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.dashboardvalues1(housetype character varying, atrribute character varying, gpcode1 integer) RETURNS SETOF sisdp.alldashboardvalues
    LANGUAGE plpgsql STABLE
    AS $$
declare
queryclause character varying;
begin

CASE
	WHEN housetype='All' THEN
	queryclause='';
	WHEN housetype='Pucca' THEN
	queryclause='and sm.house_type='||quote_literal('Pucca');
	WHEN housetype='Kachcha' THEN
	queryclause='and sm.house_type='||quote_literal('Kachcha');
	WHEN housetype='SemiPucca' THEN
	queryclause='and sm.house_type='||quote_literal('SemiPucca');
	WHEN housetype='Other'THEN
	queryclause='and sm.house_type='||quote_literal('Other');
END CASE;

 CASE 
 		
		WHEN atrribute='house types' THEN
			return query EXECUTE format('select house_type::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s group by house_type order by house_type desc',gpcode1,gpcode1,queryclause );
		WHEN atrribute='ownership' THEN
			return query EXECUTE format('select house_own::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s group by house_own order by house_own desc',gpcode1,gpcode1,queryclause );
		WHEN atrribute='bpl card' THEN
			return query EXECUTE format('select CASE  WHEN bplcard::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN bplcard::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN bplcard::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN bplcard is NULL THEN '||quote_literal('Data not available')||'
								else bplcard::TEXT
								END AS bplcard,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s group by bplcard order by bplcard desc',gpcode1,gpcode1,queryclause );
		WHEN atrribute='ration card' THEN
			return query  EXECUTE format('select CASE  WHEN rationcard::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN rationcard::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN rationcard::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN rationcard is NULL THEN '||quote_literal('Data not available')||'
								else rationcard::TEXT
								END AS rationcard,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s group by rationcard order by rationcard desc',gpcode1,gpcode1,queryclause );
		WHEN atrribute='toilet' THEN
			return query  EXECUTE format('select  CASE  WHEN toilet_avail::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN toilet_avail::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN toilet_avail::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN toilet_avail is NULL THEN '||quote_literal('Data not available')||'
								else toilet_avail::TEXT
								END AS toilet_avail,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s group by toilet_avail order by toilet_avail desc',gpcode1,gpcode1,queryclause );
		WHEN atrribute='height' then
			return query  EXECUTE format('select CASE WHEN sm.house_ht::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN sm.house_ht is NULL THEN '||quote_literal('Data not available')||'
								WHEN sm.house_ht = '||quote_literal('G')||' THEN '||quote_literal('Ground Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+1')||' THEN '||quote_literal('First Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+2')||' THEN '||quote_literal('Second Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+3')||' THEN '||quote_literal('Third Floor')||'
								WHEN sm.house_ht ='||quote_literal('>G+3')||' THEN '||quote_literal('More than three floors')||'
								else sm.house_ht::TEXT
								END AS house_ht,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s group by house_ht order by Count(*) desc',gpcode1,gpcode1,queryclause );
		WHEN atrribute='residence since' then
  			return query  EXECUTE format('select t.resi_since ,count(*)::bigint from 
													( select case when X.resi_since between 0 and 10 then '||quote_literal('0 to 10 years')||'
 																  when  X.resi_since between 11 and 20 then '||quote_literal('11 to 20 years')||'
    															  when  X.resi_since between 21 and 30 then '||quote_literal('21 to 30 years')||'
  																  when  X.resi_since > 30 then '||quote_literal('31 years and above')||'
  																  when  X.resi_since::text='||quote_literal('')||' then' ||quote_literal('Data not available')||'
  																  when  X.resi_since is NULL then ' ||quote_literal('Data not available')||' 
																end as  resi_since from 
											(select case when length(trim(resi_since))= 4 then  date_part('||quote_literal('year')||', CURRENT_DATE) -resi_since::integer  else resi_since::integer end  as resi_since  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s 
											and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s ) X ) t group by t.resi_since 
											ORDER BY t.resi_since ASC',gpcode1,gpcode1,queryclause );
        WHEN atrribute='land holding area' then
  			return query  EXECUTE format('select t.land_area::text,count(*)::bigint FROM (select case 
												  when land_area between 0.00 and 0.50 then  '||quote_literal('0.00-0.50 hectare')||'
												  when land_area between 0.51 and 1.00 then '||quote_literal('0.51-1.00 hectare')||' 
												  when land_area between 1.01 and 1.50 then  '||quote_literal('1.01-1.50 hectare')||' 
												  when land_area between 1.51 and 2.00 then '||quote_literal('1.51-2.00 hectare')||' 
												  when land_area between 2.01 and 2.50 then  '||quote_literal('2.01-2.50 hectare')||'  
												  when land_area between 2.51 and 3.00 then '||quote_literal('2.51-3.00 hectare')||' 
												  when land_area::text='||quote_literal('')||' then' ||quote_literal('Data not available')||'
												  WHEN land_area is NULL then ' ||quote_literal('Data not available')||' 	
													end as land_area FROM
												  sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ) t group by t.land_area ',gpcode1,gpcode1,queryclause );
		WHEN atrribute='water supply' then
  			return query  EXECUTE format('select  CASE WHEN water_supp::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN water_supp is NULL THEN '||quote_literal('Data not available')||'
								when water_supp::TEXT='||quote_literal('null')||' THEN '||quote_literal('Data not available')||'		 
								else water_supp::TEXT
								END AS water_supp,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s group by water_supp',gpcode1,gpcode1,queryclause );	
		WHEN atrribute='house condition' then
  			return query  EXECUTE format('select house_cond::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s group by house_cond order by house_cond desc',gpcode1,gpcode1,queryclause );	
		WHEN atrribute='solid waste collection' then
  			return query  EXECUTE format('select CASE WHEN solid_waste_coll::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN solid_waste_coll is NULL THEN '||quote_literal('Data not available')||'
								else solid_waste_coll::TEXT
								END AS solid_waste_coll,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s ))
										 %s group by solid_waste_coll order by solid_waste_coll desc',gpcode1,gpcode1,queryclause );	
		WHEN atrribute='vaccination' then
  			return query  EXECUTE format('select CASE  WHEN vaccination::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN vaccination::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN vaccination::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN vaccination is NULL THEN '||quote_literal('Data not available')||'
								else vaccination::TEXT
								END AS vaccination,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s group by vaccination order by vaccination desc',gpcode1,gpcode1,queryclause );	
		WHEN atrribute='monthly expenditure' then
			return query  EXECUTE format(' select '||quote_literal('Food')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and monthly_food=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s 
  						  union select '||quote_literal('Education')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_edu=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s
  						  union select '||quote_literal('Transport')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_tpt=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s
  						  union select '||quote_literal('Health')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_health=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s
  						  union select '||quote_literal('Leisure')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_leisure=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s
  						  union select '||quote_literal('Rent')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_rent=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s)) %s',gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause,gpcode1,gpcode1,queryclause);
  		WHEN atrribute='all' then 
			return query  EXECUTE format('select '||quote_literal('Total Households')||'::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s ',gpcode1,gpcode1,queryclause);
		WHEN atrribute='qualification' then 
			return query  EXECUTE format(' select qualification::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s group by qualification order by qualification desc',gpcode1,gpcode1,queryclause);
		WHEN atrribute='occupation' then
  			return query EXECUTE format(' select CASE WHEN occupation::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
									WHEN occupation is NULL THEN '||quote_literal('Data not available')||'
								else occupation::TEXT
								END AS occupation,count(*)::bigint FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s )) %s group by occupation order by occupation desc',gpcode1,gpcode1,queryclause); 	
	  END CASE;
	END
$$;


ALTER FUNCTION sisdp.dashboardvalues1(housetype character varying, atrribute character varying, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1191 (class 1255 OID 47558)
-- Name: dashboardvalues2(integer, integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.dashboardvalues2(stcode1 integer, dtcode1 integer, bpcode1 integer, housetype character varying, atrribute character varying, gpcode1 integer) RETURNS SETOF sisdp.alldashboardvalues
    LANGUAGE plpgsql STABLE
    AS $$
declare
queryclause character varying;
begin

CASE
	WHEN housetype='All' THEN
	queryclause='';
	WHEN housetype='Pucca' THEN
	queryclause='and sm.house_type='||quote_literal('Pucca');
	WHEN housetype='Kachcha' THEN
	queryclause='and sm.house_type='||quote_literal('Kachcha');
	WHEN housetype='SemiPucca' THEN
	queryclause='and sm.house_type='||quote_literal('SemiPucca');
	WHEN housetype='Other'THEN
	queryclause='and sm.house_type='||quote_literal('Other');
END CASE;

 CASE 	
 		WHEN atrribute='house types' THEN
			return query EXECUTE format('select house_type::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s group by house_type order by  CASE 
										WHEN house_type ='||quote_literal('')||' THEN 1
										 WHEN house_type is null THEN 2 ELSE 0
										 END, house_type ASC',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='ownership' THEN
			return query EXECUTE format('select house_own::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s group by house_own order by house_own desc',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='bpl card' THEN
			return query EXECUTE format('select CASE  WHEN bplcard::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN bplcard::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN bplcard::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN bplcard is NULL THEN '||quote_literal('Data not available')||'
								else bplcard::TEXT
								END AS bplcard,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s )) %s group by bplcard order by bplcard desc',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='ration card' THEN
			return query  EXECUTE format('select CASE  WHEN rationcard::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN rationcard::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN rationcard::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN rationcard is NULL THEN '||quote_literal('Data not available')||'
								else rationcard::TEXT
								END AS rationcard,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s )) %s group by rationcard order by rationcard desc',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='toilet' THEN
			return query  EXECUTE format('select  CASE  WHEN toilet_avail::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN toilet_avail::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN toilet_avail::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN toilet_avail is NULL THEN '||quote_literal('Data not available')||'
								else toilet_avail::TEXT
								END AS toilet_avail,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s group by toilet_avail order by toilet_avail desc',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='height' then
			return query  EXECUTE format('select CASE WHEN sm.house_ht::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN sm.house_ht is NULL THEN '||quote_literal('Data not available')||'
								WHEN sm.house_ht = '||quote_literal('G')||' THEN '||quote_literal('Ground Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+1')||' THEN '||quote_literal('First Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+2')||' THEN '||quote_literal('Second Floor')||'
								WHEN sm.house_ht ='||quote_literal('G+3')||' THEN '||quote_literal('Third Floor')||'
								WHEN sm.house_ht ='||quote_literal('>G+3')||' THEN '||quote_literal('More than three floors')||'
								else sm.house_ht::TEXT
								END AS house_ht,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s group by house_ht 
										 ORDER BY CASE WHEN house_ht ='||quote_literal('')||' THEN 1
										 WHEN house_ht is null THEN 2 ELSE 0
										 END, count desc',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='residence since' then
  			return query  EXECUTE format('select t.resi_since ,count(*)::bigint from 
													( select case when X.resi_since between 0 and 10 then '||quote_literal('0 to 10 years')||'
 																  when  X.resi_since between 11 and 20 then '||quote_literal('11 to 20 years')||'
    															  when  X.resi_since between 21 and 30 then '||quote_literal('21 to 30 years')||'
  																  when  X.resi_since > 30 then '||quote_literal('31 years and above')||'
  																  when  X.resi_since::text='||quote_literal('')||' then' ||quote_literal('Data not available')||'
  																  when  X.resi_since is NULL then ' ||quote_literal('Data not available')||' 
																end as  resi_since from 
											(select case when length(trim(resi_since))= 4 then  date_part('||quote_literal('year')||', CURRENT_DATE) -resi_since::integer  else resi_since::integer end  as resi_since  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s 
											and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s ) X ) t group by t.resi_since 
											ORDER BY t.resi_since ASC',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
        WHEN atrribute='land holding area' then
  			return query  EXECUTE format('select t.land_area::text,count(*)::bigint FROM (select case 
												  when land_area between 0.00 and 0.50 then  '||quote_literal('0.00-0.50 hectare')||'
												  when land_area between 0.51 and 1.00 then '||quote_literal('0.51-1.00 hectare')||' 
												  when land_area between 1.01 and 1.50 then  '||quote_literal('1.01-1.50 hectare')||' 
												  when land_area between 1.51 and 2.00 then '||quote_literal('1.51-2.00 hectare')||' 
												  when land_area between 2.01 and 2.50 then  '||quote_literal('2.01-2.50 hectare')||'  
												  when land_area between 2.51 and 3.00 then '||quote_literal('2.51-3.00 hectare')||' 
												  when land_area::text='||quote_literal('')||' then' ||quote_literal('Data not available')||'
												  WHEN land_area is NULL then ' ||quote_literal('Data not available')||' 	
													end as land_area FROM
												  sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s )) %s ) t group by t.land_area ',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );
		WHEN atrribute='water supply' then
  			return query  EXECUTE format('select  CASE WHEN water_supp::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN water_supp is NULL THEN '||quote_literal('Data not available')||'
								when water_supp::TEXT='||quote_literal('null')||' THEN '||quote_literal('Data not available')||'		 
								else water_supp::TEXT
								END AS water_supp,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s group by water_supp 
										 ORDER BY CASE WHEN water_supp ='||quote_literal('NotAvailable')||' THEN 1
										 WHEN water_supp ='||quote_literal('')||' THEN 2
										 WHEN water_supp is null THEN 3 
										  WHEN water_supp::TEXT='||quote_literal('null')||' THEN 4 									
										 ELSE 0
										 END,water_supp ASC ',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );	
		WHEN atrribute='house condition' then
  			return query  EXECUTE format('select house_cond::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s group by house_cond order by house_cond desc',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );	
		WHEN atrribute='solid waste collection' then
  			return query  EXECUTE format('select CASE WHEN solid_waste_coll::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN solid_waste_coll is NULL THEN '||quote_literal('Data not available')||'
								else solid_waste_coll::TEXT
								END AS solid_waste_coll,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
							st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s ))
										 %s group by solid_waste_coll ORDER BY CASE WHEN solid_waste_coll ='||quote_literal('NotAvailable')||' THEN 1
										 WHEN solid_waste_coll ='||quote_literal('')||' THEN 2
										 WHEN solid_waste_coll is null THEN 3 
										  WHEN solid_waste_coll::TEXT='||quote_literal('null')||' THEN 4 									
										 ELSE 0
										 END',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );	
		WHEN atrribute='vaccination' then
  			return query  EXECUTE format('select CASE  WHEN vaccination::BOOLEAN=true THEN '||quote_literal('Yes')||'
								WHEN vaccination::BOOLEAN =false THEN '||quote_literal('No')||'
								WHEN vaccination::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
								WHEN vaccination is NULL THEN '||quote_literal('Data not available')||'
								else vaccination::TEXT
								END AS vaccination,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and 
				st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s  and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s group by vaccination order by vaccination desc',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause );	
		WHEN atrribute='monthly expenditure' then
			return query  EXECUTE format(' select '||quote_literal('Food')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s 
		 and monthly_food=1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s 
  		union select '||quote_literal('Education')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_edu=1 
		and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s
  		union select '||quote_literal('Transport')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_tpt=1 
		and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s
  		union select '||quote_literal('Health')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_health=1 
		and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s
  		union select '||quote_literal('Leisure')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_leisure=1 
		and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s
  		union select '||quote_literal('Rent')||',count(*)::bigint  FROM sisdp_hh.hh_survey_master sm where sm.gp_code=%s and  monthly_rent=1 
		and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s order by count desc',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause,gpcode1,gpcode1,stcode1,dtcode1,
										 bpcode1,queryclause,gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause,gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause,
										 gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause,gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause);
  		WHEN atrribute='all' then 
			return query  EXECUTE format('select '||quote_literal('Total Households')||'::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s ',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause);
		WHEN atrribute='qualification' then 
			return query  EXECUTE format(' select qualification::text,count(*)::bigint FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s )) %s group by qualification order by CASE WHEN 
										 qualification ='||quote_literal('')||' THEN 1
										 WHEN qualification is null THEN 2 ELSE 0
										 END, qualification ASC',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause);
		WHEN atrribute='occupation' then
  			return query EXECUTE format(' select CASE WHEN occupation::TEXT='||quote_literal('')||' THEN '||quote_literal('Data not available')||'
									WHEN occupation is NULL THEN '||quote_literal('Data not available')||'
								else occupation::TEXT
								END AS occupation,count(*)::bigint FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
						%s and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=%s and 
										stcode=%s  and dtcode=%s and bpcode=%s)) %s group by occupation  
										ORDER BY CASE WHEN occupation ='||quote_literal('')||' THEN 1
										 WHEN occupation is null THEN 2 ELSE 0
										 END, occupation ASC',gpcode1,gpcode1,stcode1,dtcode1,bpcode1,queryclause); 	
	  END CASE;
	END
$$;


ALTER FUNCTION sisdp.dashboardvalues2(stcode1 integer, dtcode1 integer, bpcode1 integer, housetype character varying, atrribute character varying, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1192 (class 1255 OID 47560)
-- Name: downloadallfamily(integer, integer, integer, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.downloadallfamily(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer) RETURNS SETOF sisdp.familytype1
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
RETURN QUERY SELECT b.id,b.hh_code,
    b.member_name,
    b.age,
    b.sex,
	b.relationship,
    b.maritalstatus,
    b.qualification,
    b.digital_literacy,
    b.occupation,
    b.occ_location,
    b.mode_transport,
    b.occ_change,
    b.occ_prev,
    b.occ_change_since,
    b.occ_change_reason,
    b.occ_type,
    b.occ_mode_travel,
    b.agri_num_pers,
    b.agri_own,
    b.agri_area,
    b.agri_soil_type,
    b.agri_crop_type,
    b.agri_crop_freq,
    b.agri_crop_change,
    b.agri_crop_produce,
    b.agri_seed_avail,
    b.agri_store_loc,
    b.agri_sell_loc,
    b.agri_irr_source,
    b.agri_irr_sch,
    b.lab_marginal,
    b.lab_wage,
    b.serv_salary,
    b.migrant,
    b.business_income,
    b.service_salary,
    b.occ_remarks,  
    b.mobile,
    b.agri_crop_chng_det  FROM sisdp_hh.hh_survey_master, sisdp_hh.hh_family_member 
	as b where st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 and stcode=stcode1  and dtcode=dtcode1 and bpcode=bpcode1 )) and sisdp_hh.hh_survey_master.hh_code = b.hh_code and sisdp_hh.hh_survey_master.gp_code= gpcode1 order by id;
END

$$;


ALTER FUNCTION sisdp.downloadallfamily(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1193 (class 1255 OID 47561)
-- Name: downloadallmaster(integer, integer, integer, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.downloadallmaster(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer) RETURNS SETOF sisdp.mastertype1
    LANGUAGE plpgsql STABLE
    AS $$

begin

	RETURN QUERY SELECT gp_code,
hh_code,
resp_name,
religion,
caste,
address,
landmark, 
(select stname::character varying from sisdp_hh.hh_gp_list where stcode=stcode1 limit 1) as statecode,
(select dtname::character varying from sisdp_hh.hh_gp_list where dtcode=dtcode1 limit 1) as distcode,
(select bpname::character varying from sisdp_hh.hh_gp_list where bpcode=bpcode1 limit 1) as blkcode,
(select gpname::character varying from sisdp_hh.hh_gp_list where gpcode=gpcode1 limit 1) as villcode,
resi_since,
house_own,
house_rent,
bplcard,
rationcard,
fam_members,
land_khasra,
land_area,
land_since,
land_cultiv,
land_fallow,
house_type,
house_roof,
house_wall,
house_ht,
house_sch,
house_age,
house_cond,
water_supp,
water_supp_dur,
solid_waste_coll,
elec_supp,
elec_supp_dur,
elec_use,
transportation,
toilet_avail,
toilet_type,
toilet_use,
toilet_sch,
toilet_amt,
monthly_food,
monthly_edu,
monthly_tpt,
monthly_health,
monthly_rent,
monthly_leisure,
monthly_exp,
monthly_int,
monthly_int_amt,
monthly_int_since,
vaccination,
disease,
hosp_visit,
hosp_near,
hosp_fees,
hosp_travel,
cow_buffalo,
ox,
goat,
chicken,
horse,
donkey,
other_livestock,
radio,
telephone,
solar,
tv,
computer,
stove,
lpg,
kerosene,
firewood,
biogass,
cowdung,
energy_oth,
energy_sch,
voc_trng_cntr,
issues,
expectations,
suggestions,
last_updated_by,
last_updated_on,
obs_date,
surveyor_name,
surveyor_id,
disease_det,
anyremarks,
surveyor_mobile,
cow_livestock_num,
cow_livestock_disease,
cow_commercial_use,
ox_livestock_num,
ox_livestock_disease,
ox_commercial_use,
goat_livestock_num,
goat_livestock_disease,
goat_commercial_use,
chicken_livestock_num,
chicken_livestock_disease,
chicken_commercial_use,
horse_livestock_num,
horse_livestock_disease,
horse_commercial_use,
donkey_livestock_num,
donkey_livestock_disease,
donkey_commercial_use,
other_livestock_num,
other_livestock_disease,
other_commercial_use,
latitude,
accuracy,
longitude,
land_holding
 FROM sisdp_hh.hh_survey_master where 
	st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 and 
	stcode=stcode1  and dtcode=dtcode1 and bpcode=bpcode1 )) and  sisdp_hh.hh_survey_master.gp_code=gpcode1 order by id;
end

$$;


ALTER FUNCTION sisdp.downloadallmaster(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1194 (class 1255 OID 47562)
-- Name: downloadcsv1(integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.downloadcsv1(gpcode1 integer) RETURNS SETOF sisdp.familytype
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
RETURN QUERY SELECT b.id,b.hh_code,
    b.member_name,
    b.age,
    b.sex,
    b.maritalstatus,
    b.qualification,
    b.digital_literacy,
    b.occupation,
    b.occupation_id,
    b.occ_location,
    b.mode_transport,
    b.occ_change ,
    b.occ_prev,
    b.occ_change_since,
    b.occ_change_reason,
    b.last_updated_by,
    b.last_updated_on,
    b.occ_type,
    b.occ_mode_travel,
    b.agri_num_pers,
    b.agri_own,
    b.agri_area,
    b.agri_soil_type,
    b.agri_crop_type,
    b.agri_crop_freq,
    b.agri_crop_change,
    b.agri_crop_produce,
    b.agri_seed_avail,
    b.agri_store_loc,
    b.agri_sell_loc,
    b.agri_irr_source,
    b.agri_irr_sch,
    b.lab_marginal,
    b.lab_wage,
    b.serv_salary,
    b.migrant,
    b.business_income,
    b.service_salary,
    b.occ_remarks ,
    b.relationship,
    b.mobile,
    b.agri_crop_chng_det  FROM sisdp_hh.hh_survey_master, sisdp_hh.hh_family_member as b where sisdp_hh.hh_survey_master.hh_code = b.hh_code and sisdp_hh.hh_survey_master.gp_code= gpcode1;
END

$$;


ALTER FUNCTION sisdp.downloadcsv1(gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1195 (class 1255 OID 47563)
-- Name: downloadcsv2(integer, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.downloadcsv2(gpcode1 integer, value1 timestamp without time zone, value2 timestamp without time zone) RETURNS SETOF sisdp.familytype
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN

	RETURN QUERY SELECT b.id,b.hh_code,
    b.member_name,
    b.age,
    b.sex,
    b.maritalstatus,
    b.qualification,
    b.digital_literacy,
    b.occupation,
    b.occupation_id,
    b.occ_location,
    b.mode_transport,
    b.occ_change ,
    b.occ_prev,
    b.occ_change_since,
    b.occ_change_reason,
    b.last_updated_by,
    b.last_updated_on,
    b.occ_type,
    b.occ_mode_travel,
    b.agri_num_pers,
    b.agri_own,
    b.agri_area,
    b.agri_soil_type,
    b.agri_crop_type,
    b.agri_crop_freq,
    b.agri_crop_change,
    b.agri_crop_produce,
    b.agri_seed_avail,
    b.agri_store_loc,
    b.agri_sell_loc,
    b.agri_irr_source,
    b.agri_irr_sch,
    b.lab_marginal,
    b.lab_wage,
    b.serv_salary,
    b.migrant,
    b.business_income,
    b.service_salary,
    b.occ_remarks ,
    b.relationship,
    b.mobile,
    b.agri_crop_chng_det FROM sisdp_hh.hh_survey_master, sisdp_hh.hh_family_member as b where sisdp_hh.hh_survey_master.hh_code = b.hh_code and sisdp_hh.hh_survey_master.gp_code= gpcode1 and 
  sisdp_hh.hh_survey_master.last_updated_on between value1 and value2;
  
  
  END

$$;


ALTER FUNCTION sisdp.downloadcsv2(gpcode1 integer, value1 timestamp without time zone, value2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 1196 (class 1255 OID 47564)
-- Name: downloadcsv3(integer, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.downloadcsv3(gpcode1 integer, value1 timestamp without time zone, value2 timestamp without time zone) RETURNS SETOF sisdp.mastertype
    LANGUAGE plpgsql STABLE
    AS $$

begin
	RETURN QUERY SELECT id,
	hh_code,
	resp_name,
	religion,
	caste,
	address,
	landmark,
	statecode,
	distcode,
	blkcode,
	villcode,
	resi_since,
	house_own,
	house_rent,
	bplcard,
	rationcard,
	fam_members,
	land_khasra,
	land_area,
	land_since,
	land_cultiv,
	land_fallow,
	house_type,
	house_roof,
	house_wall,
	house_ht,
	house_sch,
	house_age,
	house_cond,
	water_supp,
	water_supp_dur,
	solid_waste_coll,
	elec_supp,
	elec_supp_dur,
	elec_use,
	transportation,
	toilet_avail,
	toilet_type,
	toilet_use,
	toilet_sch,
	toilet_amt,
	monthly_food,
	monthly_edu,
	monthly_tpt,
	monthly_health,
	monthly_rent,
	monthly_leisure,
	monthly_exp,
	monthly_int,
	monthly_int_amt,
	monthly_int_since,
	vaccination,
	disease,
	hosp_visit,
	hosp_near,
	hosp_fees,
	hosp_travel,
	cow_buffalo,
	ox,
	goat,
	chicken,
	horse,
	donkey,
	other_livestock,
	radio,
	telephone,
	solar,
	tv,
	computer,
	stove,
	lpg,
	kerosene,
	firewood,
	biogass,
	cowdung,
	energy_oth,
	energy_sch,
	voc_trng_cntr,
	issues,
	expectations,
	suggestions,
	loc_geom,
	loc_geom1,
	loc_geom2,
	accuracy1,
	accuracy2,	
	last_updated_by,
	last_updated_on,
	obs_date,
	surveyor_name,
	surveyor_id,
	disease_det,
	anyremarks,
	surveyor_mobile,
	cow_livestock_num,
	cow_livestock_disease,
	cow_commercial_use,
	ox_livestock_num,
	ox_livestock_disease,
	ox_commercial_use,
	goat_livestock_num,
	goat_livestock_disease,
	goat_commercial_use,
	chicken_livestock_num,
	chicken_livestock_disease,
	chicken_commercial_use,
	horse_livestock_num,
	horse_livestock_disease,
	horse_commercial_use,
	donkey_livestock_num,
	donkey_livestock_disease,
	donkey_commercial_use,
	other_livestock_num,
	other_livestock_disease,
	other_commercial_use,
	latitude,
	accuracy,
	latitude1,
	latitude2,
	longitude,
	longitude1,
	longitude2,
	gp_code,
	land_holding,
	num_img 
 FROM sisdp_hh.hh_survey_master where sisdp_hh.hh_survey_master.gp_code=gpcode1 and 
	sisdp_hh.hh_survey_master.last_updated_on between value1 and value2;
end

$$;


ALTER FUNCTION sisdp.downloadcsv3(gpcode1 integer, value1 timestamp without time zone, value2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 1197 (class 1255 OID 47565)
-- Name: downloadfamilyrange(integer, integer, integer, integer, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.downloadfamilyrange(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer, value1 timestamp without time zone, value2 timestamp without time zone) RETURNS SETOF sisdp.familytype1
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN

	RETURN QUERY SELECT b.id,b.hh_code,
    b.member_name,
    b.age,
    b.sex,
	b.relationship,
    b.maritalstatus,
    b.qualification,
    b.digital_literacy,
    b.occupation,
    b.occ_location,
    b.mode_transport,
    b.occ_change ,
    b.occ_prev,
    b.occ_change_since,
    b.occ_change_reason,
    b.occ_type,
    b.occ_mode_travel,
    b.agri_num_pers,
    b.agri_own,
    b.agri_area,
    b.agri_soil_type,
    b.agri_crop_type,
    b.agri_crop_freq,
    b.agri_crop_change,
    b.agri_crop_produce,
    b.agri_seed_avail,
    b.agri_store_loc,
    b.agri_sell_loc,
    b.agri_irr_source,
    b.agri_irr_sch,
    b.lab_marginal,
    b.lab_wage,
    b.serv_salary,
    b.migrant,
    b.business_income,
    b.service_salary,
    b.occ_remarks,  
    b.mobile,
    b.agri_crop_chng_det FROM sisdp_hh.hh_survey_master, sisdp_hh.hh_family_member as b where 
	st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 and 
	stcode=stcode1  and dtcode=dtcode1 and bpcode=bpcode1 )) and sisdp_hh.hh_survey_master.hh_code = b.hh_code and 
	sisdp_hh.hh_survey_master.gp_code= gpcode1 and sisdp_hh.hh_survey_master.last_updated_on between value1 and value2 order by id;
  
  
  END

$$;


ALTER FUNCTION sisdp.downloadfamilyrange(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer, value1 timestamp without time zone, value2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 1198 (class 1255 OID 47566)
-- Name: downloadmasterrange(integer, integer, integer, integer, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.downloadmasterrange(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer, value1 timestamp without time zone, value2 timestamp without time zone) RETURNS SETOF sisdp.mastertype1
    LANGUAGE plpgsql STABLE
    AS $$

begin

	RETURN QUERY SELECT gp_code,
hh_code,
resp_name,
religion,
caste,
address,
landmark, 
(select stname::character varying from sisdp_hh.hh_gp_list where stcode=stcode1 limit 1) as statecode,
(select dtname::character varying from sisdp_hh.hh_gp_list where dtcode=dtcode1 limit 1) as distcode,
(select bpname::character varying from sisdp_hh.hh_gp_list where bpcode=bpcode1 limit 1) as blkcode,
(select gpname::character varying from sisdp_hh.hh_gp_list where gpcode=gpcode1 limit 1) as villcode,
resi_since,
house_own,
house_rent,
bplcard,
rationcard,
fam_members,
land_khasra,
land_area,
land_since,
land_cultiv,
land_fallow,
house_type,
house_roof,
house_wall,
house_ht,
house_sch,
house_age,
house_cond,
water_supp,
water_supp_dur,
solid_waste_coll,
elec_supp,
elec_supp_dur,
elec_use,
transportation,
toilet_avail,
toilet_type,
toilet_use,
toilet_sch,
toilet_amt,
monthly_food,
monthly_edu,
monthly_tpt,
monthly_health,
monthly_rent,
monthly_leisure,
monthly_exp,
monthly_int,
monthly_int_amt,
monthly_int_since,
vaccination,
disease,
hosp_visit,
hosp_near,
hosp_fees,
hosp_travel,
cow_buffalo,
ox,
goat,
chicken,
horse,
donkey,
other_livestock,
radio,
telephone,
solar,
tv,
computer,
stove,
lpg,
kerosene,
firewood,
biogass,
cowdung,
energy_oth,
energy_sch,
voc_trng_cntr,
issues,
expectations,
suggestions,
last_updated_by,
last_updated_on,
obs_date,
surveyor_name,
surveyor_id,
disease_det,
anyremarks,
surveyor_mobile,
cow_livestock_num,
cow_livestock_disease,
cow_commercial_use,
ox_livestock_num,
ox_livestock_disease,
ox_commercial_use,
goat_livestock_num,
goat_livestock_disease,
goat_commercial_use,
chicken_livestock_num,
chicken_livestock_disease,
chicken_commercial_use,
horse_livestock_num,
horse_livestock_disease,
horse_commercial_use,
donkey_livestock_num,
donkey_livestock_disease,
donkey_commercial_use,
other_livestock_num,
other_livestock_disease,
other_commercial_use,
latitude,
accuracy,
longitude,
land_holding
 FROM sisdp_hh.hh_survey_master where 
	st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 and 
	stcode=stcode1  and dtcode=dtcode1 and bpcode=bpcode1 )) and  sisdp_hh.hh_survey_master.gp_code=gpcode1 and 
	sisdp_hh.hh_survey_master.last_updated_on between value1 and value2 order by id;
end

$$;


ALTER FUNCTION sisdp.downloadmasterrange(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer, value1 timestamp without time zone, value2 timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 1199 (class 1255 OID 47567)
-- Name: hh_legends(character varying[], text, text, text, text, integer, character varying[]); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hh_legends(tablename character varying[], xmin1 text, ymin1 text, xmax1 text, ymax1 text, count integer, columnname character varying[]) RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
 
DECLARE result text;
interresult text;
interresult2 text;

code integer;
a text;
Counter INT = 0 ;
geominput geometry;

BEGIN
 EXECUTE format('SELECT stcode FROM bp.state WHERE ST_INTERSECTS(geom,ST_MakeEnvelope(%s, %s, %s, %s,4326))',xmin1, ymin1,xmax1,ymax1) INTO code;
FOR Counter in array_lower(tablename, 1) .. count
	LOOP
raise notice 'Value: %', Counter;
case tablename[Counter]
	when 'bp.lulc' then tablename[Counter]=(select bp.lulctablemapping(code));
	when 'bp.drainage' then tablename[Counter]=(select bp.drainagetablemapping(code));
	when 'bp.road' then tablename[Counter]=(select bp.roadtablemapping(code));
	else tablename[Counter]=tablename[Counter];
end case;
if tablename[Counter]='bp.state' or tablename[Counter]='bp.district' or tablename[Counter]='bp.block' or (tablename[Counter]='bp.panchayat' and (columnname[Counter]!='profile1' and columnname[Counter]!='profile2' and columnname[Counter]!='population' )) or tablename[Counter]='bp.village' or tablename[Counter]='bp.cadastral' or tablename[Counter]='bp.parliament' or tablename[Counter]='bp.assembly' or tablename[Counter]='bp.basin' or tablename[Counter]='bp.subbasin' or tablename[Counter]='bp.watershed' or tablename[Counter]='bp.subwatershed' THEN
interresult2=columnname[Counter];
elsif tablename[Counter]='bp.mainassets' THEN 
tablename[Counter]=(select bp.assettablemapping(code));
EXECUTE format('SELECT id FROM %s WHERE id='|| quote_literal('%s')||' AND ST_INTERSECTS(geom,ST_MakeEnvelope(%s, %s, %s, %s,4326))',tablename[Counter],columnname[Counter],xmin1, ymin1,xmax1,ymax1) INTO interresult2;
SELECT replace(replace(trim( both '{"}' from interresult2),',',E'\n'),'"','') into interresult2;
elsif tablename[Counter]='bp.slope' THEN
tablename[Counter]=(select bp.slopetablemapping(code));
EXECUTE format('select array(SELECT distinct gridcode FROM %s WHERE %s is not null and ST_INTERSECTS(geom,ST_MakeEnvelope(%s, %s, %s, %s,4326)) order by gridcode)',tablename[Counter],columnname[Counter],xmin1, ymin1,xmax1,ymax1) INTO interresult2;
SELECT replace(replace(trim( both '{"}' from interresult2),',',E'\n'),'"','') into interresult2;
ELSE
EXECUTE format('Select array(SELECT distinct %s FROM %s WHERE %s is not null and ST_INTERSECTS(geom,ST_MakeEnvelope(%s, %s, %s, %s,4326)))',columnname[Counter],tablename[Counter],columnname[Counter],xmin1, ymin1,xmax1,ymax1) INTO interresult2;
SELECT replace(replace(trim( both '{"}' from interresult2),',',E'\n'),'"','') into interresult2;
END IF;
raise notice 'interresult else %',interresult2;
--SELECT replace(replace(trim( both '{"}' from interresult2),',',', '),'"','') into a;
if result is not null then
result=result ||';'|| COALESCE(interresult2||' ','Not available');
else
result=COALESCE(interresult2||' ','Not available');
end if;
raise notice 'result else %',result;

END LOOP;
raise notice 'result out loop %',result;
 RETURN result;
   END;

$$;


ALTER FUNCTION sisdp.hh_legends(tablename character varying[], xmin1 text, ymin1 text, xmax1 text, ymax1 text, count integer, columnname character varying[]) OWNER TO postgres;

--
-- TOC entry 1201 (class 1255 OID 47568)
-- Name: hhadditionalinfo(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhadditionalinfo(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Household Number ',COALESCE(sm.hh_code::text,'N.A.'),
						  'Last Updated on ',COALESCE(sm.last_updated_on::text,'N.A.'),
						  'Address ',COALESCE(sm.address::text,'N.A.'),
						 'Landmark ',COALESCE(sm.landmark::text,'N.A.'))
						  FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects
						  (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint( 
							  geomcord1::numeric, geomcord2::numeric), 4326),0.005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhadditionalinfo(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1202 (class 1255 OID 47569)
-- Name: hhadditionalinfo1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhadditionalinfo1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.additionalinfodetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;
a text;
geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode; 
 raise notice 'geominput %',geominput;
RETURN QUERY SELECT CASE WHEN sm.surveyor_name::text='' THEN 'N.A.'
								WHEN sm.surveyor_name::text is NULL THEN 'N.A.'
								else sm.surveyor_name::text
								END AS surveyor_name,
							CASE WHEN sm.hh_code::text='' THEN 'N.A.'
								WHEN sm.hh_code is NULL THEN 'N.A.'
								else sm.hh_code::text
								END AS hh_code,
								CASE WHEN sm.last_updated_on::text='' THEN 'N.A.'
								WHEN sm.last_updated_on is NULL THEN 'N.A.'
								else sm.last_updated_on::text
								END AS last_updated_on,
								CASE WHEN sm.address::text='' THEN 'N.A.'
								WHEN sm.address is NULL THEN 'N.A.'
								else sm.address::text
								END AS address,
								CASE WHEN sm.landmark::text='' THEN 'N.A.'
								WHEN sm.landmark is NULL THEN 'N.A.'
								else sm.landmark::text
								END AS landmark FROM sisdp_hh.hh_survey_master sm WHERE sm.hh_code=mainhhcode;
   END;

$$;


ALTER FUNCTION sisdp.hhadditionalinfo1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1203 (class 1255 OID 47570)
-- Name: hhdetails(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetails(geomcord1 text, geomcord2 text) RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;

EXECUTE format('SELECT toilet_avail FROM sisdp_hh.hh_survey_master WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint( %s, %s), 4326),0.5))',geomCord1, geomCord2) INTO interresult;

		SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN result;
   END;

$$;


ALTER FUNCTION sisdp.hhdetails(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1204 (class 1255 OID 47571)
-- Name: hhdetails1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetails1(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Toilet Availablity',sm.toilet_avail::text,'Family Member',sm.fam_members::text,'House Owned',sm.house_own,'Mode of transport', fm.mode_transport::text,'House Type',sm.house_type::text,'House Wall',sm.house_wall::text,'House Roof', sm.house_roof::text,'Water Supply',sm.water_supp::text) FROM sisdp_hh.hh_survey_master sm, sisdp_hh.hh_family_member fm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetails1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1205 (class 1255 OID 47572)
-- Name: hhdetailsagri(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsagri(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Land Owner',COALESCE(fm.agri_own::text,'N.A.'),'No. of Persons Involved',COALESCE(fm.agri_num_pers::text,'N.A.'),'Source of Irrigation',COALESCE(fm.agri_irr_source::text,'N.A.'),'Seed Avalibility',COALESCE(fm.agri_seed_avail::text,'N.A.'),'Area', COALESCE(fm.agri_area::text
,'N.A.'),'Cropping Pattern',COALESCE(fm.agri_crop_type::text,'N.A.'),'Location',COALESCE(fm.agri_store_loc::text,'N.A.'),'Produce P.A.', COALESCE(fm.agri_crop_produce::text,'N.A.'),'Crop',COALESCE(fm.agri_crop_type::text,'N.A.'),'Store Location',COALESCE(fm.agri_store_loc::text,'N.A.'),'Soil Fertility',COALESCE(fm.agri_crop_freq::text,'N.A.'),'Store Distance',COALESCE(fm.agri_sell_loc::text,'N.A.')) FROM sisdp_hh.hh_survey_master sm, sisdp_hh.hh_family_member fm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsagri(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1206 (class 1255 OID 47573)
-- Name: hhdetailsagri1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsagri1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.alloccupationdetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
mainhhcode text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT fm.hh_code FROM sisdp_hh.hh_survey_master fm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode; 
 raise notice 'geominput %',geominput;
RETURN QUERY SELECT CASE WHEN fm.agri_num_pers::text='' THEN 'N.A.'
								WHEN fm.agri_num_pers is NULL THEN 'N.A.'
								else fm.agri_num_pers::text
								END AS agri_num_pers,
								CASE WHEN fm.agri_area::text='' THEN 'N.A.'
								WHEN fm.agri_area is NULL THEN 'N.A.'
								else fm.agri_area::text
								END AS agri_area,
								CASE WHEN fm.occ_location::text='' THEN 'N.A.'
								WHEN fm.occ_location is NULL THEN 'N.A.'
								else fm.occ_location::text
								END AS occ_location,
								CASE WHEN fm.agri_soil_type::text='' THEN 'N.A.'
								WHEN fm.agri_soil_type is NULL THEN 'N.A.'
								else fm.agri_soil_type::text
								END AS agri_soil_type,
								CASE WHEN fm.agri_own::text='' THEN 'N.A.'
								WHEN fm.agri_own is NULL THEN 'N.A.'
								else fm.agri_own::text
								END AS agri_own,
								CASE WHEN fm.agri_crop_type::text='' THEN 'N.A.'
								WHEN fm.agri_crop_type is NULL THEN 'N.A.'
								else fm.agri_crop_type::text
								END AS agri_crop_type,
								CASE WHEN fm.agri_crop_freq::text='' THEN 'N.A.'
								WHEN fm.agri_crop_freq is NULL THEN 'N.A.'
								else fm.agri_crop_freq::text
								END AS agri_crop_freq,
								CASE WHEN fm.agri_irr_source::text='' THEN 'N.A.'
								WHEN fm.agri_irr_source::BOOLEAN=true THEN 'Yes'
								WHEN fm.agri_irr_source::BOOLEAN =false THEN 'No'
								WHEN fm.agri_irr_source is NULL THEN 'N.A.'
								else fm.agri_irr_source::text
								END AS agri_irr_source,
								CASE WHEN fm.agri_irr_sch::text='' THEN 'N.A.'
								WHEN fm.agri_irr_sch is NULL THEN 'N.A.'
								else fm.agri_irr_sch::text
								END AS agri_irr_sch,
								CASE WHEN fm.agri_seed_avail::text='' THEN 'N.A.'
								WHEN fm.agri_seed_avail is NULL THEN 'N.A.'
								else fm.agri_seed_avail::text
								END AS agri_seed_avail,
								CASE WHEN fm.agri_crop_change::text='' THEN 'N.A.'
								WHEN fm.agri_crop_change::BOOLEAN=true THEN 'Yes'
								WHEN fm.agri_crop_change::BOOLEAN =false THEN 'No'
								WHEN fm.agri_crop_change is NULL THEN 'N.A.'
								else fm.agri_crop_change::text
								END AS agri_crop_change,
								CASE WHEN fm.agri_store_loc::text='' THEN 'N.A.'
								WHEN fm.agri_store_loc is NULL THEN 'N.A.'
								else fm.agri_store_loc::text
								END AS agri_store_loc,
								CASE WHEN fm.agri_sell_loc::text='' THEN 'N.A.'
								WHEN fm.agri_sell_loc is NULL THEN 'N.A.'
								else fm.agri_sell_loc::text
								END AS agri_sell_loc,
								CASE WHEN fm.agri_crop_produce::text='' THEN 'N.A.'
								WHEN fm.agri_crop_produce is NULL THEN 'N.A.'
								else fm.agri_crop_produce::text
								END AS agri_crop_produce FROM sisdp_hh.hh_family_member fm WHERE fm.hh_code=mainhhcode 
					and occupation!='Animal' and occupation!='Fishing' and occupation!='HouseWife' and occupation!='Other' and occupation!='Student'
				and occupation!='Unemployed' and occupation is not null and occupation='Agriculture';
		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsagri1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1200 (class 1255 OID 47574)
-- Name: hhdetailsbusiness(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsbusiness(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE result text;
interresult text;
a text;
geominput geometry;
BEGIN
 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Type',COALESCE(fm.occ_type::text,'N.A'),
						  'Location',COALESCE(fm.occ_location::text,'N.A') ) FROM sisdp_hh.hh_survey_master sm, sisdp_hh.hh_family_member fm where sm.hh_code=fm.hh_code and sm.hh_code = '1596181251' INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;
$$;


ALTER FUNCTION sisdp.hhdetailsbusiness(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1207 (class 1255 OID 47575)
-- Name: hhdetailsbusiness1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsbusiness1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allbusinessdetails
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE result text;
mainhhcode text;
a text;
geominput geometry;
BEGIN
  EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode; 
 raise notice 'geominput %',geominput;
 RETURN QUERY SELECT CASE WHEN fm.occ_type::text='' THEN 'N.A.'
								WHEN fm.occ_type is NULL THEN 'N.A.'
								else fm.occ_type::text
								END AS occ_type,
								CASE WHEN fm.occ_location::text='' THEN 'N.A.'
								WHEN fm.occ_location is NULL THEN 'N.A.'
								else fm.occ_location::text
								END AS occ_location 
						  FROM sisdp_hh.hh_family_member fm WHERE fm.hh_code=mainhhcode 
					and occupation!='Animal' and occupation!='Fishing' and occupation!='HouseWife' and occupation!='Other' and occupation!='Student'
				and occupation!='Unemployed' and occupation is not null and occupation='Business';
		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;
$$;


ALTER FUNCTION sisdp.hhdetailsbusiness1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1208 (class 1255 OID 47576)
-- Name: hhdetailsenergy(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsenergy(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('LPG',COALESCE(sm.lpg::text,'N.A'),
						  'Kerosene',COALESCE(sm.kerosene::text,'N.A'),
						  'Fire wood /Coal',COALESCE(sm.firewood::text,'N.A'),
						  'Biogass',COALESCE(sm.biogass::text,'N.A'),
						  'Cow Dung Cake',COALESCE(sm.cowdung::text,'N.A'),
						  'Others',COALESCE(sm.energy_oth::text,'N.A'),
						 'SCHEME',COALESCE(sm.energy_sch::text,'N.A')) FROM sisdp_hh.hh_survey_master sm 
						  WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID
					(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsenergy(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1209 (class 1255 OID 47577)
-- Name: hhdetailsenergy1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsenergy1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allenergydetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
 RETURN QUERY SELECT CASE  WHEN sm.lpg::BOOLEAN=true THEN 'Yes'
								WHEN sm.lpg::BOOLEAN =false THEN 'No'
								WHEN sm.lpg::TEXT='' THEN 'N.A.'
								WHEN sm.lpg is NULL THEN 'N.A.'
								else  sm.lpg::text
								END AS lpg,
					  CASE  WHEN sm.kerosene::BOOLEAN=true THEN 'Yes'
								WHEN sm.kerosene::BOOLEAN =false THEN 'No'
								WHEN sm.kerosene::TEXT='' THEN 'N.A.'
								WHEN sm.kerosene is NULL THEN 'N.A.'
								else  sm.kerosene::text
								END AS kerosene,
 						CASE  WHEN sm.firewood::BOOLEAN=true THEN 'Yes'
								WHEN sm.firewood::BOOLEAN =false THEN 'No'
								WHEN sm.firewood::TEXT='' THEN 'N.A.'
								WHEN sm.firewood is NULL THEN 'N.A.'
								else  sm.firewood::text
								END AS firewood,
							CASE  WHEN sm.biogass::BOOLEAN=true THEN 'Yes'
								WHEN sm.biogass::BOOLEAN =false THEN 'No'
								WHEN sm.biogass::TEXT='' THEN 'N.A.'
								WHEN sm.biogass is NULL THEN 'N.A.'
								else  sm.biogass::text
								END AS biogass,
							CASE  WHEN sm.cowdung::BOOLEAN=true THEN 'Yes'
								WHEN sm.cowdung::BOOLEAN =false THEN 'No'
								WHEN sm.cowdung::TEXT='' THEN 'N.A.'
								WHEN sm.cowdung is NULL THEN 'N.A.'
								else  sm.cowdung::text
								END AS cowdung,
							CASE  WHEN sm.energy_oth::TEXT='' THEN 'N.A.'
								WHEN sm.energy_oth is NULL THEN 'N.A.'
								else  sm.energy_oth::text
								END AS energy_oth,
							CASE  WHEN sm.energy_sch::BOOLEAN=true THEN 'Yes'
								WHEN sm.energy_sch::BOOLEAN =false THEN 'No'
							WHEN sm.energy_sch::TEXT='' THEN 'N.A.'
								WHEN sm.energy_sch is NULL THEN 'N.A.'
								else  sm.energy_sch::text
								END AS energy_sch FROM sisdp_hh.hh_survey_master sm WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsenergy1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1210 (class 1255 OID 47578)
-- Name: hhdetailsfam(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsfam(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomcord1, geomcord2) into geominput;

 raise notice 'geominput %',geominput;
 SELECT json_build_object('Name',COALESCE(fm.member_name::text,'N.A.'),
						  'Age',fm.age,
						  'Sex',COALESCE(fm.sex::text,'N.A.'),
						  'Married',COALESCE(fm.maritalstatus::text,'N.A.'),
						  'Qualifcation',COALESCE(fm.qualification::text,'N.A.'),
						  'Occupation',COALESCE(fm.occupation::text,'N.A.'),
						  'Location',COALESCE(fm.occ_location::text,'N.A.'),
						  'Mode of Transport',COALESCE(fm.mode_transport::text,'N.A.'),
						  'Digital Literacy',COALESCE(fm.digital_literacy::text,'N.A.'),
						  'Change in Occupation(if any)',COALESCE(fm.occ_change::text,'N.A.'),
						  'Since when and Reason',COALESCE(fm.occ_change_since::text,'N.A.')||','||COALESCE(fm.occ_change_reason::text,'N.A.')) FROM 
						  sisdp_hh.hh_survey_master sm, sisdp_hh.hh_family_member fm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsfam(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1211 (class 1255 OID 47579)
-- Name: hhdetailsfam1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsfam1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allfamilydetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;
mainhhcode text;
geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomcord1, geomcord2) into geominput;

 raise notice 'geominput %',geominput;
 SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode; 
 RETURN QUERY SELECT CASE WHEN fm.member_name::text='' THEN 'N.A.'
								WHEN fm.member_name is NULL THEN 'N.A.'
								else fm.member_name::text
								END AS member_name,
					 fm.age,
					 CASE WHEN fm.sex::text='' THEN 'N.A.'
								WHEN fm.sex is NULL THEN 'N.A.'
								else fm.sex::text
								END AS sex,
					 CASE WHEN fm.maritalstatus::text='' THEN 'N.A.'
								WHEN fm.maritalstatus is NULL THEN 'N.A.'
								else fm.maritalstatus::text
								END AS maritalstatus,
					 CASE WHEN fm.qualification::text='' THEN 'N.A.'
								WHEN fm.qualification is NULL THEN 'N.A.'
								else fm.qualification::text
								END AS qualification,
					CASE WHEN fm.occupation::text='' THEN 'N.A.'
								WHEN fm.occupation is NULL THEN 'N.A.'
								else fm.occupation::text
								END AS occupation,
				    CASE WHEN fm.occ_location::text='' THEN 'N.A.'
								WHEN fm.occ_location is NULL THEN 'N.A.'
								else fm.occ_location::text
								END AS occ_location,
					 CASE WHEN fm.mode_transport::text='' THEN 'N.A.'
								WHEN fm.mode_transport is NULL THEN 'N.A.'
								else fm.mode_transport::text
								END AS mode_transport,
					CASE  WHEN fm.digital_literacy::BOOLEAN=true THEN 'Yes'
						  WHEN fm.digital_literacy::BOOLEAN =false THEN 'No'
						 WHEN fm.digital_literacy::text='' THEN 'N.A.'
								WHEN fm.digital_literacy is NULL THEN 'N.A.'
								else fm.digital_literacy::text
								END AS digital_literacy,
					CASE  WHEN fm.occ_change::BOOLEAN=true THEN 'Yes'
						  WHEN fm.occ_change::BOOLEAN =false THEN 'No'
						 WHEN fm.occ_change::text='' THEN 'N.A.'
								WHEN fm.occ_change is NULL THEN 'N.A.'
								else fm.occ_change::text
								END AS occ_change,
					CASE WHEN fm.occ_change_since::text='' and fm.occ_change_reason::text='' THEN 'N.A.'
								WHEN fm.occ_change_since is NULL and fm.occ_change_reason is NULL THEN 'N.A.'
								WHEN fm.occ_change_since is NULL and fm.occ_change_reason ='' THEN 'N.A.'
								WHEN fm.occ_change_since ='' and fm.occ_change_reason is NULL THEN 'N.A.'
								WHEN fm.occ_change_since is NULL or fm.occ_change_since='' THEN fm.occ_change_reason::text
								WHEN fm.occ_change_reason is NULL or fm.occ_change_reason='' THEN fm.occ_change_since::text
								else fm.occ_change_since::text ||',' || fm.occ_change_reason::text
								END AS since_when_and_reason 
				 FROM sisdp_hh.hh_family_member fm WHERE fm.hh_code=mainhhcode ;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsfam1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1212 (class 1255 OID 47580)
-- Name: hhdetailshealth(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailshealth(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('vaccination if any',COALESCE(sm.vaccination::text,'N.A'),
						  'Any prominent disease',COALESCE(sm.disease::text,'N.A'),
						  'No of visit to hospital in a month',COALESCE(sm.hosp_visit::text,'N.A'),
						  'Most prominent nearby Medical Facility',COALESCE(sm.hosp_near::text,'N.A'),
						  'Fees paid for 1 time visit',COALESCE(sm.hosp_fees::text,'N.A'),
						  'Mode of travel',COALESCE(sm.hosp_travel::text,'N.A')) FROM sisdp_hh.hh_survey_master sm 
						  WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID
					(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailshealth(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1213 (class 1255 OID 47581)
-- Name: hhdetailshealth1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailshealth1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allhealthdetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;
a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
RETURN QUERY SELECT  CASE       WHEN sm.vaccination::BOOLEAN=true THEN 'Yes'
								WHEN sm.vaccination::BOOLEAN =false THEN 'No'
								WHEN sm.vaccination::TEXT='' THEN 'N.A.'
								WHEN sm.vaccination is NULL THEN 'N.A.'
								else sm.vaccination::TEXT
								END AS vaccination,
					CASE       WHEN sm.disease::BOOLEAN=true THEN 'Yes'
								WHEN sm.disease::BOOLEAN =false THEN 'No'
								WHEN sm.disease::TEXT='' THEN 'N.A.'
								WHEN sm.disease is NULL THEN 'N.A.'
								else sm.disease::TEXT
								END AS disease,
					CASE      	WHEN sm.hosp_visit::TEXT='' THEN 'N.A.'
								WHEN sm.hosp_visit is NULL THEN 'N.A.'
								else sm.hosp_visit::TEXT
								END AS hosp_visit,
					CASE        WHEN sm.hosp_near::TEXT='' THEN 'N.A.'
								WHEN sm.hosp_near is NULL THEN 'N.A.'
								else sm.hosp_near::TEXT
								END AS hosp_near,
					CASE       	WHEN sm.hosp_fees::TEXT='' THEN 'N.A.'
								WHEN sm.hosp_fees is NULL THEN 'N.A.'
								else sm.hosp_fees::TEXT
								END AS hosp_fees,
					CASE        WHEN sm.hosp_travel::TEXT='' THEN 'N.A.'
								WHEN sm.hosp_travel is NULL THEN 'N.A.'
								else sm.hosp_travel::TEXT
								END AS hosp_travel FROM sisdp_hh.hh_survey_master sm 
						  WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailshealth1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1214 (class 1255 OID 47582)
-- Name: hhdetailshousing(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailshousing(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object( 'Type of Structure',COALESCE(sm.house_type::text,'N.A'),
						  'Material(Roof)',COALESCE(sm.house_roof::text,'N.A'),
						  'Material(Wall)',COALESCE(sm.house_wall::text,'N.A'),
						  'Building Height',COALESCE(sm.house_ht::text,'N.A'),
						  'Scheme(Y/N)',COALESCE(sm.house_sch::text,'N.A'),
						  'Age of Structure',COALESCE(sm.house_age::text,'N.A'),
						  'Condition',COALESCE(sm.house_cond::text,'N.A')) FROM sisdp_hh.hh_survey_master sm 
						  WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint
						 ( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailshousing(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1215 (class 1255 OID 47583)
-- Name: hhdetailshousing1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailshousing1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allhousingdetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
 RETURN QUERY SELECT  
 					CASE  		WHEN sm.house_type::TEXT='' THEN 'N.A.'
								WHEN sm.house_type is NULL THEN 'N.A.'
								else sm.house_type::TEXT
								END AS house_type,
					CASE  		WHEN sm.house_roof::TEXT='' THEN 'N.A.'
								WHEN sm.house_roof is NULL THEN 'N.A.'
								else sm.house_roof::TEXT
								END AS house_roof,
					CASE  		WHEN sm.house_wall::TEXT='' THEN 'N.A.'
								WHEN sm.house_wall is NULL THEN 'N.A.'
								else sm.house_wall::TEXT
								END AS house_wall,
					CASE  		WHEN sm.house_ht::TEXT='' THEN 'N.A.'
								WHEN sm.house_ht is NULL THEN 'N.A.'
								else sm.house_ht::TEXT
								END AS house_ht,
					CASE       WHEN sm.house_sch::BOOLEAN=true THEN 'Yes'
								WHEN sm.house_sch::BOOLEAN =false THEN 'No'
								WHEN sm.house_sch::TEXT='' THEN 'N.A.'
								WHEN sm.house_sch is NULL THEN 'N.A.'
								else sm.house_sch::TEXT
								END AS house_sch,
					CASE  		WHEN sm.house_age::TEXT='' THEN 'N.A.'
								WHEN sm.house_age is NULL THEN 'N.A.'
								else sm.house_age::TEXT
								END AS house_age,
				    CASE  		WHEN sm.house_cond::TEXT='' THEN 'N.A.'
								WHEN sm.house_cond is NULL THEN 'N.A.'
								else sm.house_cond::TEXT
								END AS house_cond FROM sisdp_hh.hh_survey_master sm 
						  WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailshousing1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1216 (class 1255 OID 47584)
-- Name: hhdetailslabour(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailslabour(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE result text;
interresult text;
a text;
geominput geometry;
BEGIN
 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Type',COALESCE(fm.occ_type::text,'N.A'),
						  'Location',COALESCE(fm.occ_location::text,'N.A'),
						  'mode of travel',COALESCE(fm.occ_mode_travel::text,'N.A'),
						  'Marginal/Full year',COALESCE(fm.lab_marginal::text,'N.A'),
						  'Wage',COALESCE(fm.lab_wage::text,'N.A')) FROM sisdp_hh.hh_survey_master sm, sisdp_hh.hh_family_member fm where sm.hh_code=fm.hh_code and sm.hh_code = '1596181251' INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;
$$;


ALTER FUNCTION sisdp.hhdetailslabour(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1217 (class 1255 OID 47585)
-- Name: hhdetailslabour1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailslabour1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.alllabourdetails
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE result text;
mainhhcode text;
a text;
geominput geometry;
BEGIN
  EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
		raise notice 'geominput %',geominput;
 raise notice 'mainhhcode %',mainhhcode;
 RETURN QUERY SELECT  
                        CASE  	WHEN fm.occ_type::TEXT='' THEN 'N.A.'
								WHEN fm.occ_type is NULL THEN 'N.A.'
								else fm.occ_type::TEXT
								END AS occ_type,
						CASE  	WHEN fm.occ_location::TEXT='' THEN 'N.A.'
								WHEN fm.occ_location is NULL THEN 'N.A.'
								else fm.occ_location::TEXT
								END AS occ_location,
						CASE  	WHEN fm.occ_mode_travel::TEXT='' THEN 'N.A.'
								WHEN fm.occ_mode_travel is NULL THEN 'N.A.'
								else fm.occ_mode_travel::TEXT
								END AS occ_mode_travel,
						CASE   WHEN fm.lab_marginal::TEXT='' THEN 'N.A.'
								WHEN fm.lab_marginal is NULL THEN 'N.A.'
								else fm.lab_marginal::TEXT
								END AS lab_marginal,
						CASE  	WHEN fm.lab_wage::TEXT='' THEN 'N.A.'
								WHEN fm.lab_wage is NULL THEN 'N.A.'
								else fm.lab_wage::TEXT
								END AS lab_wage FROM sisdp_hh.hh_family_member fm WHERE fm.hh_code=mainhhcode 
					and occupation!='Animal' and occupation!='Fishing' and occupation!='HouseWife' and occupation!='Other' and occupation!='Student'
				and occupation!='Unemployed' and occupation is not null and occupation='Labour';
		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;
$$;


ALTER FUNCTION sisdp.hhdetailslabour1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1218 (class 1255 OID 47586)
-- Name: hhdetailsland(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsland(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Khasra No.',COALESCE(sm.land_khasra::text,'N.A.'),
						  'Area',COALESCE(sm.land_area::text,'N.A.'),
						  'Time Period of Ownership of Land',COALESCE(sm.land_since,'N.A.'),
						  'Cultivable',COALESCE(sm.land_cultiv::text,'N.A.'),
						  'Fallow',COALESCE(sm.land_fallow::text,'N.A.')) FROM sisdp_hh.hh_survey_master sm 
						  WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint( 
							  geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsland(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1219 (class 1255 OID 47587)
-- Name: hhdetailsland1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsland1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.alllanddetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
mainhhcode text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
 RETURN QUERY SELECT 
 						Case    WHEN sm.land_khasra::TEXT='' THEN 'N.A.'
								WHEN sm.land_khasra is NULL THEN 'N.A.'
								else sm.land_khasra::TEXT
								END AS land_khasra,
 						Case    WHEN sm.land_area::TEXT='' THEN 'N.A.'
								WHEN sm.land_area is NULL THEN 'N.A.'
								else sm.land_area::TEXT
								END AS land_area,
						Case    WHEN sm.land_since::TEXT='' THEN 'N.A.'
								WHEN sm.land_since is NULL THEN 'N.A.'
								else sm.land_since::TEXT
								END AS land_since,
						Case   	WHEN sm.land_cultiv::Boolean=true THEN 'Yes'
								WHEN sm.land_cultiv::Boolean=false THEN 'No.'
								WHEN sm.land_cultiv::TEXT='' THEN 'N.A.'
								WHEN sm.land_cultiv is NULL THEN 'N.A.'
								else sm.land_cultiv::TEXT
								END AS land_cultiv,
						Case    WHEN sm.land_fallow::boolean=true THEN 'Yes'
								WHEN sm.land_fallow::boolean=false THEN 'No'
								WHEN sm.land_fallow::TEXT='' THEN 'N.A.'
								WHEN sm.land_fallow is NULL THEN 'N.A.'
								else sm.land_fallow::TEXT
								END AS land_fallow FROM sisdp_hh.hh_survey_master sm 
						  WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsland1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1220 (class 1255 OID 47588)
-- Name: hhdetailslandandhousing(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailslandandhousing(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$
 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Land Owner',fm.agri_own::text,'No. of Persons Involved',fm.agri_num_pers,'Source of Irrigation',fm.agri_irr_source::text,'Seed Avalibility',fm.agri_seed_avail,'Area', fm.agri_area::text,'Cropping Pattern',fm.agri_crop_type::text,'Location',fm.agri_store_loc::text,'Produce P.A.', fm.agri_crop_produce::text,'Crop',fm.agri_crop_type::text,'Crop',fm.agri_crop_type::text,'Store Location',fm.agri_store_loc::text,'Soil Fertility',fm.agri_crop_freq::text,'Store Distance',fm.agri_sell_loc::text) FROM sisdp_hh.hh_survey_master sm, sisdp_hh.hh_family_member fm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailslandandhousing(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1221 (class 1255 OID 47589)
-- Name: hhdetailslivestock(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailslivestock(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Cow Livestock Number',COALESCE(sm.cow_livestock_num::text,'N.A'),
							'Cow Livestock disease',COALESCE(sm.cow_livestock_disease::text,'N.A.'),
							'Cow Livestock Commercial Use',COALESCE(sm.cow_commercial_use::text,'N.A.'),
							'Ox Livestock Number',COALESCE(sm.ox_livestock_num::text,'N.A.'),
							'Ox Livestock disease',COALESCE(sm.ox_livestock_disease::text,'N.A.'),
							'Ox Livestock Commercial Use',COALESCE(sm.ox_commercial_use::text,'N.A.'),
							'Goat Livestock Number',COALESCE(sm.goat_livestock_num::text,'N.A.'),
							'Goat Livestock disease',COALESCE(sm.goat_livestock_disease::text,'N.A.'),
							'Goat Livestock Commercial Use',COALESCE(sm.goat_commercial_use::text,'N.A.'),
							'Chicken Livestock Number',COALESCE(sm.chicken_livestock_num::text,'N.A.'),
							'Chicken Livestock disease',COALESCE(sm.chicken_livestock_disease::text,'N.A.'),
							'Chicken Livestock Commercial Use',COALESCE(sm.chicken_commercial_use::text,'N.A.'),
							'Horse Livestock Number',COALESCE(sm.horse_livestock_num::text,'N.A.'),
							'Horse Livestock disease',COALESCE(sm.horse_livestock_disease::text,'N.A.'),
							'Horse Livestock Commercial Use',COALESCE(sm.horse_commercial_use::text,'N.A.'),
							'Donkey Livestock Number',COALESCE(sm.donkey_livestock_num::text,'N.A.'),
							'Donkey Livestock disease',COALESCE(sm.donkey_livestock_disease::text,'N.A.'),
							'Donkey Livestock Commercial Use',COALESCE(sm.donkey_commercial_use::text,'N.A.'),
							'Other Livestock Number',COALESCE(sm.other_livestock_num::text,'N.A.'),
							'Other Livestock disease',COALESCE(sm.other_livestock_disease::text,'N.A.'),
							'Other Livestock Commercial Use',COALESCE(sm.other_commercial_use::text,'N.A.')) FROM sisdp_hh.hh_survey_master sm 
						  WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID
					(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailslivestock(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1222 (class 1255 OID 47590)
-- Name: hhdetailslivestock1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailslivestock1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.alllivestockdetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
 RETURN QUERY SELECT 
 COALESCE(cow_livestock_num::text,'N.A.'),
 						CASE WHEN sm.cow_livestock_disease::TEXT='' THEN 'N.A'
								WHEN sm.cow_livestock_disease is NULL THEN 'N.A'
								else sm.cow_livestock_disease::text
								END AS cow_livestock_disease ,
							CASE WHEN sm.cow_commercial_use::BOOLEAN=true THEN 'Yes'
								WHEN sm.cow_commercial_use::BOOLEAN =false THEN 'No'
								WHEN sm.cow_commercial_use::TEXT='' THEN 'N.A'
								WHEN sm.cow_commercial_use is NULL THEN 'N.A'
								else sm.cow_commercial_use::text
								END AS cow_commercial_use ,
							COALESCE(sm.ox_livestock_num::text,'N.A.'),
							CASE WHEN sm.ox_livestock_disease::TEXT='' THEN 'N.A'
								WHEN sm.ox_livestock_disease is NULL THEN 'N.A'
								else sm.ox_livestock_disease::text
								END AS ox_livestock_disease ,
							CASE WHEN sm.ox_commercial_use::BOOLEAN=true THEN 'Yes'
								WHEN sm.ox_commercial_use::BOOLEAN =false THEN 'No'
								WHEN sm.ox_commercial_use::TEXT='' THEN 'N.A'
								WHEN sm.ox_commercial_use is NULL THEN 'N.A'
								else sm.ox_commercial_use::text
								END AS ox_commercial_use ,
							COALESCE(sm.goat_livestock_num::text,'N.A.'),
							CASE WHEN sm.goat_livestock_disease::TEXT='' THEN 'N.A'
								WHEN sm.goat_livestock_disease is NULL THEN 'N.A'
								else sm.goat_livestock_disease::text
								END AS goat_livestock_disease ,
							CASE WHEN sm.goat_commercial_use::BOOLEAN=true THEN 'Yes'
								WHEN sm.goat_commercial_use::BOOLEAN =false THEN 'No'
								WHEN sm.goat_commercial_use::TEXT='' THEN 'N.A'
								WHEN sm.goat_commercial_use is NULL THEN 'N.A'
								else sm.goat_commercial_use::text
								END AS goat_commercial_use ,
							COALESCE(sm.chicken_livestock_num::text,'N.A.'),
						CASE WHEN sm.chicken_livestock_disease::TEXT='' THEN 'N.A'
								WHEN sm.chicken_livestock_disease is NULL THEN 'N.A'
								else sm.chicken_livestock_disease::text
								END AS chicken_livestock_disease ,
							CASE WHEN sm.chicken_commercial_use::BOOLEAN=true THEN 'Yes'
								WHEN sm.chicken_commercial_use::BOOLEAN=false THEN 'No'
								WHEN sm.chicken_commercial_use::TEXT='' THEN 'N.A'
								WHEN sm.chicken_commercial_use is NULL THEN 'N.A'
								else sm.chicken_commercial_use::text
								END AS chicken_commercial_use ,
							COALESCE(sm.horse_livestock_num::text,'N.A.'),
						CASE WHEN sm.horse_livestock_disease::TEXT='' THEN 'N.A'
								WHEN sm.horse_livestock_disease is NULL THEN 'N.A'
								else sm.horse_livestock_disease::text
								END AS horse_livestock_disease ,
							CASE WHEN sm.horse_commercial_use::BOOLEAN=true THEN 'Yes'
								WHEN sm.horse_commercial_use::BOOLEAN =false THEN 'No'
								WHEN sm.horse_commercial_use::TEXT='' THEN 'N.A'
								WHEN sm.horse_commercial_use is NULL THEN 'N.A'
								else sm.horse_commercial_use::text
								END AS horse_commercial_use ,
							COALESCE(sm.donkey_livestock_num::text,'N.A.'),
						 CASE WHEN sm.donkey_livestock_disease::TEXT='' THEN 'N.A'
								WHEN sm.donkey_livestock_disease is NULL THEN 'N.A'
								else sm.donkey_livestock_disease::text
								END AS donkey_livestock_disease ,
							CASE WHEN sm.donkey_commercial_use::BOOLEAN=true THEN 'Yes'
								WHEN sm.donkey_commercial_use::BOOLEAN =false THEN 'No'
								WHEN sm.donkey_commercial_use::TEXT='' THEN 'N.A'
								WHEN sm.donkey_commercial_use is NULL THEN 'N.A'
								else sm.donkey_commercial_use::TEXT
								END AS donkey_commercial_use ,
							COALESCE(sm.other_livestock_num::text,'N.A.'),
							 CASE WHEN sm.other_livestock_disease::TEXT='' THEN 'N.A'
								WHEN sm.other_livestock_disease is NULL THEN 'N.A'
								else sm.other_livestock_disease::text
								END AS other_livestock_disease ,
							CASE WHEN sm.other_commercial_use::BOOLEAN=true THEN 'Yes'
								WHEN sm.other_commercial_use::BOOLEAN =false THEN 'No'
								WHEN sm.other_commercial_use::TEXT='' THEN 'N.A'
								WHEN sm.other_commercial_use is NULL THEN 'N.A'
								else sm.other_commercial_use::TEXT
								END AS other_commercial_use  FROM sisdp_hh.hh_survey_master sm 
						  WHERE sm.hh_code=mainhhcode;
						  

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');

   END;

$$;


ALTER FUNCTION sisdp.hhdetailslivestock1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1223 (class 1255 OID 47591)
-- Name: hhdetailsmonthly(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsmonthly(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Food',COALESCE(sm.monthly_food::text,'N.A.'),
						  'Education /Trianing',COALESCE(sm.monthly_edu::text,'N.A.'),
						  'Transportation',COALESCE(sm.monthly_tpt::text,'N.A.'),
						  'Health',COALESCE(sm.monthly_health::text,'N.A.'),
						  'Rent',COALESCE(sm.monthly_rent::text,'N.A.'),
						  'Leisure',COALESCE(sm.monthly_leisure::text,'N.A.'),
						   'Lump-sum Monthly Expenditure',COALESCE(sm.monthly_exp::text,'N.A.'),
						  'Lump-sum Monthly Expenditure',COALESCE(sm.monthly_exp::text,'N.A.'),
						  'If paying interest then how much',COALESCE(sm.monthly_int::text,'N.A.') || ',' || COALESCE(sm.monthly_int_amt::text,'N.A.') ,
						  'Time period of interest',COALESCE(sm.monthly_int_since::text,'N.A.')
						 ) FROM sisdp_hh.hh_survey_master sm 
						  WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID
					(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsmonthly(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1224 (class 1255 OID 47592)
-- Name: hhdetailsmonthly1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsmonthly1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allmonthlydetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
 RETURN QUERY SELECT 
						Case    WHEN sm.monthly_food::TEXT='' THEN 'N.A.'
								WHEN sm.monthly_food is NULL THEN 'N.A.'
								else sm.monthly_food::TEXT
								END AS monthly_food,
						Case    WHEN sm.monthly_edu::TEXT='' THEN 'N.A.'
								WHEN sm.monthly_edu is NULL THEN 'N.A.'
								else sm.monthly_edu::TEXT
								END AS monthly_edu,		
						Case    WHEN sm.monthly_tpt::TEXT='' THEN 'N.A.'
								WHEN sm.monthly_tpt is NULL THEN 'N.A.'
								else sm.monthly_tpt::TEXT
								END AS monthly_tpt,
						Case    WHEN sm.monthly_health::TEXT='' THEN 'N.A.'
								WHEN sm.monthly_health is NULL THEN 'N.A.'
								else sm.monthly_health::TEXT
								END AS monthly_health,
						Case    WHEN sm.monthly_rent::TEXT='' THEN 'N.A.'
								WHEN sm.monthly_rent is NULL THEN 'N.A.'
								else sm.monthly_rent::TEXT
								END AS monthly_rent,
						Case    WHEN sm.monthly_leisure::TEXT='' THEN 'N.A.'
								WHEN sm.monthly_leisure is NULL THEN 'N.A.'
								else sm.monthly_leisure::TEXT
								END AS monthly_leisure,
						Case    WHEN sm.monthly_exp::TEXT='' THEN 'N.A.'
								WHEN sm.monthly_exp is NULL THEN 'N.A.'
								else sm.monthly_exp::TEXT
								END AS monthly_exp,
                       case    WHEN sm.monthly_int_since::TEXT='' THEN 'N.A.'
								WHEN sm.monthly_int_since is NULL THEN 'N.A.'
								else sm.monthly_int_since::TEXT
								END AS monthly_int_since,                               
                       case     WHEN sm.monthly_int_amt::TEXT='' THEN 'N.A.'
								WHEN sm.monthly_int_amt is NULL THEN 'N.A.'
								else sm.monthly_int_amt::TEXT
								END AS monthly_int_amt                      
						  FROM sisdp_hh.hh_survey_master sm 
						  WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsmonthly1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1225 (class 1255 OID 47593)
-- Name: hhdetailsoccservice(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsoccservice(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE result text;
interresult text;
a text;
geominput geometry;
BEGIN
 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Type',fm.occ_type::text,'Location',fm.occ_location::text,'Mode of Travel',fm.occ_mode_travel::text,'Salary',fm.service_salary::text) FROM sisdp_hh.hh_survey_master sm, sisdp_hh.hh_family_member fm where sm.hh_code = '1596181251' INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;
$$;


ALTER FUNCTION sisdp.hhdetailsoccservice(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1226 (class 1255 OID 47594)
-- Name: hhdetailsoccservice1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsoccservice1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allloccservicedetails
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE result text;
mainhhcode text;
a text;
geominput geometry;
BEGIN
  EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
 RETURN QUERY SELECT distinct 
 						Case    WHEN fm.occ_type::TEXT=' ' THEN 'N.A.'
								WHEN fm.occ_type is NULL THEN 'N.A.'
								else fm.occ_type::TEXT
								END AS occ_type,
						Case    WHEN fm.occ_location::TEXT=' ' THEN 'N.A.'
								WHEN fm.occ_location is NULL THEN 'N.A.'
								else fm.occ_location::TEXT
								END AS occ_location,
						Case    WHEN fm.occ_mode_travel::TEXT=' ' THEN 'N.A.'
								WHEN fm.occ_mode_travel is NULL THEN 'N.A.'
								else fm.occ_mode_travel::TEXT
								END AS occ_mode_travel,
						Case    WHEN fm.service_salary::TEXT=' ' THEN 'N.A.'
								WHEN fm.service_salary is NULL THEN 'N.A.'
								else fm.service_salary::TEXT
								END AS service_salary
							FROM sisdp_hh.hh_family_member fm WHERE fm.hh_code=mainhhcode 
					and occupation!='Animal' and occupation!='Fishing' and occupation!='HouseWife' and occupation!='Other' and occupation!='Student'
				and occupation!='Unemployed' and occupation is not null  and occupation='Service';

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;
$$;


ALTER FUNCTION sisdp.hhdetailsoccservice1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1227 (class 1255 OID 47595)
-- Name: hhdetailsotherassets(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsotherassets(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Radio',COALESCE(sm.radio::text,'N.A.'),
						  'Telephone',COALESCE(sm.telephone::text,'N.A.'),
						  'Solar',COALESCE(sm.solar::text,'N.A.'),
						  'Stove Type',COALESCE(sm.stove::text,'N.A.'),
						  'T.V',COALESCE(sm.tv::text,'N.A.'),
						  'Computer',COALESCE(sm.computer::text,'N.A.')) FROM sisdp_hh.hh_survey_master sm 
						  WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID
					(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsotherassets(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1228 (class 1255 OID 47596)
-- Name: hhdetailsotherassets1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsotherassets1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allotherassets
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
   SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
 
 RETURN QUERY SELECT 
 						CASE    WHEN sm.radio::BOOLEAN=true THEN 'Yes'
								WHEN sm.radio::BOOLEAN =false THEN 'No'
								WHEN sm.radio::TEXT='' THEN 'N.A.'
								WHEN sm.radio is NULL THEN 'N.A.'
								else  sm.radio::text
								END AS radio,
						CASE    WHEN sm.telephone::BOOLEAN=true THEN 'Yes'
								WHEN sm.telephone::BOOLEAN =false THEN 'No'
								WHEN sm.telephone::TEXT='' THEN 'N.A.'
								WHEN sm.telephone is NULL THEN 'N.A.'
								else sm.telephone::text
								END AS telephone,	
						CASE    WHEN sm.solar::BOOLEAN=true THEN 'Yes'
								WHEN sm.solar::BOOLEAN =false THEN 'No'
								WHEN sm.solar::TEXT='' THEN 'N.A.'
								WHEN sm.solar is NULL THEN 'N.A.'
								else sm.solar::text
								END AS solar, 
						CASE    WHEN sm.stove::BOOLEAN=true THEN 'Yes'
								WHEN sm.stove::BOOLEAN =false THEN 'No'
								WHEN sm.stove::TEXT='' THEN 'N.A.'
								WHEN sm.stove is NULL THEN 'N.A.'
								else sm.stove::text
								END AS stove,
						CASE    WHEN sm.tv::BOOLEAN=true THEN 'Yes'
								WHEN sm.tv::BOOLEAN =false THEN 'No'
								WHEN sm.tv::TEXT='' THEN 'N.A.'
								WHEN sm.tv is NULL THEN 'N.A.'
								else sm.tv::text
								END AS tv,
						CASE    WHEN sm.computer::BOOLEAN=true THEN 'Yes'
								WHEN sm.computer::BOOLEAN =false THEN 'No'
								WHEN sm.computer::TEXT='' THEN 'N.A.'
								WHEN sm.computer is NULL THEN 'N.A.'
								else sm.computer::text
								END AS computer FROM sisdp_hh.hh_survey_master sm 
						  WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsotherassets1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1229 (class 1255 OID 47597)
-- Name: hhdetailsphoto(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsphoto(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Photo1',sm.photo1::text,'Photo2',sm.photo2,'Suggestion',sm.suggestions::text) FROM sisdp_hh.hh_survey_master sm, sisdp_hh.hh_family_member fm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsphoto(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1231 (class 1255 OID 47598)
-- Name: hhdetailsphoto1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsphoto1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.photodetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;
a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode; 
 raise notice 'geominput %',geominput;
RETURN QUERY SELECT CASE WHEN sm.photo1::TEXT='' THEN 'N.A'
								WHEN sm.photo1 is NULL THEN 'N.A'
								WHEN sm.photo1='null' THEN 'N.A'
								else sm.photo1::TEXT
								END AS photo1,
				    CASE WHEN sm.photo2::TEXT='' THEN 'N.A'
								WHEN sm.photo2 is NULL THEN 'N.A'
								WHEN sm.photo2='null' THEN 'N.A'
								else sm.photo2::TEXT
								END AS photo2,
				   CASE WHEN sm.anyremarks::TEXT='' THEN 'N.A'
								WHEN sm.anyremarks is NULL THEN 'N.A'
								WHEN sm.anyremarks='null' THEN 'N.A'
								else sm.anyremarks::TEXT
								END AS anyremarks
					FROM sisdp_hh.hh_survey_master sm WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsphoto1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1232 (class 1255 OID 47599)
-- Name: hhdetailsservices(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsservices(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Water Supply Availability',COALESCE(sm.water_supp::text,'N.A.'),
						  'Water Supply Frequency/Duration/Coverage',COALESCE(sm.water_supp_dur::text,'N.A.'),
						  'Solid Waste Collection',COALESCE(sm.solid_waste_coll::text,'N.A.'),
						  'Electricity Availability',COALESCE(sm.elec_supp::text,'N.A.'),
						  'Electricity Frequency/Duration/Coverage',COALESCE(sm.elec_supp_dur::text,'N.A.'),
						  'Electricity Use',COALESCE(sm.elec_use::text,'N.A.'),
						  'Transport',COALESCE(sm.transportation::text,'N.A.')) FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsservices(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1233 (class 1255 OID 47600)
-- Name: hhdetailsservices1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsservices1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allservices
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;
a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
 RETURN QUERY SELECT 
						case  when sm.water_supp::TEXT='' THEN 'N.A.'
								WHEN sm.water_supp is NULL THEN 'N.A.'
								else sm.water_supp::TEXT
								END AS water_supp,
						case  when sm.water_supp_dur::TEXT='' THEN 'N.A.'
								WHEN sm.water_supp_dur is NULL THEN 'N.A.'
								else sm.water_supp_dur::TEXT
								END AS water_supp_dur,
						case when sm.solid_waste_coll::TEXT='' THEN 'N.A.'
								WHEN sm.solid_waste_coll is NULL THEN 'N.A.'
								else sm.solid_waste_coll::TEXT
								END AS solid_waste_coll,
						CASE  WHEN sm.elec_supp::BOOLEAN=true THEN 'Yes'
						  		WHEN sm.elec_supp::BOOLEAN =false THEN 'No'
								WHEN sm.elec_supp::TEXT='' THEN 'N.A.'
								WHEN sm.elec_supp is NULL THEN 'N.A.'
								else sm.elec_supp::TEXT
								END AS elec_supp,
						 case  when sm.elec_supp_dur::TEXT='' THEN 'N.A.'
								WHEN sm.elec_supp_dur is NULL THEN 'N.A.'
								else sm.elec_supp_dur::TEXT
								END AS elec_supp_dur,
						case  when sm.elec_use::TEXT='' THEN 'N.A.'
								WHEN sm.elec_use is NULL THEN 'N.A.'
								else sm.elec_use::TEXT
								END AS elec_use,
						case when sm.transportation::TEXT='' THEN 'N.A.'
								WHEN sm.transportation is NULL THEN 'N.A.'
								else sm.transportation::TEXT
								END AS transportation
						  FROM sisdp_hh.hh_survey_master sm WHERE  sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsservices1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1234 (class 1255 OID 47601)
-- Name: hhdetailstoilet(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailstoilet(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Toilet Present',COALESCE(sm.toilet_avail::text,'N.A.'),
						  'Toilet Type',COALESCE(sm.toilet_type::text,'N.A.'),
						  'IF Private : 1)Is toilet undr use',COALESCE(sm.toilet_use::text,'N.A.'),
						  '2)Under Scheme/Own Construction',COALESCE(sm.toilet_sch::text,'N.A.'),
						  '3)If under scheme; Amount received',COALESCE(sm.toilet_amt::text,'N.A.')) FROM sisdp_hh.hh_survey_master sm 
						  WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID
					(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailstoilet(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1235 (class 1255 OID 47602)
-- Name: hhdetailstoilet1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailstoilet1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.alltoiletdetails
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
  RETURN QUERY SELECT 
  			CASE  WHEN sm.toilet_avail::BOOLEAN=true THEN 'Yes'
								WHEN sm.toilet_avail::BOOLEAN =false THEN 'No'
								WHEN sm.toilet_avail::TEXT='' THEN 'N.A.'
								WHEN sm.toilet_avail is NULL THEN 'N.A.'
								else sm.toilet_avail::TEXT
								END AS toilet_avail,
						  COALESCE(sm.toilet_type::text,'N.A.'),
				CASE  WHEN sm.toilet_use::BOOLEAN=true THEN 'Yes'
								WHEN sm.toilet_use::BOOLEAN =false THEN 'No'
								WHEN sm.toilet_use::TEXT='' THEN 'N.A.'
								WHEN sm.toilet_use is NULL THEN 'N.A.'
								else sm.toilet_use::TEXT
								END AS toilet_use,
				CASE  WHEN sm.toilet_sch::TEXT='' THEN 'N.A.'
								WHEN sm.toilet_sch='null' THEN 'N.A.'
								WHEN sm.toilet_sch is NULL THEN 'N.A.'
								else sm.toilet_sch::text
								END AS toilet_sch,
				case WHEN sm.toilet_amt::TEXT='' THEN 'N.A.'
								WHEN sm.toilet_amt is NULL THEN 'N.A.'
								else sm.toilet_amt::TEXT
								END AS toilet_amt FROM sisdp_hh.hh_survey_master sm 
						  WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailstoilet1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1230 (class 1255 OID 47603)
-- Name: hhdetailsvocational(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsvocational(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Vocational Traing Centre',COALESCE(sm.voc_trng_cntr::text,'N.A.'),
						  'Issues',COALESCE(sm.issues::text,'N.A.'),
						  'Expectations',COALESCE(sm.expectations::text,'N.A.'),
						  'Suggestions',COALESCE(sm.suggestions::text,'N.A.')) FROM sisdp_hh.hh_survey_master sm 
						  WHERE ST_intersects (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID
					(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.0005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsvocational(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1236 (class 1255 OID 47604)
-- Name: hhdetailsvocational1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhdetailsvocational1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allvocational
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode;
 raise notice 'geominput %',geominput;
 RETURN QUERY SELECT 
 							CASE WHEN sm.voc_trng_cntr::text='' THEN 'N.A.'
								WHEN sm.voc_trng_cntr is NULL THEN 'N.A.'
								else sm.voc_trng_cntr::text
								END AS voc_trng_cntr,
								CASE WHEN sm.issues::text='' THEN 'N.A.'
								WHEN sm.issues is NULL THEN 'N.A.'
								else sm.issues::text
								END AS issues,
								CASE WHEN sm.expectations::text='' THEN 'N.A.'
								WHEN sm.expectations is NULL THEN 'N.A.'
								else sm.expectations::text
								END AS expectations,
								CASE WHEN sm.suggestions::text='' THEN 'N.A.'
								WHEN sm.suggestions is NULL THEN 'N.A.'
								else sm.suggestions::text
								END AS suggestions FROM sisdp_hh.hh_survey_master sm 
						  WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhdetailsvocational1(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1237 (class 1255 OID 47605)
-- Name: hhidentify(integer, integer, integer, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhidentify(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer) RETURNS SETOF sisdp.allhhcolumns
    LANGUAGE plpgsql STABLE
    AS $$
begin
	return query 
		select
		ST_ASGEoJSON(loc_geom),* FROM sisdp_hh.hh_survey_master sm left join sisdp_hh.hh_family_member fm on sm.hh_code=fm.hh_code where sm.gp_code=
	gpcode1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat where gpcode=gpcode1 
																			 and stcode=stcode1 and dtcode=dtcode1 and bpcode=bpcode1)) ;
end
$$;


ALTER FUNCTION sisdp.hhidentify(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1238 (class 1255 OID 47606)
-- Name: hhidentifym(integer, integer, integer, integer); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhidentifym(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer) RETURNS SETOF sisdp.allhhmcolumns
    LANGUAGE plpgsql STABLE
    AS $$
begin
	return query 
		select
		ST_ASGEoJSON(loc_geom),* FROM sisdp_hh.hh_survey_master sm  where sm.gp_code=
	gpcode1 and st_intersects(ST_Transform(ST_SetSRID(loc_geom, 4326),4326),(select geom from bp.panchayat 
								where gpcode=gpcode1  and stcode=stcode1 and dtcode=dtcode1 and bpcode=bpcode1 )) ;
end
$$;


ALTER FUNCTION sisdp.hhidentifym(stcode1 integer, dtcode1 integer, bpcode1 integer, gpcode1 integer) OWNER TO postgres;

--
-- TOC entry 1239 (class 1255 OID 47607)
-- Name: hhsurveypersonal(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhsurveypersonal(geomcord1 text, geomcord2 text) RETURNS SETOF json
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;

a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
 raise notice 'geominput %',geominput;
 SELECT json_build_object('Name of Head of the Family',COALESCE(sm.resp_name::text,'N.A.'),'Religion',COALESCE(sm.religion::text,'N.A.'),'Caste',COALESCE(sm.caste,'N.A.'),
						  'Time Period of Residence', COALESCE(sm.resi_since::text,'N.A.'),'Ownership of House',COALESCE(sm.house_own::text,'N.A.'),'Rent',
						  COALESCE(sm.house_rent::text,'N.A.'),'BPL Card',COALESCE(sm.bplcard::text,'N.A.'),'Ration Card',COALESCE(sm.rationcard::text,'N.A.'))
						  FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects
						  (ST_SetSRID(loc_geom,4326),ST_BUFFER(ST_SetSRID(ST_MakePoint( 
							  geomcord1::numeric, geomcord2::numeric), 4326),0.005)) INTO interresult;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
raise notice 'mainassets %',interresult;
 RETURN NEXT interresult;
   END;

$$;


ALTER FUNCTION sisdp.hhsurveypersonal(geomcord1 text, geomcord2 text) OWNER TO postgres;

--
-- TOC entry 1240 (class 1255 OID 47608)
-- Name: hhsurveypersonal1(text, text); Type: FUNCTION; Schema: sisdp; Owner: postgres
--

CREATE FUNCTION sisdp.hhsurveypersonal1(geomcord1 text, geomcord2 text) RETURNS SETOF sisdp.allsurveypersonal
    LANGUAGE plpgsql STABLE
    AS $$

 
DECLARE result text;
interresult text;
mainhhcode text;
a text;

geominput geometry;

BEGIN

 EXECUTE format('SELECT ST_MakePoint(%s, %s)',geomCord1, geomCord2) into geominput;
  SELECT sm.hh_code FROM sisdp_hh.hh_survey_master sm WHERE ST_intersects (ST_SetSRID(loc_geom,4326),
						ST_BUFFER(ST_SetSRID(ST_MakePoint( geomcord1::numeric, geomcord2::numeric), 4326),0.00005)) INTO mainhhcode;
						 raise notice 'mainhhcode %',mainhhcode; 
 raise notice 'geominput %',geominput;
RETURN QUERY SELECT 
							CASE  WHEN sm.resp_name::TEXT='' THEN 'N.A.'
								WHEN sm.resp_name is NULL THEN 'N.A.'
								else  sm.resp_name::text
								END AS resp_name,
								CASE  WHEN sm.religion::TEXT='' THEN 'N.A.'
								WHEN sm.religion is NULL THEN 'N.A.'
								else  sm.religion::text
								END AS religion,
								CASE WHEN sm.caste::text='' THEN 'N.A.'
								WHEN sm.caste is NULL THEN 'N.A.'
								else  sm.caste::text
								END AS caste,
								CASE  WHEN sm.resi_since::TEXT='' THEN 'N.A.'
								WHEN sm.resi_since is NULL THEN 'N.A.'
								else  sm.resi_since::text
								END AS resi_since,
								CASE  WHEN sm.house_own::TEXT='' THEN 'N.A.'
								WHEN sm.house_own is NULL THEN 'N.A.'
								else  sm.house_own::text
								END AS house_own,
								CASE  WHEN sm.house_rent::TEXT='' THEN 'N.A.'
								WHEN sm.house_rent is NULL THEN 'N.A.'
								else  sm.house_rent::text
								END AS house_rent,
						  CASE  WHEN sm.bplcard::BOOLEAN=true THEN 'Yes'
								WHEN sm.bplcard::BOOLEAN =false THEN 'No'
								WHEN sm.bplcard::TEXT=' ' THEN 'N.A.'
								WHEN sm.bplcard is NULL THEN 'N.A.'
								else  sm.bplcard::text
								END AS bplcard,
						  CASE  WHEN sm.rationcard::BOOLEAN=true THEN 'Yes'
								WHEN sm.rationcard::BOOLEAN =false THEN 'No'
								WHEN sm.rationcard::TEXT=' ' THEN 'N.A.'
								WHEN sm.rationcard is NULL THEN 'N.A.'
								else sm.rationcard::text
								END AS rationcard
FROM sisdp_hh.hh_survey_master sm WHERE sm.hh_code=mainhhcode;

		--SELECT replace(replace(trim( both '{"}' from interresult),',',', '),'"','') into a;
		--result=COALESCE(a||' ','');
   END;

$$;


ALTER FUNCTION sisdp.hhsurveypersonal1(geomcord1 text, geomcord2 text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 317 (class 1259 OID 57607)
-- Name: geotagtbl; Type: TABLE; Schema: sisdp; Owner: postgres
--

CREATE TABLE sisdp.geotagtbl (
    id integer,
    obs_date timestamp without time zone,
    addedby character varying(20),
    selstate character varying(30),
    seldist character varying(30),
    l1class character varying(50),
    l2class character varying(50),
    l3class character varying(50),
    regdisc character varying(50),
    otherclass character varying(50),
    num_img integer,
    photo1 text,
    pic1time timestamp without time zone,
    latitude1 numeric,
    longitude1 numeric,
    accuracy1 numeric,
    photo2 text,
    pic2time timestamp without time zone,
    latitude2 numeric,
    longitude2 numeric,
    accuracy2 numeric,
    remark character varying(100),
    loc_geom1 public.geometry,
    loc_geom2 public.geometry
);


ALTER TABLE sisdp.geotagtbl OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 47623)
-- Name: hh_gp_list_id_seq; Type: SEQUENCE; Schema: sisdp; Owner: postgres
--

CREATE SEQUENCE sisdp.hh_gp_list_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE sisdp.hh_gp_list_id_seq OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 47689)
-- Name: gp_list; Type: TABLE; Schema: sisdp; Owner: postgres
--

CREATE TABLE sisdp.gp_list (
    id integer DEFAULT nextval('sisdp.hh_gp_list_id_seq'::regclass) NOT NULL,
    stname character varying(30),
    stcode integer,
    dtname character varying(30),
    dtcode integer,
    bpname character varying(30),
    bpcode integer,
    gpname character varying(30),
    gpcode integer
);


ALTER TABLE sisdp.gp_list OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 47609)
-- Name: hh_family_member_id_seq; Type: SEQUENCE; Schema: sisdp; Owner: postgres
--

CREATE SEQUENCE sisdp.hh_family_member_id_seq
    START WITH 31
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sisdp.hh_family_member_id_seq OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 47625)
-- Name: hh_survey_data_id_seq; Type: SEQUENCE; Schema: sisdp; Owner: postgres
--

CREATE SEQUENCE sisdp.hh_survey_data_id_seq
    START WITH 15
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sisdp.hh_survey_data_id_seq OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 47627)
-- Name: login; Type: TABLE; Schema: sisdp; Owner: postgres
--

CREATE TABLE sisdp.login (
    id integer NOT NULL,
    username character varying(16),
    password character varying(32),
    name character varying(128),
    email character varying(64),
    phone character varying(16),
    desig character varying(20),
    org character varying(20),
    confirmcode character varying(32),
    vill_code integer
);


ALTER TABLE sisdp.login OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 47630)
-- Name: hh_survey_login_id_seq; Type: SEQUENCE; Schema: sisdp; Owner: postgres
--

CREATE SEQUENCE sisdp.hh_survey_login_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sisdp.hh_survey_login_id_seq OWNER TO postgres;

--
-- TOC entry 4689 (class 0 OID 0)
-- Dependencies: 312
-- Name: hh_survey_login_id_seq; Type: SEQUENCE OWNED BY; Schema: sisdp; Owner: postgres
--

ALTER SEQUENCE sisdp.hh_survey_login_id_seq OWNED BY sisdp.login.id;


--
-- TOC entry 313 (class 1259 OID 47680)
-- Name: mailids_id_seq; Type: SEQUENCE; Schema: sisdp; Owner: postgres
--

CREATE SEQUENCE sisdp.mailids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sisdp.mailids_id_seq OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 47682)
-- Name: mailids; Type: TABLE; Schema: sisdp; Owner: postgres
--

CREATE TABLE sisdp.mailids (
    id bigint DEFAULT nextval('sisdp.mailids_id_seq'::regclass) NOT NULL,
    gpcode character varying(100) NOT NULL,
    bpcode character varying(100) NOT NULL,
    dtcode character varying(100) NOT NULL,
    stcode character varying(100) NOT NULL,
    inst_name character varying(250) NOT NULL,
    primary_mail character varying(100) NOT NULL,
    secondary_mail character varying(100)
);


ALTER TABLE sisdp.mailids OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 47693)
-- Name: users_id_seq; Type: SEQUENCE; Schema: sisdp; Owner: postgres
--

CREATE SEQUENCE sisdp.users_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE sisdp.users_id_seq OWNER TO postgres;

--
-- TOC entry 4402 (class 2604 OID 47695)
-- Name: login id; Type: DEFAULT; Schema: sisdp; Owner: postgres
--

ALTER TABLE ONLY sisdp.login ALTER COLUMN id SET DEFAULT nextval('sisdp.hh_survey_login_id_seq'::regclass);


--
-- TOC entry 4324 (class 0 OID 46173)
-- Dependencies: 219
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 4323 (class 0 OID 45831)
-- Dependencies: 215
-- Data for Name: us_gaz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.us_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4321 (class 0 OID 45817)
-- Dependencies: 213
-- Data for Name: us_lex; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.us_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4322 (class 0 OID 45845)
-- Dependencies: 217
-- Data for Name: us_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.us_rules (id, rule, is_custom) FROM stdin;
\.


--
-- TOC entry 4675 (class 0 OID 57607)
-- Dependencies: 317
-- Data for Name: geotagtbl; Type: TABLE DATA; Schema: sisdp; Owner: postgres
--

COPY sisdp.geotagtbl (id, obs_date, addedby, selstate, seldist, l1class, l2class, l3class, regdisc, otherclass, num_img, photo1, pic1time, latitude1, longitude1, accuracy1, photo2, pic2time, latitude2, longitude2, accuracy2, remark, loc_geom1, loc_geom2) FROM stdin;
48	2022-07-28 23:38:39	test	BIHAR	BHAGALPUR	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)		1	\N	2022-07-28 22:54:41	37.4219983	-122.084	5	\N	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
49	2022-07-28 23:41:23	test	BIHAR	BHAGALPUR	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)		1		2022-07-28 22:54:41	37.4219983	-122.084	5		\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
50	2022-07-28 23:43:06	test	BIHAR	BHAGALPUR	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)		1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQUB\nAQEBAQAAAAAAAAAACgEGBwgJBQQDAgv/xAB0EAEAAAEHAgoRCwoOEAcBAAAAAQIDBAUGBxFRkQgS\nFiExVmFxlfAJExQXGTdBVVd0d4GUsbbU1hU1NjhydbO0wdHVMlRkdpahpLW3xBgiIzRSU4eSk5el\nsuHxCiQlJicoM0VIZXN4goXH0kNER2JmZ6OE/8QAHgEBAAIBBQEBAAAAAAAAAAAAAAcIBgEDBAUJ\nAgr/xABkEQABAgMDAggWDQkECQUAAAAAAQIDBAUGEWEHEggTITFRkZTwFBUWFxg1N0FSU1RVVnF2\nkpahsbXR8TZidHWTlbO00tPU1eEiMjM0cnOBssElY2W2CSNERVd3xMbiJkJkZsP/2gAMAwEAAhED\nEQA/AJ7ADsDuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM\nV3ww/vSke+1C+CpfzxZUYrvh9iUj32oXwVKat107aeUGrYDfAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAABvwA44AAAAAAAAAAAAAAAAD+JyckTUiVOTsuTNzciEZUuXLlQkyJMmGzGVKlRh\n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\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/9k=\n	2022-07-28 22:54:41	37.4219983	-122.084	5	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
51	2022-07-28 23:44:02	test	BIHAR	BHAGALPUR	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)	other class	2	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQUB\nAQEBAQAAAAAAAAAACgEGBwgJBQQDAgv/xAB0EAEAAAEHAgoRCwoOEAcBAAAAAQIDBAUGBxFRkQgS\nFiExVmFxlfAJExQXGTdBVVd0d4GUsbbU1hU1NjhydbO0wdHVMlRkdpahpLW3xBgiIzRSU4eSk5el\nsuHxCiQlJicoM0VIZXN4goXH0kNER2JmZ6OE/8QAHgEBAAIBBQEBAAAAAAAAAAAAAAcIBgEDBAUJ\nAgr/xABkEQABAgMDAggWDQkECQUAAAAAAQIDBAUGEWEHEggTITFRkZTwFBUWFxg1N0FSU1RVVnF2\nkpahsbXR8TZidHWTlbO00tPU1eEiMjM0cnOBssElY2W2CSNERVd3xMbiJkJkZsP/2gAMAwEAAhED\nEQA/AJ7ADsDuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM\nV3ww/vSke+1C+CpfzxZUYrvh9iUj32oXwVKat107aeUGrYDfAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAABvwA44AAAAAAAAAAAAAAAAD+JyckTUiVOTsuTNzciEZUuXLlQkyJMmGzGVKlRh\n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\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/9k=\n	2022-07-28 22:54:41	37.4219983	-122.084	5	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIEAwv/xAByEAEAAAEHAQsUCwsHBgwHAAAAAQIDBAUGBxFRCBIW\nITFWYXGRldQJExQXGTU3QVVXdHeBlLG20dPW8BU2OFRydZeztMHVGCIydpKhsrW3xOEKM0hTeIfH\nIzRSk6XxJCVCR2ZzgoWWo9LlJidDYmRnpv/EAB4BAQACAgIDAQAAAAAAAAAAAAAHCAYJAQMCBAUK\n/8QAZREAAQIDAgQHFxIDBQYHAQAAAAECAwQFBhEHIWHwCBIYMVFxkRMUFRYXNTdBU1RVVnR2kpSV\nsbO10dPxIjI0NlJic3WBk5ahsrTB0tTVM2VyIyVEY7YJQkXExuImQ0ZHZHfD4f/aAAwDAQACEQMR\nAD8A72AH0D7AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAABDGGzuR8iX1tLlzdWU2XNy5UiXJo85Kky5EqMmVJlQhpRkypMYRhGHSjCMIwWt9k\nqx9/03vukec2fXCCAsLWH2kYJa1TaLULP1KrxalS0qjI8lNSsCHDhrNzEpvJzY7XOV+mlnP0yep0\nrkS69FPFzrluuLxYw2dyPkM9DU08cmEfIs77JVj7/pvfc/5xSlsa3raZqiEuZrOsZqXyXMSc/N02\nkyJWEZE7jDPSZ2EdPp6en00SxtGtZiDCiRVsRXnJDarlalSp6Kt2vcqw1Q9eYmmy8GLHcxXNhMV6\ntRUvW7lJfi3TI3GGzuR8hjDZ3I+RhBohr/q5XG+dN8+aIa/6uVxvnTfPvj6u6yfSFaLupTfN7eaY\n/hcM0DnWN2bM9nNcWb+MNncj5DGGzuR8jCDRDX/VyuN86b580Q1/1crjfOm+fNXdZPpCtF3Upvm9\nvNMbhmgc6xuzZns5rizfxhs7kfIYw2dyPkYQaIa/6uVxvnTfPmiGv+rlcb503z5q7rJ9IVou6lN8\n3t5pjcM0DnWN2bM9nNcWb+MNncj5DGGzuR8jCDRDX/VyuN86b580Q1/1crjfOm+fNXdZPpCtD3Up\nvmxwzQOdYvZs8hm/jDZ3I+Qxhs7kfIwg0Q1/1crjfOm+fNENf9XK43zpvnzV3WT6QrRd1Kb5vbzT\nG4ZoHOsbs2Z7Oa4s38YbO5HyGMNncj5GEGiGv+rlcb503z5ohr/q5XG+dN8+au6yfSFaLupTfN7e\naY3DNA51jdmzPZzXFm/jDZ3I+Qxhs7kfIwg0Q1/1crjfOm+fNENf9XK43zpvnzV3WT6QrRd1Kb5v\nbzTG4ZoHOsbs2Z7Oa4s38YbO5HyGMNncj5GEGiGv+rlcb503z5ohr/q5XG+dN8+au6yfSFaLupTf\nN7eaY3DNA51jdmzPZzXFm/jDZ3I+Qxhs7kfIwg0Q1/1crjfOm+fNENf9XK43zpvnzV3WT6QrRd1K\nb5vbzTG4ZoHOsbs2Z7Oa4s38YbO5HyGMNncj5GEGiGv+rlcb503z5ohr/q5XG+dN8+au6yfSFaLu\npTfN7eaY3DNA51jdmzPZzXFm/jDZ3I+Qxhs7kfIwg0Q1/wBXK43zpvnzRDX/AFcrjfOm+fNXdZPp\nCtF3Upvm9vNMbhmgc6xuzZns5rizfxhs7kfIYw2dyPkYQaIa/wCrlcb503z5ohr/AKuVxvnTfPmr\nusn0hWi7qU3ze3mmNwzQOdY3Zsz2c1xZv4w2dyPkMYbO5HyMINENf9XK43zpvnzRDX/VyuN86b58\n1d1k+kK0XdSm+b280xuGaBzrG7NmezmuLN/GGzuR8hjDZ3I+RhBohr/q5XG+dN8+aIa/6uVxvnTf\nPmrusn0hWh7qU3zY4ZoHOsXs2eQzfxhs7kfIYw2dyPkYQaIa/wCrlcb503z5ohr/AKuVxvnTfPmr\nusn0hWi7qU3ze3mmNwzQOdY3Zsz2c1xZv4w2dyPkMYbO5HyMINENf9XK43zpvnzRDX/VyuN86b58\n1d1k+kK0XdSm+b280xuGaBzrG7NmezmuLN/GGzuR8hjDZ3I+RhBohr/q5XG+dN8+aIa/6uVxvnTf\nPmrusn0hWi7qU3ze3mmNwzQOdY3Zsz2c1xZv4w2dyPkMYbO5HyMINENf9XK43zpvnzRDX/VyuN86\nb581d1k+kK0PdSm+bHDNA51i9mzyGb+MNncj5BhBohr/AKuVxvnTfPhq7rJ9IVou6lN83t5pjcM0\nDnWN2bM9nNcWcAC95k4AAAAAAAAAAAAAAAASyuedVP7GnPAtEu7XPOqn9jTngWia4tGb7e7LdaTf\nHFTOp+um1+KhSNtec0OzJj9CeVcpG2vOaHZkx+hPKYz/ALDmfgnd4+dU/YE38C78C0oDCiPQAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADPgB+iAlgAAAAAAAAAAAAAAAAJZXPOqn9jTngWi\nXdrnnVT+xpzwLRNcWjN9vdlutJvjipnU/XTa/FQpG2vOaHZkx+hPKuUjbXnNDsyY/QnlMZ/2HM/B\nO7x86p+wJv4F34FpQGFEegAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGfAD9EBLAAAAA\nAAAAAAAAAAAASyuedVP7GnPAtEu7XPOqn9jTngWia4tGb7e7LdaTfHFTOp+um1+KhSNtec0OzJj9\nCeVcpG2vOaHZkx+hPKYz/sOZ+Cd3j51T9gTfwLvwLSgMKI9AAAAAAAAAAAAAAAAAAAAAAAAAALMQ\nzSGZ3j/z93LfKnYX7eXncZ0nUhtQ8C0WhqwCUXDi+2jaxXqrREswlnVl1pkCUjLM8GVre9kjJNMd\npUgpSoW89JcqrFiab1rTya1HX5LjrK+6PzPHX7uW+VOwv28fdH5njr93LfKnYX7ecmwtNqBbFdPt\nquV/gaRkv/8AL293c8t5psrnmuaY+sn7o/M8dfu5b5U7C/bx90fmeOv3ct8qdhft5ybDnUC2J5dv\nbVdo0jJ/l7e7uN5psrnmuaY+u+yl7V1dvKxnqosNebd7bOtqNQpysqRVdk7aWbtHWMxV0zP0aiz1\nPnqDU9Z0ylTVCmqTTKJR5ylS5qExIn6VR5mXOSZyfmoSrguf/iVXuiLYdpe0fjxdw6AFGcO2DOn4\nJcIU9YymVKcq0pKU+lzjJ2fhwIUy98/KtmIjHMl2thI2G52lYqJerfXKqngqXKqbAAQ4cAAAAAZ8\nAP0QEsAAAAAAAAAABR9Z29snU1On6trKtY0am0bjXH5jkCs57OcemZukTX+Uo9CnZmVnpmdm5f3k\n5Kwz2dlYSoRhBcq6yXgrAUBy0bC9XI711z9nHLRsL1cjvXXP2c5uXYXcUFfigOWjYXq5Heuufs45\naNherkd665+zi5dhdxQVZXPOqn9jTngWiVHWd5diaRV9LmJmuoy52dmJcibk+xlbyc9KlQwhDPS6\nBJkwxyxjCGytzots/wC/49507grW7o0Y0GFbyyrYsWHCctkWqiRIjWKqcGaol6I5UVUvRUv1r0PU\nmJiXguRsaPBhOVt6JEisYqpeqXojnIqpfivTFeVGpG2vOaHZkx+hPPr0W2f9/wAe86dwVTtp6+qm\nsathRqHSuPT0KTNTmcjMUma+8kyZ2EY56emZuT09THGOngpdOzMs+UmGtmIDnOhuRGtiw1cq7CIj\nlVVyIfMqE5KPkpljJqXe90JyNa2PCc5y7CNRyqq5EQt4AxEwUAAAAAAAAAAAAAAAAAAAAAAAAAA4\nzpOpDah4HZi4zpOpDah4Gxz/AGfX8XC3/TYX/q87IfL+T8SIDZIdgAAbMOJVe6Ith2l7SePF3DoA\nc/8AxKr3RFsO0vaTx4u4dADTbo0OTpWPiOzvi2GdL/XL8neQAKoniAAAABnwA/RASwAAAAAAAAAB\niHeb7ea8/wC6/wBS1cy8Yh3m+3mvP+6/1LVzzZrrtfigKDAdoAACEdTuyfDBFCOp3ZPhgi1caOzk\nh2P6zE8eVUwu03suX6n/AP0eAFHjGwAAAAAAAAAAAAAAAAAAAAAAAAAAAA4zpOpDah4HZi4zpOpD\nah4Gxz/Z9fxcLf8ATYX/AKvOyHy/k/EiA2SHYAAGzDiVXuiLYdpe0njxdw6AHP8A8Sq90RbDtL2k\n8eLuHQA026NDk6Vj4js74thnS/1y/J3kACqJ4gAAAAZ8AP0QEsAAAAAAAAAAYhXmx/8AjmvNPqZp\nbVTVdsQ/PD64svWIV5nt4r3bq39T1crfon8Jlq8Fdg6PaCx8zKStSnbXyFGjxJySgz8JZGYo9dnY\njGwY6KxsRY8hLOSInqka1zPWvch8etTkeRlocWXVqPdHbDVXNRyaVYcRypcuJFvYmPXuvRNdShAF\nFdWPhx6MUP6OU3J7zJ9a7JjXDBUvdwvmmgA1Y+HHoxQ/o5TcnvMn1rsjhgqXu4XzTSnLYWmoFi7J\nWotlWk1S5+rLJWdrq09YzFAkTM5Tp+gVBVtJrWmTNCm6TP0WjTlLnaPRJybo0ikUqjTEqflSJM9S\nJibjKnZGB/NMri+nZC9va9g7GR/PC3sYZNOGMMmrpZb5oDoD32dqO8jxNrpzBpKsVLw9ErITVq8K\nmmqVYoM5wvU6LSl4CwYdNSBBqKQ4kCSRrIsXfqdmHLGf6vSuRms1t0o2Fs3SrY06bnq5CixpiVnV\nlILoEd8s1IKQIMa5zYa3Odp4j/VLjuVE5SG8XmmVxWtG9veOxvp6c0yuK1o3t7x2N9PWjoZlqacF\nXQ6rd2Zzy53rkuzfiWWP50nO34+TLkXdyG8XmmVxWtG9veOxvp6c0yuK1o3t7xWN9Pdv1hp6Ohzq\nacFXQ6rd2pzJl293aHEssfzpOdvx8mXIu7kN4vNMritaN7e8VjfT3a9dRzTK4rWje3vHY309aOhx\nqacFXQ6rd2Zzy53rkucSyx/Ok52/HyZci7uQ3i80yuK1o3t7x2N9PTmmVxWtG9veKxvp7tesdLR0\nGppwVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5DeLzTK4rWje3vHY309OaZXFa0b2947G+nrR0Gppw\nVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5DeLzTK4rWje3vHY309OaZXFa0b294rG+nu36w09HQ51N\nOCrodVu7U5ky7e7tDiWWP50nO34+TLkXdyG8XmmVxWtG9veOxvp6c0yuK1o3t7x2N9PWjocamnBV\n0Oq3dmc8ud65LnEssfzpOdvx8mXIu7kN4vNMritaN7e8djfT05plcVrRvb3isb6e7XrHS0dBqacF\nXQ6rd2Zzy53rkucSyx/Ok52/HyZci7uQ3i80yuK1o3t7x2N9PTmmVxWtG9veOxvp60dBqacFXQ6r\nd2Zzy53rkucSyx/Ok52/HyZci7uQ3i80yuK1o3t7x2N9PTmmVxWtG9veKxvp7t+sNPR0OdTTgq6H\nVbu1OZMu3u7Q4llj+dJzt+Pky5F3chvF5plcVrRvb3jsb6enNMritaN7e8djfT1o6HGppwVdDqt3\nZnPLneuS5xLLH86Tnb8fJlyLu5DeLzTK4rWje3vFY3092/XVc0yuK1o3t7xWN9Pdr1jpaOg1NOCr\nodVu7M55c71yXOJZY/nSc7fj5MuRd3IbxeaZXFa0b2947G+npzTK4rWje3vHY309aOg1NOCrodVu\n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\n	2022-07-28 23:43:47	37.4219983	-122.084	3.0750000476837	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	0101000020E61000004C37894160855EC0DABB500A04B64240
52	2022-07-28 23:48:36	test	BIHAR	BHAGALPUR	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)	other class	2	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQUB\nAQEBAQAAAAAAAAAACgEGBwgJBQQDAgv/xAB0EAEAAAEHAgoRCwoOEAcBAAAAAQIDBAUGBxFRkQgS\nFiExVmFxlfAJExQXGTdBVVd0d4GUsbbU1hU1NjhydbO0wdHVMlRkdpahpLW3xBgiIzRSU4eSk5el\nsuHxCiQlJicoM0VIZXN4goXH0kNER2JmZ6OE/8QAHgEBAAIBBQEBAAAAAAAAAAAAAAcIBgEDBAUJ\nAgr/xABkEQABAgMDAggWDQkECQUAAAAAAQIDBAUGEWEHEggTITFRkZTwFBUWFxg1N0FSU1RVVnF2\nkpahsbXR8TZidHWTlbO00tPU1eEiMjM0cnOBssElY2W2CSNERVd3xMbiJkJkZsP/2gAMAwEAAhED\nEQA/AJ7ADsDuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM\nV3ww/vSke+1C+CpfzxZUYrvh9iUj32oXwVKat107aeUGrYDfAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAABvwA44AAAAAAAAAAAAAAAAD+JyckTUiVOTsuTNzciEZUuXLlQkyJMmGzGVKlRh\n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\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/9k=\n	2022-07-28 22:54:41	37.4219983	-122.084	5	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIEAwv/xAByEAEAAAEHAQsUCwsHBgwHAAAAAQIDBAUGBxFRCBIW\nITFWYXGRldQJExQXGTU3QVVXdHeBlLG20dPW8BU2OFRydZeztMHVGCIydpKhsrW3xOEKM0hTeIfH\nIzRSk6XxJCVCR2ZzgoWWo9LlJidDYmRnpv/EAB4BAQACAgIDAQAAAAAAAAAAAAAHCAYJAQMCBAUK\n/8QAZREAAQIDAgQHFxIDBQYHAQAAAAECAwQFBhEHIWHwCBIYMVFxkRMUFRYXNTdBU1RVVnR2kpSV\nsbO10dPxIjI0NlJic3WBk5ahsrTB0tTVM2VyIyVEY7YJQkXExuImQ0ZHZHfD4f/aAAwDAQACEQMR\nAD8A72AH0D7AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAABDGGzuR8iX1tLlzdWU2XNy5UiXJo85Kky5EqMmVJlQhpRkypMYRhGHSjCMIwWt9k\nqx9/03vukec2fXCCAsLWH2kYJa1TaLULP1KrxalS0qjI8lNSsCHDhrNzEpvJzY7XOV+mlnP0yep0\nrkS69FPFzrluuLxYw2dyPkM9DU08cmEfIs77JVj7/pvfc/5xSlsa3raZqiEuZrOsZqXyXMSc/N02\nkyJWEZE7jDPSZ2EdPp6en00SxtGtZiDCiRVsRXnJDarlalSp6Kt2vcqw1Q9eYmmy8GLHcxXNhMV6\ntRUvW7lJfi3TI3GGzuR8hjDZ3I+RhBohr/q5XG+dN8+aIa/6uVxvnTfPvj6u6yfSFaLupTfN7eaY\n/hcM0DnWN2bM9nNcWb+MNncj5DGGzuR8jCDRDX/VyuN86b580Q1/1crjfOm+fNXdZPpCtF3Upvm9\nvNMbhmgc6xuzZns5rizfxhs7kfIYw2dyPkYQaIa/6uVxvnTfPmiGv+rlcb503z5q7rJ9IVou6lN8\n3t5pjcM0DnWN2bM9nNcWb+MNncj5DGGzuR8jCDRDX/VyuN86b580Q1/1crjfOm+fNXdZPpCtD3Up\nvmxwzQOdYvZs8hm/jDZ3I+Qxhs7kfIwg0Q1/1crjfOm+fNENf9XK43zpvnzV3WT6QrRd1Kb5vbzT\nG4ZoHOsbs2Z7Oa4s38YbO5HyGMNncj5GEGiGv+rlcb503z5ohr/q5XG+dN8+au6yfSFaLupTfN7e\naY3DNA51jdmzPZzXFm/jDZ3I+Qxhs7kfIwg0Q1/1crjfOm+fNENf9XK43zpvnzV3WT6QrRd1Kb5v\nbzTG4ZoHOsbs2Z7Oa4s38YbO5HyGMNncj5GEGiGv+rlcb503z5ohr/q5XG+dN8+au6yfSFaLupTf\nN7eaY3DNA51jdmzPZzXFm/jDZ3I+Qxhs7kfIwg0Q1/1crjfOm+fNENf9XK43zpvnzV3WT6QrRd1K\nb5vbzTG4ZoHOsbs2Z7Oa4s38YbO5HyGMNncj5GEGiGv+rlcb503z5ohr/q5XG+dN8+au6yfSFaLu\npTfN7eaY3DNA51jdmzPZzXFm/jDZ3I+Qxhs7kfIwg0Q1/wBXK43zpvnzRDX/AFcrjfOm+fNXdZPp\nCtF3Upvm9vNMbhmgc6xuzZns5rizfxhs7kfIYw2dyPkYQaIa/wCrlcb503z5ohr/AKuVxvnTfPmr\nusn0hWi7qU3ze3mmNwzQOdY3Zsz2c1xZv4w2dyPkMYbO5HyMINENf9XK43zpvnzRDX/VyuN86b58\n1d1k+kK0XdSm+b280xuGaBzrG7NmezmuLN/GGzuR8hjDZ3I+RhBohr/q5XG+dN8+aIa/6uVxvnTf\nPmrusn0hWh7qU3zY4ZoHOsXs2eQzfxhs7kfIYw2dyPkYQaIa/wCrlcb503z5ohr/AKuVxvnTfPmr\nusn0hWi7qU3ze3mmNwzQOdY3Zsz2c1xZv4w2dyPkMYbO5HyMINENf9XK43zpvnzRDX/VyuN86b58\n1d1k+kK0XdSm+b280xuGaBzrG7NmezmuLN/GGzuR8hjDZ3I+RhBohr/q5XG+dN8+aIa/6uVxvnTf\nPmrusn0hWi7qU3ze3mmNwzQOdY3Zsz2c1xZv4w2dyPkMYbO5HyMINENf9XK43zpvnzRDX/VyuN86\nb581d1k+kK0PdSm+bHDNA51i9mzyGb+MNncj5BhBohr/AKuVxvnTfPhq7rJ9IVou6lN83t5pjcM0\nDnWN2bM9nNcWcAC95k4AAAAAAAAAAAAAAAASyuedVP7GnPAtEu7XPOqn9jTngWia4tGb7e7LdaTf\nHFTOp+um1+KhSNtec0OzJj9CeVcpG2vOaHZkx+hPKYz/ALDmfgnd4+dU/YE38C78C0oDCiPQAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADPgB+iAlgAAAAAAAAAAAAAAAAJZXPOqn9jTngWi\nXdrnnVT+xpzwLRNcWjN9vdlutJvjipnU/XTa/FQpG2vOaHZkx+hPKuUjbXnNDsyY/QnlMZ/2HM/B\nO7x86p+wJv4F34FpQGFEegAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGfAD9EBLAAAAA\nAAAAAAAAAAAASyuedVP7GnPAtEu7XPOqn9jTngWia4tGb7e7LdaTfHFTOp+um1+KhSNtec0OzJj9\nCeVcpG2vOaHZkx+hPKYz/sOZ+Cd3j51T9gTfwLvwLSgMKI9AAAAAAAAAAAAAAAAAAAAAAAAAALMQ\nzSGZ3j/z93LfKnYX7eXncZ0nUhtQ8C0WhqwCUXDi+2jaxXqrREswlnVl1pkCUjLM8GVre9kjJNMd\npUgpSoW89JcqrFiab1rTya1HX5LjrK+6PzPHX7uW+VOwv28fdH5njr93LfKnYX7ecmwtNqBbFdPt\nquV/gaRkv/8AL293c8t5psrnmuaY+sn7o/M8dfu5b5U7C/bx90fmeOv3ct8qdhft5ybDnUC2J5dv\nbVdo0jJ/l7e7uN5psrnmuaY+u+yl7V1dvKxnqosNebd7bOtqNQpysqRVdk7aWbtHWMxV0zP0aiz1\nPnqDU9Z0ylTVCmqTTKJR5ylS5qExIn6VR5mXOSZyfmoSrguf/iVXuiLYdpe0fjxdw6AFGcO2DOn4\nJcIU9YymVKcq0pKU+lzjJ2fhwIUy98/KtmIjHMl2thI2G52lYqJerfXKqngqXKqbAAQ4cAAAAAZ8\nAP0QEsAAAAAAAAAABR9Z29snU1On6trKtY0am0bjXH5jkCs57OcemZukTX+Uo9CnZmVnpmdm5f3k\n5Kwz2dlYSoRhBcq6yXgrAUBy0bC9XI711z9nHLRsL1cjvXXP2c5uXYXcUFfigOWjYXq5Heuufs45\naNherkd665+zi5dhdxQVZXPOqn9jTngWiVHWd5diaRV9LmJmuoy52dmJcibk+xlbyc9KlQwhDPS6\nBJkwxyxjCGytzots/wC/49507grW7o0Y0GFbyyrYsWHCctkWqiRIjWKqcGaol6I5UVUvRUv1r0PU\nmJiXguRsaPBhOVt6JEisYqpeqXojnIqpfivTFeVGpG2vOaHZkx+hPPr0W2f9/wAe86dwVTtp6+qm\nsathRqHSuPT0KTNTmcjMUma+8kyZ2EY56emZuT09THGOngpdOzMs+UmGtmIDnOhuRGtiw1cq7CIj\nlVVyIfMqE5KPkpljJqXe90JyNa2PCc5y7CNRyqq5EQt4AxEwUAAAAAAAAAAAAAAAAAAAAAAAAAA4\nzpOpDah4HZi4zpOpDah4Gxz/AGfX8XC3/TYX/q87IfL+T8SIDZIdgAAbMOJVe6Ith2l7SePF3DoA\nc/8AxKr3RFsO0vaTx4u4dADTbo0OTpWPiOzvi2GdL/XL8neQAKoniAAAABnwA/RASwAAAAAAAAAB\niHeb7ea8/wC6/wBS1cy8Yh3m+3mvP+6/1LVzzZrrtfigKDAdoAACEdTuyfDBFCOp3ZPhgi1caOzk\nh2P6zE8eVUwu03suX6n/AP0eAFHjGwAAAAAAAAAAAAAAAAAAAAAAAAAAAA4zpOpDah4HZi4zpOpD\nah4Gxz/Z9fxcLf8ATYX/AKvOyHy/k/EiA2SHYAAGzDiVXuiLYdpe0njxdw6AHP8A8Sq90RbDtL2k\n8eLuHQA026NDk6Vj4js74thnS/1y/J3kACqJ4gAAAAZ8AP0QEsAAAAAAAAAAYhXmx/8AjmvNPqZp\nbVTVdsQ/PD64svWIV5nt4r3bq39T1crfon8Jlq8Fdg6PaCx8zKStSnbXyFGjxJySgz8JZGYo9dnY\njGwY6KxsRY8hLOSInqka1zPWvch8etTkeRlocWXVqPdHbDVXNRyaVYcRypcuJFvYmPXuvRNdShAF\nFdWPhx6MUP6OU3J7zJ9a7JjXDBUvdwvmmgA1Y+HHoxQ/o5TcnvMn1rsjhgqXu4XzTSnLYWmoFi7J\nWotlWk1S5+rLJWdrq09YzFAkTM5Tp+gVBVtJrWmTNCm6TP0WjTlLnaPRJybo0ikUqjTEqflSJM9S\nJibjKnZGB/NMri+nZC9va9g7GR/PC3sYZNOGMMmrpZb5oDoD32dqO8jxNrpzBpKsVLw9ErITVq8K\nmmqVYoM5wvU6LSl4CwYdNSBBqKQ4kCSRrIsXfqdmHLGf6vSuRms1t0o2Fs3SrY06bnq5CixpiVnV\nlILoEd8s1IKQIMa5zYa3Odp4j/VLjuVE5SG8XmmVxWtG9veOxvp6c0yuK1o3t7x2N9PWjoZlqacF\nXQ6rd2Zzy53rkuzfiWWP50nO34+TLkXdyG8XmmVxWtG9veOxvp6c0yuK1o3t7xWN9Pdv1hp6Ohzq\nacFXQ6rd2pzJl293aHEssfzpOdvx8mXIu7kN4vNMritaN7e8VjfT3a9dRzTK4rWje3vHY309aOhx\nqacFXQ6rd2Zzy53rkucSyx/Ok52/HyZci7uQ3i80yuK1o3t7x2N9PTmmVxWtG9veKxvp7tesdLR0\nGppwVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5DeLzTK4rWje3vHY309OaZXFa0b2947G+nrR0Gppw\nVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5DeLzTK4rWje3vHY309OaZXFa0b294rG+nu36w09HQ51N\nOCrodVu7U5ky7e7tDiWWP50nO34+TLkXdyG8XmmVxWtG9veOxvp6c0yuK1o3t7x2N9PWjocamnBV\n0Oq3dmc8ud65LnEssfzpOdvx8mXIu7kN4vNMritaN7e8djfT05plcVrRvb3isb6e7XrHS0dBqacF\nXQ6rd2Zzy53rkucSyx/Ok52/HyZci7uQ3i80yuK1o3t7x2N9PTmmVxWtG9veOxvp60dBqacFXQ6r\nd2Zzy53rkucSyx/Ok52/HyZci7uQ3i80yuK1o3t7x2N9PTmmVxWtG9veKxvp7t+sNPR0OdTTgq6H\nVbu1OZMu3u7Q4llj+dJzt+Pky5F3chvF5plcVrRvb3jsb6enNMritaN7e8djfT1o6HGppwVdDqt3\nZnPLneuS5xLLH86Tnb8fJlyLu5DeLzTK4rWje3vFY3092/XVc0yuK1o3t7xWN9Pdr1jpaOg1NOCr\nodVu7M55c71yXOJZY/nSc7fj5MuRd3IbxeaZXFa0b2947G+npzTK4rWje3vHY309aOg1NOCrodVu\n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\n	2022-07-28 23:43:47	37.4219983	-122.084	3.0750000476837	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	0101000020E61000004C37894160855EC0DABB500A04B64240
53	2022-07-28 23:58:21	test	BIHAR	BHAGALPUR	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)	other class	2	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQUB\nAQEBAQAAAAAAAAAACgEGBwgJBQQDAgv/xAB0EAEAAAEHAgoRCwoOEAcBAAAAAQIDBAUGBxFRkQgS\nFiExVmFxlfAJExQXGTdBVVd0d4GUsbbU1hU1NjhydbO0wdHVMlRkdpahpLW3xBgiIzRSU4eSk5el\nsuHxCiQlJicoM0VIZXN4goXH0kNER2JmZ6OE/8QAHgEBAAIBBQEBAAAAAAAAAAAAAAcIBgEDBAUJ\nAgr/xABkEQABAgMDAggWDQkECQUAAAAAAQIDBAUGEWEHEggTITFRkZTwFBUWFxg1N0FSU1RVVnF2\nkpahsbXR8TZidHWTlbO00tPU1eEiMjM0cnOBssElY2W2CSNERVd3xMbiJkJkZsP/2gAMAwEAAhED\nEQA/AJ7ADsDuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM\nV3ww/vSke+1C+CpfzxZUYrvh9iUj32oXwVKat107aeUGrYDfAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAABvwA44AAAAAAAAAAAAAAAAD+JyckTUiVOTsuTNzciEZUuXLlQkyJMmGzGVKlRh\n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\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/9k=\n	2022-07-28 22:54:41	37.4219983	-122.084	5	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIEAwv/xAByEAEAAAEHAQsUCwsHBgwHAAAAAQIDBAUGBxFRCBIW\nITFWYXGRldQJExQXGTU3QVVXdHeBlLG20dPW8BU2OFRydZeztMHVGCIydpKhsrW3xOEKM0hTeIfH\nIzRSk6XxJCVCR2ZzgoWWo9LlJidDYmRnpv/EAB4BAQACAgIDAQAAAAAAAAAAAAAHCAYJAQMCBAUK\n/8QAZREAAQIDAgQHFxIDBQYHAQAAAAECAwQFBhEHIWHwCBIYMVFxkRMUFRYXNTdBU1RVVnR2kpSV\nsbO10dPxIjI0NlJic3WBk5ahsrTB0tTVM2VyIyVEY7YJQkXExuImQ0ZHZHfD4f/aAAwDAQACEQMR\nAD8A72AH0D7AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAABDGGzuR8iX1tLlzdWU2XNy5UiXJo85Kky5EqMmVJlQhpRkypMYRhGHSjCMIwWt9k\nqx9/03vukec2fXCCAsLWH2kYJa1TaLULP1KrxalS0qjI8lNSsCHDhrNzEpvJzY7XOV+mlnP0yep0\nrkS69FPFzrluuLxYw2dyPkM9DU08cmEfIs77JVj7/pvfc/5xSlsa3raZqiEuZrOsZqXyXMSc/N02\nkyJWEZE7jDPSZ2EdPp6en00SxtGtZiDCiRVsRXnJDarlalSp6Kt2vcqw1Q9eYmmy8GLHcxXNhMV6\n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\nWotlWk1S5+rLJWdrq09YzFAkTM5Tp+gVBVtJrWmTNCm6TP0WjTlLnaPRJybo0ikUqjTEqflSJM9S\nJibjKnZGB/NMri+nZC9va9g7GR/PC3sYZNOGMMmrpZb5oDoD32dqO8jxNrpzBpKsVLw9ErITVq8K\nmmqVYoM5wvU6LSl4CwYdNSBBqKQ4kCSRrIsXfqdmHLGf6vSuRms1t0o2Fs3SrY06bnq5CixpiVnV\nlILoEd8s1IKQIMa5zYa3Odp4j/VLjuVE5SG8XmmVxWtG9veOxvp6c0yuK1o3t7x2N9PWjoZlqacF\nXQ6rd2Zzy53rkuzfiWWP50nO34+TLkXdyG8XmmVxWtG9veOxvp6c0yuK1o3t7xWN9Pdv1hp6Ohzq\nacFXQ6rd2pzJl293aHEssfzpOdvx8mXIu7kN4vNMritaN7e8VjfT3a9dRzTK4rWje3vHY309aOhx\nqacFXQ6rd2Zzy53rkucSyx/Ok52/HyZci7uQ3i80yuK1o3t7x2N9PTmmVxWtG9veKxvp7tesdLR0\nGppwVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5DeLzTK4rWje3vHY309OaZXFa0b2947G+nrR0Gppw\nVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5DeLzTK4rWje3vHY309OaZXFa0b294rG+nu36w09HQ51N\nOCrodVu7U5ky7e7tDiWWP50nO34+TLkXdyG8XmmVxWtG9veOxvp6c0yuK1o3t7x2N9PWjocamnBV\n0Oq3dmc8ud65LnEssfzpOdvx8mXIu7kN4vNMritaN7e8djfT05plcVrRvb3isb6e7XrHS0dBqacF\nXQ6rd2Zzy53rkucSyx/Ok52/HyZci7uQ3i80yuK1o3t7x2N9PTmmVxWtG9veOxvp60dBqacFXQ6r\nd2Zzy53rkucSyx/Ok52/HyZci7uQ3i80yuK1o3t7x2N9PTmmVxWtG9veKxvp7t+sNPR0OdTTgq6H\nVbu1OZMu3u7Q4llj+dJzt+Pky5F3chvF5plcVrRvb3jsb6enNMritaN7e8djfT1o6HGppwVdDqt3\nZnPLneuS5xLLH86Tnb8fJlyLu5DeLzTK4rWje3vFY3092/XVc0yuK1o3t7xWN9Pdr1jpaOg1NOCr\nodVu7M55c71yXOJZY/nSc7fj5MuRd3IbxeaZXFa0b2947G+npzTK4rWje3vHY309aOg1NOCrodVu\n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\n	2022-07-28 23:43:47	37.4219983	-122.084	3.0750000476837	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	0101000020E61000004C37894160855EC0DABB500A04B64240
54	2022-07-28 23:59:44	test	BIHAR	AURANGABAD	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)		2	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgQCAwv/xABzEAEAAAEHAA4QDQ4HDQkBAAAAAQIDBAUGBxEIEhYZ\nITFBUVZhcZGV1AkTFzdVV3R3gZSxtLbR1vAUFTI1OFRydZahs8HVGDQ2UlNkdpKTl6Syt8QiIzOl\ntcfhCicoRUhlZnOChYfS0yQlJkNERoSGxvH/xAAeAQEAAgIDAQEBAAAAAAAAAAAABwgGCQEEBQMK\nAv/EAGURAAECAwIFCBEQBgUKBwAAAAABAgMEBQYRBxIhYfAIEzFRcZGU0RQVFhcYNTdBU1RVVnaS\nsbXxNlJic3R1k5WWobO00tPU1TIzNGVygSJEY7LBCSUmRVeitsTG4SNCZGbCw+L/2gAMAwEAAhED\nEQA/AO9gB6B7AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAF\nq74Yf+EpHvtQvkqX44rqLV3w/YlI99qF8lSnLdlN1PKDFsB9wAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAZ8AOuAAAAAAAAAAAAAAAAA+JyckTUiVOTkuTNzciEZUuXLlQkyZMmGnGVKjGE\n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\nAAAAAAAAAAAAAAAAAAAAAB//2Q==\n	2022-07-28 23:59:28	37.4219983	-122.084	3.0750000476837	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIEAwv/xABxEAEAAAEHAQsUCwkLBwwDAAAAAQIDBAUGBxFRCBIW\nITFWYXGRldQJExcZNTdBVVd0d4GUsbS20dPW8BQVMjhUcnWXs8HVGCI2dpKhssThCjM0SFJTh5O1\nt8cjJSdClqXxQ0dlZnOCg6Ok0uTlYmSm/8QAHgEBAAEEAwEBAAAAAAAAAAAAAAgBBgcJAwQFAgr/\nxABlEQABAgMCBAcXEgMECQUBAAAAAQIDBAUGEQchYfAIEhgxUXGRExQVFhc1N0FTVFVWdHaSlJWx\ns7XR0/EiMzQ2UmJzdYGTlqGytMHS1NUyZXIlRGO2CSNCRaPExuHiJkNGZHfD/9oADAMBAAIRAxEA\nPwDvYAegewAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAQxhs7kfIl9bS5c3VlNlzcuVIlyaPOSpMuRKjJlSZUIaUZMqTGEYRh0IwjCMFrfbKs\nfh9N7rpHnNn1wgwFhaw+0jBLWqbRahZ+pVeLUqWlUZHkpqVgQ4cNZuYlN5ObHa5yv00s5+mT1Olc\niXXop8udct1xeLGGzuR8hnoamnjkwj5FnfbKsfh9N7rn/OKUtjW9bTNUQlzNZ1jNS/ZcxJz83TaT\nIlYRkTuMM9JnYR0+jp6fRYljaNazEGFEirYivOSG1XK1KlT0Vbte5Vhqh15iabLwYsdzFc2ExXq1\n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\n8itXVj4cejFD+jlNye8yfWuyWRwwVL3cL5ppTlsLTUCxdkrUWyrSapc/VlkrO11aesZigSJmcp0/\nQKgq2k1rTJmhTdJn6LRpylztHok5N0aRSKVRpiVPypEmepExNxlTsjA/lmVxfRshe3te0djI/nhb\n2MMmnDGGTV0st80Bzh77OxHeR4m105g2SrFS8PRKyE1avCppqlWKDOcL1Oi0peAsGHTUgQaikOJA\nkkayLF36nZhyxn+r0rkZrNbdlGwtm6VbGnTc9XIUWNMSs6spBdAjvlmpBSBBjXObDW5ztPEf6pcd\nyonKQ3i8syuK1o3t7x2N9PTlmVxWtG9veOxvp60dC8tTTgq6HVbuzOeXO9cl178Syx/Ok52/HyZc\ni7uQ3i8syuK1o3t7x2N9PTlmVxWtG9veKxvp7t+sNPR0K6mnBV0Oq3dqcyZdvd2hxLLH86Tnb8fJ\nlyLu5DeLyzK4rWje3vFY3092vXUcsyuK1o3t7x2N9PWjoU1NOCrodVu7M55c71yXOJZY/nSc7fj5\nMuRd3IbxeWZXFa0b2947G+npyzK4rWje3vFY3092vWOlo6DU04Kuh1W7sznlzvXJc4llj+dJzt+P\nky5F3chvF5ZlcVrRvb3jsb6enLMritaN7e8djfT1o6DU04Kuh1W7sznlzvXJc4llj+dJzt+Pky5F\n3chvF5ZlcVrRvb3jsb6enLMritaN7e8VjfT3b9YaejoV1NOCrodVu7U5ky7e7tDiWWP50nO34+TL\nkXdyG8XlmVxWtG9veOxvp6csyuK1o3t7x2N9PWjoU1NOCrodVu7M55c71yXOJZY/nSc7fj5MuRd3\nIbxeWZXFa0b2947G+npyzK4rWje3vFY3092vWOlo6DU04Kuh1W7sznlzvXJc4llj+dJzt+Pky5F3\nchvF5ZlcVrRvb3jsb6enLMritaN7e8djfT1o6DU04Kuh1W7sznlzvXJc4llj+dJzt+Pky5F3chvF\n5ZlcVrRvb3jsb6enLMritaN7e8VjfT3b9YaejoV1NOCrodVu7U5ky7e7tDiWWP50nO34+TLkXdyG\n8XlmVxWtG9veOxvp6csyuK1o3t7x2N9PWjoU1NOCrodVu7M55c71yXOJZY/nSc7fj5MuRd3IbxeW\nZXFa0b294rG+nu366rlmVxWtG9veKxvp7tesdLR0GppwVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5\nDeLyzK4rWje3vHY309OWZXFa0b2947G+nrR0GppwVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5DeLy\nzK4rWje32qisbl/H2HQ/P+bQDJs3T4yYf5WiamGnLnoY4Ywxw9jx0o4QjDo4R04QjpK5GVsGFj6J\nghWtrYqDHlFtClNSpLOzD6hvRKVv9vnvPe9+8tLwRmdPpP49M3TfwNuqmC2yCa0pOcr+/wAfJl29\n3dojQ1T/AOdon9ZPcHNDVP8A52if1k9wdW4yxw82h5vL9qwvIV4l1kOdZzt+YyZcn17d9EaGqf8A\nztE/rJ7g+16w02hqn/ztE/rJ7g+36x0q3Dh6tDzeX7VheQcS6yHOs52/MZMuT69u+h9DVOx/fqJq\nfzk92/8AkNr1iaGqw/naH/Wz3BlcDA1vsFFjsJdo49qrVSs5M1iYlpWVixZSfjyUF0GThNgwESBB\nVIbVbDbc5yJe5VvXGUXBZY9VvWUnOV/f4+TLkXdyFD6Gqw/naH/Wz/B2zbMUZq273M3XbWmsbbip\nLZ1rWlc24pdpqLP2Uq+o6dV83QJ+oagqqRMz89XFoqipEimQpFVUiXLm5uizszxmcmJcmflS4zk3\nN4Aiy9TTgr6HVbuzOZMuT61yFOJZY/nSc7fj5MuRd3IbxeWZXFa0b2947G+npyzK4rWje3vHY309\naOhTU04Kuh1W7sznlzvXJc4llj+dJzt+Pky5F3chvF5ZlcVrRvb3jsb6ejR0K6mnBV0Nq3K/3zN5\nPIu6o4llj+dJzt+Pky5F3ch3oAJ+mNAAAAAAAALZW0vG0IVpR6t9pvbHj9XzVO4/7Y+xM7x2kUqj\n8a437BpOezvsbP5/jkMc/nc5DO56VSHJw/6r/wC+v/qX1pXLyvrTygv4tPaLm7Tv/A8Fo6m+Th/1\nX/31/wDUqSrC8n2wp1IpvtLxnj0ZEONe2PHM7xuam5v3fsCRjjnM97iGGOGnhjGIGjTjQ5XBjZ6J\nHdpGLb2msR1zneqWgWlciXMRy40a5b7rsWveqX9ScmoEoxkSYfvNjn6RHaV773KiuRLmNcus1y3q\nl2LXvVCuRbvR9/0T/wCv/wDhmj7/AKJ/9f8A/DazOCshzf8A4UbzZ53Bqmc8/wDBmPNFupOpDah3\nkSEMIQhkhgLPLDLR5oDnD32diO8jxNrpzBunzNAc4e+zsR3keJtdOYNPfQm+0y0nXO7xVTiRWBzj\n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\n5LkyIYypUIRoiKqoiIqqq3IiY1VV1kROWqnGiK5Ua1FVVW5ERFVVVdZERMaquwh9IpjRtY3XbZnf\n6quFeuEY9CJo2sZruszv9VWO57Kx/bparl3hG5jF+bf5Dl32mOYRvmn/AJSpxTGjaxmu6zG/1VcL\n9dLKaNrGa7bM7/VVwv8APsRyRN4R+Yxfm3+Qb7THMI3zT/ylTimNG1jOha2zMdqvqqj+t+ullgjo\n1sbrtszv9VXC3y6FEYl74b2prXuY5qX7F6oiHy6DGYmmfCiMbraZ0NzUvXWS9URMZUwpnRrY3XbZ\nnf6quFmjWxuu2zO/1VcLfBxlTD56LS6LTqPNUuhUmj0yiz8nPzNJos9N0ijz0jGMM9NT01Klzc5J\nxhGGekSpUMYRhjjCL6AAFoPug7g8IR5N90GnCEeeVYzUjDHp1k+tVGudfpWuddr3Iq3bdxzwZWZm\ndNvvLx5jSaXT7xgxIuk01+l02ka7S6bSu0t91+lW7WUu+LQfdB3B9W+6D5y7GfbR90HcH1b7oPnL\nsZ9tPrecT3D+xd5Dn4F1PodPdqTHmy74tB90HcH1b7oPnKsZ9tbEUfug7g+rfdB85VjPtrZhum84\nnM39i7yDgXU+h092pMebLvC0UjNA3DTkc7N323RS5WGOEi8mxsqOGMIY4Sa6jHDGMIY5YwfpyfLi\n+rTdN841j/tlRWPTXY5Ntq+QotNqKLcshOouvcsrHRbl1luWHyy7ItNyfLi+rTdN841j/tlW1mbY\nWRtpQp6srHWps5ayrqPSpdCpFPszXdWV9Qpimzc1Mz85Q56lVXSqVMTVKkTFJo89Lo8uckz0man5\nmcjIhInZEqVRUVNdFTbRc+WhxRJObgtV8aVmITEVEV8SBFY1FXEiK5zUS9V1kvxlRgKHXAADqoAY\n3P0UAAAfNSIaUjZlRx2fvZWrtY6T6Xz0jUkfGj+jF7VnePVP+GXwUQtq2Htaq3wEP7xBPmwhkhue\nuWO6YQyQ3ERmYjoc+/FXPfEWM7C9nfHi8VrHbOOKue+IsZ2F7O+PF4rWO6UT+N22cLv4l+TvIAHw\nfIAAAAAB5FR9ch/0L9pfKQl0Tvtts/1up4yngrm73m/K6wpP0kwoZXN3vN+V1hSfpJh5xGkveAA5\nxv3QHCGGZKh0IcnnCEdPqM5XOPhDJDcg6Of3QH/FK/p5/wAGXOOznZBE4Xadi1kmETtuObjNC8q8\n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\nE9yLZj47pHhYpErRqchKb65aB4WOAGt40+G0i5bnW2L+Sf1qkroLX3Lc62xfyT+tUldAAAAAAAAA\nAAAAAAAAAdVADG5+igAAAAAAAAAAAAAAAAKftX+Dlc9Yz3egxnZMWr/ByuesZ7vQYzs0YNONVQ+M\nP+WgkA9Fr7dLN9a7fG1RDDXN1VxSqkuPmqbQ5FHnJ2NtrPzMZNJkTkubzk5Q65jGOdmp2ZlZ6EZE\nnCOfwhDHGEWZTCDigXOEmvx7s54FXa9qxxrnup394h9XOM9S6kjfZU1Cckavfg1U9z0zh5yRq9+D\nVT3PTOHqBGKTChX3JGr34NVPc9M4eckavfg1U9z0zh6gQBX3JGr34NVPc9M4eckavfg1U9z0zh6g\nQBX3JGr34NVPc9M4eckavfg1U9z0zh6gQBX3JGr34NVPc9M4eckavfg1U9z0zh6gQBX3JGr34NVP\nc9M4eckavfg1U9z0zh6gQBX3JGr34NVPc9M4epe2dd0y29m6xsvWsijUegVpGh8fnqum52Zpk37C\np1GrGajMzlJn6ZMQz09RJuROQnKNOQlTUqXJk5yXGTOSZShHVk7f1RX9gr5JVg+uyheMZcylgP5M\neC7r8st44lC0vIasx0wr/uqrfso5DVmOmFf91Vb9lLtjbUb5i0nIasx0wr/uqrfso5DVmOmFf91V\nb9lLtgC0nIasx0wr/uqrfso5DVmOmFf91Vb9lLtiPGie5Fsx8d0jwkUiVo1OQlN9ctA8LHLSchqz\nHTCv+6qt+yjkNWY6YV/3VVv2Uu2Nbxp8KgsvaWsLJ1BVdnKumqHPUKqaP7Go87TZqenaXLm+OS5z\nPT85MUijTMqXGVOStObmJuTCGEM7jCMYz7kjV78GqnuemcPUCAK+5I1e/Bqp7npnDzkjV78Gqnue\nmcPUCAK+5I1e/Bqp7npnDzkjV78GqnuemcPUCAK+5I1e/Bqp7npnDzkjV78GqnuemcPUCAK+5I1e\n/Bqp7npnDzkjV78GqnuemcPUCAK+5I1e/Bqp7npnDzkjV78GqnuemcPUCAK+5I1e/Bqp7npnDzkj\nV78GqnuemcPUCAK+5I1e/Bqp7npnDxQIA7UAGNz9FAAAAAAAAAAAAAAAAAU/av8AByuesZ7vQYzs\nradRZmm0Ok0WkSOOTE/NS5udm4SpUjPSIw04Z6RKky5OOGrJlQjkUXoKs50sld10/Z//AGfXDbxy\n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\n	2022-07-28 23:59:37	37.4219983	-122.084	3.0750000476837	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	0101000020E61000004C37894160855EC0DABB500A04B64240
56	2022-07-29 00:03:32	test	BIHAR	AURANGABAD	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)		1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgQCAwv/xABzEAEAAAEHAA4QDQ4HDQkBAAAAAQIDBAUGBxEIEhYZ\nITFBUVZhcZGV1AkTFzdVV3R3gZSxtLbR1vAUFTI1OFRydZahs8HVGDQ2UlNkdpKTl6Syt8QiIzOl\ntcfhCicoRUhlZnOChYfS0yQlJkNERoSGxvH/xAAeAQEAAgIDAQEBAAAAAAAAAAAABwgGCQEEBQMK\nAv/EAGURAAECAwIFCBEQBgUKBwAAAAABAgMEBQYRBxIhYfAIEzFRcZGU0RQVFhcYNTdBU1RVVnaS\nsbXxNlJic3R1k5WWobO00tPU1TIzNGVygSJEY7LBCSUmRVeitsTG4SNCZGbCw+L/2gAMAwEAAhED\nEQA/AO9gB6B7AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAF\nq74Yf+EpHvtQvkqX44rqLV3w/YlI99qF8lSnLdlN1PKDFsB9wAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAZ8AOuAAAAAAAAAAAAAAAAA+JyckTUiVOTkuTNzciEZUuXLlQkyZMmGnGVKjGE\n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\nAAAAAAAAAAAAAAAAAAAAAB//2Q==\n	2022-07-29 00:03:27	37.4219983	-122.084	3.0750000476837	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
57	2022-07-29 00:07:32	test	BIHAR	AURANGABAD	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)		1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgQCAwv/xABzEAEAAAEHAA4QDQ4HDQkBAAAAAQIDBAUGBxEIEhYZ\nITFBUVZhcZGV1AkTFzdVV3R3gZSxtLbR1vAUFTI1OFRydZahs8HVGDQ2UlNkdpKTl6Syt8QiIzOl\ntcfhCicoRUhlZnOChYfS0yQlJkNERoSGxvH/xAAeAQEAAgIDAQEBAAAAAAAAAAAABwgGCQEEBQMK\nAv/EAGURAAECAwIFCBEQBgUKBwAAAAABAgMEBQYRBxIhYfAIEzFRcZGU0RQVFhcYNTdBU1RVVnaS\nsbXxNlJic3R1k5WWobO00tPU1TIzNGVygSJEY7LBCSUmRVeitsTG4SNCZGbCw+L/2gAMAwEAAhED\nEQA/AO9gB6B7AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAF\nq74Yf+EpHvtQvkqX44rqLV3w/YlI99qF8lSnLdlN1PKDFsB9wAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAZ8AOuAAAAAAAAAAAAAAAAA+JyckTUiVOTkuTNzciEZUuXLlQkyZMmGnGVKjGE\n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\nAAAAAAAAAAAAAAAAAAAAAB//2Q==\n	2022-07-29 00:07:17	37.4219983	-122.084	3.0750000476837	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
58	2022-07-29 00:08:44	test	BIHAR	AURANGABAD	Forest land (FR)	Forest (FR)	Closed Forest (CF)	Semi- Evergreen (02)		1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIECwP/xAB0EAEAAAIFAQkTFQwHBQQLAAAAAQUCAwQGBxEIEhYh\nMVFWldETFBUXGTdVYXGBkZShsdPU1dbwCRg0NjhBVFdicnR1dneisrO0tbbBChoyMzVTc3iSl7fh\nIkhSlsLH0iNlhIWTQqOl5SQnREVGR1hkZmfG/8QAHgEBAAEEAwEBAAAAAAAAAAAAAAgFBgcJAwQK\nAQL/xABqEQABAgIDBQoVDwYMBQUAAAAAAQIDBAUGEQchUWGRCBITFBgxcZWx8Bc0NjdBUlNUVVZy\ndXaSlLO10dLT8RUyMzViZnN0k5ahtMHU4RZCRXeywgkiJSY4RmNlgoW2xCNEgcbVQ6Om1uL/2gAM\nAwEAAhEDEQA/AO9gBUCsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAIxyabznqOv1I7j5ZhSpULFaqVClGjSo1NONGlRjGjSoxhDSjCMMkYRh\n50YRyqE39tnou0/9et/1sBXWrvtEXJaao2haRq9SVLxaSotKUZHkpuVl4cKGs3MSmhPZHY5zn56X\nc/PIqNsciWWoqnagSro7Vc17Wojs7YqLgRbb2yXFz1HX6kdwz9HX6kdxbrf22ei7T/163/Wpu9Ex\nmFVLYUqq322qpb81MM9V2qvoUskaNblhnqFZCOSOSGWGXJFiaLm1asQob4i1Hp5UY1XKiUnR9q2J\n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\nJhVNZrNLZZZdLJZLcRLoW6YzGYW6voWaxWCwWKyzittNsttstNbVWey2Wz1VZX2ivrKuqqqunWU6\nNGN1HxUVNdFTZOCNLzEurUjwI0BXIqtSNCfCVyJeVWo9rVVEW8qoAfJbrfYZZZay2zK22SX2Kpzm\n9rXbrTU2Sy1W9KyjVVe9bRaKdXVVe9K2nQqqvP04Z+sp0Kujlp0qMI/URVVERFVVWxERLVVcCIl9\nVOJEVVRERVVVREREtVVW8iIiX1VVvIia59YpXR1cjZjdX+8Mo7cNHVyNmN1f7wyjtxyaBH5jF+Tf\n4jm0tM87x/konk40ylVCldHVyNmN1f7wyjtw0dXI2Y3V/vDKO3DQI/MYvyb/ABHzS0zzvH+SieTj\nTKVUKV0dXI2Y3V/vDKO3E7l01lc4qKVqlEysE0s1CtpVFO0S62We3VFCuo0KFZSqaVdZqytq6NbR\nq62rp0quNKFOFCsoUowhRp0Yx/LoUViZ58OI1ttlrmOaluC1URLT8ugxmJnnwojG62edDc1LV1kt\nVES+feA/BxgAACMcmTV045NKGXrLM+OOzPPp84L6kI8dK42pHU/9+vqNcusirZr2Iq2W62thsU54\nErNTOe0tLR5jOWZ/QIMSLnM9bnc9obXZ3PZ11ltlti2ayl5hZnxx2Z59PnBf96Vxu7p447M8+nzg\nv+9K43d19zj+Vd2q+I7HqVSnQ2f7jmPNl5hZnxx2Z59PnBf96Vxu7p447M8+nzgv+9K43d0zj+Vd\n2q+IepVKdDZ/uOY82XmFAXUxYwrv3MK6UXHxMw9vnNrNYqyY2iV3Uvpdq8UyqJdU19mstdb66wSe\nZ2y1VdiqrTbLJZ62106qFnq6+1Waqp1lGnX1VGlX78qiotipYuBby5DqxoMaXfoceDFgRERHLDjQ\n3w3o1dZc69GusWxbFssWy8AA4gAAAAOj3OQ5fU3DOQ149TcexUD0kHjOQ149TcM5DXj1Nx7AHjOQ\n149TcfHbYQhVUYaf42ENXzs5SjzNWHQ52T73w278XR/TQ+SpuxKcMwuq+xS3a2cTtKfAw+/wiWZI\na0OhAyQ1odCCIuD7TAJo78Uuo0Y47XT0v/lLIuV/8Y381mvHOUdbqx3WxDxS7j7XT96WRfXG/jXi\n6UT17tkpkf2V+ym4h5zlHW6sd0zlHW6sd16H4OI852jrdcztHW670APOdo63XM5R1urHdeg+0HmF\n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\nAAAAAf/Z\n	2022-07-29 00:08:39	37.4219983	-122.084	3.0750000476837	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
59	2022-07-29 00:09:34	test	BIHAR	AURANGABAD	Agriculture Land (AL)	Fallow land (FL)	Fallow Land (FL)	Fallow land (01)	tesr	2	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgQCCwP/xAB0EAEAAAIFAQkVEAwKBwYHAAAAAQUCAwQGBxEIEhYh\nUVaRldEJExQVFxkxN1RVYXF0lKGx09TV1vAYNTY4QVd1dneBs7S1tsHiIjIzNFNicoaSl7K3CiNI\nUniHpcfS4SUnQmRmk6IkRmeWpOUmREVzo6bx/8QAHgEBAAEEAwEBAAAAAAAAAAAAAAgFBgcJAgME\nCgH/xABqEQABAgIDBQkZDAQKCQUAAAAAAQIDBAUGEQcSIWGRCBMYMVFTlfDxFBUXNTdBUlRVVnFy\ndHV2kpOUlrGztdHS0xYyMzQ2YnOhtMHU1SJFssIlQkNjgYWjtsPECSMmRGRmg8bhJEZld+L/2gAM\nAwEAAhEDEQA/AO9gBUCsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAIxhDTi+c/R1exHceOZ06VCX2unQpUqFOjUU6VGnQpRo0qNKEMsI0aVG\nMIwjCPIjCOVbnhjMObrZ1zX/AONgK61d9oi5LTVG0LSFXqSpeLSVFpSjI8lNysvDhQ1m5iUzpzY7\nHOc++l3PvkVG3rkTTRTuhwXREVUVEsWzDb9xdLP0dXsR3DP0dXsR3FreGMw5utnXNf8A41M3rms0\nqpXRp1Uyt9XT4KqYZ+rtlooUskaFblhnqNZCOSPqwysSxs2tViDCfFWo9PKjG3yolJ0fatnGwwj8\njwnQIMSMqo5IbFeqJaiqiaaJallpfjP0dXsR3DP0dXsR3GH/AA/nvPqbbY2zuxw/nvPqbbY2zuyl\n6OqqnOFWHZWjfZFF36w9af2zTMDP0dXsR3DP0dXsR3GH/D+e8+pttjbO7HD+e8+pttjbO7Gjqqpz\nhVh2Vo32Q36w9af2zTMDP0dXsR3DP0dXsR3GH/D+e8+pttjbO7HD+e8+pttjbO7GjqqpzhVh2Vo3\n2Q36w9af2zTMDP0dXsR3DP0dXsR3GH/D+e8+pttjbO7HD+e8+pttjbO7GjqqpzhVh2Vo32Q36w9a\nf2zTMDP0dXsR3DP0dXsR3GH/AA/nvPqbbY2zuxw/nvPqbbY2zuxo6qqc4VYdlaN9kN+sPWn9s0zA\nz9HV7Edwz9HV7Edxh/w/nvPqbbY2zuxw/nvPqbbY2zuxo6qqc4VYdlaN9kN+sPWn9s0zAz9HV7Ed\nwz9HV7Edxh/w/nvPqbbY2zuxw/nvPqbbY2zuxo6qqc4VYdlaN9kN+sPWn9s0zAz9HV7Edwz9HV7E\ndxh/w/nvPqbbY2zuxw/nvPqbbY2zuxo6qqc4VYdlaN9kN+sPWn9s0zAz9HV7Edwz9HV7Edxh/wAP\n57z6m22Ns7scP57z6m22Ns7saOqqnOFWHZWjfZDfrD1p/bNMwM/R1exHcM/R1exHcYf8P57z6m22\nNs7scP57z6m22Ns7saOqqnOFWHZWjfZDfrD1p/bNMwM/R1exHcM/R1exHcYf8P57z6m22Ns7scP5\n7z6m22Ns7saOqqnOFWHZWjfZDfrD1p/bNMwM/R1exHcM/R1exHcYf8P57z6m22Ns7scP57z6m22N\ns7saOqqnOFWHZWjfZDfrD1p/bNMwM/R1exHcM/R1exHcYf8AD+e8+pttjbO7HD+e8+pttjbO7Gjq\nqpzhVh2Vo32Q36w9af2zTMDP0dXsR3DP0dXsR3GH/D+e8+pttjbO7HD+e8+pttjbO7GjqqpzhVh2\nVo32Q36w9af2zTMDP0dXsR3DP0dXsR3GH/D+e8+pttjbO7HD+e8+pttjbO7GjqqpzhVh2Vo32Q36\nw9af2zTMDP0dXsR3DP0dXsR3GH/D+e8+pttjbO7HD+e8+pttjbO7GjqqpzhVh2Vo32Q36w9af2zT\nMDP0dXsR3DP0dXsR3GH/AA/nvPqbbY2zuxw/nvPqbbY2zuxo6qqc4VYdlaN9kN+sPWn9s0zAz9HV\n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\nAAAAAAAAAAAAAAAAAAAAD//Z\n	2022-07-29 00:09:18	37.4219983	-122.084	3.0750000476837	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQUB\nAQEBAQAAAAAAAAAAAQYHCAkKBQQCAwv/xABzEAEAAAEHAgwLEAoKDwgDAAAAAQIDBAUGBxFRkQgS\nFhkhMVZhcZWx8AkTN0FVV3SBlNTWFBUXNThydnehs7S1tsHR1TI2U1RkdZKWpLcYIiM0UoeXsuHx\nCiQlJygzRUhzeIKFk8fSJkNERkdiZqNnhKX/xAAeAQEAAgEFAQEAAAAAAAAAAAAABwgGAQMEBQkC\nCv/EAGMRAAECAwMCChEPCQQJBQAAAAABAgMEBQYRYQcSExQYITFRcZGU8AgVFhc1N0FTVFVWkrG1\n0dLxUmJ0dXaTlZahs7TT1NXhMjM2ZXJzgbLBIiU0YwkjRFdktsTG4kJFRmbD/9oADAMBAAIRAxEA\nPwDvYAdgdwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABau+\nGH/ZKR+NqF71S/piuotXfD9qUj8bUL3qlNW7KbqeEGLYDfAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAABnwA44AAAAAAAAAAAAAAAAD8Tk5ImpEqcnZcmbm5EIypcuXKhJkSZMNuMqVKjCEI\n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\nAAAAAAAAAAAAAAAAD//Z\n	2022-07-29 00:09:26	37.4219983	-122.084	3.0750000476837	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	0101000020E61000004C37894160855EC0DABB500A04B64240
60	2022-07-29 00:11:19	test	BIHAR	AURANGABAD					tesrcd	1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIECwP/xABwEAEAAAEHAA4RDgkHBwsFAAAAAQIDBAUGBxEIEhYh\nMVFWYXGRlbHR1AkTFBcZNTdBVFVXdIGU09bwFRg2OHJ2d5Khs7S1ttUiMjNTdYWXsrcKSHiHwcfh\nIyREUmaT8SUmJyhFYpajpdLlNENHZYb/xAAeAQEAAgICAwEAAAAAAAAAAAAABwgGCQQFAQIDCv/E\nAGURAAECAgQFBhQQCwcEAwEAAAABAgMEBQYRYQcSIVHwCBhBVHGRExQVFhcxN1VWdXaSlJWhsbO1\n0fEyNDU2UlNiY3N0k5a0wdLUM0JDRWVygbLE09UiIyVEhbbGCWTD4SQmpOL/2gAMAwEAAhEDEQA/\nAO9gB2B3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAABDGGvtR4HwVtLlzdW02XIlSpEuTMS4yZciVGTKkxhoRkypMYRkxh1owjCMFsvVCn9n0\n3xukeUQFhaw+0TglpqjaFpCr1I0vEpKi0pRkeTm5aXZChrNzEpwJzI7HOc/GlnPxkVG2OanLRbfK\nNV3KVMmfTdLuYw19qPAYw19qPAtH6oU/s+m+N0jyilLY1tWszVMmVM1nWM1K5rmIZabptJkSsIyJ\n+MYZaTOwlQhHCGMIR6yJI2rXqxBhRIq1Hp5yQ2q5USk6PRVsstRLYVmez9n7flMPWXgRY7kRyQmK\n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\nCHhj1utjHZ8ERhHHjTvt8DsaHd5F37jP+MugvaY/ZEX7W7omXXdDkmFxcc+Nkb24aEcPUGx0dLrw\nt7hjo6GMNePXdEvuK1JXt7PqBY/S0s3unr6GdrtH8nQhsQ3kTjxp32+B2NDu8i79x44y6C9pj9kx\nbvdbuiZd4HRL7itSV7fhqGx0M7P6+b3Y9Io9EuuK1JXt7hWN8/Wj4Q7hHwdVZwq0pI0xXGBNTU9R\n0glGyr5ObiyENsqkxGmsV8OAqNe/g0eKuOv9rFcjeU1DhzODyrM29r48vMuc1uImLORmJZaq8q1d\nlV30zZd4PRLritSV7e4VjfP06JdcVqSvb3Csb5+tHwjvW04Kud1LduZzy6WrdZx+RjVLas52dG0z\n6Jl3g9EuuK1JXt7hWN8/Tol1xWpK9vcKxvn60fBracFXO6lu3M55dLVuscjGqW1Zzs6Npn0TLvB6\nJdcVqSvb3Csb5+nRLritSV7e4VjfP1o+DW04Kud1LduZzy6WrdY5GNUtqznZ0bTPomXeD0S64rUl\ne3uFY3z9OiXXFakr29wrG+frR8GtpwVc7qW7cznl0tW6xyMapbVnOzo2mfRMu8Hol1xWpK9vcKxv\nn6dEuuK1JXt7hWN8/Wj4NbTgq53Ut25nPLpat1jkY1S2rOdnRtM+iZd4PRLritSV7e4VjfP06Jdc\nVqSvb3Csb5+tHwa2nBVzupbtzOeXS1brHIxqltWc7OjaZ9Ey7weiXXFakr29wrG+fp0S64rUle3u\nFY3z9aPg1tOCrndS3bmc8ulq3WORjVLas52dG0z6Jl3g9EuuK1JXt7hWN8/Tol1xWpK9vcKxvn60\nfBracFXO6lu3M55dLVuscjGqW1Zzs6Npn0TLvB6JdcVqSvb3Csb5+nRLritSV7e4VjfP1o+DW04K\nud1LduZzy6WrdY5GNUtqznZ0bTPomXeD0S64rUle3uFY3z9OiXXFakr29wrG+frR8GtpwVc7qW7c\nznl0tW6xyMapbVnOzo2mfRMu8Hol1xWpK9vcKxvn6dEuuK1JXt7hWN8/Wj4NbTgq53Ut25nPLpat\n1jkY1S2rOdnRtM+iZd4PRLritSV7e4VjfP06JdcVqSvb3Csb5+tHwa2nBVzupbtzOeXS1brHIxql\ntWc7OjaZ9Ey7weiXXFakr29wrG+fp0S64rUle3uFY3z9aPg1tOCrndS3bmc8ulq3WORjVLas52dG\n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\nEMYacNuBjDThtwLFzLp503wREMYacNuBjDThtwLFzLp503wREMYacNuBjDThtwLFzLp503wREMYa\ncNuBjDThtwLFzLp503wREMYacNuBjDThtwLFzLp503wREMYacNuBjDThtwLFzLp503wREMYacNuB\njDThtwLFzLp503wREMYacNuBjDThtwLFzLp503wREMYacNuBjDThtwLFzLp503wREMYacNuBjDTh\ntwLFzLp503wREMYacNuBjDThtwLFzLp503wREMYacNuBjDThtwLFzLp503wREMYacNuBjDThtwLF\nzLp503wREMYacNuAWLmXTzpvg7wQFgCt4AAFK2s6XTHf0j5ufVUpW1nS6Y7+kfNz6G9UFzG6+dK5\nfxpIDZb+s395CgQGoM5Baq3PTaj/AKOmfpNLUYrO3PTaj/o6Z+k0tRjC6Q9OzHwi95CPqU9UJv4V\ne8geYyYR8Ojw7efCGfCGfnZ+L0PEnSE/R0V0aj52bkIz2LCdGkpmNKxXQlcx6w3RID4b3Q1fDY9W\nKqtVzGuVLWoqcaBMTEs9YktHjS71arFfAivhPViqjlarobmqrVc1rlaq2WtRbLUQ85STr7ZlJPp4\nPTwx1sPQ7LjorN0R0924pG7/ALm5DlcVqV550h2bM/zbtLVLRwyP9w8NC5O6LOhh1NbF/cmxtQPW\n/wBw/cTui2OdrYv7k0s7YXcDjprP0R0924pG7/ubtLVPHFaleedI9mzP827v51LMU+4O4qaoVKnJ\nu5W6ORLkTMuVJlQu1sXCMIwhjCMP+RNHHHwxioPnLXMdx66j9m9i/uRkrWfS+md7zv7sVtVytTbS\ndJUhVanos/SE9PRWVgVjIk5NzE1EYzidIuxGvjxHua3GVXYqKiYyqtlqqpS/VLVrrTIVsoGHI1lr\nBJQ31dbEfDlKZpKWY5/FKebjuZBmWNc/Fa1MZUVbGoltiFtOctcx3HrqP2b2L+5FhskXdVdbU930\nimVPdld3VFM9X6tmea6psPZerKVymXMU6Mua5ooNVTE9yuXGRJjLm8vlJUZMmMqEcrDDMRjxknOp\nrN++Oqvo9YLCTUSIkvGVIj0VIblRUe5FRURLFRUXJZYm8hWedr1XdspMObXKtaKkJyoqViphFRbE\nyoqTlyd81r5lLLamqg3Hq7ixmUstqaqDceruLJ+Ma4ZmdsR/lYn2rk3jDuSDX3o3rh85qa++3d/O\n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\nAAAAAAAAAAAAAAAAB//Z\n	2022-07-29 00:11:14	37.4219983	-122.084	3.0750000476837	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
61	2022-07-29 00:55:23	test	BIHAR		Agriculture Land (AL)	Fallow land (FL)				1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIEAwv/xABxEAEAAAEHAQsUCwkLBwwDAAAAAQIDBAUGBxFRCBIW\nITFWYXGRldQJExcZNTdBVVd0d4GUsbS20dPW8BQVMjhUcnWXs8HVGCI2dpKhssThCjM0SFJTh5O1\nt8cjJSdClqXxQ0dlZnOCg6Ok0uTlYmSm/8QAHgEBAAEEAwEBAAAAAAAAAAAAAAgBBgcJAwQFAgr/\nxABlEQABAgMCBAcXEgMECQUBAAAAAQIDBAUGEQchYfAIEhgxUXGRExQVFhc1N0FTVFVWdHaSlJWx\ns7XR0/EiMzQ2UmJzdYGTlqGytMHS1NUyZXIlRGO2CSNCRaPExuHiJkNGZHfD/9oADAMBAAIRAxEA\nPwDvYAegewAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAQxhs7kfIl9bS5c3VlNlzcuVIlyaPOSpMuRKjJlSZUIaUZMqTGEYRh0IwjCMFrfbKs\nfh9N7rpHnNn1wgwFhaw+0jBLWqbRahZ+pVeLUqWlUZHkpqVgQ4cNZuYlN5ObHa5yv00s5+mT1Olc\niXXop8udct1xeLGGzuR8hnoamnjkwj5FnfbKsfh9N7rn/OKUtjW9bTNUQlzNZ1jNS/ZcxJz83TaT\nIlYRkTuMM9JnYR0+jp6fRYljaNazEGFEirYivOSG1XK1KlT0Vbte5Vhqh15iabLwYsdzFc2ExXq1\n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\n8itXVj4cejFD+jlNye8yfWuyWRwwVL3cL5ppTlsLTUCxdkrUWyrSapc/VlkrO11aesZigSJmcp0/\nQKgq2k1rTJmhTdJn6LRpylztHok5N0aRSKVRpiVPypEmepExNxlTsjA/lmVxfRshe3te0djI/nhb\n2MMmnDGGTV0st80Bzh77OxHeR4m105g2SrFS8PRKyE1avCppqlWKDOcL1Oi0peAsGHTUgQaikOJA\nkkayLF36nZhyxn+r0rkZrNbdlGwtm6VbGnTc9XIUWNMSs6spBdAjvlmpBSBBjXObDW5ztPEf6pcd\nyonKQ3i8syuK1o3t7x2N9PTlmVxWtG9veOxvp60dC8tTTgq6HVbuzOeXO9cl178Syx/Ok52/HyZc\ni7uQ3i8syuK1o3t7x2N9PTlmVxWtG9veKxvp7t+sNPR0K6mnBV0Oq3dqcyZdvd2hxLLH86Tnb8fJ\nlyLu5DeLyzK4rWje3vFY3092vXUcsyuK1o3t7x2N9PWjoU1NOCrodVu7M55c71yXOJZY/nSc7fj5\nMuRd3IbxeWZXFa0b2947G+npyzK4rWje3vFY3092vWOlo6DU04Kuh1W7sznlzvXJc4llj+dJzt+P\nky5F3chvF5ZlcVrRvb3jsb6enLMritaN7e8djfT1o6DU04Kuh1W7sznlzvXJc4llj+dJzt+Pky5F\n3chvF5ZlcVrRvb3jsb6enLMritaN7e8VjfT3b9YaejoV1NOCrodVu7U5ky7e7tDiWWP50nO34+TL\nkXdyG8XlmVxWtG9veOxvp6csyuK1o3t7x2N9PWjoU1NOCrodVu7M55c71yXOJZY/nSc7fj5MuRd3\nIbxeWZXFa0b2947G+npyzK4rWje3vFY3092vWOlo6DU04Kuh1W7sznlzvXJc4llj+dJzt+Pky5F3\nchvF5ZlcVrRvb3jsb6enLMritaN7e8djfT1o6DU04Kuh1W7sznlzvXJc4llj+dJzt+Pky5F3chvF\n5ZlcVrRvb3jsb6enLMritaN7e8VjfT3b9YaejoV1NOCrodVu7U5ky7e7tDiWWP50nO34+TLkXdyG\n8XlmVxWtG9veOxvp6csyuK1o3t7x2N9PWjoU1NOCrodVu7M55c71yXOJZY/nSc7fj5MuRd3IbxeW\nZXFa0b294rG+nu366rlmVxWtG9veKxvp7tesdLR0GppwVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5\nDeLyzK4rWje3vHY309OWZXFa0b2947G+nrR0GppwVdDqt3ZnPLneuS5xLLH86Tnb8fJlyLu5DeLy\nzK4rWje32qisbl/H2HQ/P+bQDJs3T4yYf5WiamGnLnoY4Ywxw9jx0o4QjDo4R04QjpK5GVsGFj6J\nghWtrYqDHlFtClNSpLOzD6hvRKVv9vnvPe9+8tLwRmdPpP49M3TfwNuqmC2yCa0pOcr+/wAfJl29\n3dojQ1T/AOdon9ZPcHNDVP8A52if1k9wdW4yxw82h5vL9qwvIV4l1kOdZzt+YyZcn17d9EaGqf8A\nztE/rJ7g+16w02hqn/ztE/rJ7g+36x0q3Dh6tDzeX7VheQcS6yHOs52/MZMuT69u+h9DVOx/fqJq\nfzk92/8AkNr1iaGqw/naH/Wz3BlcDA1vsFFjsJdo49qrVSs5M1iYlpWVixZSfjyUF0GThNgwESBB\nVIbVbDbc5yJe5VvXGUXBZY9VvWUnOV/f4+TLkXdyFD6Gqw/naH/Wz/B2zbMUZq273M3XbWmsbbip\nLZ1rWlc24pdpqLP2Uq+o6dV83QJ+oagqqRMz89XFoqipEimQpFVUiXLm5uizszxmcmJcmflS4zk3\nN4Aiy9TTgr6HVbuzOZMuT61yFOJZY/nSc7fj5MuRd3IbxeWZXFa0b2947G+npyzK4rWje3vHY309\naOhTU04Kuh1W7sznlzvXJc4llj+dJzt+Pky5F3chvF5ZlcVrRvb3jsb6ejR0K6mnBV0Nq3K/3zN5\nPIu6o4llj+dJzt+Pky5F3ch3oAJ+mNAAAAAAAALZW0vG0IVpR6t9pvbHj9XzVO4/7Y+xM7x2kUqj\n8a437BpOezvsbP5/jkMc/nc5DO56VSHJw/6r/wC+v/qX1pXLyvrTygv4tPaLm7Tv/A8Fo6m+Th/1\nX/31/wDUqSrC8n2wp1IpvtLxnj0ZEONe2PHM7xuam5v3fsCRjjnM97iGGOGnhjGIGjTjQ5XBjZ6J\nHdpGLb2msR1zneqWgWlciXMRy40a5b7rsWveqX9ScmoEoxkSYfvNjn6RHaV773KiuRLmNcus1y3q\nl2LXvVCuRbvR9/0T/wCv/wDhmj7/AKJ/9f8A/DazOCshzf8A4UbzZ53Bqmc8/wDBmPNFupOpDah3\nkSEMIQhkhgLPLDLR5oDnD32diO8jxNrpzBunzNAc4e+zsR3keJtdOYNPfQm+0y0nXO7xVTiRWBzj\n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\n5LkyIYypUIRoiKqoiIqqq3IiY1VV1kROWqnGiK5Ua1FVVW5ERFVVVdZERMaquwh9IpjRtY3XbZnf\n6quFeuEY9CJo2sZruszv9VWO57Kx/bparl3hG5jF+bf5Dl32mOYRvmn/AJSpxTGjaxmu6zG/1VcL\n9dLKaNrGa7bM7/VVwv8APsRyRN4R+Yxfm3+Qb7THMI3zT/ylTimNG1jOha2zMdqvqqj+t+ullgjo\n1sbrtszv9VXC3y6FEYl74b2prXuY5qX7F6oiHy6DGYmmfCiMbraZ0NzUvXWS9URMZUwpnRrY3XbZ\nnf6quFmjWxuu2zO/1VcLfBxlTD56LS6LTqPNUuhUmj0yiz8nPzNJos9N0ijz0jGMM9NT01Klzc5J\nxhGGekSpUMYRhjjCL6AAFoPug7g8IR5N90GnCEeeVYzUjDHp1k+tVGudfpWuddr3Iq3bdxzwZWZm\ndNvvLx5jSaXT7xgxIuk01+l02ka7S6bSu0t91+lW7WUu+LQfdB3B9W+6D5y7GfbR90HcH1b7oPnL\nsZ9tPrecT3D+xd5Dn4F1PodPdqTHmy74tB90HcH1b7oPnKsZ9tbEUfug7g+rfdB85VjPtrZhum84\nnM39i7yDgXU+h092pMebLvC0UjNA3DTkc7N323RS5WGOEi8mxsqOGMIY4Sa6jHDGMIY5YwfpyfLi\n+rTdN841j/tlRWPTXY5Ntq+QotNqKLcshOouvcsrHRbl1luWHyy7ItNyfLi+rTdN841j/tlW1mbY\nWRtpQp6srHWps5ayrqPSpdCpFPszXdWV9Qpimzc1Mz85Q56lVXSqVMTVKkTFJo89Lo8uckz0man5\nmcjIhInZEqVRUVNdFTbRc+WhxRJObgtV8aVmITEVEV8SBFY1FXEiK5zUS9V1kvxlRgKHXAADqoAY\n3P0UAAAfNSIaUjZlRx2fvZWrtY6T6Xz0jUkfGj+jF7VnePVP+GXwUQtq2Htaq3wEP7xBPmwhkhue\nuWO6YQyQ3ERmYjoc+/FXPfEWM7C9nfHi8VrHbOOKue+IsZ2F7O+PF4rWO6UT+N22cLv4l+TvIAHw\nfIAAAAAB5FR9ch/0L9pfKQl0Tvtts/1up4yngrm73m/K6wpP0kwoZXN3vN+V1hSfpJh5xGkveAA5\nxv3QHCGGZKh0IcnnCEdPqM5XOPhDJDcg6Of3QH/FK/p5/wAGXOOznZBE4Xadi1kmETtuObjNC8q8\n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\nE9yLZj47pHhYpErRqchKb65aB4WOAGt40+G0i5bnW2L+Sf1qkroLX3Lc62xfyT+tUldAAAAAAAAA\nAAAAAAAAAdVADG5+igAAAAAAAAAAAAAAAAKftX+Dlc9Yz3egxnZMWr/ByuesZ7vQYzs0YNONVQ+M\nP+WgkA9Fr7dLN9a7fG1RDDXN1VxSqkuPmqbQ5FHnJ2NtrPzMZNJkTkubzk5Q65jGOdmp2ZlZ6EZE\nnCOfwhDHGEWZTCDigXOEmvx7s54FXa9qxxrnup394h9XOM9S6kjfZU1Cckavfg1U9z0zh5yRq9+D\nVT3PTOHqBGKTChX3JGr34NVPc9M4eckavfg1U9z0zh6gQBX3JGr34NVPc9M4eckavfg1U9z0zh6g\nQBX3JGr34NVPc9M4eckavfg1U9z0zh6gQBX3JGr34NVPc9M4eckavfg1U9z0zh6gQBX3JGr34NVP\nc9M4eckavfg1U9z0zh6gQBX3JGr34NVPc9M4epe2dd0y29m6xsvWsijUegVpGh8fnqum52Zpk37C\np1GrGajMzlJn6ZMQz09RJuROQnKNOQlTUqXJk5yXGTOSZShHVk7f1RX9gr5JVg+uyheMZcylgP5M\neC7r8st44lC0vIasx0wr/uqrfso5DVmOmFf91Vb9lLtjbUb5i0nIasx0wr/uqrfso5DVmOmFf91V\nb9lLtgC0nIasx0wr/uqrfso5DVmOmFf91Vb9lLtiPGie5Fsx8d0jwkUiVo1OQlN9ctA8LHLSchqz\nHTCv+6qt+yjkNWY6YV/3VVv2Uu2Nbxp8KgsvaWsLJ1BVdnKumqHPUKqaP7Go87TZqenaXLm+OS5z\nPT85MUijTMqXGVOStObmJuTCGEM7jCMYz7kjV78GqnuemcPUCAK+5I1e/Bqp7npnDzkjV78Gqnue\nmcPUCAK+5I1e/Bqp7npnDzkjV78GqnuemcPUCAK+5I1e/Bqp7npnDzkjV78GqnuemcPUCAK+5I1e\n/Bqp7npnDzkjV78GqnuemcPUCAK+5I1e/Bqp7npnDzkjV78GqnuemcPUCAK+5I1e/Bqp7npnDzkj\nV78GqnuemcPUCAK+5I1e/Bqp7npnDxQIA7UAGNz9FAAAAAAAAAAAAAAAAAU/av8AByuesZ7vQYzs\nradRZmm0Ok0WkSOOTE/NS5udm4SpUjPSIw04Z6RKky5OOGrJlQjkUXoKs50sld10/Z//AGfXDbxy\n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\n	2022-07-29 00:55:19	37.4219983	-122.084	3.0750000476837	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
62	2022-07-29 00:56:07	test	BIHAR		Grasslands / Grazing Lands (GG)					1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQQD\nAQEBAAAAAAAAAAAAAQYICQoCBQcEAwv/xABwEAEAAAEHAQwRDAsKDAYDAAAAAQIDBAUGBxFRCBIW\nGSExVpGV0dTWCRMUFzU3VVdhcXR3gZSxtvAVNjhBVHahorO0tdUzU3J1hZKWpLK3wRgiJDJIh5OX\n0+EKIyY0RFJiZGZ4pcclJ0Oj0vFjhsX/xAAeAQEAAgICAwEAAAAAAAAAAAAABwgGCQQFAQIDCv/E\nAGYRAAECAwIGBRESCgYLAQEAAAABAgMEBQYRBxIhUWHwCBNBVJEUFRcYMTdVVnGSlJWWsbXR8RYy\nNTZSYnN0dXaTs7TB0tPU1SIzNEJTZXKBobIjJUVjtsQJJCZDRFd3hcPG4WTi/9oADAMBAAIRAxEA\nPwDfYAdgdwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB5Ze\n/q2UkYwhH/xWhe1/+KmPU3ll73rVkffWhfJUx7N5vB/MgLYcIZIbUDCGSG1BI+wIwhkhtQMIZIbU\nEgCMIZIbUDCGSG1BIAjCGSG1AwhkhtQSAIwhkhtQMIZIbUEgCMIZIbUDCGSG1BIAjCGSG1Awhkht\n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\n	2022-07-29 00:56:03	37.4219983	-122.084	3.0750000476837	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
63	2022-07-29 00:57:28	test	ARUNACHAL PRADESH		Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)		1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQUB\nAQEBAQAAAAAAAAAABgEHCAkKBQQCCwP/xAByEAEAAAIFAQsSDQwMDAcBAAAAAQQCAwUGBxEIEhYh\nMVZhcZXU8AkTFBk2N0FRVXWRlLGztLbR1hUXGDQ4V3N0d5a3wdUaIlNUWIGEl6Gk0tcKIzN2eIaS\nk6Wy0/EkJjJCSFJmcoKHo+E1REZkZYXHtf/EAB4BAQABBAMBAQAAAAAAAAAAAAAIBQYHCQIDBAoB\n/8QAaREAAQIDAgUGExENBQcFAQAAAAECAwQFBhEHEiFBYQgTMVGR8BQVFhcYUlNUVVZicXaSlLHR\n0vEzNTY3REVlcnSBk5WWobO1wSIyNEJGY2RzdbK01NUjOFdmdwmFtsLG1uElJsPExeL/2gAMAwEA\nAhEDEQA/AO9gBUCsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAMsNTLp9IAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAELv3CHoLCPSnJbJsfW18E0Qu/f/gn4ZLf1a9ybs7n7zT8X7U76FmwHcfoAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkwA84AAAAAAAAAAAAAAAAD806dGhRpU6VKjRo0YZaVK\n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\nAAD/2Q==\n	2022-07-29 00:57:25	37.4219983	-122.084	3.0750000476837	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
64	2022-07-29 00:58:59	test	BIHAR	BHABUA	Wastelands (WL)					1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIEAwv/xABzEAEAAAEHAQsUCwkNAwgLAAAAAQIDBAUGBxFRCBIW\nITFWYXGRldQJExcZNTdBVVd0dXeBlLG0ttHT1hQyOFRykpehwdXwFRg0NlKys8ThCiIzSFN2h5OW\npbW3xyMnZiQlZXOCpOTlKENFRmJkhYamxtL/xAAeAQEAAgIDAQEBAAAAAAAAAAAABwgGCQEEBQMC\nCv/EAGYRAAECAgMGCRQOBwQJBQEAAAABAgMEBQYRBxIhYXHwCBMYMUFRkbHRFBUWFzU2N1NUVVZ0\ndpKUlaGztfEzNFJiY3N1gZOWtNLU1SIyQ0RystMlZbbBCSMmQkWjxMbhRmR3osPi/9oADAMBAAIR\nAxEAPwDvYAegewAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAQxhs7kfMl9bS5c3VlNlzcuVIlyaPOSpMuRKjJlSZUIaUZMqTGEYRh0IwjCMFr\nfulWPv8ApvfU/wCkQFdau+0RclpqjaFpGr9JUvFpKi0pRkeSm5WXhwoazcxKaU5sdrnK++lnPvk/\nRsc1NdFt4tW2xLNi23Gv/hS8WMNncj5jPQ2dyPmWd+6VY+/6b31P+kUpbGt62maphOTNZ1jNS/Zc\nxDPzdNpMiVhnJ7Sz0mdhHCPR09NEsbRrVYgwokVakU85IbVcqJSVHoqollqJbDy+Taw/GYjcTwIs\n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\nofdZQXpGXPAuH9GO5d3eVW9MShrPAbajfMAAABXjRPdC2Y+W6I87FKlaNToJTfdLQHnY4Aa3jT4b\nSLludbYvsT+tUldBa+5bnW2L7E/rVJXQAQjqydv6Iv5w0j2sO74Yv6PMdWTt/RF/OGke1h3fDFJd\nzrXpjJIb84bAdAp7JdQ/gqX/ADVrPQCTTYOAAFyLr+b9M7D0jx2r1+Fh7r+b9M7D0jx2r1+ETVv5\ntRfiJf8AkKh3XefikO1aO+xwg6ReI1+52vI7dNZeQ1iXN06ReI1+52vI7dNZeQ1iWIzPsS5W75WW\n67zlzXb0h5425gPOKmgAB1QAI3P6KAAAPnpGpI+FH82L6H4TsmMvO4YQzsqOMcYfkxy4bGpjq7Ec\nPWoKLCgUtIxY0RkKEyKqviRHI1jU0t6WuctiIlqomHZUx+tUCNM0BSUCXhRI8aLBY2HChMc+I92n\nwlsa1qKqrYirgTWQ+YfpxqVlk/GgcalZZPxoJX49UR1ykvCIX3iCOR2nus1J+BTH9M5+OKs+6Hsb\n2mLO+XF4rWU3e8UBzKd+9+F8lmrWXYWKmrSVBV92VTWdpdOlWosjU0ZquKJaq2dZUiiexa+r2q6Z\nOQm6FW1Xz3sibo8ujS+P8bkT0qdmp6RN4M8ruzX3UqmP7fXbet7qPpei1e5UpCTVLdfiiHi99n8y\nnydVusCuWyhaT8CmNpPg8/mUwoGa/K7s191Kpj+3123re8yuJ45ruTGMmN1czjDoaPLt8kI6sLXR\nhjpw0n0l52TmnrDlpmBHiI1XqyFEbEcjEVrVcrWqqoiK5qW61qomudSboilJCG2NO0dOysJz0hti\nTEtFhMWIrXPRiOe1EVytY5UTXsau0YVDNTleWa76lcz/AG8u49bjleWa76lczD/78u4+i1ruXj/c\nu71eA8+9dtLuKYVhCMIwhGGpGEI7sB+TgAPIpH2SH/Av8ylJdE7z21f7nU9JzwVzd7zfldYUn9JM\nKGVzd7zfldYUn9JMPOK0l7wAHOH+6Bv4pP8AT1/ow5w3R5+6Bv4pP9PX+jDnDTnVDndo/JMfa45u\nL0L3QJqF8RT3+KqcADJSfQAAyns7zAqTsRVniNHTlJrO8wKk7EVZ4jR05QPN+25rtiN5xxQil+a1\nJ9vzfn4hfbMt+6bzOfb4ug/zCs67QnF7mW/dN5nPt8XQf5hWddoTypvXZkdvoVfu4c1KC7QmvtDQ\n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\nAAAH/9k=\n	2022-07-29 00:58:17	37.4219983	-122.084	3.0750000476837	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
18	2022-07-28 15:28:13	test	ANDHRA PRADESH	KRISHNA	Forest land (FR)	Forest (FR)	Open Forest (OF)	Evergreen  (01)	other	2	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQQD\nAQEBAAAAAAAAAAAACgYHCAkBAgUECwP/xABxEAEAAAIFAgkUCgsJCw0BAAAAAQQCAwUGBxFWCBIW\nITFRkZXUCRMUFxk1NzhBVFdxdHeUsbS21vAVMjZhcnWXstHVIlNVdoGSs7fE0tMYMzRieIWhorUk\nJ2Zzh5OlpsHl8SMlJihDREVGR2Nlo8Lh/8QAHgEBAAICAgMBAAAAAAAAAAAAAAcIBgkEBQECAwr/\nxABnEQABAgMCBAgVDwYMBQUAAAAAAQIDBAUGEQcSUWEIFBghcZHS8BMWMTU3QVNUVVZ0dXaTlJWh\nsbO18RUXMjZjZHJzgZKWtNHV4SUzNENFwSIjRGKEsrbCxMbT1AkkUmWCJkd3osP/2gAMAwEAAhED\nEQA/AJ7ADsDuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAADjLDbhuwebbVZTqrKn6yrp06usoS1ZSoU6FKNCnRpQhrUqNKjGFKjGHUjCMIwWh\n9lbU+6U/4ZMftEBYWsPtJwS1qm0WoWfqNXiVKlpVGR5OblpdkKGs3MSnAnNjtc5z8aXc/GT+Dc5q\ncW8+T4mIqJdfrX+G7xIvgL4ZYbcN2Blhtw3YLH+ytqfdKf8ADJj9opK+ltWzUWPRrKm1rTqqfJlR\nR09XPzVClpY0K7LDTUa2EckerDLr9VEcfRr2YgQYkZ1iK85IbVcrUqVPvW67WS+GiZTizM8ktLxZ\n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\nyoUjOxmNiwZOaiw334sSFLxojHXOVq4r2sVrrnIrVuVbnIqLroXaFpeX9gR2a8I/lIub9de965YH\nL+wI7NeEfykXN+uvf8e1F54HE5m/5rvsPf1MqXQ+e7kj/wCnnTbLtC0vL+wI7NeEfykXN+unHL+w\nI7NeEfykXN28n3Z9dnYOBxOZv+a77B6mVLofPdyR/wDTzptl2xamGPGB0YQjDGbCmMIwhGEYYiXQ\njCMIwywjCPsxkjCMIwjCMOpHKcvfA/sy4U/KJdD64euK7Iu0p49TqhzjOdyx9wXWFtJDGnB21Z6S\nsuy8WMNLStO0puWkLOs6Qv3decn5+enK6hLyklJSctatZMTU3NTFZV1EtLVFXWV1fXVlCqqqFKnS\no0Y3LeFRU4qKmyfCLAjwFRI8GLBVyXtSLDfDVyJrKqI9rVVEXWvQA+acnZOzpatnLQm5aRk6nSce\nmpyvqpaWquOVlCqq+O19fToVVXp62nQq6GmpQ01ZToUKOWlShCPlEVVRERVVVuRES9VXIiJrqp80\nRXKjWoqqq3IiIqqqrxERE11VciH0imtWdz867tfht2y4eOaNWdz87Ltb+2Xwp9OAR+Yxe1v+w+ul\n5jmEbtT9yVKKa1Z3Pzsu1v7ZfCjVnc/Oy7W/tl8KOAR+Yxe1v+waXmOYRu1P3JUoprVnc/Oy7W/t\nl8KNWdz87Ltb+2Xwp6uhRWJe6HEamVzHIm2qIh6ugxWJjPhRGN4l7mOal68RL1REKlFNas7n52Xa\n39svhRqzufnZdrf2y+FPQ+ZUo/hKzUrPS9VNyUzLzkrX0dPUzMrXVcxL11DLGGmqq6qpU6uso5YR\nhpqFKMMsIwy6z+4AHrrQy+JaTl/YEZIR5deEeSMIRh/fIubsRhlh/wCM7XrrweUa51+K1zruLcir\nds3H3gy0zM42l5ePHxMXH4DCiRcTGvxcbEa7Fxrlxb7r7lu4il2xaXl/YEdmvCP5SLm/XRy/sCOz\nXhH8pFzdrL92vWOtsvbgcTmb/mu+w+3qZUuh893JH/086bZdoWl5f2BHZrwj+Ui5v1173rlgcv7A\njs14R/KRc3669/x7UTgcTmb/AJrvsHqZUuh893JH/wBPOm2XaFDXZxPw0vpP1tlXOxEuLe21KiUr\nLQr7Nuze679vWhUyFVXVEvWztbJ2VaE3M1cpVTE1K1FZM06ujU0K6Zl6qlThTrqujSrnZeqoqLcq\n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\n	2022-07-27 17:13:29	37.4219983	-122.084	3.0750000476837	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIECwP/xABvEAEAAAEHAA0VCgcKCwgDAAAAAQIDBAUGBxEIEhYh\nMVFWYZGVsdHUCRMUFxk1N0FVV3F0dXeBlLS209bwFRg2OFSSl6Gz1TIzcnaFssEKIkhTh5a1t8fh\nIyQnNERSZWaTpfEmRWKjpNLk5ShDR//EAB4BAQACAgIDAQAAAAAAAAAAAAAHCAYJBAUBAgMK/8QA\nZxEAAQICBAQIFQ4KCAUFAAAAAAECAwQFBhFhBxIhUQgYMUFUcZHwExQVFhc1NjdVVnN0dpKUlaGx\ns7XRMjM0UlNidZOWtMHS1PEiQkNFY2VygdPVIyVEhbK2xMYJJCajw2R3pOHi/9oADAMBAAIRAxEA\nPwDvYAdgdwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAQxhr7Ed58FbS5c3VtNlyJUqRLkzEuMmXIlRkypMYaEZMqTGEZMYdKMIwjBbL3Qp/y\n+m+N0j0iAsLWH2icEtNUbQtIVepGl4lJUWlKMjyc3LS7IUNZuYlOBOZHY5zn40s5+Mio2xzU1UW3\nyjVdqKmTPv2y7mMNfYjvGMNfYjvLR+6FP+X03xukekUpbGtq1mapkypms6xmpXJcxDLTdNpMiVhG\nRPxjDLSZ2EqEI4QxhCPSRJG0a9WIMKJFWo9POSG1XKiUnR6KtllqJbCsz2fu/f8AKYesvAix3Ijk\n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\n	2022-07-27 17:13:41	37.4219983	-122.084	3.0750000476837	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	0101000020E61000004C37894160855EC0DABB500A04B64240
18	2022-07-28 15:28:13	test	ANDHRA PRADESH	KRISHNA	Forest land (FR)	Forest (FR)	Open Forest (OF)	Evergreen  (01)	other	2	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQQD\nAQEBAAAAAAAAAAAACgYHCAkBAgUECwP/xABxEAEAAAIFAgkUCgsJCw0BAAAAAQQCAwUGBxFWCBIW\nITFRkZXUCRMUFxk1NzhBVFdxdHeUsbS21vAVMjZhcnWXstHVIlNVdoGSs7fE0tMYMzRieIWhorUk\nJ2Zzh5OlpsHl8SMlJihDREVGR2Nlo8Lh/8QAHgEBAAICAgMBAAAAAAAAAAAAAAcIBgkEBQECAwr/\nxABnEQABAgMCBAgVDwYMBQUAAAAAAQIDBAUGEQcSUWEIFBghcZHS8BMWMTU3QVNUVVZ0dXaTlJWh\nsbO18RUXMjZjZHJzgZKWtNHV4SUzNENFwSIjRGKEsrbCxMbT1AkkUmWCJkd3osP/2gAMAwEAAhED\nEQA/AJ7ADsDuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAADjLDbhuwebbVZTqrKn6yrp06usoS1ZSoU6FKNCnRpQhrUqNKjGFKjGHUjCMIwWh\n9lbU+6U/4ZMftEBYWsPtJwS1qm0WoWfqNXiVKlpVGR5OblpdkKGs3MSnAnNjtc5z8aXc/GT+Dc5q\ncW8+T4mIqJdfrX+G7xIvgL4ZYbcN2Blhtw3YLH+ytqfdKf8ADJj9opK+ltWzUWPRrKm1rTqqfJlR\nR09XPzVClpY0K7LDTUa2EckerDLr9VEcfRr2YgQYkZ1iK85IbVcrUqVPvW67WS+GiZTizM8ktLxZ\n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\nyoUjOxmNiwZOaiw334sSFLxojHXOVq4r2sVrrnIrVuVbnIqLroXaFpeX9gR2a8I/lIub9de965YH\nL+wI7NeEfykXN+uvf8e1F54HE5m/5rvsPf1MqXQ+e7kj/wCnnTbLtC0vL+wI7NeEfykXN+unHL+w\nI7NeEfykXN28n3Z9dnYOBxOZv+a77B6mVLofPdyR/wDTzptl2xamGPGB0YQjDGbCmMIwhGEYYiXQ\njCMIwywjCPsxkjCMIwjCMOpHKcvfA/sy4U/KJdD64euK7Iu0p49TqhzjOdyx9wXWFtJDGnB21Z6S\nsuy8WMNLStO0puWkLOs6Qv3decn5+enK6hLyklJSctatZMTU3NTFZV1EtLVFXWV1fXVlCqqqFKnS\no0Y3LeFRU4qKmyfCLAjwFRI8GLBVyXtSLDfDVyJrKqI9rVVEXWvQA+acnZOzpatnLQm5aRk6nSce\nmpyvqpaWquOVlCqq+O19fToVVXp62nQq6GmpQ01ZToUKOWlShCPlEVVRERVVVuRES9VXIiJrqp80\nRXKjWoqqq3IiIqqqrxERE11VciH0imtWdz867tfht2y4eOaNWdz87Ltb+2Xwp9OAR+Yxe1v+w+ul\n5jmEbtT9yVKKa1Z3Pzsu1v7ZfCjVnc/Oy7W/tl8KOAR+Yxe1v+waXmOYRu1P3JUoprVnc/Oy7W/t\nl8KNWdz87Ltb+2Xwp6uhRWJe6HEamVzHIm2qIh6ugxWJjPhRGN4l7mOal68RL1REKlFNas7n52Xa\n39svhRqzufnZdrf2y+FPQ+ZUo/hKzUrPS9VNyUzLzkrX0dPUzMrXVcxL11DLGGmqq6qpU6uso5YR\nhpqFKMMsIwy6z+4AHrrQy+JaTl/YEZIR5deEeSMIRh/fIubsRhlh/wCM7XrrweUa51+K1zruLcir\nds3H3gy0zM42l5ePHxMXH4DCiRcTGvxcbEa7Fxrlxb7r7lu4il2xaXl/YEdmvCP5SLm/XRy/sCOz\nXhH8pFzdrL92vWOtsvbgcTmb/mu+w+3qZUuh893JH/086bZdoWl5f2BHZrwj+Ui5v1173rlgcv7A\njs14R/KRc3669/x7UTgcTmb/AJrvsHqZUuh893JH/wBPOm2XaFDXZxPw0vpP1tlXOxEuLe21KiUr\nLQr7Nuze679vWhUyFVXVEvWztbJ2VaE3M1cpVTE1K1FZM06ujU0K6Zl6qlThTrqujSrnZeqoqLcq\n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\n	2022-07-27 17:13:29	37.4219983	-122.084	3.0750000476837	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAAcB\nAQEBAAAAAAAAAAAAAQUGBwgJCgIECwP/xABvEAEAAAEHAA0VCgcKCwgDAAAAAQIDBAUGBxEIEhYh\nMVFWYZGVsdHUCRMUFxk1N0FVV3F0dXeBlLS209bwFRg2OFSSl6Gz1TIzcnaFssEKIkhTh5a1t8fh\nIyQnNERSZWaTpfEmRWKjpNLk5ShDR//EAB4BAQACAgIDAQAAAAAAAAAAAAAHCAYJBAUBAgMK/8QA\nZxEAAQICBAQIFQ4KCAUFAAAAAAECAwQFBhFhBxIhUQgYMUFUcZHwExQVFhc1NjdVVnN0dpKUlaGx\ns7XRMjM0UlNidZOWtMHS1PEiQkNFY2VygdPVIyVEhbK2xMYJJCajw2R3pOHi/9oADAMBAAIRAxEA\nPwDvYAdgdwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAQxhr7Ed58FbS5c3VtNlyJUqRLkzEuMmXIlRkypMYaEZMqTGEZMYdKMIwjBbL3Qp/y\n+m+N0j0iAsLWH2icEtNUbQtIVepGl4lJUWlKMjyc3LS7IUNZuYlOBOZHY5zn40s5+Mio2xzU1UW3\nyjVdqKmTPv2y7mMNfYjvGMNfYjvLR+6FP+X03xukekUpbGtq1mapkypms6xmpXJcxDLTdNpMiVhG\nRPxjDLSZ2EqEI4QxhCPSRJG0a9WIMKJFWo9POSG1XKiUnR6KtllqJbCsz2fu/f8AKYesvAix3Ijk\n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\n	2022-07-27 17:13:41	37.4219983	-122.084	3.0750000476837	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	0101000020E61000004C37894160855EC0DABB500A04B64240
40	2022-07-28 23:07:46	test	BIHAR	BHAGALPUR	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)		1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQUB\nAQEBAQAAAAAAAAAACgEGBwgJBQQDAgv/xAB0EAEAAAEHAgoRCwoOEAcBAAAAAQIDBAUGBxFRkQgS\nFiExVmFxlfAJExQXGTdBVVd0d4GUsbbU1hU1NjhydbO0wdHVMlRkdpahpLW3xBgiIzRSU4eSk5el\nsuHxCiQlJicoM0VIZXN4goXH0kNER2JmZ6OE/8QAHgEBAAIBBQEBAAAAAAAAAAAAAAcIBgEDBAUJ\nAgr/xABkEQABAgMDAggWDQkECQUAAAAAAQIDBAUGEWEHEggTITFRkZTwFBUWFxg1N0FSU1RVVnF2\nkpahsbXR8TZidHWTlbO00tPU1eEiMjM0cnOBssElY2W2CSNERVd3xMbiJkJkZsP/2gAMAwEAAhED\nEQA/AJ7ADsDuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM\nV3ww/vSke+1C+CpfzxZUYrvh9iUj32oXwVKat107aeUGrYDfAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAABvwA44AAAAAAAAAAAAAAAAD+JyckTUiVOTsuTNzciEZUuXLlQkyJMmGzGVKlRh\n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\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/9k=\n	2022-07-28 22:54:41	37.4219983	-122.084	5	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
50	2022-07-28 23:43:06	test	BIHAR	BHAGALPUR	Agriculture Land (AL)	Crop Land (CL)	Crop Land (CL)	Single crop (01)		1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQUB\nAQEBAQAAAAAAAAAACgEGBwgJBQQDAgv/xAB0EAEAAAEHAgoRCwoOEAcBAAAAAQIDBAUGBxFRkQgS\nFiExVmFxlfAJExQXGTdBVVd0d4GUsbbU1hU1NjhydbO0wdHVMlRkdpahpLW3xBgiIzRSU4eSk5el\nsuHxCiQlJicoM0VIZXN4goXH0kNER2JmZ6OE/8QAHgEBAAIBBQEBAAAAAAAAAAAAAAcIBgEDBAUJ\nAgr/xABkEQABAgMDAggWDQkECQUAAAAAAQIDBAUGEWEHEggTITFRkZTwFBUWFxg1N0FSU1RVVnF2\nkpahsbXR8TZidHWTlbO00tPU1eEiMjM0cnOBssElY2W2CSNERVd3xMbiJkJkZsP/2gAMAwEAAhED\nEQA/AJ7ADsDuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM\nV3ww/vSke+1C+CpfzxZUYrvh9iUj32oXwVKat107aeUGrYDfAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAABvwA44AAAAAAAAAAAAAAAAD+JyckTUiVOTsuTNzciEZUuXLlQkyJMmGzGVKlRh\n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\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/9k=\n	2022-07-28 22:54:41	37.4219983	-122.084	5	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
65	2022-07-29 01:01:53	test	BIHAR	BHABUA	Forest land (FR)	Forest (FR)	Closed Forest (CF)	Semi- Evergreen (02)		1	/9j/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAIQAABtbnRyUkdC\nIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAA\nAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlk\nZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAA\nAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAA\nAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAA\nAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3Bh\ncmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADT\nLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAw\nADEANv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAlgBwgMBIgACEQEDEQH/xAAfAAEAAQUB\nAQEBAQAAAAAAAAAAAQYHCAkKBQIECwP/xABxEAEAAAIEBAkTDgoFBQ4HAAAAAQUCAwQGBxFRkQgS\nFiExVnGV1AkTFBUXGTU3QVRVYWJ0lLHR09YYNjhXcnZ3l7O0tbbV8DIzU3WBhZKht8EKUniy4SIk\nQpPCIyUmQ2Vmc4eWpKXS5fEnNERFZKbG/8QAHgEBAAICAgMBAAAAAAAAAAAAAAcIBgkEBQECAwr/\nxABnEQABAgIEBQUWEgcECQUAAAAAAQIDBAUGEWEHEiGR8AgTGEFRFBUXMTdTVFVWcXR1dpKTlJWh\ns7XR8RYyNDU2UmJjcnOWsbK00tTV4SIzRYHBwtNChbbECSQlZGVmgsPGI0RGo+L/2gAMAwEAAhED\nEQA/AO9gB2B3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAACMcWWO5svnTdzSzPwzWnTq5dbKdXTpVdOjUU40adClGjToxhsRo0qMYRhGGWEYR\nW05ZTHr+2+FV/nEBYWsPtEYJaao2haRq9SNMRaSotKUZHk5uWl2QoazcxK605sdquc/GlnOxkWyx\n6JZainlGq7hKmTd055dnTdzSzGm7mlmWm5ZTHr+2+FV/nFL3um01qpTClVTOYVVLkuphpqu22mhS\nxRo1uOEKVGthShCPVhjxR6qJY2rXqxBhPiuqPTrkY3GVEpOj0VbLMiKsPn5z0juWBBiRnIjkhsV6\nomRVsThJbk3dOHkDpu5pZjTdzSzML+X8+7NzjfO2+fOX8+7NzjfO2+f7X3xxdXs66qcwVYO6lHXe\n93LnuOk3+Q+MP65t35968zQ03c0sxpu5pZmF/L+fdm5xvnbfPnL+fdm5xvnbfPmzrqpzBVg7qUdd\n73cue4b/ACHxh/XNu/PvXmaGm7mlmNN3NLMwv5fz7s3ON87b585fz7s3ON87b582ddVOYKsHdSjr\nve7lz3Df5D4w/rm3fn3rzNDTdzSzGm7mlmYX8v592bnG+dt8+cv592bnG+lu8+bOuqnMFWDupR13\nvdy57hv8h8Yf1zbvz715mhpu5pZjTdzSzML+X8+7NzjfO2+fOX8+7NzjfO2+fNnXVTmCrB3Uo673\nu5c9w3+Q+MP65t35968zQ03c0sxpu5pZmF/L+fdm5xvnbfPnL+fdm5xvnbfPmzrqpzBVg7qUdd73\ncue4b/IfGH9c278+9eZoabuaWY03c0szC/l/Puzc43ztvnzl/Puzc43ztvn+398UDZ11U5gqwd1K\nOu97uXPcN/kPjD+ubd+fevM0NN3NLMabuaWZhfy/n3Zucb523z5y/n3Zucb6W7z5s66qcwVYO6lH\nXe93LnuG/wAh8Yf1zbvz715mhpu5pZjTdzSzML+X8+7NzjfO2+fOX8+7NzjfO2+fNnXVTmCrB3Uo\n673u5c9w3+Q+MP65t35968zQ03c0sxpu5pZmF/L+fdm5xvnbvPnL+fdm5xvnbfPmzrqpzBVg7qUd\nd73cue4b/IfGH9c278+9eZoabuaWY03c0szC/l/Puzc43ztvnzl/Puzc43ztvn+398UDZ11U5gqw\nd1KOu97uXPcN/kPjD+ubd+fevM0NN3NLMabuaWZhfy/n3Zucb523z5y/n3Zucb527z5s66qcwVYO\n6lHXe93LnuG/yHxh/XNu/PvXmaGm7mlmNN3NLMwv5fz7s3ON87b585fz7s3ON87b582ddVOYKsHd\nSjrve7lz3Df5D4w/rm3fn3rzNDTdzSzGm7mlmYX8v592bnG+du8+cv592bnG+du8+bOuqnMFWDup\nR13vdy57hv8AIfGH9c278+9eZoabuaWY03c0szC/l/Puzc43ztvnzl/Puzc43ztvn+398UDZ11U5\ngqwd1KOu97uXPcN/kPjD+ubd+fevM0NN3NLMabuaWZhfy/n3Zucb523z5y/n3Zucb527z5s66qcw\nVYO6lHXe93LnuG/yHxh/XNu/PvXmaGm7mlmNN3NLMwv5fz7s3ON87b5/7/ogcv592bnG+dt8+bOu\nqnMFWDupR13vdy57hv8AIfGH9c278+9eZoabuaWY03c0szC/l/Puzc43zt3nzl/Puzc43zt3nzZ1\n1U5gqwd1KOu97uXPcN/kPjD+ubd+fevM0NN3NLMMMNUE+7NzffK2+fDZ1VU5gqw7X7Uo663+xz8+\nZv8AIfGH9c278+9eZogL1negAAAAAAAAAAAAAAAB5s46F27ven4lqV1px0Lt3e9PxLUtcWrN9ndV\nupJvjikz6Q9v938QpS+XQeHfdR/drVVqUvl0Hh33Uf3a1TKd9STHxa/wOPSHqGa+Jf8AMWqAYiYG\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZ0AP0MEgAAAAAAAAAAAAAAAAB5s46F27ve\nn4lqV1px0Lt3e9PxLUtcWrN9ndVupJvjikz6Q9v938QpS+XQeHfdR/drVVqUvl0Hh33Uf3a1TKd9\nSTHxa/wOPSHqGa+Jf8xaoBiJgYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnQA/QwSA\nAAAAAAAAAAAAAAAAHmzjoXbu96fiWpXWnHQu3d70/EtS1xas32d1W6km+OKTPpD2/wB38QpS+XQe\nHfdR/drVVqUvl0Hh33Uf3a1TKd9STHxa/wADj0h6hmviX/MWqAYiYGAAAAAAAAAAAAAAAAAAAAAA\nAAAAWa9Uboevb4wMfGjcf7dXlcb1HYhuQ8S0GpswC0LhwfXNtMU7SlCJVhKvLLrRsCUjLM7+VprX\nUjJNNdi6ylFw9bxFTG12Jjelap8okRWWWIi228O6zynV56ozQ9e3xgY+NK4326eqM0PXt8YGPjSu\nN9uuUQWk2BFSubytPaNEXe98/ThfLX3bje/5efomXq79UZoevb4wMfGlcb7dPVGaHr2+MDHxpXG+\n3XKIGwIqVzeVp7Roi73vn6cJr7txvf8ALz9Ey9cN1cLGCy/UxrpRcjCZg+vlNrPYqyY2iV3Uvndy\n8UxqJfU19nstbb66xSeZWy01ViqrTbLJZ6y1U6qjUUK+1WeppVkKyvqqNKv2griWHshL4fA1eL67\n4O2/VRzDrg1o/BNhCnamUZSU5S0pK0fRk42cn4cCFMPfPSsOYexzJdrYSNhucrWKiWqnpto+8Nyv\nbatiZVTJcAEPHuAAAABnQA/QwSAAAAAAAAAAAFJTK/N1pRba6XTGaRs9ss8KqNdU8gzKu0nHqmrt\nFXjrLPY62qpRpVVbV08VGspaXTaWlipQjCCxV4SWgq0UJzTLk9mo72Tj7POaZcns1HeycfZ7zYu4\nuZQV2KE5plyezUd7Jx9nnNMuT2ajvZOPs8sXcXMoKpnHQu3d70/EtSqCZYRrm2iwWupqZxGnW1tT\nToUKPK2bUdNSjDWhpqVghRhjyxjCGWK32qqQ9fR8Et3Bmt3VoxYUKvlVUixIcNVqi1USI9rFVN/N\nKJaiOVFVLclp41+BCWyLGhQlVEVEiRGMVUypaiOciqluS1CoVKXy6Dw77qP7ta/VqqkPX0fBLdwZ\nT95Z5K5hLYWex2qNbW8k1VPSRs9pq/8AJo0azHHTVtTQoa2PY02OPUxqYTkxLulo7Wx4LnLDVEa2\nKxVVdxERyqq844s9NSr5OZayZl3OdCejWtjQ3OVVTIiIjlVVXcRCgAGLmFAAAAAAAAAAAAAAAAAA\nAAAAAAAAHG9R2IbkPE7IXG9R2IbkPE2Mf6P79bhZ+DUb/wAuOPH/ALH/AFfykgNkBxwAA2V8Sw9k\nJfD4GrxfXfB236tBXEsPZCXw+Bq8X13wdt+rTjqzeLpTHSOr3i2CcuD6ROeoAVVPqAAAABnQA/Qw\nSAAAAAAAAAABihhJ9ek53Jb9EWBlexQwk+vSc7kt+iLA92cNed/FAUMA+oAAAA1eaunih1Q6jG+P\nKWMZpv1RB+J/neAFIjpQAAAAAAAAAAAAAAAAAAAAAAAAAAAA43qOxDch4nZC43qOxDch4mxj/R/f\nrcLPwajf+XHHj/2P+r+UkBsgOOAAGyviWHshL4fA1eL674O2/VoK4lh7IS+HwNXi+u+Dtv1acdWb\nxdKY6R1e8WwTlwfSJz1ACqp9QAAAAM6AH6GCQAAAAAAAAAAMTcJNKOrSc63Y2EYQ14w/3osG5s6+\nKOv+/FDLJihhJ9ek53Jb9EWBjtZaTmqKkYMxJuY2K+bhwXK9iPTEdCjOVMV2S3GY1bblTbMoqnRU\nnS9Ix5adY98JklEjtRkR0NdcbMS0NFVW2KqYkR6WWpYqou0UJpo5I/s/4/fLlaaOSOb/AB3P3/o+\nhhPoxp3j8DtaHd5Fz3Ehegir/GJjtuP9o14w4pZgLjCEdSWFuGPXxRkNzseeF/Ywy7EY9T9M88sw\nF7UsLe8Fz8nv8y/u1u20h0diG5DxJPRjTvH4Ha0O7yLnuHoIq/xiY7bj/aN3fPLMBe1LC1+mQ3Ph\nl6urzc6n6NdPPKsBm1PCxvHc/wBOmkMQ/hFwd1Zwp0pI0xXCXmpueo6QSjZV8nNxZBjZVJiNNYro\ncBUa96xpiKuOv6VjkbwmocSYwdVYmnNfGlppVa3FTFnYyZLVXdXdU3ec8qwGbU8LG8dz/To55VgM\n2p4WN47n+nTSGI92NmCvlbSvdqcuvuXPcfDgY1S5FnO3o2m7omXd5zyrAZtTwsbx3P8ATo55VgM2\np4WN47n+nTSGGxswV8raV7tTl19y57hwMapciznb0bTd0TLu855VgM2p4WN47n+nRzyrAZtTwsbx\n3P8ATppDDY2YK+VtK92py6+5c9w4GNUuRZzt6Npu6Jl3ec8qwGbU8LG8dz/To55VgM2p4WN47n+n\nTSGGxswV8raV7tTl19y57hwMapciznb0bTd0TLu855VgM2p4WN47n+nRzyrAZtTwsbx3P9OmkMNj\nZgr5W0r3anLr7lz3DgY1S5FnO3o2m7omXd5zyrAZtTwsbx3P9OjnlWAzanhY3juf6dNIYbGzBXyt\npXu1OXX3LnuHAxqlyLOdvRtN3RMu7znlWAzanhY3juf6dHPKsBm1PCxvHc/06aQw2NmCvlbSvdqc\nuvuXPcOBjVLkWc7ejabuiZd3nPKsBm1PCxvHc/06OeVYDNqeFjeO5/p00hhsbMFfK2le7U5dfcue\n4cDGqXIs529G03dEy7vOeVYDNqeFjeO5/p0c8qwGbU8LG8dz/TppDDY2YK+VtK92py6+5c9w4GNU\nuRZzt6Npu6Jl3ec8qwGbU8LG8dz/AE6OeVYDNqeFjeO5/p00hhsbMFfK2le7U5dfcue4cDGqXIs5\n29G03dEy7vOeVYDNqeFjeO5/p0c8qwGbU8LG8dz/AE6aQw2NmCvlbSvdqcuvuXPcOBjVLkWc7eja\nbuiZd3nPKsBm1PCxvHc/06OeVYDNqeFjeO5/p00hhsbMFfK2le7U5dfcue4cDGqXIs529G03dEy7\nvOeVYDNqeFjeO5/p0c8qwGbU8LG8dz/TppDDY2YK+VtK92py6+5c9w4GNUuRZzt6Npu6Jl3ec8qw\nGdW6eFj9EjufH/8AumgqjduYYof7pZIa2xGsroR1tbqWePjVyJUwZVRoXBEtNuqVBjyi1gSjUpLe\n2YiUhrm+re7eTW96Ldaxd+Mzj4lmPjNxvSIejsF1UX2Y0rOLZuT8dNy3hLd3yh9TUw/K2P8A1tfw\nY1NTD8rY/wDW1/BlcCVvR1WHj8v2rC8h68Cup/Is7tftCYuvuXOpQ+pqYflbH/ra/gxqamH5Wx/6\n2v4MrgPR1WHj8v2rC8g4FdT+RZ3a/aExdfcudTIPQXYWbvaHPCnP7733sM6mspmmD+a3Vs9nurUW\nG2zChMLfeO6s3qa6uqpvMZHZoWOjZpFa6FZTqrVW19GvrLPRhZ6VXTrK2q2c88rwGbU8LH6ZHc/H\n+n/h00hiCK+4KanYSqxx61VqlJyZpeZlpSVixZSfjyUFYMnCbBgokCCuI1yQ2ojnJlcuVcp7twX1\nRYliS05ZfPRrdq3Lp+83ec8qwGbU8LG8dz/To55VgM2p4WN47n+nTSGMM2NmCvlbSvdqcuvuXPce\n3AxqlyLOdvRtN3RMu7znlWAzanhY3juf6dHPKsBm1PCxvHc/06aQw2NmCvlbSvdqcuvuXPcOBjVL\nkWc7ejabuiZd3nPKsBm1PCxvHc/06GkMNjZgr5W0r3anLr7lz3DgY1S5FnO3o2m7omXuwAX6InAA\nAAAAAAtvfHCFqTmdRLuVHJ/HrBVW3j3J/Iul45aLVUca43yFadNpeRtPp9PDHp9LpIaXHSpPm0/8\n2v8Axn/0p7Yrl2u+nlBfRihhJ9ek53Jb9EWBXfNp/wCbX/jP/pS095J1qinVsnHI3IfJkLL/AJtx\n7kjjfI9js9l/HcaqNPp+Mcc/FUdLptL/AJWl00cMrw1UoqWtT9oQdzjEyZzg/wDXma6WRvrUn5Dw\nwEYEvnJtR2IbkPElFHYhuQ8SQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHd\ngAsAVnAAAAAAAMbsMPrmsP5isv0hM1qF18MPrmsP5isv0hM1qH3bwk5yfMAijsQ3IeJKKOxDch4m\nF179aZbpjB8BMmdYP/Xia6WxfrUoSAiwl45NqOxDch4koo7ENyHiSAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAA7sAFgCs4AAHizmYVsts1XX1VChWUqVfxrFWabSwhSo1lKMcVG\nNGOmhpYwhr4s72lLXr6H1HftH5K0Ivw0U3StXMF9cKaoSdi0fStH0fBiyc7BRixZeI+fk4LnsSI1\n7LVhxHt/Sa5LHLktG2nwkTOtn8c55Oqy3fkLNmrP/OarLd+Qs2as/wDOpYaz+D9hi5vaY7HR93+5\nXd9d0+2I3c76+Ut9hHmFdM55Za+to0KulQlVRUwhVwjpY0aNst1OEY6aNKOPHWRhs4sUIa2yt/ij\n/Wjmh5Nz7x1qxvt0Vs/5vqvnNrUexyb1ReG2FMxmMwiU21jXWNbiUdYiWItnqHS3nWYjPTs1CnI8\nOHGe1jX2NalioiWItiWopGKP9aP7vIiEYRjuaaH74f8Av1dnZfT4o7Md2l46KaMAOFjCLXyuFJ0R\nW+tdI07RstVqbpGBKTjZRsOHPQqUoeVhzDVgS0F+O2BNzMNEVytxYzrW24qpIeCmamI9PzzI0Vz2\ntoaO5EWz0yT1HtRciIvCcu3tn2At2T6cm1HYhuQ8SUUdiG5DxJAAAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAd2ACwBWcAAClr19D6jv2j8laFUqWvX0PqO/aPyVoQ3qguI3XzpXL\n+NJAbbfhN+khQADUGcgtffborZ/zfVfObWo9WF9uitn/ADfVfObWo9iU/wCq4/w/5UMFpL1fM/Gf\nytD4o7Md2l46L7fFHZju0vHRWP1KnFBprqNpDx3V4kXBH7Ip/pJH8YUafYC/xYU5NqOxDch4koo7\nENyHiSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA7sAFgCs4AAFLXr6H1Hft\nH5K0KpUtevofUd+0fkrQhvVBcRuvnSuX8aSA22/Cb9JCgAGoM5Ba++3RWz/m+q+c2tR6sL7dFbP+\nb6r5za1HsSn/AFXH+H/KhgtJer5n4z+VofFHZju0vHRfb4hrRjj1tels7tFY/UqcUGmuo2f79N1e\nszki4I/ZFP8ASSP4wo0+xGOGWGeBjhlhngv8WFsXc00VM5yb0diG5DxJfMIwxQ14bEOrDInHDLDP\nAPNi7i6edM5IjHDLDPAxwywzwDwSIxwywzwMcMsM5Yu4unnTOCRGOGWGeBjhlhngWLuLp50zgkRj\nhlhngY4ZYZ4Fi7i6edM4JEY4ZYZ4GOGWGeBYu4unnTOCRGOGWGeBjhlhngWLuLp50zgkRjhlhngY\n4ZYZ4Fi7i6edM4JEY4ZYZ4GOGWGeBYu4unnTOCRGOGWGeBjhlhngWLuLp50zgkRjhlhngY4ZYZ4F\ni7i6edM4JEY4ZYZ4GOGWGeBYu4unnTOCRGOGWGeBjhlhngWLuLp50zgkRjhlhngY4ZYZ4Fi7i6ed\nM4JEY4ZYZ4GOGWGeBYu4unnTOCRGOGWGeBjhlhngWLuLp50zgkRjhlhngY4ZYZ4Fi7i6edM4JEY4\nZYZ4GOGWGeBYu4unnTOCRGOGWGeBjhlhngWLuLp50zgkRjhlhngY4ZYZ4Fi7i6edM4JEY4ZYZ4GO\nGWGeBYu4unnTOCRGOGWGeAWLuLp50zg7sQFgCs4AAFLXr6H1HftH5K0KpUtevofUd+0fkrQhvVBc\nRuvnSuX8aSA22/Cb9JCgAGoM5Ba++3RWz/m+q+c2tR6sL7dFbP8Am+q+c2tR7Ep/1XH+H/KhgtJe\nr5n4z+VofOlhj/RuY49WOti/Tl/Q+gk5+eo6K6NR87NyMZ7FhOiyczGlYroSua9YbokB8N7oavYx\nysVVarmNVUtalnHgTExLPWJLR40u9WqxXwIr4T1Yqo5Wq6G5qq1XNa5WqtlrUWy1EI0sO3nj5TSw\n+8Y9rt9qGZI7H0T1l5oqd7r0hd/vFyHK37UryzpDt2Z/qFpeYFgJ9pTBHra3S2ub1P1KcwLAT7Sm\nCP4trmfYq7Qeiis3NFT3dikPvF3z7qjftSvLOkO3Zn+oWXmeAbAZVWC11lXgWwSUKyhU0qVCnRwb\n3MhGjShsRh/vL1FveYxgb9qHBV8XFze3/wAi9v8AduYsmZv0Mtv/AEFP+S2C5WptpGkaQqtTsWfn\n52eiMrAsNkScmo81EYzfdJOxGPjxIjmsxlV2KiomMqustVVKS6pytdaaPrdQEOQrLWCShvq42I+H\nKUzSUsxz9+c+mO5kGZY1z8VrW4yorsVEbbYiIW15jGBv2ocFXxcXN7X/ACL2vvr47GaIXBZgwk9w\nKFrlGDTB5KbXGfS2pja5Vci7EttUaqnUW6NOqjabFK6mvjVU6VChGnV6fSUo0aMaUIxowjDL1j7o\nlulzV++KV/N5gsFORHtlY6te9qpDWxUcqKnC4SotqFYZ2vdeGykwra51saqQnWKlY6YRUsRLLFSc\ntRUsSxUyoa4tSl1trUg3nl3BjUpdba1IN55dwZ74xXemZ5Ij9lifauTMYdwQq/c3NcflPTf348DU\npdba1IN55dwY1KXW2tSDeeXcGe+G9MzyRH7LE+1cmYcEGv3NzXH5T039+PA1KXW2tSDeeXcGNSl1\ntrUg3nl3BnvhvTM8kR+yxPtXJmHBBr9zc1x+U9N/fjwNSl1trUg3nl3BjUpdba1IN55dwZ74b0zP\nJEfssT7VyZhwQa/c3NcflPTf348DUpdba1IN55dwY1KXW2tSDeeXcGe+G9MzyRH7LE+1cmYcEKv3\nNzXH5T039+PA1KXW2tSDeeXcGNSl1trUg3nl3BnvhvTM8kR+yxPtXJmHBBr9zc1x+U9N/fjwNSl1\ntrUg3nl3BjUpdba1IN55dwZ74b0zPJEfssT7VyZhwQa/c3NcflPTf348DUpdba1IN55dwY1KXW2t\nSDeeXcGe+G9MzyRH7LE+1cmYcEGv3NzXH5T039+PA1KXW2tSDeeXcGNSl1trUg3nl3BnvhvTM8kR\n+yxPtXJmHBCr9zc1x+U9N/fjwNSl1trUg3nl3BjUpdba1IN55dwZ74b0zPJEfssT7VyZhwQa/c3N\ncflPTf348DUpdba1IN55dwY1KXW2tSDeeXcGe+G9MzyRH7LE+1cmYcEGv3NzXH5T039+PA1KXW2t\nSDeeXcGNSl1trUg3nl3BnvhvTM8kR+yxPtXJmHBBr9zc1x+U9N/fjwNSl1trUg3nl3BjUpdba1IN\n55dwZ74b0zPJEfssT7VyZhwQq/c3NcflPTf348DUpdba1IN55dwY1KXW2tSDeeXcGe+G9MzyRH7L\nE+1cmYcEGv3NzXH5T039+PA1KXW2tSDeeXcGNSl1trUg3nl3BnvhvTM8kR+yxPtXJmHBBr9zc1x+\nU9N/fjwNSl1trUg3nl3BjUpdba1IN55dwZ74b0zPJEfssT7VyZhwQa/c3NcflPTf348DUpdba1IN\n55dwY1KXW2tSDeeXcGe+G9MzyRH7LE+1cmYcEKv3NzXH5T039+PA1KXW2tSDeeXcGNSl1trUg3nl\n3BnvhvTM8kR+yxPtXJmHBBr9zc1x+U9N/fjwNSl1trUg3nl3Bh74b0zPJEfssT7VyZjzwQ6/83Nc\nflPTd3+/XIdZAoLjlZ+Up/tUvKccrPylP9ql5V3tbXdTTRdFyb2Mt2b8+fomWvRQXHKz8pT/AGqX\nlOOVn5Sn+1S8pra7qaaLouRluzfnz9Ey16pa9fQ+o79o/JWh5fHKz8pT/apeV4s8p042Wqx06Uf9\n3o7NKMf+LrMsUMaoVMTAxX13DsoqXycL9qSG3l27uEernYiYy5cVWrZwrbFTn6ZLzzh5GOOWOeJj\njljni09a+ntVz/lz9FyeN609ovXf/nn6LkoW+0cU1s+z0PqupGP/ANTa8kFH44dvNHyNUvFL53OZ\ndh2unUS+bzOw1NLBLIq2lU2O32qy1VKtpXxv5QpVlKrqK2hQjWRoUKFGNOMI0o0aFGjGOKjCENeG\nqq8+2Ofb8TDhDGJ1caajLZZa+2z9yGGz7secmHWWWxLbLbbMiJw7E+Y6accO3mj5DHDt5o+RzLaq\nrz7Y59vxMOEGqq8+2Ofb8TDhDjHEOmnHDt5o+Qxw7eaPkcy2qq8+2Ofb8TDhBqqvPtjn2/Ew4QA6\naccO3mj5DHDt5o+RzLaqrz7Y59vxMOEGqq8+2Ofb8TDhADpYm0ccttuz+Ip9SPkWxc+kb03mjCMI\n3insYRhijCM3mEYRhkjCNoxRg/z1R3h7OznfS3efXL1Ns8kpVWnWrDV+PWBXWo7Fsso6RSzhLtW9\n4oJqtaRSTrpVtiwliY9WGutR6Ns/2tSCWWYrreFbw7rzoPY+6Jbpc1fvilfzeYNOWqO8PZ2c76W7\nz6sbjzebW2dUqi2zSY2up5Cr6fGbVbbTaKrT0adVCjT43W1tOhpqMKVKFGlixwhSpQhGGOOOwsel\nEjQYkLWVbjtVtuPbZbZlsxU27f3WFTpimGx4MWFvOrdcYrcbXEWy2zLZiJbt7aeS7wDpzowAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADqIEaajlhnNNRyw+/wD7+PJFeTXoXHYfXt8p+ggk\nRpqOWH3+/wB8cDTQywzmvQuOw+vb5QS8ad//AC1V/wBPR+TrHsaajlhneNOowjZqvFr4q+Gxr/8A\nF1mxi2f0a6GNUO9j8C9fmse17loqXsa1yOctlKSCrYiKqrkRVybR8436t37vpIUyGKOSl+zS8hr5\nKX7NLyNO2tReNxOsd5Dg4zfbNzp5TRTxTvp93R+CGQfXO/7XK2NcU7jiw93RxwjD/wCEMg/0Y7c7\n/wDaa5MfV180fFixsfmoMZZiLZCir+lxt24lxjM4qb0xsqZXrZlTLkQkRj3c0fIY4dvNHyOPrMbj\nUTsbvJemc41qbqZyRGPdzR8hj3c0fJ2/viiazG41F7G7yXpnFqbqZyRGPdzR8hj3c0fIazG41F7G\n7yXpnFqbqZyRGPdzR8iVt9T41zasU0jmuau/5y2ORUWzffJZbFsyZFNeWrDVPRvVjL/8VTxvSIVz\ng96P0u8LT8pUKGVzg96P0u8LT8pUJ9Kil7wAAUfevCHcC4fIGrm/Nz7l8teSuVeq280lu3yy5B5G\n5O5X8ubbYuTeQ+TbHyXCzcc5G5Ls3HtJx+q01H+qFwA+3lgd+M65P249ka5yWta5UXhKiKqLls4a\nJu5OecuFIT8eG2LAkpuNCdbixIUtGiQ3WKqLivYxWrYqKi2KtioqLlQvALP+qFwA+3lgd+M65P24\neqFwA+3lgd+M65P24a2/2j+tXyXpnPpvqpTlbP8Aacx/TLwCz/qhcAPt5YHfjOuT9uHqhsAPt54H\nfjOuT9uGtv8AaP61fJemcb6qU5Wz/acx/TLwC0cNEBgGpQhSo4bcEMaMYQjCMMJVy4wjCMIRhGEY\nTrFGEYRhGEYbMIwjsRTzfsA/t24IvjKuZ9tGK72rsy+S9M5677aR5Ane1Y/9Mu2LXy/DfgWm1vsM\nqlWF/BdM5pM7ZZZdLZbLsIF07dMJhMLbX1dmsdhsNiss3rbTa7Za7TW1dns1ms9VWV1fXVlCqqqF\nOnTo0Y3QeFRU4aKnPSw+EaXmJdWpHgRoCuRVakaE+ErkTIqtR7WqqIuRVQA/LbbdYpbZq22zG2WW\nwWOo0nHrXbbRVWWzVPHKyhU1fHa+vp0Kqr09bWVdXQ01OGmrKdGhDHSpQhEiKqoiIqqq2IiJaqru\nIiZVU+SIrlRrUVzlVERERVVVXhIiJlVV2kQ/UKX1b3L23XYydHpVs48WKP8Anetsp1b3M2dV12N/\npVu9dvfWY3GonWO8h9t5pnkeP2KJ9m9M5U4pjVtczbddjf8AlXCzVvczbddjf6VcL7eyazG41F7G\n7yXpnPG80zyPH7FE+zemcqcUxq3uZtuuxv8ASrt//l9p7Eumssm9RStMpmNgmdmoVtKop2iXWyz2\n2ooV1GhQrKVTSrbNWVtXRraNXW1dOlVxpQpwoVlClGGlp0Yx8OhxGpa6G9qJZarmORMvCyqlmXa3\nT1dBjMTGfCisb7Z0NzUy8LKqImW1M5+8B6HzAAAH79xZ/wBUNgB9vPA78Z1yerDHD/75k13lGudb\nitVbLLbEVbLeFbZu7R94ErNTWPvNLR5jExcfWIMSLiY1uLj6212LjWLi22W2LZwlLwCz/qhcAPt5\nYHfjOuT9uHqhcAPt5YHfjOuT9uPOtv8AaP61fJemc5G+qlOVs/2nMf0y8As/6oXAD7eWB34zrk/b\nh6oXAD7eWB34zrk/bhrb/aP61fJemcb6qU5Wz/acx/TLwCgrr4VMGF95hXSm5WEi4V8JrZ7HWTG0\nSy618bu3gmFRL6mvs1lrbfXWKUzG12mrsdVabZZLPWWqnVQqKFfarPVUqcKddV0aVevCoqLYqKi7\nipYvfOLGgxpd+tx4MWBEsR2txob4b8VeEuK9GusXaWyxQA8HyAAAAA6iAGLn6OAAAPx2qEI0IQyV\nkY7uOjGOvn/dDI/Y/JavwYe7/wBiDs6G9dZL413goimN1uyVcpX4mH35iCi95VQ/DihkhmgYoZIZ\noJEmlezQfxUyEPVA3P1odJy7/Uht2whNa2KGSGaDZVxUz2QNz/gcu/8AXbCE1rOFE9O7nnCiImO7\nJt+TyJmIxQyQzQMUMkM0Ej0PnYm4mnmTMRihkhmgYoZIZoJAWJuJp5kzEYoZIZoGKGSGaCQFibia\neZMxGKGSGZIOnpH9az4tPpOKOaqT2X1e6m2+M58K5we9H6XeFp+UqFDK5we9H6XeFp+UqHXlYy94\nADm1/pCMIRpaEbHr62HzZ7ccC7m4xQyQzQdJH9IR2dCNuYe/HgXc3CeKmKq1aoy3L+jMfW5g3Mal\nriDVA6Hp7/FVOkYoZIZoGKGSGaCRlBYAjFDJDNA0sMkM0EgDK67kKOp6Ra0Og0r6nV5BqPv+7YhB\n7OKGSGaDx7uet6Q/maV/Mah7Kv8AN+q5roiN4RxQCl1XftSmX9ozv1mJ5EzF99CxCHqntDfrQ6fm\nBzqQ9sW7jtRcV+hY9k9ob/h8wOfxFu47UHVTfDZznfOhVrDn660D0vmfrLQsvohoY8D97u1ygj/+\n0SVehZfRC9J+9/6g+tEkZpgp4plQOq+r/jOWOhwFcWfBX1fVV8cyhrGxQyQ/TrmKGSGaCRt6t04f\nCs8mlqm/u1d3TJ5EIxQyQzQMUMkM0EhbpYl3kTRVFq7umTyIRpYZIZoeRsD0J/S7nfv2mX0Fdxr9\nbAtCf0u5379pl9B3cVz1UnEpmbqdobwkZCoWrdy4DZ23arNVyy7/ANaZT5ksz7qmTwDWkaawAAf6\nVHWx/wCVCHjj/KD+bbCEMUNaGxDqQf0kofhUPdQ8UX826jsQ3IeJKGDb9tf3d/njYRqDf1uFL4up\nX0q1+UYoZIZoGKGSGaCRKBsQIxQyQzQMUMkM0EgDdrxBaEPVf4R9aHsbb4Q2IdXCfgd8kMeXq43W\n25JeILey/wAI/wDZtvh/E/A862kH169kEfoeV8EnkNROrB4tlLdJav8Ai6GAGHlXQAAAAOogBi5+\njgAAD8lq/Bh7v/Yg/W/JavwYe7/2IOzob11kvjXeCiGN1v8AY3SvxMP6xBPxAJNK9mhDipnsgbn/\nAAOXf+u2EJrWbKeKmeyBuf8AA5d/67YQmtZwonp3c84UT07ueAHoegAAAAAB09I/rWfFp9JxRvVS\ney+r3U23xpPhXOD3o/S7wtPylQoZXOD3o/S7wtPylQ68rGXvAAc239IR2dCNuYe/HgXc3DpH/pCO\nzoRtzD348C7m4TxUz2NUb8GY+txzcxqWuINg/wCh6e/xVToAZQWAAADK+7nrekP5mlfzGoey8a7n\nrekP5mlfzGoeyr/N+q5roiN4RxQCmPXalOmM79Zil+NCx7J7Q3/D5gc/iLdx2oOK/Qseye0N/wAP\nmBz+It3Hag6qb4bOc750KtYc/XWgel8z9ZaFl9EL0n73/qD60SRehZfRC9J+9/6g+tEkZpgp4plQ\nOq+r/jOWOhwFcWfBX1fVV8cShrHAbeTf0AABsC0J/S7nfv2mX0Hdxr9bAtCf0u5379pl9B3cV01U\nnEpmentDeEjFQ9W5xDZ3qmq54aaMngGtI01gAAh+FQ91DxRfzbqOxDch4n9JGH4VD3UPFF/Nuo7E\nNyHiShg2/bX93f582Eag39bhS+LqX9KtZICUDYgAAG7biC3sv8I/9m2+H8T8DzrackvEFvZf4R/7\nNt8P4n4HnW0g+vXshj9DyvgkNROrB4tlLdJav+LoYAYeVdAAAAA6iAGLn6OAAAPyWr8GHu/9iD9b\n81dQpU4QhDF+Fj2e1GGLdxwhrbMMePFihF2FExGQqRlIkR7YcNkRyve9Ua1qLDe1Fcq5ES1UTLtq\ndBWmDGmaBpGBLwokeNEhQ2w4UJjokR6pHhKqNY1FctiIqrYmREtPwD/fkatyQ/agcjVuSH7UEhb8\n6O5Olezw/tEG74Kc5UUl2lMXe93oaCeKmeyBuf8AA5d/67YQmtZuu0e+hWw7YbMMF271YM7k1d45\nDL8Gsnu/a7dSvNdKTRqpvZL0XxmNfZORZ9PZZbKyFCxzWwV3H6uz07NS4/xuhXUq2qrqFXhFzvbR\nde1VVf8AbzBv6XOI+kJFXuVJyWVLeHr0O73Wn7lOI+rlPq9ypQ1Jqirk/wBSmLve70MLhmjzvbRd\ne1VVf9vMG/pcxhwhYPr34K74Ti4V/JTCR3rkPK/ltK6Nvls0o2XlrKrBO7Bit0otlul9fx+WTKxW\nn/N7VW8a49GproVdfV1tVQ9oUzLx3K2DHhRXI3GVsOI1zkbaiYyoiqtiK5qKu0qonDOHN0VSchDb\nGnZCclIT3pDbEmJeLCY6I5rntYjntaiuVrXOROGqNXcKMAfc68AAADp6R/Ws+LT6Tijeqk9l9Xup\ntvjSfCucHvR+l3haflKhQyucHvR+l3haflKh15WMveAA5tv6Qjs6Ebcw9+PAu5uHSP8A0hHZ0I25\nh78eBdzcJ4qZ7GqN+DMfW45uY1LXEGwf9D09/iqnQAygsAAAGV93PW9IfzNK/mNQ9l413PW9IfzN\nK/mNQ9lX+b9VzXREbwjigFMeu1KdMZ36zFL8aFj2T2hv+HzA5/EW7jtQcV+hY9k9ob/h8wOfxFu4\n7UHVTfDZznfOhVrDn660D0vmfrLQsvohek/e/wDUH1oki9Cy+iF6T97/ANQfWiSM0wU8UyoHVfV/\nxnLHQ4CuLPgr6vqq+OJQ1jgNvJv6AAA2BaE/pdzv37TL6Du41+tgWhP6Xc79+0y+g7uK6aqTiUzP\nT2hvCRioerc4hs71TVc8NNGTwDWkaawAAQ/Coe6h4ov5t1HYhuQ8T+kjD8Kh7qHii/m3UdiG5DxJ\nQwbftr+7v8+bCNQb+twpfF1L+lWskBKBsQAADdtxBb2X+Ef+zbfD+J+B51tOSXiC3sv8I/8AZtvh\n/E/A862kH169kMfoeV8EhqJ1YPFspbpLV/xdDADDyroAAAAHUQAxc/RwAABGlhjx4tf79TYSAIxQ\nyQzQMUMkM0EgLE3E08yZiMUMkM0DFDJDNBICxNxNPMmYjFDJDNBzNcUE9l7hd/6v/wCFtyI+OLpm\nczPFBPZe4Xf+r/8AhZcdkFXfVcfoV3hoJHGE7JQUnZk/2rA+rTafNkMNQGYEHAAAAdPSP61nxafS\ncUb1Unsvq91Nt8aT4Vzg96P0u8LT8pUKGVzg96P0u8LT8pUOvKxl7wAHNt/SEdnQjbmHvx4F3Nw6\nR/6Qjs6Ebcw9+PAu5uE8VM9jVG/BmPrcc3MalriDYP8Aoenv8VU6AGUFgAAAyvu563pD+ZpX8xqH\nsvGu563pD+ZpX8xqHsq/zfqua6IjeEcUApj12pTpjO/WYpfjQseye0N/w+YHP4i3cdqDiv0LHsnt\nDf8AD5gc/iLdx2oOqm+GznO+dCrWHP11oHpfM/WWhZfRC9J+9/6g+tEkXoWX0QvSfvf+oPrRJGaY\nKeKZUDqvq/4zljocBXFnwV9X1VfHEoaxwG3k39AAAbAtCf0u5379pl9B3ca/WwLQn9Lud+/aZfQd\n3FdNVJxKZnp7Q3hIxUPVucQ2d6pqueGmjJ4BrSNNYAAIfhUPdQ8UX826jsQ3IeJ/SRh+FQ91DxRf\nzbqOxDch4koYNv21/d3+fNhGoN/W4Uvi6l/SrWSAlA2IAABu24gt7L/CP/Ztvh/E/A862nJLxBb2\nX+Ef+zbfD+J+B51tIPr17IY/Q8r4JDUTqweLZS3SWr/i6GAGHlXQAAAAOogBi5+jgAAAAAAAAADU\nJooNAFhRw2YdL84TruXvuDK5PefUxyHYJ1abxUJnZ4yS5t3buWnkmjYbv22yw47a5RX11RGqtNZj\ns9ZVRrIUKyNOrobe3mV/42nuw8UGR1YRHT8Zq8LeR65o0DykeYSWo+hJRFtsSlIK5Fsy7zTSfxt5\n9hob51dht2/YLPC72+ixzq7Dbt+wWeF3t9Fm98ZxrLNxc66edbrIV1ll+c0Qc6uw27fsFnhd7fRY\n51dht2/YLPC72+ize+Gss3Fzrp51usayy/OaFJjxLzDRLbFabdXX8wX06qzVcaynQq7VeuNOlCEY\nQxUYUrsUaOOMYw2aUIdtRHO9sK23HB74TeT0edAV6vW7Nu9Y/wB+gx3dhJ0LIT7HxJhkRzmOxG4s\nVzExbEdlRFyraq5b+dZU3VAVfo2kqyULGmocVz2UGkNqsiuYiNSfm3WKjeGtrlymoXne2Fbbjg98\nJvJ6PPEn2hQvzgYsOrC8V4bpzOX06+qlELNJa6cVls5It1Gsraus0tulNiqONUKNjpwpx49p8dKj\npaEdfFuVYx6LLpW1Xvok/wA1mr1pKr1GS0hNTEKHFSJBgvexVjPcmMiZFVFWxd2z+BXWlarURKUb\nOzMGFGSLAl4kSGro73IjmpkVWqtipcprTAR8RganuKf6AbCfo4Y4D+Zxe+4V1eZhDCVy51b2i8NR\nyfq01AcruVnKGQzzT8i6k7dybyXCy6XkiycY4/pq7jOqDnB2ie9t7ALvhhD9AnWAJ5qb7G6M+BH7\n81HX+OY3MalriDYP+h6e/wAVU6cn/ODtE97b2AXfDCH6BHODtE97b2AXfDCH6BOsAZOWAOT/AJwd\nonvbewC74YQ/QI5wdonvbewC74YQ/QJ1gADmolXEWNENYJXLbDWYUMC9OssVgsdkrKdC3X50lKss\n9nq6mnSoaa5VGlpKVKhGNHTUYUtLGGOEI44P385j0QftnYGfDb8ehjpIFcZ6YiNnZtEVLEmY+174\n7T9/ONKdZ8LVc5estYYEKakkhwKcpaDDRaPl3KjIU/HYxFVUtVcVqWquVbVVeGc/+BriS2HPBxhf\nwUYRJvhEwTW6U3Cwl3DvrNLFLLXfCnMbXLrq3qlU9ttmsFC13Tstlp22vs1graqy0bTarPUUq+lQ\nhW19VQjSrKPQADgPiOiWK6zJwrEsI2rHWqmK1RpaYpiLBixJSE+DBWDAhwERj3I9yOSGiI5Vcltq\n5Qsvohek/e/9QfWiSL0LL6IXpP3v/UH1okjPMFPFMqB1X1f8ZyxmeAriz4K+r6qvjiUNY4Dbyb+g\nAANgWhP6Xc79+0y+g7uNfrYFoT+l3O/ftMvoO7iumqk4lMz09obwkYqHq3OIbO9U1XPDTRk8A1pG\nmsAAI2I0Y9v+UXKBzg3ROwxYsL2AbYhs2/CFj2OriuFizY4duLq/js0d3+UUpPwb8OmUuo/vb3eU\n2E6g39ZhT+BUr6VbDk/5wdonvbewC74YQ/QI5wdonvbewC74YQ/QJ1gCUTYecn/ODtE97b2AXfDC\nH6BHODtE97b2AXfDCH6BOsAAaR+JscTIwxaC/DnevCjhCv3gyvPJp9gnntwbLL7mWq9dfNKqaTS+\nFxLxVFrr6E8uxJrHCwVdkurbqmtpULXTtELRX2WFCz06ulW1lVu4RHZo7v8AKKUH169kMfoeV8Eh\nqJ1YPFspbpLV/wAXQwAw8q6AAAAB1EAMXP0cAAAAAAAAAAeZX/jae7DxQem/LTqaNKlGlSpRhGOz\nsYsetsQ14xhijDc2e1DuqCnZeRm4kWZerGOlnw0VGuequWLBciWNRVssYtq8LhJtmIV0omepijJe\nWkITYsZk9DjOa6JDhIkNsGOxVxojmttxntREttW3ImRT8I/ZyPV/16Wb/A5Hq/69LN/gyv0Q0Vx9\n/YYv2CM/QPWTkKH23K5OF77eh+Mfs5Hq/wCvSzf4HI9V/XpZv8D0Q0Xx9/YYv2B6B6ychw9r/wB3\nK7dnvt6FJ3q9bs271j/foMd2Sd67PVwu5OIwp0oxhY6ylCGLZ0saNLFsdpjYzGrc9Lz0rHiSz1ex\nkxiOVWOZY7W2OssciKuRUy8IqRqhKJnqHrLQkCfhNhRYlBJGY1sSHFRYaz82xFxobnIn6TXJYqou\nS2yxUDGPRZdK2q99En+azVk4xj0WXStqvfRJ/ms1c+mfWqf6GifMVqp/1lpLoSL8xrTAREQcB8wj\nHtYsXa/T1f5Qhr48mOccMsM6V6t1qoSjqFkpObmnw5iC2K2IxJeYiI1XR4r2pjshuYtrXNXIq2W2\nLltQ2T4B9UXgmqPgnqjVaslYJqSpqioNKsnpaHQdMzjITpunqUn4CJMSkjGl4mPKzUGIutxHYquV\njrHtVqSIxwywzpxwyw++PyRzRd56N6t8mxO1Jr+lemcl3ZbYCuaqe+TVYvw3SxbrQY4R2IwiiMYZ\nYf4f+2v5Xn0b1c5NiZeF/qk1l/8AqvQbLbAXzUz3yarF+G6Wc62RGX7x/T+6MEoTm4jYs1MRWKqs\niR4r2qqWKrXPcqLYuVLUVMi5U2zUnWGbgUhT9OT8q9YktO0xSc3LvVrmK+BMzseNBerHo17FdDe1\nVa5Ec1VsciKioAHHOnCy+iF6T97/ANQfWiSL0LL6IXpP3v8A1B9aJIz/AAU8UyoHVfV/xnLErYCu\nLPgr6vqq+OJQ1jgNvJv6AAA2BaE/pdzv37TL6Du41+tgWhP6Xc79+0y+g7uK6aqTiUzPT2hvCRio\nerc4hs71TVc8NNGTwDWkaawAAiOzR3f5RSiPU7UdbdjrfzIR1tfZ6u7nizmpdN0bQy0lvwjug70p\nKaziwosXG1lZnHt1pjsWzXWWY1ltq2W2KXA1J+FuouC19fFrrSsajEpxtWEo3WaNpCkVjLRq1gWc\nxkkJaYWDraUhKqixcTXMddbxlY+yRGOEdiMM5jhlhnZ36N6ucmxO1Jr+kXE2W2Armqnvk1WL8N0s\nW62RGOGWGf75YZzHDLDP98kczx6N6t8mxO1Jr+lemcbLbAVzVT3yarF+G6WLdajs0d3+UUvnHjjD\nYjD+eKPVhH90Ybj6RdWmkZSlKYizclEWLAdBgMR6sfDVXMhojkxYjWuyLt2WLtGvDVGV3q5hCwnU\nhWWqs7En6ImKMoiWhTEWUmpJ6xpSTZCjtWXnIUGO3EiIqI50NGuT9Jqq1UVQDHSCgAAAAOogBi5+\njgAAAAAAAAAAAAAAAAKdvb62p13jW/yYwsnr2+tqdd41v8mMKWsH3rbO9Hf5eCa/tVz7NqtdSzfG\n1JBjHosulbVe+iT/ADWasnGMeiy6VtV76JP81mrK6Z9ap/oaJ8xTmn/WWkuhIvzGtMBERBwAAAAA\nAAAAAABZfRC9J+9/6g+tEkXoWX0QvSfvf+oPrRJGf4KeKZUDqvq/4zliVsBXFnwV9X1VfHEoaxwG\n3k39AAAbAtCf0u5379pl9B3ca/WwLQn9Lud+/aZfQd3FdNVJxKZnp7Q3hIxUPVucQ2d6pqueGmjJ\n4BrSNNYAAAAAAAAAAAAAAAAAAHUQAxc/RwAAAAAAAAAAAAAAAAFO3t9bU67xrf5MYWT17fW1Ou8a\n3+TGFLWD71tnejv8vBNf2q59m1WupZvjakgxA0bc3tUkwNVVtslCz1lbqxkNTpbTQrKdXpKyyTiM\nY6WqramlpoRowxR0+KEMeOEdZl+wr0efSOqvftd75nOmV0z61T/Q0T5inNP+stJdCRfmNUPNGnvW\n0p8HtnDzmjT3raU+D2zh6gRERBxX3NGnvW0p8HtnDzmjT3raU+D2zh6gQBX3NGnvW0p8HtnDzmjT\n3raU+D2zh6gQBX3NGnvW0p8HtnDzmjT3raU+D2zh6gQBX3NGnvW0p8HtnDzmjT3raU+D2zh6gQBX\n3NGnvW0p8HtnDzmjT3raU+D2zh6gQBX3NGnvW0p8HtnD1MXynVsvxduZXXm1CzWewTTkPj9dLqut\nqbZQ5Ct9lmNVxmstNdbKijpq6yVdCs09nrMdVSp0aOkpxo06PkDP8FPFMqB1X1f8ZyxK2Ariz4K+\nr6qvjiULQcxe7HZCf+Fy37IOYvdjshP/AAuW/ZC7428m/otBzF7sdkJ/4XLfsg5i92OyE/8AC5b9\nkLvgC0HMXux2Qn/hct+yF4cHlbTwbSW1yKRaW12S1TW0TatrJvCNotMLTX2Sw2OnQq6dijL6qFRC\nqsFTSoUaVRSrIVlOsjSrKVGNCjQ+XzR/0vdR/krpqpOJTM9PaG8JGKh6tziGzvVNVzw0yXA5o096\n2lPg9s4ec0ae9bSnwe2cPUCNaRprK+5o0962lPg9s4ec0ae9bSnwe2cPUCAK+5o0962lPg9s4ec0\nae9bSnwe2cPUCAK+5o0962lPg9s4ec0ae9bSnwe2cPUCAK+5o0962lPg9s4ec0ae9bSnwe2cPUCA\nK+5o0962lPg9s4ec0ae9bSnwe2cPUCAK+5o0962lPg9s4ec0ae9bSnwe2cPUCAK+5o0962lPg9s4\nec0ae9bSnwe2cPUCAK+5o0962lPg9s4eKBAHZgAxc/RwAAAAAAAAAAAAAAAAFO3t9bU67xrf5MYW\nWkwstRbbFabJaaHHKi0VVKrraGmp0NNQpbMNNV0qFOju0aUIw6kVD6hrs9Yf99mXCkm1Hn4MpITb\nIjYjldOYyKxGKiJrMJuXGiNW21NpF59uQpzqjsHtNVwrTQc9RkzRcCDLUA2UiNno8zCiLESkZ6Nj\nMbAk5lqsxYrUtVzXYyOTFsRFWwbCvR59I6q9+13vmc6bUNQ12esP++zLhTALikd2ZLKdDtVWqwWX\njNo5oN16rT8kWuthxunYp9GlDS19fWUdeNGGvixw6kYa7KKRpKBMyM1Lw2RUfGgvY1XJDRqK5MmM\nrYjnImVLVRq5itNK4CK3zdHTktCpCraRI8B8NjnztIoxHOSxMZW0S5yIm2qNVdxFNCAjXywzR8pr\n5YZo+VgG++N7aF1zrvc36ZLYz2L2EDltU/ujS/4CSI18sM0fKa+WGaPlN98b20LrnXe5v0yWti9h\nA5bVP7o0v+AkiNfLDNHymvlhmj5TffG9tC6513ub00sGxewgctqn90aX/ASRGvlhmj5TXywzR8pv\nvje2hdc673N+mQbF7CBy2qf3Rpf8BJEa+WGaPlNfLDNHym8Eb20Lrlu9zemlg2L2EDltU/ujS/4C\nSI18sM0fKa+WGaPlN98b20LrnXe4v0tS1sXsIHLap/dGl/wEkRr5YZo+VEYUssMuxHXxdTZj+5lF\nSJqHVyuFV6fnkfEkqFp6i6Um4cqjYky+XkpyDMRWwGRXQYb4rmMVIbXxobFcqI57EXGM1wbYAq5V\nOwg1LrXSdI1aj0dVys9C01PQZCdpKLOxZSjp+BNR2SkKPREtBiTDocNyQmRZiAxz7EdEYi4yfQ+I\n6fqQ1upj2djtxx59mPa1jHTyQ+/6V7dlNg95U1w7n0Ld/wAwXpw7DZ7wV6u8hU12tJXf8Rv+fcPs\nfGOnkhHY2cWSGPqw6pjp5IdTW1u3j6u51f5mynwe8qa4dz6Eu/5hvQcFirvIVNdrSV3/ABG/vLuH\n2+aP+l7qP8kY6fVhCG5s+OOP77GymEI6+LFCGPq44x7cY6+ZFGGfDbVTCJUmNVuhJGn5aeiUlR84\nkWlJWjoEqkKVe90RqxJSlZ2Lrio9MREgqiqi2ubktgnVEzLMLuDeZqfVpr5Kk4tMUTSDY9OI2VkU\ngSMSM+M10WSdSMdIrkit1tiSyo5UdjOajVU+hGvlhmj5TXywzR8qoO++N7aF1zrvc3ppYUD2L2ED\nltU/ujS/4CSI18sM0fKa+WGaPlN98b20LrnXe4v0tS1sXsIHLap/dGl/wEkRr5YZo+U18sM0fKbw\nRvbQuuW73N6aWDYvYQOW1T+6NL/gJIjXywzR8pr5YZo+U33xvbQtr+07bs9xf5Nq1sXsIHLap/dG\nl/wEkRr5YZo+U18sM0fKbwRvbQuuW73N6aWDYvYQOW1T+6NL/gJIjXywzR8pr5YZo+U33xvbQuud\nd7i/S1LWxewgctqn90aX/ASRGvlhmj5TXywzR8pvvje2hdc673N+mS1sXsIHLap/dGl/wEkRr5YZ\no+U18sM0fKb743toW1/adt2e4v8AJtWti9hA5bVP2v2jS+3/AHDtbZIjXywzR8ob743t4O1/bXbs\n9z7pO+eNi/hA5bVQ7o0vd/wG/vLuHZiAwk3UgAAAAAAAAAAAAAAAB/nW/iqfuYvLepW/iqfuYvLZ\nzVb1HMdE/wDahkN4SPXWR6Xp9Zjhrz4pp7G+p+ES6vzG8DYY158U09jfU/CJdX5jeBkkT0jucRxE\n9I7nHPmA4RwgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADswAReW4AAAAAAAAAAAAAAA\nAD/Ot/FU/cxeW9St/FU/cxeWzmq3qOY6J/7UMhvCR66yPS9PrMcNefFNPY31PwiXV+Y3gbDGvPim\nnsb6n4RLq/MbwMkiekdziOInpHc458wHCOEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAdmACLy3AAAAAAAAAAAAAAAAAf51v4qn7mLywZzVb1HMdE/9qGQ3hI9dZHpen1mOGvPimnsb6n4R\nLq/MbwAySJ6R3OI4iekdzjnzAcI4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB//9k=\n	2022-07-29 01:01:48	37.4219983	-122.084	3.0750000476837	null	\N	\N	\N	\N	\N	0101000020E61000004C37894160855EC0DABB500A04B64240	\N
\.


--
-- TOC entry 4673 (class 0 OID 47689)
-- Dependencies: 315
-- Data for Name: gp_list; Type: TABLE DATA; Schema: sisdp; Owner: postgres
--

COPY sisdp.gp_list (id, stname, stcode, dtname, dtcode, bpname, bpcode, gpname, gpcode) FROM stdin;
2	Andhra Pradesh	28	Krishna	547	Unguturu	5013	Telaprolu	203770
3	Chhattisgarh	22	Durg	378	Patan	3318	Jhit	124907
4	Chhattisgarh	22	Raipur	387	Raipur	3332	Sankra	129199
6	Gujarat	24	Mahesana	471	Kadi	3759	NANDASAN	161222
7	Haryana	6	Ambala	70	Saha	451	Mullana	27949
8	Haryana	6	Ambala	70	Shahzadpur	452	Patrehri	28167
9	Jharkhand	20	Bokaro	355	Chas	2595	Kandra	111215
10	Jharkhand	20	Ranchi	364	Kanke	2684	Neuri	114696
11	Karnataka	29	Udupi	569	Kundapura	5522	Shankaranarayana	220493
12	Karnataka	29	Udupi	569	Kundapura	5522	Uppunda	220499
13	Madhya Pradesh	23	Sehore	445	Sehore	4349	Bilkis ganj	149346
14	Madhya Pradesh	23	Vidisha	443	Lateri	4408	Murvas	154191
15	Maharashtra	27	Ahmednagar	522	Rahuri	4210	Guha	168434
16	Maharashtra	27	Kolhapur	530	Kagal	4290	Boravade	178678
17	Maharashtra	27	Nagpur	505	Kalmeshwar	4025	Gondkhairi	180128
18	Maharashtra	27	Nagpur	505	Ramtek	4028	Mansar	180644
19	Maharashtra	27	Pune	521	Junnar	4187	Belhe	185917
20	Maharashtra	27	Pune	521	Junnar	4187	Rajuri	186001
21	Tamil Nadu	33	Thiruvallur	602	Poonamalle	6351	Sembarambakkam	229373
22	Tamil Nadu	33	Thiruvallur	602	Villivakkam	6359	Morai	229643
23	Tamil Nadu	33	Tiruchirapalli	614	Manikandam	6374	Navalurkuttapattu	230219
24	Tamil Nadu	33	Tiruchirapalli	614	Thiruverumpur	6379	Gundur	230371
25	Uttar Pradesh	9	G.B. Nagar	141	DADRI	1126	KALONDA	63317
26	Uttar Pradesh	9	Lucknow	157	GOSAIGANJ	1331	BAKKAS	75478
27	Uttarakhand	5	DEHRADUN	60	Vikasnagar	967	CHARBA	23190
28	Uttarakhand	5	HARIDWAR	68	Roorkee	973	BELDA	23535
29	West Bengal	19	West medinipur	344	Jhargram	2454	Aguibani	110376
30	West Bengal	19	West medinipur	344	Narayangarh	2465	Mokrampur	110453
32	Assam	18	Kamrup	321	Sualkuch	3014	Bongshar	106841
31	Assam	18	Kamrup	321	Bezera	2999	Saraighat	183210021
1	Andhra Pradesh	28	Krishna	547	Kanchikacherla	5007	Paritala	203282
2	Chhattisgarh	22	Surguja	389	Udaypur	3249	Udaipur	131460
5	Gujarat	24	Anand	482	Khambhat	3866	TARAPUR	155778
4	Odissa	21	KHORDHA	386	Balianta	3819	PRATAP SASAN	119544
5	Odissa	21	CUTTACK	381	Tigiria	3708	NUAPATNA	117175
\.


--
-- TOC entry 4669 (class 0 OID 47627)
-- Dependencies: 311
-- Data for Name: login; Type: TABLE DATA; Schema: sisdp; Owner: postgres
--

COPY sisdp.login (id, username, password, name, email, phone, desig, org, confirmcode, vill_code) FROM stdin;
1	testuser	test123	test	khushboo.mirza@gmail.com	9871106478	test	test	\N	\N
\.


--
-- TOC entry 4672 (class 0 OID 47682)
-- Dependencies: 314
-- Data for Name: mailids; Type: TABLE DATA; Schema: sisdp; Owner: postgres
--

COPY sisdp.mailids (id, gpcode, bpcode, dtcode, stcode, inst_name, primary_mail, secondary_mail) FROM stdin;
1	203282	5007	547	28	IIT 	developersrc_sisdp@nrsc.gov.in	veenu22sharma@yahoo.com
1	203282	5007	547	28	School of Planning and Architecture, Vijayawada	director@spav.ac.in	jainminakshi@gmail.com
\.


--
-- TOC entry 4325 (class 0 OID 46896)
-- Dependencies: 224
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- TOC entry 4326 (class 0 OID 47250)
-- Dependencies: 268
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4327 (class 0 OID 47262)
-- Dependencies: 270
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4328 (class 0 OID 47274)
-- Dependencies: 272
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- TOC entry 4329 (class 0 OID 47320)
-- Dependencies: 274
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- TOC entry 4330 (class 0 OID 47333)
-- Dependencies: 275
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- TOC entry 4690 (class 0 OID 0)
-- Dependencies: 308
-- Name: hh_family_member_id_seq; Type: SEQUENCE SET; Schema: sisdp; Owner: postgres
--

SELECT pg_catalog.setval('sisdp.hh_family_member_id_seq', 18323, true);


--
-- TOC entry 4691 (class 0 OID 0)
-- Dependencies: 309
-- Name: hh_gp_list_id_seq; Type: SEQUENCE SET; Schema: sisdp; Owner: postgres
--

SELECT pg_catalog.setval('sisdp.hh_gp_list_id_seq', 5, true);


--
-- TOC entry 4692 (class 0 OID 0)
-- Dependencies: 310
-- Name: hh_survey_data_id_seq; Type: SEQUENCE SET; Schema: sisdp; Owner: postgres
--

SELECT pg_catalog.setval('sisdp.hh_survey_data_id_seq', 7321, true);


--
-- TOC entry 4693 (class 0 OID 0)
-- Dependencies: 312
-- Name: hh_survey_login_id_seq; Type: SEQUENCE SET; Schema: sisdp; Owner: postgres
--

SELECT pg_catalog.setval('sisdp.hh_survey_login_id_seq', 44, true);


--
-- TOC entry 4694 (class 0 OID 0)
-- Dependencies: 313
-- Name: mailids_id_seq; Type: SEQUENCE SET; Schema: sisdp; Owner: postgres
--

SELECT pg_catalog.setval('sisdp.mailids_id_seq', 1, true);


--
-- TOC entry 4695 (class 0 OID 0)
-- Dependencies: 316
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: sisdp; Owner: postgres
--

SELECT pg_catalog.setval('sisdp.users_id_seq', 3, false);


-- Completed on 2022-07-29 18:37:47

--
-- PostgreSQL database dump complete
--

