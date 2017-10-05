require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  subject { create(:question) }

  login_user


  describe 'Get #index' do
    subject(:question_list) { create_list(:question, 2) }

    before do
      get :index
    end
    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(question_list)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'Get #show' do
    before do
      get :show, params: { id: subject }
    end

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq subject
    end

    it 'assings the requested question to @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'Get #new' do

    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'Get #edit' do
    before { get :edit, params: { id: subject } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq subject
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: {question: attributes_for(:question)} }.
            to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assings the requested question to @question' do
        patch :update, params: { id: subject, question: attributes_for(:question) }
        expect(assigns(:question)).to eq subject
      end

      it 'changes question attributes' do
        patch :update, params: { id: subject, question: { title: 'new title', body: 'new body' } }
        subject.reload
        expect(subject.title).to eq 'new title'
        expect(subject.body).to eq 'new body'
      end

      it 'redirects to the updated question' do
        patch :update, params: { id: subject, question: attributes_for(:question) }
        expect(response).to redirect_to subject
      end
    end

    context 'invalid attributes' do
      before { patch :update, params: { id: subject, question: { title: 'new title', body: nil } } }

      it 'does not change question attributes' do
        subject.reload
        expect(subject.title).to eq 'MyString'
        expect(subject.body).to eq 'MyText'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { subject }

    it 'deletes question' do
      expect { delete :destroy, params: { id: subject } }.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: subject }
      expect(response).to redirect_to questions_path
    end
  end

end
