-- =====================================================
-- PVR INOX Business Performance FY26 : SQL Analysis
-- Database: SQLite  |  Tables: Bookings, Shows, Movies, Theatres, Food_Sales
-- Rule: revenue metrics use Booking_Status = 'Confirmed' only
-- =====================================================

-- Task 1: Tickets sold and ticket revenue
-- Expected: 570652 tickets, 137624710 revenue
SELECT SUM(Tickets) AS tickets_sold,
       SUM(Ticket_Gross_Amount) AS ticket_revenue
FROM Bookings
WHERE Booking_Status = 'Confirmed';

-- Task 2: Average ticket price (ATP)
-- Expected: 241.17
SELECT ROUND(1.0 * SUM(Ticket_Gross_Amount) / SUM(Tickets), 2) AS avg_ticket_price
FROM Bookings
WHERE Booking_Status = 'Confirmed';

-- Task 3: Total revenue = tickets + convenience fees + food
-- Food is totalled per booking first so joined rows are not duplicated
-- Expected: 214993708
SELECT SUM(b.Ticket_Gross_Amount + b.Convenience_Fee) + SUM(COALESCE(f.food, 0)) AS total_revenue
FROM Bookings b
LEFT JOIN (
    SELECT Booking_ID, SUM(Food_Sales_Amount) AS food
    FROM Food_Sales
    GROUP BY Booking_ID
) f ON b.Booking_ID = f.Booking_ID
WHERE b.Booking_Status = 'Confirmed';

-- Task 4: Cancellation rate (%)
-- Expected: 6.1
SELECT ROUND(100.0 * COUNT(CASE WHEN Booking_Status = 'Cancelled' THEN 1 END) / COUNT(*), 1) AS cancel_pct
FROM Bookings;

-- Task 5: Monthly ticket revenue
-- Expected: 12 rows, lowest is 2026-02 (10395768)
SELECT strftime('%Y-%m', Show_Date) AS month,
       SUM(Ticket_Gross_Amount) AS revenue
FROM Bookings
WHERE Booking_Status = 'Confirmed'
GROUP BY month
ORDER BY month;

-- Task 5b: Weakest month
-- Expected: 2026-02
SELECT strftime('%Y-%m', Show_Date) AS month,
       SUM(Ticket_Gross_Amount) AS revenue
FROM Bookings
WHERE Booking_Status = 'Confirmed'
GROUP BY month
ORDER BY revenue ASC
LIMIT 1;

-- Task 6: Revenue by state
-- Expected: Maharashtra first (27514379)
SELECT t.State,
       SUM(b.Ticket_Gross_Amount) AS revenue
FROM Bookings b
JOIN Theatres t ON b.Theatre_ID = t.Theatre_ID
WHERE b.Booking_Status = 'Confirmed'
GROUP BY t.State
ORDER BY revenue DESC;

-- Task 7: Revenue by genre
-- Expected: Horror first (24546559)
SELECT m.Genre,
       SUM(b.Ticket_Gross_Amount) AS revenue
FROM Bookings b
JOIN Movies m ON b.Movie_ID = m.Movie_ID
WHERE b.Booking_Status = 'Confirmed'
GROUP BY m.Genre
ORDER BY revenue DESC;

-- Task 8: Booking channel share (window function)
-- Expected: App 62.1, Website 23.0, Counter 14.9
SELECT Booking_Channel,
       SUM(Ticket_Gross_Amount) AS revenue,
       ROUND(100.0 * SUM(Ticket_Gross_Amount) / SUM(SUM(Ticket_Gross_Amount)) OVER (), 1) AS share_pct
FROM Bookings
WHERE Booking_Status = 'Confirmed'
GROUP BY Booking_Channel
ORDER BY revenue DESC;

-- Task 9a: Food sales by item
-- Expected: Combo Meal first (17150178)
SELECT Item_Name,
       SUM(Food_Sales_Amount) AS food_sales
FROM Food_Sales
GROUP BY Item_Name
ORDER BY food_sales DESC;

-- Task 9b: Food spend per head
-- Expected: 126
SELECT ROUND(
         1.0 * (SELECT SUM(Food_Sales_Amount) FROM Food_Sales)
         / (SELECT SUM(Tickets) FROM Bookings WHERE Booking_Status = 'Confirmed'),
       0) AS fb_spend_per_head;

-- Task 10: Occupancy (tickets sold / seats offered)
-- Tickets are totalled per show first to avoid inflating the seat count
-- Expected: 24.4
SELECT ROUND(100.0 * SUM(COALESCE(x.sold, 0)) / SUM(s.Available_Seats), 1) AS occupancy_pct
FROM Shows s
LEFT JOIN (
    SELECT Show_ID, SUM(Tickets) AS sold
    FROM Bookings
    WHERE Booking_Status = 'Confirmed'
    GROUP BY Show_ID
) x ON s.Show_ID = x.Show_ID;
