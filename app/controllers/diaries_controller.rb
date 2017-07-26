class DiariesController < ApplicationController

  def index
    @diaries = Diary.all
  end

  def show
    @page = Diary.find(params[:id])
  end

end
