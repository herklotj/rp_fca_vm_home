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

  dimension: policy_cover {
    type: string
    sql: ${TABLE}.policy_cover ;;
    label: "Policy Cover"
  }

  dimension: exposure_h1_flag {
    type: yesno
    sql:month(cast(${TABLE}.exposure_mth as TIMESTAMP without TIME zone)) in (1,2,3,4,5,6) ;;
    label: "Exposure H1 IND"
    group_label: "Exposure Indicators"
  }

  dimension: exposure_june_flag {
    type: yesno
    sql:month(cast(${TABLE}.exposure_mth as TIMESTAMP without TIME zone)) in (6) ;;
    label: "Exposure June IND"
    group_label: "Exposure Indicators"
  }

  dimension: exposure_dec_flag {
    type: yesno
    sql:month(cast(${TABLE}.exposure_mth as TIMESTAMP without TIME zone)) in (12) ;;
    label: "Exposure Dec IND"
    group_label: "Exposure Indicators"
  }

  dimension: aauicl_tenure {
    type: number
    sql: ${TABLE}.uw_tenure - 1 ;;
    label: "AAUICL Tenure"
  }

  measure: aauicl_ifp {
    label: "AAUICL IFP"
    type: sum
    sql:  ${TABLE}.aauicl_ifp ;;
    value_format_name: decimal_0
  }

}
