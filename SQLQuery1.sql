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

SELECT rv.review_id, rv.rating, g.full_name, rt.typename
FROM reviews rv
JOIN bookings b   ON b.booking_id = rv.booking_id
JOIN guests g     ON g.guest_id   = b.guest_id
JOIN rooms r      ON r.room_id    = b.room_id
JOIN room_type rt ON rt.room_type_id = r.room_type_id
ORDER BY rv.rating DESC, rv.review_id;



--Q15. Every guest with the number of 'Confirmed' bookings they have.
--      Use a LEFT JOIN so guests with 0 confirmed bookings still appear with 0.
--    Why is an INNER JOIN wrong here? (It would hide the inactive guests.)
SELECT
    g.guest_id,
    g.full_name,
    COUNT(b.booking_id) AS confirmed_booking_count
FROM guests AS g
LEFT JOIN bookings AS b
    ON b.guest_id = g.guest_id
   AND b.status = 'Confirmed'
GROUP BY
    g.guest_id,
    g.full_name
ORDER BY
    g.full_name;
-- Q16. QA check: guests who have NEVER booked (LEFT JOIN + IS NULL). How many rows?

SELECT COUNT(*) AS guests_who_never_booked
FROM guests AS g
LEFT JOIN bookings AS b
    ON b.guest_id = g.guest_id
WHERE b.booking_id IS NULL;

-- Q17. QA check: rooms that have NEVER been booked. Which room_numbers?

SELECT
    r.room_id,
    r.room_number
FROM rooms AS r
LEFT JOIN bookings AS b
    ON b.room_id = r.room_id
WHERE b.booking_id IS NULL
ORDER BY r.room_number;


-- Q18. QA check: bookings with NO payment recorded. How many rows do you expect?
--      (Think: which statuses should legitimately have no payment?)
SELECT
    b.booking_id,
    b.status,
    b.total_amount
FROM bookings AS b
LEFT JOIN payments AS p
    ON p.booking_id = b.booking_id
WHERE p.payment_id IS NULL
ORDER BY b.booking_id;

-- Q19. QA check: 'Completed' bookings with NO review. Who stayed but never rated?
SELECT
    b.booking_id,
    g.full_name,
    b.check_in,
    b.check_out
FROM bookings AS b
JOIN guests AS g
    ON g.guest_id = b.guest_id
LEFT JOIN reviews AS rv
    ON rv.booking_id = b.booking_id
WHERE b.status = 'Completed'
  AND rv.review_id IS NULL
ORDER BY b.check_out;



-- Q18. QA check: bookings with NO payment recorded. How many rows do you expect?
--      (Think: which statuses should legitimately have no payment?)
-- Q19. QA check: 'Completed' bookings with NO review. Who stayed but never rated?
