 SELECT projects.project_name,
        date_details.fulldate,
        CASE 
			WHEN a.previous_timeline = 1 THEN 'On Track'
			WHEN a.previous_timeline = 2 THEN 'Low'
			WHEN a.previous_timeline = 3 THEN 'Medium'
			WHEN a.previous_timeline = 4 THEN 'High'
			WHEN a.previous_timeline = 5 THEN 'On Hold'
		END previous_timeline,
        CASE 
			WHEN a.previous_quality = 1 THEN 'On Track'
			WHEN a.previous_quality = 2 THEN 'Low'
			WHEN a.previous_quality = 3 THEN 'Medium'
			WHEN a.previous_quality = 4 THEN 'High'
			WHEN a.previous_quality = 5 THEN 'On Hold'
		END previous_quality,
        CASE 
			WHEN a.previous_customer = 1 THEN 'On Track'
			WHEN a.previous_customer = 2 THEN 'Low'
			WHEN a.previous_customer = 3 THEN 'Medium'
			WHEN a.previous_customer = 4 THEN 'High'
			WHEN a.previous_customer = 5 THEN 'On Hold'
		END previous_customer,
        CASE 
			WHEN a.previous_resources = 1 THEN 'On Track'
			WHEN a.previous_resources = 2 THEN 'Low'
			WHEN a.previous_resources = 3 THEN 'Medium'
			WHEN a.previous_resources = 4 THEN 'High'
			WHEN a.previous_resources = 5 THEN 'On Hold'
		END previous_resources,
        CASE 
			WHEN projects_status.timeline = 1 THEN 'On Track'
            WHEN projects_status.timeline = 2 THEN 'Low'
            WHEN projects_status.timeline = 3 THEN 'Medium'
            WHEN projects_status.timeline = 4 THEN 'High'
            WHEN projects_status.timeline = 5 THEN 'On Hold'
        END current_timeline,
		CASE 
			WHEN projects_status.quality = 1 THEN 'On Track'
            WHEN projects_status.quality = 2 THEN 'Low'
            WHEN projects_status.quality = 3 THEN 'Medium'
            WHEN projects_status.quality = 4 THEN 'High'
            WHEN projects_status.quality = 5 THEN 'On Hold'
        END current_quality,
        CASE 
			WHEN projects_status.customer = 1 THEN 'On Track'
            WHEN projects_status.customer = 2 THEN 'Low'
            WHEN projects_status.customer = 3 THEN 'Medium'
            WHEN projects_status.customer = 4 THEN 'High'
            WHEN projects_status.customer = 5 THEN 'On Hold'
        END current_customer,
        CASE 
			WHEN projects_status.resources = 1 THEN 'On Track'
            WHEN projects_status.resources = 2 THEN 'Low'
            WHEN projects_status.resources = 3 THEN 'Medium'
            WHEN projects_status.resources = 4 THEN 'High'
            WHEN projects_status.resources = 5 THEN 'On Hold'
        END current_resources 
   FROM projects_status
  INNER JOIN projects  ON projects.id = projects_status.project_id
  INNER JOIN date_details ON date_details.date_id = projects_status.date_id
  left JOIN ( SELECT projects.project_name,
                date_details.fulldate,
                projects_status.timeline as previous_timeline,
                projects_status.quality as previous_quality,
                projects_status.customer as previous_customer,
                projects_status.resources as previous_resources
           FROM projects_status
          INNER JOIN projects  ON projects.id = projects_status.project_id
		  INNER JOIN date_details ON date_details.date_id = projects_status.date_id) as a on a.project_name = projects.project_name
          AND a.fulldate = DATE_SUB(date_details.fulldate, INTERVAL 7 DAY)
      WHERE projects.project_name = 'project name 1' 