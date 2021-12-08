require 'rails_helper'

def basic_auth(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "大会投稿", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @event = FactoryBot.build(:event)
  end

  context "大会投稿ができるとき" do
    it "ログインした管理者ユーザーは新規投稿できる" do
      basic_auth root_path
      @user.admin = true
      @user.save
      sign_in(@user)
      # 作成ボタンをクリック
      click_on("New Event")
      expect(current_path).to eq(new_event_path)
      # 情報を記述
      fill_in 'event[event_title]', with: @event.event_title
      fill_in 'event[place]', with: @event.place
      select @event.prefecture.name, from: 'event[prefecture_id]'
      select @event.genre.name, from: 'event[genre_id]'
      select @event.date.year, from: 'event[date(1i)]'
      select @event.date.month, from: 'event[date(2i)]'
      select @event.date.day, from: 'event[date(3i)]'
      # Create ボタンをクリック
      expect{
        find('input[name="commit"]').click
      }.to change { Event.count }.by(1)
      expect(current_path).to eq(root_path)
      # 内容の表示があるか確認する
      expect(page).to have_content(@event.event_title)
    end
  end

  context "大会投稿できないとき" do
    it "管理者ユーザー以外は投稿できない" do
      @user.save
      sign_in(@user)
      expect(page).to have_no_content("New Event")
    end

    it "投稿内容に不備があるときは投稿できない" do
      @user.admin = true
      @user.save
      sign_in(@user)
      click_on("New Event")
      expect(current_path).to eq(new_event_path)
      fill_in 'event[event_title]', with: ""
      fill_in 'event[place]', with: ""
      select @event.prefecture.name, from: 'event[prefecture_id]'
      select @event.genre.name, from: 'event[genre_id]'
      select @event.date.year, from: 'event[date(1i)]'
      select @event.date.month, from: 'event[date(2i)]'
      select @event.date.day, from: 'event[date(3i)]'
      expect{
        find('input[name="commit"]').click
      }.not_to change { Event.count }
      expect(current_path).to eq(events_path)
    end
  end

end

RSpec.describe "大会編集", type: :system do
  before do
    @event1 = FactoryBot.create(:event)
    @event2 = FactoryBot.create(:event)
  end

  context "大会内容を編集できるとき" do
    it "投稿したユーザー自身は編集することができる" do
      sign_in(@event1.user)
      visit edit_event_path(@event1)
      expect(
        find('input[name="event[event_title]"]').value
      ).to eq(@event1.event_title)
      fill_in "event[event_title]", with: "#{@event1.event_title}+編集したevent_title"
      fill_in "event[place]", with: "#{@event1.place}+編集したplace"
      select @event1.prefecture.name, from: 'event[prefecture_id]'
      select @event1.genre.name, from: 'event[genre_id]'
      select @event1.date.year, from: 'event[date(1i)]'
      select @event1.date.month, from: 'event[date(2i)]'
      select @event1.date.day, from: 'event[date(3i)]'
      expect{
        find('input[name="commit"]').click
      }.not_to change { Event.count }
      expect(current_path).to eq(root_path)
      expect(page).to have_content("#{@event1.event_title}+編集したevent_title")
    end
  end

  context "大会内容を編集できないとき" do
    it "投稿者以外のユーザーは編集できない" do
      sign_in(@event2.user)
      expect(
        all('.btn-group')[1]
      ).to have_no_link 'Edit', href: edit_event_path(@event1)
    end
  end
end

RSpec.describe "大会削除", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @user.admin = true
    @user.save
    @another_user = FactoryBot.create(:user)
    @event1 = FactoryBot.create(:event, user_id: @user.id)
    @event2 = FactoryBot.create(:event, user_id: @user.id)
  end
  
  context "大会を削除できるとき" do
    it "投稿者と同じユーザーなら削除できる" do
      sign_in(@user)
      expect(
        all('.btn-group')[1]
      ).to have_link 'Delete', href: event_path(@event1)
      expect{
        all('.btn-group')[1].find_link('Delete', href: event_path(@event1)).click
      }.to change { Event.count }.by(-1)
      expect(page).to have_no_content("#{@event1.event_title}")
    end
  end

  context "大会を削除できないとき" do
    it "投稿者以外は削除できない" do
      sign_in(@another_user)
      expect(
        all('.btn-group')[0]
      ).to have_no_link 'Delete', href: event_path(@event2)
    end
  end
end