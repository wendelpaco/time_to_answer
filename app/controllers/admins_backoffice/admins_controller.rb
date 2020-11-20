class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :verify_password, only: [:update, :create]
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.all.page(params[:page])
  end

  def edit
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save()
        redirect_to admins_backoffice_admins_path, notice: t("notice.admnistrator.create")
    else
        render :new
    end
  end

  def update
    if @admin.update(params_admin)
        redirect_to admins_backoffice_admins_path, notice: t("notice.admnistrator.update")
    else
        render :edit
    end
  end

  def destroy
    if @admin.destroy
        redirect_to admins_backoffice_admins_path, notice: t("notice.admnistrator.destroy")
    else
      render :index
    end
  end

private

  def verify_password
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
       params[:admin].extract!(:password, :password_confirmation)
    end
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end