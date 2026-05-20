# 🏋️‍♂️ Workout Analytics SQL Project

## 📌 Project Overview
This project focuses on executing exploratory data analysis (EDA) on a 20-row workout dataset using **SQLite**. The goal was to practice data pipeline management—transforming raw data into a structured format, importing it into a relational database, and writing structured, production-grade SQL queries using the **Big 6 logical clauses** (`SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`) to extract performance insights.

## 📊 Database Schema & Design
The raw data was cleaned using the `Trim Fields` function during ingestion to eliminate trailing spaces and ensure exact string matching. The relational schema is structured as follows:

```sql
CREATE TABLE daily_workouts (
    workout_id INT PRIMARY KEY,
    category VARCHAR(20) NOT NULL,
    duration_mins INT NOT NULL,
    calories_burned INT NOT NULL
);
```

### Raw Dataset Profile
*   **Total Samples:** 20 records
*   **Granularity:** Individual exercise session metrics
*   **Target Variables:** `duration_mins`, `calories_burned`

---

## 🔍 Core Analytical Challenges

### 1. The Production-Grade Big 6 Aggregation Query
This query analyzes category performance by calculating total tracked sessions and average calorie burn rates. It applies localized row filters (`WHERE`) before grouping, aggregates metrics using `COUNT` and `AVG`, applies a secondary group constraint (`HAVING`), and outputs an ordered result set.

```sql
SELECT 
    category AS workout_type, 
    COUNT(workout_id) AS total_sessions, 
    AVG(calories_burned) AS average_calories 
FROM daily_workouts
WHERE duration_mins > 30
GROUP BY category
HAVING AVG(calories_burned) > 350
ORDER BY COUNT(workout_id) DESC;
```

#### Query Execution Insights
*   **Filtered Output:** Only 1 category (**Cardio**) returned data.
*   **The Data Debugging Discovery:** The `Strength` category was completely filtered out by the `HAVING` clause because its localized average dropped to **342.5 calories**, falling just short of the strict `> 350` constraint.

### 2. Query Optimization & Data Validation Workflow
To verify the integrity of the aggregated findings and ensure the database engine wasn't executing redundant logic, the script was optimized by removing an unnecessary constraint (`calories_burned > 350`). 

The following validation query was run to dissect the summary group and extract the raw rows responsible for the 484-calorie average:

```sql
SELECT workout_id, category, calories_burned 
FROM daily_workouts
WHERE duration_mins > 30 AND category = 'Cardio'
ORDER BY workout_id;
```

#### Mathematical Proof
The optimization query exposed exactly 5 underlying Cardio sessions:
*   **ID 105:** 450 kcal
*   **ID 110:** 520 kcal
*   **ID 113:** 380 kcal
*   **ID 115:** 610 kcal
*   **ID 120:** 460 kcal

**Calculation:** 
(450 + 520 + 380 + 610 + 460) / 5 = **484.0 Average Calories**

