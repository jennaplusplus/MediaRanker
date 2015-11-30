class BooksController < ApplicationController
  def index
    books = Book.all

    @books = books.order(votes: :desc) if params[:order].nil?

    @books = books.order(votes: :asc) if params[:order] == 'asc'
    @books = books.order(votes: :desc) if params[:order] == 'desc'

  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params[:book])

    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end

  end

  def show
    @book = Books.find(params[:id])
  end

  def edit
    @book = Books.find(params[:id])
  end

  def update
    @book = Books.find(params[:id])
    @book.attributes = book_params[:movie]

    if @book.save
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = Books.find(params[:id])
    book.destroy

    redirect_to books_path
  end

  def upvote
    book = Books.find(params[:id])
    book.increment!(:votes)

    redirect_to :back
  end


  private

  def book_params
    params.permit(book:[:title, :author, :description])
  end
end
