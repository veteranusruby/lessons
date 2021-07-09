class GunsController < ApplicationController
  def index
    @guns = Gun.all
  end

  def show
    @gun = Gun.find(params[:id])
  end

  def new
    @gun = Gun.new
  end

  def create
    @gun = Gun.new(gun_params)

    if @gun.save
      redirect_to @gun
    else
      render :new
    end
  end

  def edit
    @gun = Gun.find(params[:id])
  end

  def update
    @gun = Gun.find(params[:id])

    if @gun.update(gun_params)
      redirect_to @gun
    else
      render :edit
    end
  end

  def destroy
    @gun = Gun.find(params[:id])
    @gun.destroy

    redirect_to @gun
  end

  private
    def gun_params
      params.require(:gun).permit(:name, :start_speed, :min_angle, :max_angle, :bullet_count)
    end
end
