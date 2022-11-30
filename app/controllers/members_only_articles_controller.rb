class MembersOnlyArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    documents = Document.all
    render json: documents
  end

  def show
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    document = Document.find(params[:id])
    render json: document
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

end
