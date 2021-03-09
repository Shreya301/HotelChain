class MonthlyExpensesController < ApplicationController
  before_action :set_monthly_expense, only: %i[ show edit update destroy ]
  before_action :set_branch_choices
  before_action :set_branch_names
  # GET /monthly_expenses or /monthly_expenses.json
  def index
    @monthly_expenses = MonthlyExpense.all
  end

  # GET /monthly_expenses/1 or /monthly_expenses/1.json
  def show
  end

  # GET /monthly_expenses/new
  def new
    @monthly_expense = MonthlyExpense.new
  end

  # GET /monthly_expenses/1/edit
  def edit
  end

  # POST /monthly_expenses or /monthly_expenses.json
  def create
    @monthly_expense = MonthlyExpense.new(monthly_expense_params)

    respond_to do |format|
      if @monthly_expense.save
        format.html { redirect_to @monthly_expense, notice: "Monthly expense was successfully created." }
        format.json { render :show, status: :created, location: @monthly_expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @monthly_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monthly_expenses/1 or /monthly_expenses/1.json
  def update
    respond_to do |format|
      if @monthly_expense.update(monthly_expense_params)
        format.html { redirect_to @monthly_expense, notice: "Monthly expense was successfully updated." }
        format.json { render :show, status: :ok, location: @monthly_expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @monthly_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monthly_expenses/1 or /monthly_expenses/1.json
  def destroy
    @monthly_expense.destroy
    respond_to do |format|
      format.html { redirect_to monthly_expenses_url, notice: "Monthly expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthly_expense
      @monthly_expense = MonthlyExpense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def monthly_expense_params
      params.require(:monthly_expense).permit(:financial_month, :electricity_bill, :water_bill, :branch_id, :monthly_turnover, :monthly_profit)
    end
    def set_branch_choices
        # SELECT branch_name, id FROM `hotels`
        # pluck is a helper function that converts projection to 2d array
        @branch_choices = Hotel.pluck("branch_name, id")
    end
    def set_branch_names
      # SELECT branch_name, id FROM `hotels`
      # pluck().to_h is a helper function that converts projection to hashtable
      # with key as id
      @branch_names = Hotel.pluck("id,branch_name").to_h
    end

end
