require 'net/http'
require 'json'
require_relative '../../services/bysquare_service'

class Api::ExpensesController < Api::BaseController
  before_action :set_expense, only: [:show, :update, :destroy]

  # GET vydavky
  def index
    expenses = current_user.accessible_expenses
                           .includes(:supplier, :user, :expense_items)
                           .order(document_date: :desc)

    render json: expenses.as_json(
      only: [
        :id,
        :document_date,
        :total_price,
        :receipt_number
      ],

      include: {
        supplier: {
          only: [:id, :name]
        },

        user: {
          only: [
            :id,
            :email,
            :first_name,
            :last_name
          ]
        },

        expense_items: {
          only: [:description]
        }
      }
    )
  end

  # GET vydavok podla id
  def show
    render json: @expense.as_json(
      include: {
        supplier: {},
        expense_items: {},

        user: {
          only: [
            :email,
            :first_name,
            :last_name
          ]
        }
      }
    )
  end

  # POST novy vydavok
  def create
    supplier = Supplier.find_or_create(supplier_params)
    expense = current_user.expenses.new(expense_params.except(:supplier))
    expense.supplier = supplier

    if expense.save
      render json: expense, status: :created
    else
      render json: {errors: expense.errors.full_messages},
             status: :unprocessable_entity
    end
  end

  # PUT uprava vydavku
  def update
    @expense.expense_items.destroy_all

    supplier = Supplier.find_or_create(supplier_params)
    @expense.supplier = supplier

    if @expense.update(expense_items_params)
      render json: @expense
    else
      render json: {errors: @expense.errors.full_messages},
             status: :unprocessable_entity
    end
  end

  # DESTROY zmazanie vydavku
  def destroy
    @expense.destroy
    head :no_content
  end

  # QR ekasa
  def receipt
    uid = params[:uid]
    url = URI("https://ekasa.financnasprava.sk/mdu/api/v1/opd/receipt/find")

    response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new(url.path)
      request["Content-Type"] = "application/json"
      request.body = { receiptId: uid }.to_json
      http.request(request)
    end

    render json: JSON.parse(response.body)
  end

  # QR bysquare
  def decode_bysquare
    result = BysquareService.decode(params[:payload])
    render json: result
  end

  private

  def set_expense
    @expense = current_user.accessible_expenses
                           .includes(:supplier, :expense_items, :user)
                           .find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(
      :document_date,
      :tax_base,
      :vat_rate,
      :vat_amount,
      :total_price,
      :uid,
      :kp,
      :okp,
      :receipt_number,

      supplier: [
        :name,
        :ico,
        :dic,
        :ic_dph,
        :address
      ],

      expense_items_attributes: [
        :description,
        :quantity,
        :unit_price,
        :total_price
      ]
    )
  end

  def supplier_params
    expense_params[:supplier] || {}
  end

  def expense_items_params
    expense_params.except(:supplier)
  end
end