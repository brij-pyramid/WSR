-- - - - - - - - 
-- PROJECT STATE QUERY
-- - - - - - - - 

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
  LEFT JOIN ( SELECT projects.project_name,
                date_details.fulldate,
                projects_status.timeline AS previous_timeline,
                projects_status.quality AS previous_quality,
                projects_status.customer AS previous_customer,
                projects_status.resources AS previous_resources
           FROM projects_status
          INNER JOIN projects  ON projects.id = projects_status.project_id
      INNER JOIN date_details ON date_details.date_id = projects_status.date_id) AS a ON a.project_name = projects.project_name AND a.fulldate = DATE_SUB(date_details.fulldate, INTERVAL 7 DAY)
      WHERE projects.project_name = 'project name 1'
      AND date_details.fulldate = '2020-02-03';

-- - - - - - - - 
-- PROJECT MILESTONE QUERY
-- - - - - - - - 

SELECT projects.project_name,
       date_details.fulldate,
       projects_milestone.milestone, 
       projects_milestone.plan_date, 
       projects_milestone.actual_date
  FROM projects_milestone
INNER JOIN projects_status ON projects_status.id = projects_milestone.project_status_id
INNER JOIN projects  ON projects.id = projects_status.project_id
INNER JOIN date_details ON date_details.date_id = projects_status.date_id
WHERE projects.project_name = 'project name 1'
  AND date_details.fulldate = '2020-02-03'; 

-- - - - - - - - 
-- PROJECT ACTIVITY QUERY
-- - - - - - - - 

 SELECT projects.project_name,
        date_details.fulldate,
        projects_activies.activity AS current_activity,
        projects_activies.activity_status AS current_activity,
        a.next_activity,
        a.next_activity_status
  FROM projects_activies
 INNER JOIN projects  ON projects.id = projects_activies.project_id
 INNER JOIN date_details ON date_details.date_id = projects_activies.date_id
 LEFT JOIN (  SELECT projects.project_name,
                     date_details.fulldate,
                     projects_activies.activity AS next_activity,
                     projects_activies.activity_status AS next_activity_status
                FROM projects_activies
               INNER JOIN projects  ON projects.id = projects_activies.project_id
               INNER JOIN date_details ON date_details.date_id = projects_activies.date_id) AS a ON a.project_name = projects.project_name AND a.fulldate = DATE_ADD(date_details.fulldate, INTERVAL 7 DAY)
 WHERE projects.project_name = 'project name 1'
      AND date_details.fulldate = '2020-01-06';
      
-- - - - - - - - 
-- PROJECT RISKS QUERY
-- - - - - - - -       

SELECT projects.project_name,
        date_details.fulldate,
        projects_risk.risk_name,
        projects_risk.risk_severiy,
        projects_risk.risk_mitigation
   FROM projects_risk
INNER JOIN projects  ON projects.id = projects_risk.project_id
INNER JOIN date_details ON date_details.date_id = projects_risk.date_id
WHERE projects.project_name = 'project name 1'
  AND date_details.fulldate = '2020-01-06';   

-- - - - - - - - 
-- PROJECT RESOURCE COUNT QUERY
-- - - - - - - -   

 SELECT projects.project_name,
        date_details.fulldate,
        COUNT(*) tot_count , 
        a.previous_count
   FROM projects_resources
  INNER JOIN projects  ON projects.id = projects_resources.project_id
  INNER JOIN date_details ON date_details.date_id = projects_resources.date_id
  LEFT JOIN (  SELECT projects.project_name,
                      date_details.fulldate,
                      COUNT(*) previous_count  
         FROM projects_resources
                INNER JOIN projects  ON projects.id = projects_resources.project_id
                INNER JOIN date_details ON date_details.date_id = projects_resources.date_id 
        GROUP BY projects.project_name, date_details.fulldate ) AS a ON a.project_name = projects.project_name AND a.fulldate = DATE_SUB(date_details.fulldate, INTERVAL 7 DAY)
WHERE projects.project_name = 'project name 1'
--  AND date_details.fulldate = '2020-01-13'
  GROUP BY projects.project_name,
        date_details.fulldate, previous_count;

-- - - - - - - - 
-- PROJECT RESOURCE BILLABLE COUNT QUERY
-- - - - - - - -   

 SELECT projects.project_name,
        date_details.fulldate,
        COUNT(*) billable_count , 
        a.previous_billable_count
   FROM projects_resources
  INNER JOIN projects  ON projects.id = projects_resources.project_id
  INNER JOIN date_details ON date_details.date_id = projects_resources.date_id
  LEFT JOIN (  SELECT projects.project_name,
                      date_details.fulldate,
                      COUNT(*) previous_billable_count  
         FROM projects_resources
                INNER JOIN projects  ON projects.id = projects_resources.project_id
                INNER JOIN date_details ON date_details.date_id = projects_resources.date_id 
                WHERE projects_resources.user_billable = 'YES'
        GROUP BY projects.project_name, date_details.fulldate ) AS a ON a.project_name = projects.project_name AND a.fulldate = DATE_SUB(date_details.fulldate, INTERVAL 7 DAY)
WHERE projects.project_name = 'project name 1'
 AND  projects_resources.user_billable = 'YES'
--  AND date_details.fulldate = '2020-01-13'
  GROUP BY projects.project_name,
        date_details.fulldate, previous_billable_count;        