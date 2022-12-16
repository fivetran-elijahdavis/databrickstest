SELECT
   apt._line AS linenumber,
   apt._fivetran_synced AS _fivetran_synced,
   CONCAT(CAST(apt._line AS string),cast(apt.account_id as string),cast(apt.connection_method as string)) AS uniqueid,
   CONCAT(CAST(apt._line AS string),cast(apt._fivetran_synced as string)) AS ftkey 
FROM
  fivetran-wild-west.elijah_onboarding_adoption_test.onboarding_and_adoption_tracker_account_checklist apt
WHERE
  CONCAT(CAST(apt._line AS string),cast(apt.account_id as string),cast(apt.connection_method as string))
     NOT IN (select dt.uniqueid from fivetran-wild-west.elijah_onboarding_adoption_test.data_transform_sheet_1 dt)
