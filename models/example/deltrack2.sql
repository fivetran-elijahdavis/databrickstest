    SELECT
    dt.linenumber,
   dt._fivetran_synced,
   dt.uniqueid,
   case when dt.uniqueid
    not in (select
              CONCAT(CAST(apt._line AS string),cast(apt.account_id as string),cast(apt.connection_method as string ))
            from  fivetran-wild-west.elijah_onboarding_adoption_test.onboarding_and_adoption_tracker_account_checklist apt)
            then 'Y' else 'N'
            end as deletedflag
   ,
   dt.ftkey
FROM
fivetran-wild-west.elijah_dbt_databricks_test.deltrack dt
