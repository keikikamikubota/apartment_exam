class PropertiesController < ApplicationController
  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
    2.times {@property.stations.build} #newではなくbuildにするとアソシエーションと認識されやすいとのアドバイスから変更
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to properties_path, notice: "物件が登録できました"
    else
      render :new, notice: "登録に失敗しました"
    end
  end

  def show
    @property = Property.find(params[:id])
  end

  def edit
    @property = Property.find(params[:id])
    1.times {@property.stations.build}
  end

  def update
    @property = Property.find(params[:id])
    @property.stations.destroy_all #一度過去の最寄り駅を全て削除することで、重複を回避した
    if @property.update(property_params)
      redirect_to properties_path, notice: "更新が完了しました"
    else
      render :edit
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to properties_path, notice: "物件が削除されました"
  end

  private

  def property_params
    params.require(:property).permit(:name, :value, :address, :age, :note,
      stations_attributes: [:train_line, :station_name, :walking_time, :destroy])
  end
end
