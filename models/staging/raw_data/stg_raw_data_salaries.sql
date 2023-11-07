with source as (

    select * from {{ source('raw_data', 'salaries') }}

),

stg_table as (

    select
    *
    from source

)

select * from stg_table