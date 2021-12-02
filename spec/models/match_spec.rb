require 'rails_helper'

RSpec.describe Match, type: :model do
  before do
    @match = FactoryBot.build(:match)
  end

  describe '新規記録投稿の保存' do
    context '新規保存ができる場合' do
      it 'turn_idからlogまで全て存在すれば保存できる' do
        expect(@match).to be_valid
      end
      it 'score_1が空でも保存できる' do
        @match.score_1 = ""
        expect(@match).to be_valid
      end
      it 'player_name_2が空でも保存できる' do
        @match.player_name_2 = ""
        expect(@match).to be_valid
      end
      it 'belongs_2が空でも保存できる' do
        @match.belongs_2 = ""
        expect(@match).to be_valid
      end
      it 'score_2が空でも保存できる' do
        @match.score_2 = ""
        expect(@match).to be_valid
      end
      it 'logが空でも保存できる' do
        @match.log = ""
        expect(@match).to be_valid
      end
    end

    context '新規保存ができない場合' do
      it 'turn_idが1だと保存できない' do
        @match.turn_id = 1
        @match.valid?
        expect(@match.errors.full_messages).to include("Turn can't be blank")
      end
      it 'field_idが1だと保存できない' do
        @match.field_id = 1
        @match.valid?
        expect(@match.errors.full_messages).to include("Field can't be blank")
      end
      it 'order_numberが空だと保存できない' do
        @match.order_number = ""
        @match.valid?
        expect(@match.errors.full_messages).to include("Order number can't be blank")
      end
      it 'order_numberが全角数字だと保存できない' do
        @match.order_number = "２２２"
        @match.valid?
        expect(@match.errors.full_messages).to include("Order number input only half-numbers")
      end
      it 'player_name_1が空だと保存できない' do
        @match.player_name_1 = ""
        @match.valid?
        expect(@match.errors.full_messages).to include("Player name 1 can't be blank")
      end
      it 'belons_1が空だと保存できない' do
        @match.belongs_1 = ""
        @match.valid?
        expect(@match.errors.full_messages).to include("Belongs 1 can't be blank")
      end
      it 'score_1が全角数字だと保存できない' do
        @match.score_1 = "１１１"
        @match.valid?
        expect(@match.errors.full_messages).to include("Score 1 input only half-numbers")
      end
      it 'score_1に半角数字以外の文字が記述されると保存できない' do
        @match.score_1 = "1a"
        @match.valid?
        expect(@match.errors.full_messages).to include("Score 1 input only half-numbers")
      end
      it 'score_2が全角数字だと保存できない' do
        @match.score_2 = "２２２"
        @match.valid?
        expect(@match.errors.full_messages).to include("Score 2 input only half-numbers")
      end
      it 'score_2に半角数字以外の文字が記述されると保存できない' do
        @match.score_2 = "2b"
        @match.valid?
        expect(@match.errors.full_messages).to include("Score 2 input only half-numbers")
      end
      it 'userが紐づいていないと保存できない' do
        @match.user = nil
        @match.valid?
        expect(@match.errors.full_messages).to include("User must exist")
      end
      it 'eventが紐づいていないと保存できない' do
        @match.event = nil
        @match.valid?
        expect(@match.errors.full_messages).to include("Event must exist")
      end
    end
  end
end
