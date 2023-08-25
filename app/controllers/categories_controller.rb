class CategoriesController < ApplicationController
  before_action :category_find, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @categories = Category.all.order('created_at DESC')
  end

  def show
  end

  def new
    @user = current_user
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to  categories_path(@category), notice: 'Categorie créée!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @user = current_user
    if @category.update(category_params)
      redirect_to categories_path, :notice => "Catégorie a été mis à jour."
    else
      redirect_to categories_path, :alert => "Impossible de mettre à jour la catégorie."
    end
  end

  def destroy
    # On récupère l'id avec before_action
    # On supprime l'enregistrement avec l'id dans la BdD
    @category.destroy
    # On redirige vers la page index
    redirect_to categories_path, status: :see_other, :notice => "Catégorie supprimée!"
  end

  private

  def category_params
    params.require(:category).permit(:nom, :image)
  end

  def category_find
    @category = Category.find(params[:id])
    @user = current_user
  end
end
