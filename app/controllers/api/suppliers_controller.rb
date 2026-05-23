class Api::SuppliersController < Api::BaseController
  before_action :set_supplier, only: [:show]

  # get dodavatelia
  def index
    suppliers = Supplier
                  .joins(:expenses)
                  .merge(current_user.accessible_expenses)
                  .distinct

    render json: suppliers
  end

  # get dodavatel podla id
  def show
    render json: @supplier
  end

  private
  def set_supplier
    @supplier = Supplier
                  .joins(:expenses)
                  .merge(current_user.accessible_expenses)
                  .find(params[:id])
  end
end
