SELECT ailmentName, COUNT(ailmentName) total 
FROM(SELECT assigned.appointmentID, patientHasA.patientID, patientHasA.ailmentName FROM patientHasA
	NATURAL JOIN assigned) AS t
group by ailmentName
order by total desc
limit 1
