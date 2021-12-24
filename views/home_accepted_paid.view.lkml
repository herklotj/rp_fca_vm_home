view: home_accepted_paid {
  derived_table: {
    sql:

      select
    a.source,
    a.claim_no,
    a.uw_policy_no,
    a.policy_product,
    a.policy_cover,
    a.policy_inception_dttm,
    a.policy_start_dttm,
    a.uw_year,
    a.fuw_year,
    a.claim_stage,
    a.claim_status,
    a.claim_cover,
    a.claim_peril,
    a.incident_dttm,
    a.notification_dttm,
    a.latest_closure_reason,
    a.first_closed_dttm,
    a.latest_closed_dttm,
    a.reopened_ind,
    a.total_incurred,
    b.settledamount as fca_accepted_paid_amount,
    b.paid as payment_dttm,
    greatest(a.first_closed_dttm,
    b.paid) as fca_paid_dttm,
    date_trunc('month',
    (greatest(a.first_closed_dttm,
    b.paid))) as fca_paid_mth
  from
    aapricing.v_home_claims_fca a
  left join
    actian.sgy_reserve_line b
  on
    a.claim_no = b.claimno
  where
    a.fca_accepted_paid = true
    and a.source = 'SGY'

union all

  select
    a.source,
    a.claim_no,
    a.uw_policy_no,
    a.policy_product,
    a.policy_cover,
    a.policy_inception_dttm,
    a.policy_start_dttm,
    a.uw_year,
    a.fuw_year,
    a.claim_stage,
    a.claim_status,
    a.claim_cover,
    a.claim_peril,
    a.incident_dttm,
    a.notification_dttm,
    a.latest_closure_reason,
    a.first_closed_dttm,
    a.latest_closed_dttm,
    a.reopened_ind,
    a.total_incurred,
    b.subpaymentamount as fca_accepted_paid_amount,
    b.dateauthorised as payment_dttm,
    greatest(a.first_closed_dttm,
    b.dateauthorised) as fca_paid_dttm,
    date_trunc('month',
    (greatest(a.first_closed_dttm,
    b.dateauthorised))) as fca_paid_mth
  from
    aapricing.v_home_claims_fca a
  left join
    actian.tcs_payments_reporting b
  on
    a.claim_no = b.claimnumber
  where
    a.fca_accepted_paid = true
    and a.source = 'TCS'
;;
  }

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

  dimension_group: fca_paid_mth {
    label: "FCA Paid Month"
    type: time
    timeframes: [
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.fca_paid_mth ;;
    group_label: "Dates"
  }

  measure: fca_accepted_paid_total {
    label: "FCA Accepted Paid Amount"
    type: sum
    sql:  ${TABLE}.fca_accepted_paid_amount ;;
    value_format_name: decimal_0
  }

}
