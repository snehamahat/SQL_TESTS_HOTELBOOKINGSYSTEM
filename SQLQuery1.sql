use HotelBooking
GO

-- Q6.  Every booking with the guest's full_name and country (bookings JOIN guests),
--      sorted by booking_id.
SELECT b.booking_id, g.full_name, g.country, b.check_in, b.status
FROM bookings b				
JOIN guests g ON g.guest_id = b.guest_id
ORDER BY b.booking_id;

-- Q7.  All 'Completed' bookings with the guest name, earliest check-in first.
SELECT b.booking_id,g.full_name,b.check_in,b.check_out
FROM bookings b
JOIN guests g ON g.guest_id =b.guest_id
WHERE b.status = 'Completed'
ORDER BY b.check_in;

-- Q8.  Every booking with room_number and floor (bookings JOIN rooms), by booking_id.
SELECT b.booking_id,r.room_number,r.flooor
FROM bookings b
JOIN rooms r ON r.room_id=b.room_id
ORDER BY b.booking_id;
-- Q9.  Full detail of booking_id 5: guest name, room number, room type name and
--      price per night (bookings + guests + rooms + room_types = 4 tables).
SELECT b.booking_id, g.full_name, r.room_number, rt.typename, rt.price_per_night
FROM bookings b
JOIN guests g    ON g.guest_id   = b.guest_id
JOIN rooms r     ON r.room_id    = b.room_id
JOIN room_type rt ON rt.room_type_id = r.room_type_id
WHERE b.booking_id = 5;


-- Q10. Every booking of room type 'Suite': booking_id, guest name, room number.
SELECT b.booking_id,g.full_name,r.room_number,rt.typename
FROM bookings b
JOIN guests g    ON g.guest_id   = b.guest_id
JOIN rooms r     ON r.room_id    = b.room_id
JOIN room_type rt ON  rt.room_type_id = r.room_type_id
WHERE rt.typename = 'Suite';


-- Q11. Bookings made by guests from Nepal: booking_id, guest name, check_in (sorted).
SELECT b.booking_id,g.full_name,b.check_in
FROM bookings b
JOIN guests g ON g.guest_id   = b.guest_id
JOIN rooms r ON r.room_id = b.room_id
JOIN room_type rt ON  rt.room_type_id = r.room_type_id
WHERE country='Nepal'
ORDER BY check_in;

-- Q12. The cancelled booking with the guest's name and country.
SELECT b.booking_id, g.full_name, g.country, b.total_amount
FROM bookings b
JOIN guests g ON g.guest_id = b.guest_id
WHERE b.status = 'Cancelled';




-- Q13. All UPI payments with the name of the guest who paid: payment_id, full_name,
--      amount, paid_on (most recent first).

SELECT p.payment_id, g.full_name, p.amount, p.paid_on
FROM payments p
JOIN bookings b ON b.booking_id = p.booking_id
JOIN guests g   ON g.guest_id   = b.guest_id
WHERE p.method = 'UPI'
ORDER BY p.paid_on DESC, p.payment_id DESC;

-- Q14. Every review with the reviewer's name and the room type: review_id, rating,
--      full_name, type_name (reviews + bookings + guests + rooms + room_types

--Q15. Every guest with the number of 'Confirmed' bookings they have.
--      Use a LEFT JOIN so guests with 0 confirmed bookings still appear with 0.
--    Why is an INNER JOIN wrong here? (It would hide the inactive guests.)
-- Q16. QA check: guests who have NEVER booked (LEFT JOIN + IS NULL). How many rows?
-- Q17. QA check: rooms that have NEVER been booked. Which room_numbers?
-- Q18. QA check: bookings with NO payment recorded. How many rows do you expect?
--      (Think: which statuses should legitimately have no payment?)
-- Q19. QA check: 'Completed' bookings with NO review. Who stayed but never rated?
