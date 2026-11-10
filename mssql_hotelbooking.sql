EXEC sp_help 'dbo.bookings';

SELECT booking_id
FROM dbo.bookings
WHERE booking_id BETWEEN 1 AND 12;

SELECT guest_id FROM dbo.guests;
SELECT room_id FROM dbo.rooms;

INSERT INTO bookings (booking_id,guest_id,room_id,check_in,check_out,num_guests,status) VALUES
(1,1,1,'2026-09-01','2026-09-04',2,'Completed'),
(2,2,3,'2026-09-05','2026-09-08',3,'Completed'),
(3,3,7,'2026-09-10','2026-09-12',2,'Completed'),
(4,4,1,'2026-09-10','2026-09-13',1,'Completed'),
(5,5,5,'2026-10-01','2026-10-05',4,'Completed'),
(6,1,3,'2026-10-20','2026-10-23',2,'Completed'),
(7,6,2,'2026-10-24','2026-10-28',2,'Confirmed'),
(8,7,8,'2026-11-05','2026-11-08',3,'Confirmed'),
(9,2,1,'2026-11-05','2026-11-07',2,'Cancelled'),
(10,8,1,'2026-11-05','2026-11-09',2,'Confirmed'),
(11,3,9,'2026-12-24','2026-12-28',4,'Confirmed'),
(12,4,4,'2026-10-25','2026-10-27',2,'Pending');

DELETE FROM dbo.bookings
WHERE booking_id BETWEEN 1 AND 12;

