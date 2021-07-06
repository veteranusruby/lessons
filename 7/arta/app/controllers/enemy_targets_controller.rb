class EnemyTargetsController < ApplicationController
  def index
    @enemy_targets = EnemyTarget.all
  end

  def show
    @enemy_target = EnemyTarget.find(params[:id])
  end

  def new
    @enemy_target = EnemyTarget.new
  end

  def create
    @enemy_target = EnemyTarget.new(
      name: params[:enemy_target][:name],
      distance: params[:enemy_target][:distance],
      max_radius: params[:enemy_target][:max_radius],
    )

    if @enemy_target.save
      redirect_to 'http://intellectchain.com'
    else
      render :new
    end
  end
end
