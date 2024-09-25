class Public::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    @word = params[:word]
    @items = Item.where("name LIKE?","%#{@word}%").page(params[:page]).per(8)
  end

  def genre_search
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: params[:id]).page(params[:page]).per(8)
  end
end
