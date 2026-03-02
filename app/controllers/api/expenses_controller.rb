class Api::ExpensesController < Api::BaseController
  before_action :set_expense, only: [:show, :update, :destroy]

  # list of expenses
  def index
    expenses = current_user.expenses.includes(:supplier).order(document_date: :desc)
    render json: expenses.as_json(
      only: [:id, :document_date, :total_price],
      include: {
        supplier: {
          only: [:id, :name]
        }
      }
    )
  end

  # detail
  def show
    render json: @expense.as_json(
      include: {
        supplier: {},
        #expenses_items: {}
      }
    )
  end

  # new expense
  def create
    supplier = Supplier.find_or_create(supplier_params)

    expense = current_user.expenses.new(expense_params)
    expense.supplier = supplier

    if expense.save
      render json: expense, status: :created
    else
      render json: {errors: expense.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # edit
  def update
    if @expense.update(expense_params)
      render json: @expense, status: :ok
    else
      render json: {errors: @expense.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    head :no_content
  end


  private

  def set_expense
    @expense = current_user.expenses.includes(:supplier).find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(
      :supplier_id,
      :document_date,
      :tax_base,
      :vat_rate,
      :vat_amount,
      :total_price,
      :uid,
      :kp,
      :okp,
      :receipt_number
    )
  end

  def supplier_params
    params.require(:expense)
          .require(:supplier)
          .permit(
            :name,
            :ico,
            :dic,
            :ic_dph,
            :address
          )
  end
end
