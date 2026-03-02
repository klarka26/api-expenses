class Api::SuppliersController < Api::BaseController
  before_action :set_supplier, only: [:show]

  def index
    suppliers = Supplier
                  .joins(:expenses)
                  .where(expenses: { user_id: current_user.id })
                  .distinct

    render json: suppliers
  end

  def show
    render json: @supplier
  end


  private

  def set_supplier
    @supplier = Supplier
                  .joins(:expenses)
                  .where(expenses: { user_id: current_user.id })
                  .find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(
      :name,
      :ico,
      :dic,
      :ic_dph,
      :address
    )
  end

end
