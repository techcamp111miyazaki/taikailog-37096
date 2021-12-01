require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event)
  end

  describe '新規大会投稿の保存' do
    context '新規保存ができる場合' do
      it 'event_title...dateまで全て存在すれば保存できる' do
        expect(@event).to be_valid
      end
      it 'imageが空でも保存できる' do
        @event.image = ""
        expect(@event).to be_valid
      end
    end
    context '新規保存ができない場合' do
      it 'event_titleが空だと保存できない' do
        @event.event_title = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Event title can't be blank")
      end
      it 'placeが空だと保存できない' do
        @event.place = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Place can't be blank")
      end
      it 'prefecture_idが1だと保存できない'do
        @event.prefecture_id = 1
        @event.valid?
        expect(@event.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'genre_idが1だと保存できない' do
        @event.genre_id = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Genre can't be blank")
      end
      it 'userに紐づいていないと保存できない' do
        @event.user = nil
        @event.valid?
        expect(@event.errors.full_messages).to include("User must exist")
      end
    end
  end
end
