class AnswersController < ApplicationController
    def index
      finished = Answer.group(:ip).having('COUNT(*) == 5').count
      @answers = Answer.where('ip IN (?)',  finished.keys)

      @distribution = []
      @questions = []
      
      for i in 0..4
         @distribution[i] = @answers.where("question == ?",i + 1).group(:option).count
         @questions[i] = generate_question(i)
      end
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
     
    def destroy
      @answer = Answer.find(params[:id])
      @answer.destroy
      redirect_to action: "list"
    end
    
    def list
      @answers = Answer.all
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
          'question' => "1) How many books did you read last year?",
          'options' => [
            'none',
            'less than 3',
            'less than 10',
            "10 books or more"
          ]
        },{
          'question' => "2) What book category do you prefere?",
          'options' => [
            'fiction',
            'non-fiction'
          ]
        },{
          'question' => "3) What's your favorite way to read a book?",
          'options' => [
            'paper book',
            'tablet or mobile phone',
            'e-reader',
            'I prefer audio books'
          ]
        },{
          'question' => "4) Usually, how do you choose a book?",
          'options' => [
            "recomendations from friends",
            'best sellers',
            'literary critics',
            "recomendations from specialized apps",
            "by myself"
          ]
        },{
          'question' => '5) How much do you usually pay for a book?',
          'options' => [
            "I don't use to pay for books",
            "less than 5 euros",
            "less than 10 euros",
            "10 euros or more"
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
