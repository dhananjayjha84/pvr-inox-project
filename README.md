# 🎬 PVR INOX Business Performance Dashboard (SQL + Tableau)

An end-to-end business intelligence project that analyses cinema bookings and food sales to show where revenue comes from and how performance compares to FY26 benchmarks.

🔗 **Live dashboard:** [Tabluea Public Link](https://public.tableau.com/views/PVRINOXBusinessPerformnceFY26/PVRINOXDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

![Dashboard preview](PVR%20INOX%20DASHBOARD.png)

---

## 📌 Project Overview
This project analyses **285K bookings** and **232K food orders** for a multi-city cinema chain (FY26). I used **SQL** to compute the core business metrics and **Tableau** to build a one-page, interactive dashboard with cross-filtering.

> **Data note:** the transaction-level data is synthetic. The FY26 benchmarks (ATP, F&B spend per head, occupancy) are real PVR INOX figures and are used for comparison.

## ❓ Business Questions
1. How much revenue do tickets, food and convenience fees generate?
2. Which states, genres and booking channels drive the most revenue?
3. How full are the screens (occupancy), and how does it compare to the FY26 benchmark?
4. What share of bookings is cancelled?
5. Which food items sell the most, and how does spend per head compare to the benchmark?

## 🛠️ Tools & Skills
| Area | Details |
|---|---|
| SQL | Joins, CASE, subqueries, window functions (`RANK`, `SUM() OVER`) |
| Tableau Public | Relationships, calculated fields, filled map, donut chart, dashboard actions |
| Data modelling | Bookings related to Shows, Movies, Theatres and Food Sales |
| Excel | Source dataset |

## 🗂️ Dataset
[PVR_INOX_PowerBI_Project_Dataset.xlsx](PVR_INOX_PowerBI_Project_Dataset.xlsx)

| Sheet | Contents |
|---|---|
| Bookings | One row per booking: status, channel, tickets, gross amount, convenience fee |
| Shows | Show date, time, format, available seats |
| Movies | Movie name, genre, language |
| Theatres | Theatre name, city, state |
| Food_Sales | Food orders by item |
| FY26_Benchmarks | Real FY26 reference values |

**Rule used:** revenue metrics count only bookings with `Booking_Status = 'Confirmed'`.

## 🧮 SQL Analysis
All queries are in [`PVR_INOX_SQL_Analysis.sql`](PVR_INOX_SQL_Analysis.sql). They cover:
- Headline KPIs (tickets, revenue, ATP)
- Cancellation rate
- Monthly revenue trend
- Revenue by state and by genre
- Booking-channel share (window function)
- Food sales by item and spend per head
- Occupancy (tickets sold ÷ seats offered)

## 📊 Dashboard Features
- 6 KPI cards with FY26 benchmarks
- Monthly revenue trend
- India map of revenue by state
- Booking-channel donut
- Revenue by genre and food sales by item
- Illustrative seat-map visual of screen occupancy
- Cross-filtering: click any chart, including the monthly trend, to filter the whole dashboard
- Dropdown filters for quarter and booking channel

## 🔍 Key Insights
| Metric | Result | FY26 benchmark |
|---|---|---|
| Total revenue | ₹21.5 Cr | n/a |
| Tickets sold | 570,652 | n/a |
| Average ticket price | ₹241 | ₹280 |
| F&B spend per head | ₹126 | ₹147 |
| Occupancy | 24.4% | 26.2% |
| Cancellation rate | 6.1% | n/a |

- **App** drives 62% of ticket revenue, followed by Website (23%) and Counter (15%).
- **Horror** is the top genre (₹24.5M) and **Action** the lowest (₹11.5M).
- **Maharashtra** is the top state (₹27.5M), well ahead of Tamil Nadu and Karnataka.
- **Combo Meal** is the best-selling food item (₹17.2M).
- **February** is the weakest month (about ₹10.4M).
- ATP, occupancy and F&B spend per head all sit below the FY26 benchmarks.

## 💡 Recommendations
1. Promote combos and larger popcorn sizes to lift F&B spend per head toward the benchmark.
2. Push app-exclusive offers, since it is the main booking channel.
3. Investigate the causes of the 6.1% cancellations and test reminders or flexible rebooking.

## ▶️ How to Use
1. Open the [live dashboard](https://public.tableau.com/views/PVRINOXBusinessPerformnceFY26/PVRINOXDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) and click any chart to filter the rest.
2. To rerun the SQL, load the Excel sheets into SQLite or MySQL, using the sheet names as table names, then run [`PVR_INOX_SQL_Analysis.sql`](PVR_INOX_SQL_Analysis.sql).

## 📁 Repository Structure
```
├── README.md
├── PVR_INOX_SQL_Analysis.sql
├── PVR_INOX_PowerBI_Project_Dataset.xlsx
└── dashboard_preview.png
```

## 👤 Author
**Dhananjay Jha**
🔗 [LinkedIn](https://www.linkedin.com/in/dhananjay-jha-43085a241) | 📊 [Tableau Public](https://public.tableau.com/app/profile/dhananjay.jha8576)

*This is an independent portfolio project and is not affiliated with PVR INOX.*
