class AnswersController < ApplicationController
    def index
      @answers = Answer.all
    end
    
    def new
      @article = Answer.new
    end
    
    def create
      @answer = Answer.new(answer_params)
     
      if @answer.save
        redirect_to @answer
      else
        render 'new'
      end
      
    end
     
    def show
        @answer = Answer.find(params[:id])
    end
    
    def edit
      @answer = Answer.find(params[:id])
    end
    
    def update
      @answer = Answer.find(params[:id])
   
      if @answer.update(answer_params)
        redirect_to @answer
      else
        render 'edit'
      end
    end
    
    def destroy
      @answer = Answer.find(params[:id])
      @answer.destroy
   
      redirect_to articles_path
    end
    
    private
      def answer_params
        params.require(:answer).permit(:ip, :question, :option)
      end
    
end
