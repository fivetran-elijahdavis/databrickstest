insert into fivetran-wild-west.elijah_dbt_databricks_test.deltrack (uniqueid,deletedflag)
with a
as (
select uniqueid,deletedflag from fivetran-wild-west.elijah_dbt_databricks_test.deltrack dt
),
b as(
select CONCAT(CAST(apt._line AS string),cast(apt.account_id as string),cast(apt.connection_method as string)) AS loadeduniqueid
FROM
  fivetran-wild-west.elijah_onboarding_adoption_test.onboarding_and_adoption_tracker_account_checklist apt
),
c as(
select loadeduniqueid as newids,'New' as deletedflag from b where b.loadeduniqueid not in (select a.uniqueid from a)
),
d as(
select a.uniqueid as delids, 'Y' as deletedflag from a where a.uniqueid not in (select loadeduniqueid from b)
)
select * from c
