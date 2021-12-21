connection: "echo_actian"

# include all the views
include: "/views/**/*.view"
fiscal_month_offset: -11

datagroup: fca_vm_home_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: fca_vm_home_default_datagroup

explore: home_claims_fca{}

explore: home_complaints_fca{}

explore: home_monthly {}
