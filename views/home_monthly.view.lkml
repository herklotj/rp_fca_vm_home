view: home_monthly {
  sql_table_name: aapricing.home_monthly;;

  dimension: policy_number {
    type: string
    sql: ${TABLE}.policy_number ;;
    label: "UW Policy Number"
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transaction_id ;;
    label: "TIA Transaction No"
  }

  dimension: transaction_no {
    type: string
    sql: ${TABLE}.transaction_no ;;
    label: "Transaction Number"
  }

  dimension: policy_uw {
    type: string
    sql: ${TABLE}.policy_uw ;;
    label: "Policy UW"
  }

  dimension: policy_status {
    type: string
    sql: ${TABLE}.policy_status ;;
    label: "Policy Status"
  }

  dimension_group: exposure_mth {
    label: "Exposure Month"
    type: time
    timeframes: [
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: cast(${TABLE}.exposure_mth as TIMESTAMP without TIME zone) ;;
    group_label: "Dates"
  }


  measure: aauicl_ifp {
    label: "AAUICL IFP"
    type: sum
    sql:  ${TABLE}.aauicl_ifp ;;
    value_format_name: decimal_0
  }

}
