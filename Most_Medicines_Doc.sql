SELECT primaryPhysician, SUM(quantity) total FROM
(SELECT Patient.primaryPhysician, Patient.patientID, billed.medID, Medicine.quantity FROM Patient
	NATURAL JOIN billed
    NATURAL JOIN Medicine) AS t
group by primaryPhysician
limit 1
