class AnswersController < ApplicationController
    def index
      @answers = Answer.all
    end
    
    def new
      @article = Answer.new
    end
    
    def create
      @answer = Answer.new(answer_params)
      @answer.ip = request.remote_ip
     
      if @answer.save
        redirect_to answers_path
      else
        render 'index'
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
   
      redirect_to answers_path
    end
    
    private
      def answer_params
        params.require(:answer).permit(:question, :option)
      end
      
end
