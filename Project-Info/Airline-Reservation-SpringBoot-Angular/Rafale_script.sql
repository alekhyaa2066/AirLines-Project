-- // AIRLINES RESERVATION PROJECT - RAFALE //

/*CREATE LOGIN rafale WITH PASSWORD = 'rafale'
CREATE USER rafale for LOGIN rafale
    GRANT ALL PRIVILEGES TO rafale;
 can use an existing db user or create a new one using below commands
    CREATE USER rafale IDENTIFIED by rafale;
    GRANT ALL PRIVILEGES TO rafale;
*/

/*  Tables -
    1. FLIGHTS
    2. ROUTES
    3. SCHEDULE
    4. FLIGHT_SCHEDULE
    5. USERS
    6. ADMIN
    7. SEATS
    8. BOOKING
    9. PASSENGERS
*/

-- FLIGHTS table with each Airline having its own unique ID
-- Admin will use this ID to refer to respective Airline while Adding Flight

CREATE TABLE FLIGHTS (
    id integer PRIMARY KEY IDENTITY(100,1),
    airlines VARCHAR(20) NOT NULL,
    max_seats integer,
    max_baggage_kg integer,
    economy DOUBLE PRECISION NOT NULL,
    business DOUBLE PRECISION
);

INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Air India', 50, 21, 3000, 5000);
INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Indigo', 40, 20, 3000, 4500);
INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Air India', 50, 21, 3000, 5000);
INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Vistara', 50, 15, 4000, 6000);
INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Go Air', 30, 15, 3500, 5000);
INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Vistara', 25, 14, 4000, 6000);
INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Go Air', 5, 7, 3500, 5000);
INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Indigo', 30, 15, 3000, 4500);
INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Indigo', 40, 15, 3000, 4500);
INSERT INTO FLIGHTS(airlines,max_seats,max_baggage_kg,economy,business) VALUES('Air India', 35, 15, 3000, 5000);


-- ROUTES table with each route having its own unique ID

CREATE TABLE ROUTES(
    id INTEGER PRIMARY KEY IDENTITY(1000,1),
    source VARCHAR(20) NOT NULL,
    destination VARCHAR(20) NOT NULL
);

INSERT INTO ROUTES(source,destination) VALUES('Delhi','Mumbai');
INSERT INTO ROUTES(source,destination) VALUES('Mumbai', 'Delhi');
INSERT INTO ROUTES(source,destination) VALUES('Delhi', 'Pune');
INSERT INTO ROUTES(source,destination) VALUES('Pune', 'Delhi');
INSERT INTO ROUTES(source,destination) VALUES('Bangalore', 'Chennai');
INSERT INTO ROUTES(source,destination) VALUES('Chennai', 'Bangalore');
INSERT INTO ROUTES(source,destination) VALUES('Chennai', 'Mumbai');
INSERT INTO ROUTES(source,destination) VALUES('Mumbai', 'Chennai');
INSERT INTO ROUTES(source,destination) VALUES('Mumbai', 'Bangalore');
INSERT INTO ROUTES(source,destination) VALUES('Bangalore', 'Mumbai');
INSERT INTO ROUTES(source,destination) VALUES('Delhi', 'Chennai');
INSERT INTO ROUTES(source,destination) VALUES('Chennai', 'Delhi');
INSERT INTO ROUTES(source,destination) VALUES('Pune', 'Bangalore');
INSERT INTO ROUTES(source,destination) VALUES('Bangalore', 'Pune');

-- Creating SEQUENCES

create sequence schedule_seq start with 100 increment by 1;
create sequence fschedule_seq start with 200 increment by 1;
create sequence user_seq start with 300 increment by 1;
create sequence seats_seq start with 10 increment by 1;
create sequence booking_seq start with 401 increment by 1;
create sequence passenger_seq start with 501 increment by 1;


-- SCHEDULE table with each route having multiple depart/arrive schedules

CREATE TABLE SCHEDULE(
    id integer PRIMARY KEY IDENTITY(10000,1),
    route_id integer,
    depart DATETIME NOT NULL,
    arrive DATETIME NOT NULL,
    CONSTRAINT route_fk FOREIGN KEY (route_id) REFERENCES ROUTES(id)
);


-- FLIGHT_SCHEDULE table with each row corresponding to a unique schedule and flight pair

CREATE TABLE FLIGHT_SCHEDULE(
    id integer PRIMARY KEY IDENTITY(20000,1),
    schedule_id integer,
    flight_id integer,
    economy DOUBLE PRECISION NOT NULL,
    business DOUBLE PRECISION,
    eco_seats_available integer,
    bus_seats_available integer,
    status VARCHAR(20) DEFAULT 'AVAILABLE',
    CONSTRAINT f_fk FOREIGN KEY (flight_id) REFERENCES FLIGHTS(id),
    CONSTRAINT s_fk FOREIGN KEY (schedule_id) REFERENCES SCHEDULE(id)
);


-- USERS table for registered public data

CREATE TABLE USERS(
    id integer PRIMARY KEY IDENTITY(30000,1),
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone_no integer,
    date_of_birth DATE,
    password VARCHAR(30)
);

-- INSERT INTO USERS VALUES(601,'Gurdeep Mishra','gurdeep1@xyz.com',1234567890, TO_TIMESTAMP('02-OCT-1998', 'DD-MON-YYYY'),'GURDEEP1');
-- INSERT INTO USERS VALUES(602,'Gautam Jukaria','gautam1@xyz.com',9876543210, TO_TIMESTAMP('10-MAR-1998', 'DD-MON-YYYY'),'GAUTAM1');



-- ADMIN table for registered Admins data

CREATE TABLE ADMIN(
    id integer PRIMARY KEY IDENTITY(1,1),
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(30)
);

-- Password stored in Users and Admin table is Base64 encoding of the original password
-- Below statement will create a default Admin profile with user id = admin@lti and password = admin#123
INSERT INTO ADMIN (full_name,email,password) VALUES ('Admin User', 'admin@lti', 'YWRtaW4jMTIz');


-- SEATS table to store no of seats and their availability for a flight-schedule

CREATE TABLE SEATS (
    id VARCHAR(4) PRIMARY KEY,
    fs_id integer,
    status VARCHAR(20),
    class VARCHAR(20),
    CONSTRAINT fs_fk FOREIGN KEY (fs_id) REFERENCES FLIGHT_SCHEDULE(id)
);


-- BOOKING table to store user and flight-schedule pair

CREATE TABLE BOOKING(
    id integer PRIMARY KEY IDENTITY(50000,1),
    user_id integer,
    fs_id integer,
    booking_datetime TIMESTAMP,
    total_passengers integer NOT NULL,
    amount DOUBLE PRECISION NOT NULL,
    status VARCHAR(20),
    CONSTRAINT bu_fk FOREIGN KEY (user_id) REFERENCES USERS(id),
    CONSTRAINT bfs_fk FOREIGN KEY (fs_id) REFERENCES FLIGHT_SCHEDULE(id)
);


-- PASSENGERS table to store seats and passenger details booked by a user

CREATE TABLE PASSENGERS(
    id integer PRIMARY KEY IDENTITY(60000,1),
    title VARCHAR(5),
    full_name VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    age integer NOT NULL,
    phone_integer integer NOT NULL,
    seat_integer VARCHAR(4),
    booking_id integer,
    CONSTRAINT ps_fk FOREIGN KEY (seat_integer) REFERENCES SEATS(id),
    CONSTRAINT pb_fk FOREIGN KEY (booking_id) REFERENCES BOOKING(id)
);
