require 'rails_helper'

def basic_auth(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "試合記録投稿", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @user.admin = true
    @user.save
    @event = FactoryBot.create(:event, user_id: @user.id)
    @match = FactoryBot.build(:match)
  end

  context "試合記録の投稿ができる場合" do
    it "大会を投稿した管理者ユーザーは試合記録を投稿することができる" do
      basic_auth root_path
      sign_in(@user)
      expect(page).to have_content(@event.event_title)
      visit event_matches_path(@event)
      # 作成ボタンをクリック
      click_on("New Match")
      expect(current_path).to eq(new_event_match_path(@event.id))
      # 情報を記述
      select @match.turn.name, from: 'match[turn_id]'
      select @match.field.name, from: 'match[field_id]'
      fill_in 'match[order_number]', with: @match.order_number
      fill_in 'match[player_name_1]', with: @match.player_name_1
      fill_in 'match[belongs_1]', with: @match.belongs_1
      fill_in 'match[score_1]', with: @match.score_1
      fill_in 'match[player_name_2]', with: @match.player_name_2
      fill_in 'match[belongs_2]', with: @match.belongs_2
      fill_in 'match[score_2]', with: @match.score_2
      fill_in 'match[log]', with: @match.log
      # Create ボタンをクリック
      expect{
        find('input[name="commit"]').click
      }.to change { Match.count }.by(1)
      expect(current_path).to eq(event_matches_path(@event.id))
      # 内容の表示があるか確認する
      expect(page).to have_content(@match.player_name_1)
    end
  end

  context "試合記録の投稿ができない場合" do
    it "該当しないユーザーは試合記録を投稿できない" do
      another_user = FactoryBot.create(:user)
      sign_in(another_user)
      expect(page).to have_content(@event.event_title)
      visit event_matches_path(@event)
      expect(page).to have_no_content("New Match")
    end
    it "投稿内容に不備があると投稿できない" do
      sign_in(@user)
      expect(page).to have_content(@event.event_title)
      visit event_matches_path(@event)
      # 作成ボタンをクリック
      click_on("New Match")
      expect(current_path).to eq(new_event_match_path(@event.id))
      # 情報を記述
      select @match.turn.name, from: 'match[turn_id]'
      select @match.field.name, from: 'match[field_id]'
      fill_in 'match[order_number]', with: ""
      fill_in 'match[player_name_1]', with: ""
      fill_in 'match[belongs_1]', with: ""
      fill_in 'match[score_1]', with: ""
      fill_in 'match[player_name_2]', with: ""
      fill_in 'match[belongs_2]', with: ""
      fill_in 'match[score_2]', with: ""
      fill_in 'match[log]', with: ""
      # Create ボタンをクリック
      expect{
        find('input[name="commit"]').click
      }.not_to change { Match.count }
      expect(current_path).to eq(event_matches_path(@event.id))
    end
  end

end

RSpec.describe "試合記録編集", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @user.admin = true
    @user.save
    @event = FactoryBot.create(:event, user_id: @user.id)
    @match = FactoryBot.create(:match, event_id: @event.id, user_id: @user.id)
  end

  context "大会内容を編集できるとき" do
    it "投稿したユーザー自身は編集することができる" do
      sign_in(@user)
      expect(page).to have_content(@event.event_title)
      visit event_matches_path(@event)
      expect(page).to have_content(@match.player_name_1)
      visit edit_event_match_path(@event.id, @match)
      sleep 0.1
      expect(
        find('input[name="match[player_name_1]"]').value
      ).to eq(@match.player_name_1)
      select @match.turn.name, from: 'match[turn_id]'
      select @match.field.name, from: 'match[field_id]'
      fill_in 'match[order_number]', with: @match.order_number + 1
      fill_in 'match[player_name_1]', with: "#{@match.player_name_1}+編集"
      fill_in 'match[belongs_1]', with: "#{@match.belongs_1}+編集"
      fill_in 'match[score_1]', with: @match.score_1 + 1
      fill_in 'match[player_name_2]', with: "#{@match.player_name_2}+編集"
      fill_in 'match[belongs_2]', with: "#{@match.belongs_2}+編集"
      fill_in 'match[score_2]', with: @match.score_2 + 2
      fill_in 'match[log]', with: "#{@match.log}+編集"
      expect{
        find('input[name="commit"]').click
      }.not_to change { Match.count }
      expect(current_path).to eq(event_matches_path(@event.id))
      expect(page).to have_content("#{@match.player_name_1}+編集")
    end
  end

  context "大会内容を編集できないとき" do
    it "投稿者以外のユーザーは編集できない" do
      another_user = FactoryBot.create(:user)
      sign_in(another_user)
      expect(
        all('.btn-group')[0]
      ).to have_no_link 'Edit', href: edit_event_match_path(@event.id, @match)
    end
  end
end

RSpec.describe "試合記録削除", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @user.admin = true
    @user.save
    @another_user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user_id: @user.id)
    @match1 = FactoryBot.create(:match, event_id: @event.id, user_id: @user.id)
    @match2 = FactoryBot.create(:match, event_id: @event.id, user_id: @user.id)
  end

  context "試合記録の削除ができるとき" do
    it "投稿者と同一のユーザーなら削除できる" do
      sign_in(@user)
      expect(page).to have_content(@event.event_title)
      visit event_matches_path(@event)
      expect(page).to have_content(@match1.player_name_1)
      expect(
        all('.btn-group')[0]
      ).to have_link 'Delete', href: event_match_path(@event.id, @match1)
      expect{
        all('.btn-group')[0].find_link('Delete', href: event_match_path(@event.id, @match1)).click
      }.to change { Match.count }.by(-1)
      expect(page).to have_no_content("#{@match1.player_name_1}")
    end
  end

  context "試合記録の削除ができないとき" do
    it "投稿者以外は削除できない" do
      sign_in(@another_user)
      expect(page).to have_content(@event.event_title)
      visit event_matches_path(@event)
      expect(
        all('.btn-group')[0]
      ).to have_no_link 'Delete', href: event_path(@event.id, @match2)
    end
  end
end
