class DashboardController < ApplicationController
  def index
    # SELECT `monthly_expenses`.*
    # FROM `monthly_expenses`
    # WHERE
    #   (month(financial_month)=month(now()) and
    #    year(financial_month)=year(now()))
    @hotel_wise_monthly_expenses = MonthlyExpense.where("month(financial_month)=month(now()) and year(financial_month)=year(now())")
    net_monthly_turn_over = @hotel_wise_monthly_expenses.sum("monthly_turnover")
    total_water_bill = @hotel_wise_monthly_expenses.sum("water_bill")
    total_electricity_bill = @hotel_wise_monthly_expenses.sum("electricity_bill")
    net_monthly_profit = @hotel_wise_monthly_expenses.sum("monthly_profit")
    avg_monthly_profit = @hotel_wise_monthly_expenses.average("monthly_profit")
    avg_monthly_turn_over = @hotel_wise_monthly_expenses.average("monthly_turnover")
    # SELECT `guests`.*
    # FROM `guests`
    # WHERE
    #   (check_in >= now() and
    #   check_in <= DATE_ADD(now(), INTERVAL 10 DAY));
    @upcoming_checkin = Guest.where("check_in >= now() and check_in <= DATE_ADD(now(), INTERVAL 10 DAY)")
    @pie_chart_data = [["Resource", "Bill"],["Water",total_water_bill], ["Electricity",total_electricity_bill]]
    @bar_chart_data = [["Branch Name", "Turnover"],["Month Average",avg_monthly_turn_over], ["Net Monthly Turnover",net_monthly_turn_over]]
    @col_chart_data = [["Branch Name", "Profit"],["Month Average Profit",avg_monthly_profit], ["Net Monthly Profit",net_monthly_profit]]
    @hotel_name_hash = Hotel.all.pluck(:id,:branch_name).to_h
    @hotel_wise_monthly_expenses.each do |me|
      @bar_chart_data.append([@hotel_name_hash[me.branch_id],me.monthly_turnover || 0])
      @col_chart_data.append([@hotel_name_hash[me.branch_id],me.monthly_profit || 0])
    end


  end

end
