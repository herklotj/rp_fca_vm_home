view: home_claims_fca {
  sql_table_name: aapricing.v_home_claims_fca  ;;

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
    label: "Source"
  }

  dimension: claim_no {
    type: string
    sql: ${TABLE}.claim_no ;;
    label: "Claim Number"
  }

  dimension: uw_policy_no {
    type: string
    sql: ${TABLE}.uw_policy_no ;;
    label: "UW Policy Number"
  }

  dimension: policy_product {
    type: string
    sql: ${TABLE}.policy_product ;;
    label: "Policy Product"
  }

  dimension: policy_cover {
    type: string
    sql: ${TABLE}.policy_cover ;;
    label: "Policy Cover"
  }

  dimension_group: policy_inception_date {
    label: "Policy Inception"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.policy_inception_dttm ;;
    group_label: "Dates"
  }

  dimension_group: policy_start_date {
    label: "Policy Start"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.policy_start_dttm ;;
    group_label: "Dates"
  }

  dimension: uw_year {
    type: number
    sql: ${TABLE}.uw_year ;;
    label: "UW Year"
  }

  dimension: fuw_year {
    type: number
    sql: ${TABLE}.fuw_year ;;
    label: "FUW Year"
  }

  dimension: claim_stage {
    type: string
    sql: ${TABLE}.claim_stage ;;
    label: "Claim Stage"
  }

  dimension: claim_status {
    type: string
    sql: ${TABLE}.claim_status ;;
    label: "Claim Status"
  }

  dimension: claim_cover {
    type: string
    sql: ${TABLE}.claim_cover ;;
    label: "Claim Cover"
  }

  dimension: claim_peril {
    type: string
    sql: ${TABLE}.claim_peril ;;
    label: "Claim Peril"
  }


  dimension_group: incident_dttm {
    label: "Incident"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.incident_dttm ;;
    group_label: "Dates"
  }

  dimension_group: notification_dttm {
    label: "Notification"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.notification_dttm ;;
    group_label: "Dates"
  }

  dimension: latest_closure_reason {
    type: string
    sql: ${TABLE}.latest_closure_reason ;;
    label: "Latest Closure Reason"
  }

  dimension_group: first_closed_dttm {
    label: "First Closed"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.first_closed_dttm ;;
    group_label: "Dates"
  }

  dimension_group: latest_closed_dttm {
    label: "Latest Closed"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.latest_closed_dttm ;;
    group_label: "Dates"
  }

  dimension: reopened_flag {
    type: yesno
    sql: ${TABLE}.reopened_ind = true ;;
    label: "Reopened IND"
    group_label: "Claim Indicators"
  }

  dimension: fca_registered_claim_flag {
    type: yesno
    sql: ${TABLE}.fca_registered_claim = true ;;
    label: "FCA Registered Claim IND"
    group_label: "Claim Indicators"
  }

  dimension: fca_walkaway_flag {
    type: yesno
    sql: ${TABLE}.fca_walkaway = true ;;
    label: "FCA Walkaway IND"
    group_label: "Claim Indicators"
  }

  dimension: fca_fraud_flag {
    type: yesno
    sql: ${TABLE}.fca_fraud = true ;;
    label: "FCA Fraud IND"
    group_label: "Claim Indicators"
  }

  dimension: fca_voidance_flag {
    type: yesno
    sql: ${TABLE}.fca_voidance = true ;;
    label: "FCA Voidance IND"
    group_label: "Claim Indicators"
  }

  dimension: fca_accepted_paid_flag {
    type: yesno
    sql: ${TABLE}.fca_accepted_paid = true ;;
    label: "FCA Accepted Paid IND"
    group_label: "Claim Indicators"
  }

  dimension: fca_rejected_flag {
    type: yesno
    sql: ${TABLE}.fca_rejected = true ;;
    label: "FCA Rejected IND"
    group_label: "Claim Indicators"
  }

  dimension: fca_not_reported_flag {
    type: yesno
    sql: ${TABLE}.fca_not_reported = true ;;
    label: "FCA Not Reported IND"
    group_label: "Claim Indicators"
  }

  dimension: fca_rejected_reason {
    type: string
    sql: ${TABLE}.fca_rejected_reason ;;
    label: "FCA Rejected Reason"
  }




  measure: fca_incident_count {
    label: "Reported Incidents"
    type: sum
    sql:  cast(${TABLE}.fca_incident_ind as int) ;;
    value_format_name: decimal_0
  }

  measure: fca_registered_claim_count {
    label: "FCA Registered Claim"
    type: sum
    sql:  cast(${TABLE}.fca_registered_claim as int) ;;
    value_format_name: decimal_0
  }

  measure: fca_walkaways_count {
    label: "FCA Walkaway"
    type: sum
    sql:  cast(${TABLE}.fca_walkaway as int) ;;
    value_format_name: decimal_0
  }

  measure: fca_fraud_count {
    label: "FCA Fraud"
    type: sum
    sql:  cast(${TABLE}.fca_fraud as int) ;;
    value_format_name: decimal_0
  }

  measure: fca_voidance_count {
    label: "FCA Voidance"
    type: sum
    sql:  cast(${TABLE}.fca_voidance as int) ;;
    value_format_name: decimal_0
  }

  measure: fca_accepted_paid_count {
    label: "FCA Accepted Paid"
    type: sum
    sql:  cast(${TABLE}.fca_accepted_paid as int) ;;
    value_format_name: decimal_0
  }

  measure: fca_rejected_count {
    label: "FCA Rejected"
    type: sum
    sql:  cast(${TABLE}.fca_rejected as int) ;;
    value_format_name: decimal_0
  }

  measure: fca_not_reported_count {
    label: "FCA Not Reported"
    type: sum
    sql:  cast(${TABLE}.fca_not_reported as int) ;;
    value_format_name: decimal_0
  }














}
