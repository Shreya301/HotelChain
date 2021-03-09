class DashboardController < ApplicationController
  def index
    @hotel_wise_monthly_expenses = MonthlyExpense.all
    net_monthly_turn_over = @hotel_wise_monthly_expenses.sum("monthly_turnover")
    net_monthly_profit = @hotel_wise_monthly_expenses.sum("monthly_profit")
    avg_monthly_profit = @hotel_wise_monthly_expenses.average("monthly_profit")
    avg_monthly_turn_over = @hotel_wise_monthly_expenses.average("monthly_turnover")
    @bar_chart_data = [["Branch Name", "Turnover"],["Month Average",avg_monthly_turn_over], ["Net Monthly Turnover",net_monthly_turn_over]]
    @col_chart_data = [["Branch Name", "Profit"],["Month Average Profit",avg_monthly_profit], ["Net Monthly Profit",net_monthly_profit]]
    hotel_name_hash = Hotel.where(id: @hotel_wise_monthly_expenses.pluck(:branch_id)).pluck(:id,:branch_name).to_h
    @hotel_wise_monthly_expenses.each do |me|
      @bar_chart_data.append([hotel_name_hash[me.branch_id],me.monthly_turnover || 0])
      @col_chart_data.append([hotel_name_hash[me.branch_id],me.monthly_profit || 0])
    end


  end

end
