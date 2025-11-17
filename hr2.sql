

-- self join
SELECT e.employee_id "사원ID"
      ,e.first_name || '-' || e.last_name "사원이름"
      ,ee.employee_id "MANAGE ID"
      ,ee.first_name || '-' || ee.last_name "MANAGER이름"
FROM employees e
LEFT OUTER JOIN employees ee ON e.manager_id = ee.employee_id 
ORDER BY 1;