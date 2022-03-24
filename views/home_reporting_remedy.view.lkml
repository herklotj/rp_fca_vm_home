view: home_reporting_remedy {
  derived_table: {
    sql:


    select
    cy.policy_number as policy_number,
    cy.transaction_id as transaction_id,
    cy.transaction_no as transaction_no,
    cy.policy_cover,
    case
      when cy.policy_start_date < '2017-08-01' then 1
      when cy.policy_start_date < '2018-08-01' then 2
      when cy.policy_start_date < '2019-08-01' then 3
      when cy.policy_start_date < '2020-08-01' then 4
      when cy.policy_start_date < '2021-08-01' then 5
      when cy.policy_start_date < '2022-08-01' then 6
      when cy.policy_start_date < '2023-08-01' then 7
      when cy.policy_start_date < '2024-08-01' then 8
      when cy.policy_start_date < '2025-08-01' then 9
      when cy.policy_start_date < '2026-08-01' then 10
      when cy.policy_start_date < '2027-08-01' then 11
      when cy.policy_start_date < '2028-08-01' then 12
      when cy.policy_start_date < '2029-08-01' then 13
      else 0
    end as uw_year,
    case
      when cy.policy_start_date< '2017-02-01' then 2017
      when cy.policy_start_date< '2018-02-01' then 2018
      when cy.policy_start_date< '2019-02-01' then 2019
      when cy.policy_start_date< '2020-02-01' then 2020
      when cy.policy_start_date< '2021-02-01' then 2021
      when cy.policy_start_date< '2022-02-01' then 2022
      when cy.policy_start_date< '2023-02-01' then 2023
      when cy.policy_start_date< '2024-02-01' then 2024
      when cy.policy_start_date< '2025-02-01' then 2025
      when cy.policy_start_date< '2026-02-01' then 2026
      when cy.policy_start_date< '2027-02-01' then 2027
      when cy.policy_start_date< '2028-02-01' then 2028
      when cy.policy_start_date< '2029-02-01' then 2029
      else 0
    end as fuw_year,
    case
      when cy.policy_start_date<= '2017-06-30' then 'XoL Period 1'
      when cy.policy_start_date<= '2018-06-30' then 'XoL Period 2'
      when cy.policy_start_date<= '2018-12-31' then 'XoL Period 3'
      when cy.policy_start_date<= '2019-12-31' then 'XoL Period 4'
      when cy.policy_start_date<= '2020-12-31' then 'XoL Period 5'
      when cy.policy_start_date<= '2021-12-31' then 'XoL Period 6'
      when cy.policy_start_date<= '2022-12-31' then 'XoL Period 7'
      else 'Unknown'
    end as xol_period,
    cy.policy_status as policy_transaction_type,
    cast(cy.policy_inception_date as timestamp without time zone) as policy_inception_date,
    cast(cy.policy_start_date as timestamp without time zone) as policy_start_date,
    cy.effective_start_date as exposure_start,
    cy.effective_end_date as exposure_end,
    1 as sale,
    case when cy.policy_status in ('R')
          then 1
          else 0
      end
    as renewed,
    cy.calc_premium_net as net_premium_annualized,
    py.calc_premium_net as net_premium_annualized_py,
    cy.calc_premium_gross as gross_premium_annualized,
    py.calc_premium_gross as gross_premium_annualized_py,
    cy.effective_start_date as transaction_start_date,
    cy.effective_end_date as transaction_end_date,
    case
      when cy.aauicl_tenure > 10 then 10
      else cy.aauicl_tenure
    end as aauicl_tenure,
    case
      when cy.calc_premium_gross is not null and cy.calc_premium_gross != 0
        then bc.bc
        else 0
    end as predicted_bc_ia_annualized,
    case
      when bc.bc is not null and bc.bc !=0 and cy.calc_premium_gross is not null and cy.calc_premium_gross != 0 then bc.bc / cy.calc_premium_gross
      when (bc.bc is null or bc.bc =0) and cy.calc_premium_gross is not null and cy.calc_premium_gross != 0 then 0.64 * cy.calc_premium_net / cy.calc_premium_gross
      when (bc.bc is null or bc.bc =0) and (cy.calc_premium_gross is null or cy.calc_premium_gross = 0) then 0.64
      else 0
    end as expected_gross_loss_ratio,
    case when bc.bc is not null and bc.bc !=0 and cy.calc_premium_net is not null and cy.calc_premium_net != 0
      then bc.bc / cy.calc_premium_net
      else 0.64
    end as expected_net_loss_ratio,
    case when bc.bc is not null and bc.bc !=0 and cy.calc_premium_gross is not null and cy.calc_premium_gross != 0
      then 1
      else 0
    end as in_expected_gross_loss_ratio,
    case
      when bc.bc is null or bc.bc =0 then 'Default LR: No BC'
      when cy.calc_premium_gross is null or cy.calc_premium_gross = 0 then 'Default LR: No Gross Prem'
      else 'Ok'
    end as in_expected_gross_loss_ratio_reason
  from  (
    select
    policy_number,
    transaction_id,
    transaction_no,
    policy_status,
    policy_inception_date,
    policy_start_date,
    policy_end_date,
    effective_start_date,
    effective_end_date,
    timestampdiff(YEAR,policy_inception_date,policy_start_date) as aauicl_tenure,
    case
      when lead(policy_start_date) over(partition by policy_number order by transaction_no) = lead(effective_start_date) over(partition by policy_number order by transaction_no) and lead(policy_status) over(partition by policy_number order by transaction_no) in ('X','Z') then 1
      when policy_start_date = effective_start_date and policy_status in ('X','Z') then 1
      else 0
    end as same_day_canx,

    case when section_code_1 = 1 and section_code_4 = 4 then 'JOINT'
        when section_code_1 = 1 and section_code_4 != 4 then 'CONTENTS ONLY'
        when section_code_1 != 1 and section_code_4 = 4 then 'BUILDINGS ONLY'
        else 'JOINT'
    end as policy_cover,

    case when commission_rate_1 > commission_rate_4
      then commission_rate_1
      else commission_rate_4
    end as commission_rate,

    case when commission_rate_1 > commission_rate_4
      then commission_rate_1/(1-commission_rate_1)
      else commission_rate_4/(1-commission_rate_4)
    end as commission_load,

    case when commission_rate_1 > commission_rate_4
      then round(transaction_premium_gross/((1+ipt_rate)*(1+commission_rate_1/(1-commission_rate_1))),0.01)
      else round(transaction_premium_gross/((1+ipt_rate)*(1+commission_rate_4/(1-commission_rate_4))),0.01)
    end as calc_premium_net,

    case when commission_rate_1 > commission_rate_4
      then round((transaction_premium_gross/(1+ipt_rate))-(transaction_premium_gross/((1+ipt_rate)*(1+commission_rate_1/(1-commission_rate_1)))),0.01 )
      else round((transaction_premium_gross/(1+ipt_rate))-(transaction_premium_gross/((1+ipt_rate)*(1+commission_rate_4/(1-commission_rate_4)))),0.01 )
    end as calc_commission,

    round(transaction_premium_gross/(1+ipt_rate),0.01) as calc_premium_gross
    from actian.home_cover) as cy

    left join (
      select
        policy_number,
        policy_status,
        timestampdiff(YEAR,policy_inception_date,policy_start_date) as aauicl_tenure,
        case
          when lead(policy_start_date) over(partition by policy_number order by transaction_no) = lead(effective_start_date) over(partition by policy_number order by transaction_no) and lead(policy_status) over(partition by policy_number order by transaction_no) in ('X','Z') then 1
          when policy_start_date = effective_start_date and policy_status in ('X','Z') then 1
          else 0
        end as same_day_canx,

    case when commission_rate_1 > commission_rate_4
      then round(transaction_premium_gross/((1+ipt_rate)*(1+commission_rate_1/(1-commission_rate_1))),0.01)
      else round(transaction_premium_gross/((1+ipt_rate)*(1+commission_rate_4/(1-commission_rate_4))),0.01)
    end as calc_premium_net,

        round(transaction_premium_gross/(1+ipt_rate),0.01) as calc_premium_gross
        from actian.home_cover) as py

    on py.same_day_canx = 0
    and py.policy_status in ('N','R')
    and cy.policy_number = py.policy_number
    and cy.aauicl_tenure = py.aauicl_tenure + 1

    left join (
      select
      policy_number,
      transaction_id,
      coalesce(pbs_1_eow,0) + coalesce(pbs_1_fire,0) + coalesce(pbs_1_theft,0) + coalesce(pbs_1_storm,0) + coalesce(pbs_1_flood,0) + coalesce(pbs_1_other,0)
        + coalesce(pbs_2_ad,0)
        + coalesce(pbs_3_pps,0)
        + coalesce(pbs_3a_pps,0)
        + coalesce(pbs_4_eow,0) + coalesce(pbs_4_fire,0) + coalesce(pbs_4_theft,0) + coalesce(pbs_4_storm,0) + coalesce(pbs_4_flood,0) + coalesce(pbs_4_subs,0) + coalesce(pbs_4_other,0) + coalesce(pbs_4_ad,0)
      as bc
    from actian.home_pbs) as bc
    on cy.policy_number = bc.policy_number
    and cy.transaction_id = bc.transaction_id

  where cy.same_day_canx = 0
  and cy.policy_status in ('N','R')
    ;;}

      dimension: policy_number {
        type: string
        sql: ${TABLE}.policy_number ;;
        label: "UW Policy Number"
      }

      dimension: policy_cover {
        type: string
        sql: ${TABLE}.policy_cover ;;
        label: "Policy Cover"
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

      dimension: xol_period {
        type: string
        sql: ${TABLE}.xol_period ;;
        label: "XoL Period"
      }

  dimension: in_expected_gross_loss_ratio_reason {
    type: string
    sql: ${TABLE}.in_expected_gross_loss_ratio_reason ;;
    label: "Included in Expected Loss Ratio"
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
        sql: ${TABLE}.policy_inception_date ;;
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
        sql: ${TABLE}.policy_start_date ;;
        group_label: "Dates"
      }

      dimension: policy_start_h1_flag {
        type: yesno
        sql:month(${TABLE}.policy_start_date) in (1,2,3,4,5,6) ;;
        label: "Policy Start H1 IND"
      }

      dimension: aauicl_tenure {
        type: number
        sql: ${TABLE}.aauicl_tenure ;;
        label: "AAUICL Tenure"
      }

      dimension: policy_transaction_type {
        type: string
        sql: ${TABLE}.policy_transaction_type ;;
        label: "Transaction Type"
      }

      dimension: expected_gross_loss_ratio {
        type: tier
        style: relational
        tiers: [0.10,0.20,0.30,0.40,0.50,0.60,0.70,0.80]
        sql: ${TABLE}.expected_gross_loss_ratio;;
        value_format: "0#%"
        label: "Expected Gross Loss Ratio"
      }

  dimension: expected_net_loss_ratio {
    type: tier
    style: relational
    tiers: [0.10,0.20,0.30,0.40,0.50,0.60,0.70,0.80]
    sql: ${TABLE}.expected_net_loss_ratio;;
    value_format: "0#%"
    label: "Expected Net Loss Ratio"
  }

      dimension: in_expected_gross_loss_ratio {
        type: yesno
        sql: ${TABLE}.in_expected_gross_loss_ratio = 1 ;;
        label: "Include in Expected Gross Loss Ratio"
      }

      measure: gross_premium_annualized_py {
        label: "AAUICL Annualized Gross Premium Prior Year"
        type: sum
        sql:  ${TABLE}.gross_premium_annualized_py ;;
        value_format_name: decimal_0
      }

      measure: net_premium_annualized_py {
        label: "AAUICL Annualized Net Premium Prior Year"
        type: sum
        sql:  ${TABLE}.net_premium_annualized_py ;;
        value_format_name: decimal_0
      }

      measure: net_premium_annualized {
        label: "AAUICL Annualized Net Premium"
        type: sum
        sql:  ${TABLE}.net_premium_annualized ;;
        value_format_name: decimal_0
      }

      measure: gross_premium_annualized {
        label: "AAUICL Annualized Gross Premium"
        type: sum
        sql:  ${TABLE}.gross_premium_annualized ;;
        value_format_name: decimal_0
      }

      measure: predicted_bc_ia_annualized {
        label: "Expected Claims Annualized"
        type: sum
        sql:  ${TABLE}.predicted_bc_ia_annualized;;
        value_format_name: decimal_0
      }

      measure: sale {
        label: "Sale"
        type: sum
        sql:  ${TABLE}.sale ;;
        value_format_name: decimal_0
      }

      measure: renewed {
        label: "Renewed"
        type: sum
        sql:  ${TABLE}.renewed ;;
        value_format_name: decimal_0
      }
    }
