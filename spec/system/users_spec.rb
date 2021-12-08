require 'rails_helper'

def basic_auth(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      basic_auth root_path
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[name]', with: @user.name
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[name]', with: "test"
      fill_in 'user[email]', with: "test"
      fill_in 'user[password]', with: "test"
      fill_in 'user[password_confirmation]', with: "test"
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(new_user_registration_path)
    end
  end
end


RSpec.describe "ユーザーログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context "ログインができるとき" do
    it 'ログインに成功し、TopPageに遷移する' do
      basic_auth root_path
      visit new_user_session_path
      expect(current_path).to eq(new_user_session_path)
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_on('Log in')
      expect(current_path).to eq(root_path)
    end
  end

  context "ログインができないとき" do
    it 'ログインに失敗し、再びログインページに戻ってくる' do
      visit new_user_session_path
      fill_in 'user[email]', with: "test"
      fill_in 'user[password]', with: "test"
      click_on('Log in')
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
