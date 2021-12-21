view: home_complaints_fca {
  sql_table_name: aapricing.v_home_complaints_fca;;

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
    label: "Source"
  }

  dimension: feedback_id {
    type: string
    sql: ${TABLE}.feedback_id ;;
    label: "Feedback ID"
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

  dimension_group: claim_notification_dttm {
    label: "Claim Notification"
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
    sql: ${TABLE}.claim_notification_dttm ;;
    group_label: "Dates"
  }

  dimension: claim_peril {
    type: string
    sql: ${TABLE}.claim_peril ;;
    label: "Claim Peril"
  }

  dimension_group: created_dttm {
    label: "Complaint Created"
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
    sql: ${TABLE}.created_dttm ;;
    group_label: "Dates"
  }

  dimension_group: receipt_dttm {
    label: "Complaint Received"
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
    sql: ${TABLE}.receipt_dttm ;;
    group_label: "Dates"
  }

  dimension: feedback_level {
    type: string
    sql: ${TABLE}.feedback_level ;;
    label: "Feedback Level"
  }

  dimension: feedback_focus_name {
    type: string
    sql: ${TABLE}.feedback_focus_name ;;
    label: "Feedback Focus Name"
  }

  dimension: feedback_method {
    type: string
    sql: ${TABLE}.feedback_method ;;
    label: "Feedback Method"
  }

  dimension: root_cause {
    type: string
    sql: ${TABLE}.root_cause ;;
    label: "Root Cause"
  }

  dimension: feedback_status {
    type: string
    sql: ${TABLE}.feedback_status ;;
    label: "Feedback Status"
  }

  dimension_group: closed_dttm {
    label: "Complaint Closed"
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
    sql: ${TABLE}.closed_dttm ;;
    group_label: "Dates"
  }

  dimension: justification_status {
    type: string
    sql: ${TABLE}.justification_status ;;
    label: "Feedback Status"
  }

  dimension: feedback_ind {
    type: yesno
    sql: ${TABLE}.feedback_ind = true ;;
    label: "Feedback IND"
    group_label: "Complaint Indicators"
  }

  dimension: grumble_ind {
    type: yesno
    sql: ${TABLE}.grumble_ind = true ;;
    label: "Grumble IND"
    group_label: "Complaint Indicators"
  }

  dimension: informal_complaint_ind {
    type: yesno
    sql: ${TABLE}.informal_complaint_ind = true ;;
    label: "Informal Complaint IND"
    group_label: "Complaint Indicators"
  }

  dimension: formal_complaint_ind {
    type: yesno
    sql: ${TABLE}.formal_complaint_ind = true ;;
    label: "Formal Complaint IND"
    group_label: "Complaint Indicators"
  }

  dimension: fos_complaint_ind {
    type: yesno
    sql: ${TABLE}.fos_complaint_ind = true ;;
    label: "FOS Complaint IND"
    group_label: "Complaint Indicators"
  }

  dimension: fca_complaint_ind {
    type: yesno
    sql: ${TABLE}.fca_complaint_ind = true ;;
    label: "FCA Complaint IND"
    group_label: "Complaint Indicators"
  }



  ### Measures

  measure: feedback_count {
    label: "Feedback Count"
    type: sum
    sql:  cast(${TABLE}.feedback_ind as int) ;;
    value_format_name: decimal_0
  }

  measure: grumble_count {
    label: "Grumble Count"
    type: sum
    sql:  cast(${TABLE}.grumble_ind as int) ;;
    value_format_name: decimal_0
  }

  measure: informal_complaint_count {
    label: "Informal Complaint Count"
    type: sum
    sql:  cast(${TABLE}.informal_complaint_ind as int) ;;
    value_format_name: decimal_0
  }

  measure: formal_complaint_count {
    label: "Formal Complaint Count"
    type: sum
    sql:  cast(${TABLE}.formal_complaint_ind as int) ;;
    value_format_name: decimal_0
  }

  measure: fos_complaint_count {
    label: "FOS Complaint Count"
    type: sum
    sql:  cast(${TABLE}.fos_complaint_ind as int) ;;
    value_format_name: decimal_0
  }

  measure: fca_complaint_count {
    label: "FCA Complaint Count"
    type: sum
    sql:  cast(${TABLE}.fca_complaint_ind as int) ;;
    value_format_name: decimal_0
  }






 }
