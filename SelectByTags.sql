SELECT g.Id, g.Name, g.LocLa, g.LocLo, g.Details, g.URL, g.AddressID, g.Image
    FROM GYM g
    JOIN GYMACTIVITY ga ON ga.GymID = g.Id
    JOIN ACTIVITY a ON a.Id = ga.ActivityID
	JOIN ADDRESS ad ON ad.Id = g.AddressID
   WHERE a.Name IN ('Bodybuilding','Swimming')
   AND g.Name LIKE '%%' 
   AND (ad.City LIKE '%Kristianstad%' OR ad.Street LIKE '%%'OR ad.PostalCode LIKE '%%')
GROUP BY g.Id, g.Name, g.LocLa, g.LocLo, g.Details, g.URL, g.AddressID, g.Image
  HAVING COUNT(DISTINCT a.Name) = 1