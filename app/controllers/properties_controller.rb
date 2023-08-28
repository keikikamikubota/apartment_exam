class PropertiesController < ApplicationController
  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
    2.times {@property.stations.build}
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
  end

  def update

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
