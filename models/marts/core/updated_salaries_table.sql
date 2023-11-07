WITH salaries AS (
    SELECT * FROM {{ ref("stg_raw_data_salaries") }}
),
iso_code AS (
    SELECT * FROM {{ ref('stg_raw_data_country_code') }}
),
final AS (
    SELECT
        WORK_YEAR,
        CASE
            WHEN EXPERIENCE_LEVEL = 'EN' THEN 'Entry-level / Junior'
            WHEN EXPERIENCE_LEVEL = 'MI' THEN 'Mid-level / Intermediate'
            WHEN EXPERIENCE_LEVEL = 'SE' THEN 'Senior-level / Expert'
            ELSE 'Executive-level / Director'
        END AS EXPERIENCE_LEVEL_DESCR,
        CASE
            WHEN EMPLOYMENT_TYPE = 'PT' THEN 'Part-time'
            WHEN EMPLOYMENT_TYPE = 'FT' THEN 'Full-time'
            WHEN EMPLOYMENT_TYPE = 'CT' THEN 'Contract'
            ELSE 'Freelance'
        END AS EMPLOYMENT_TYPE_DESCR,
        JOB_TITLE,
        SALARY,
        SALARY_CURRENCY,
        SALARY_IN_USD,
        CASE
            WHEN REMOTE_RATIO = 0 THEN 'No remote work (less than 20%)'
            WHEN REMOTE_RATIO = 50 THEN 'Partially remote/hybrid'
            ELSE 'Fully remote (more than 80%)'
        END AS REMOTE_RATIO_DESCR,
        CASE
            WHEN COMPANY_SIZE = 'S' THEN 'less than 50 employees (small)'
            WHEN COMPANY_SIZE = 'M' THEN '50 to 250 employees (medium)'
            ELSE 'more than 250 employees (large)'
        END AS COMPANY_SIZE_DESCR,
        i.company_location
    FROM salaries as s,iso_code as i
    where  s.company_location = i.ISO_CODE_ALPHA
)

SELECT * FROM final
