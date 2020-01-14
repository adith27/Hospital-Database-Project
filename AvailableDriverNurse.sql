SELECT nurseIsA.employeeID, t.appointmentID, t.ddate, t.ttime FROM nurseIsA
    LEFT JOIN (SELECT attends.employeeID, attends.appointmentID, attends.ddate, attends.ttime FROM attends WHERE ddate = '2019-04-01'
    AND ttime = '13:30:00') AS t
    ON nurseIsA.employeeID = t.employeeID
	WHERE license = "EVOC"
