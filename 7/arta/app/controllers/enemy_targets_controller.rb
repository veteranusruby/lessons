class EnemyTargetsController < ApplicationController
  def index
    @enemy_targets = EnemyTarget.all
  end
end
