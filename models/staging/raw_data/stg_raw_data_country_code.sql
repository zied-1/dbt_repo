with source as (

    select * from {{ source('raw_data', 'COUNTRY_ISO_CODE') }}

),

stg_table as (

    select
     COUNTRY_NAME as company_location
     ISO_CODE_ALPHA
    from source

)

select * from stg_table