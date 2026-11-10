CREATE DATABASE HotelBooking;

USE HotelBooking;
GO

CREATE TABLE guests (
    guest_id   INTEGER PRIMARY KEY,
    full_name  Varchar(55) NOT NULL,
    email      Varchar(55) NOT NULL UNIQUE,
    phone      INTEGER NOT NULL,
    country    Varchar NOT NULL,
    created_at Varchar NOT NULL
);


CREATE TABLE room_type (
room_type_ID  INTEGER PRIMARY KEY,
typename Varchar(55) NOT NULL UNIQUE,
price_per_night REAL NOT NULL CHECK (price_per_night > 0),
capacity INTEGER NOT NULL CHECK (Capacity > 0)
);

CREATE TABLE rooms (
    room_id      INTEGER PRIMARY KEY,
    room_number  INTEGER NOT NULL UNIQUE,
    flooor       INTEGER NOT NULL,
    room_type_id INTEGER NOT NULL REFERENCES room_type(room_type_id),
    is_active    INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0,1))
    );

CREATE TABLE bookings (
    booking_id   INTEGER PRIMARY KEY,
    guest_id     INTEGER NOT NULL REFERENCES guests(guest_id),
    room_id      INTEGER NOT NULL REFERENCES rooms(room_id),
    check_in     VARCHAR(255) NOT NULL,   -- YYYY-MM-DD
    check_out    VARCHAR(255) NOT NULL,
    num_guests   INTEGER NOT NULL CHECK (num_guests > 0),
    status       VARCHAR(255) NOT NULL CHECK (status IN ('Pending','Confirmed','Completed','Cancelled')),
    total_amount REAL,
    CHECK (check_out > check_in)
);

ALTER TABLE dbo.bookings
ALTER COLUMN booking_id INTEGER;

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    booking_id INTEGER NOT NULL REFERENCES bookings(booking_id),
    amount     REAL NOT NULL CHECK (amount > 0),
    method     VARCHAR(255) NOT NULL CHECK (method IN ('Card','Cash','UPI','BankTransfer')),
    paid_on    VARCHAR(255) NOT NULL
);

CREATE TABLE reviews (
    review_id  INTEGER PRIMARY KEY,
    booking_id INTEGER NOT NULL UNIQUE REFERENCES bookings(booking_id),
    rating     INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment    TEXT
);


ALTER TABLE dbo.guests
ALTER COLUMN phone VARCHAR(15);

ALTER TABLE dbo.guests
ALTER COLUMN country Varchar(55) NOT NULL;

ALTER TABLE dbo.guests
DROP COLUMN created_at;



INSERT INTO guests (guest_id, full_name, email, phone, country) VALUES
(1,'Aarav Sharma','aarav@example.com','9800000001','Nepal'),
(2,'Emma Wilson','emma@example.com','9400000002','UK'),
(3,'Liam Chen','liam@example.com','9600000003','China'),
(4,'Sofia Rossi','sofia@example.com','9300000004','Italy'),
(5,'Rohan Mehta','rohan@example.com','9100000005','India'),
(6,'Maya Thapa','maya@example.com','9800000006','Nepal'),
(7,'Noah Smith','noah@example.com','9000000007','USA'),
(8,'Yuki Tanaka','yuki@example.com','8100000008','Japan');


SELECT * FROM guests WHERE country = 'Nepal';




