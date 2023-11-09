with source as (

    select * from {{ source('raw_data', 'salaries') }}

)

select * from stg_table