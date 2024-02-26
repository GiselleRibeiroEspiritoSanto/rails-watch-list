class BookmarksController < ApplicationController
  before_action :set_list, only: %i[new create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list), notice: "O bookmark foi criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    list = bookmark.list
    bookmark.destroy
    redirect_to list_path(list), notice: "O bookmark foi excluído com sucesso."
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end