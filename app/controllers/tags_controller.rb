class TagsController < AuthenticatedController
  def index
    @tags = current_user.tags
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user = current_user
    @tag.save!
    redirect_to tags_path, notice: 'Folder created. Great job.'
  end

  def edit
    @tag = current_user.tags.find(params[:id])
  end

  def update
    @tag = current_user.tags.find(params[:id])
    @tag.update!(tag_params)
    redirect_to tags_path, notice: 'Folder updated. Great job.'
  end

  def destroy
    @tag = current_user.tags.find(params[:id])
    @tag.destroy
    redirect_to tags_path, notice: 'Folder destroyed. Great job.'
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
