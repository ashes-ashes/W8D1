class PostsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :edit, :update]

  def new 
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end

  end

  def show
    @post = Post.find_by(id: params[:id])
    @all_comments = @post.comments.includes(:author)
    @toplevel = @all_comments.select { |comment| comment.parent_comment_id == nil }
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
  end

  def edit 
    @post = Post.find_by(id: params[:id])
    if @post.author_id == current_user.id
      render :edit
    else
      flash.now[:errors] = ["You can't edit someone else's post!"]
      render :show
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.author_id != current_user.id
      flash.now[:errors] = ["You can't edit someone else's post!"]
      render :show
    elsif @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end

  end

  def destroy
    @post = Post.find_by(id: params[:id])

    if @post.author_id != current_user.id
      flash.now[:errors] = ["You can't destroy someone else's post!"]
      render :show
    elsif @post.destroy
      redirect_to subs_url(Sub.find_by(id: @post.sub_id))
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_url(@post)
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end
