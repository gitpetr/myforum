require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  subject(:question) { create :question }

  context 'with valid attributes' do
    it 'saves the new answer in the database' do
      expect { post :create, params: { answer: attributes_for(:answer), question_id: question }, format: :js }.to change(question.answers, :count).by(1)
    end

    it 'render nothing' do
      post :create, params: { answer: attributes_for(:answer), question_id: question }, format: :js
      expect(response.body).to be_blank
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question }, format: :js }.to_not change(Answer, :count)
      end

      it 'render crate template' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question }, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    subject(:answer) { create(:answer, question: question) }

    it 'assings the requested answer to @answer' do
      # answer = question.answers.create(body: 'myanswer')
      patch :update, params: {id: answer, question_id: question, answer: attributes_for(:answer)}, format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns th question' do
      patch :update, params: {id: answer, question_id: question, answer: attributes_for(:answer)}, format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, params: {id: answer, question_id: question, answer: { body: 'new body'}}, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, params: {id: answer, question_id: question, answer: attributes_for(:answer)}, format: :js
      expect(response).to render_template :update
    end
  end
end
