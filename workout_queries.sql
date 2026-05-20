'1' SELECT * FROM daily_workouts;

'2' SELECT * FROM daily_workouts
WHERE calories_burned > 400;

'3' SELECT * FROM daily_workouts
WHERE category = 'Strength';

'4' SELECT * FROM daily_workouts
ORDER BY duration_mins DESC;

'5' SELECT * FROM daily_workouts
ORDER BY calories_burned DESC
LIMIT 3;

'6' SELECT count(workout_id) FROM daily_workouts;

'7' SELECT sum(calories_burned) FROM daily_workouts;

'8' SELECT avg(duration_mins) FROM daily_workouts;

'9' SELECT count(category) FROM daily_workouts
WHERE category = 'Cardio';

'10' SELECT sum(calories_burned) FROM daily_workouts
WHERE category = 'Strength';

'11' SELECT avg(duration_mins) FROM daily_workouts
WHERE duration_mins < 45; 

'12' SELECT category, count(category) FROM daily_workouts
GROUP BY category;

'13' SELECT category, avg(calories_burned) FROM daily_workouts
GROUP BY category;

'14' SELECT category, avg(calories_burned) FROM daily_workouts
GROUP BY category
HAVING avg(calories_burned) > 300;

'BIG 6 PORTFOLIO CHALLENGE'
SELECT category, count(workout_id), avg(calories_burned) FROM daily_workouts
WHERE duration_mins > 30
GROUP BY category
HAVING avg(calories_burned) > 350
ORDER BY count(workout_id) DESC;

'To show specifically which 5 cardio workouts gave us the average calories burned of 484 in workout id order'
SELECT workout_id, category, calories_burned FROM daily_workouts
WHERE duration_mins > 30 AND category = 'Cardio'
ORDER BY workout_id;
