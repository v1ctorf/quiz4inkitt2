class AnswersController < ApplicationController
    def index
      @answers = Answer.all
    end
    
    def new
      @answered_questions = answered_questions
      
      redirect_to answers_path if answered_questions == 5
      
      @answer = Answer.new
    end
    
    def create
      @answer = Answer.new(answer_params)
      @answer.ip = request.remote_ip
      @answer.question = next_question
     
      if @answer.save
        if answered_questions < 5
          @answered_questions = answered_questions
          render 'new'
        else
          redirect_to answers_path
        end
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
   
      redirect_to answers_path
    end
    
    def next_question
      return answered_questions + 1 if answered_questions < 5
      0
    end
    
    def answered_questions
      Answer.where(["ip = ?", request.remote_ip]).length
    end
    
    private
      def answer_params
        params.require(:answer).permit(:option)
      end
end
