class AnswersController < ApplicationController
    def index
      @answers = Answer.all
    end
    
    def new
      redirect_to answers_path if answered_questions == 5
      @answer = Answer.new
      @question = generate_question(answered_questions)
    end
    
    def create
      @answer = Answer.new(answer_params)
      @answer.ip = request.remote_ip
      @answer.question = next_question
     
      if @answer.save
        if answered_questions < 5
          @question = generate_question(answered_questions)
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
    
    def generate_question(question)
      questions = [
        {
          'question' => 'question one?',
          'options' => [
            'answer 11',
            'answer 12',
            'answer 13',
            'answer 14'
          ]
        },{
          'question' =>'question two?',
          'options' => [
            'answer 21',
            'answer 22',
            'answer 23'
          ]
        },{
          'question' => 'question three?',
          'options' => [
            'answer 31',
            'answer 32',
            'answer 33',
            'answer 31',
            'answer 32'
          ]
        },{
          'question' => 'question four?',
          'options' => [
            'answer 41',
            'answer 42',
            'answer 43'
          ]
        },{
          'question' => 'question five?',
          'options' => [
            'answer 51',
            'answer 52',
            'answer 53'
          ]
        }
      ]
      
      return questions[question]
    end
    
    private
      def answer_params
        params.require(:answer).permit(:option)
      end
end
