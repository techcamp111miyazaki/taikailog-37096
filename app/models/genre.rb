class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '陸上競技' },
    { id: 3, name: '水泳競技' }, 
    { id: 4, name: '体操' }, 
    { id: 5, name: '球技' }, 
    { id: 6, name: '格闘技' }, 
    { id: 7, name: '武道' }, 
    { id: 8, name: '自転車' }, 
    { id: 9, name: '射的スポーツ' }, 
    { id: 10, name: 'スキー' }, 
    { id: 11, name: 'スノーボード' }, 
    { id: 12, name: 'スケート' }, 
    { id: 13, name: 'スカイスポーツ' }, 
    { id: 14, name: '山岳スポーツ' }, 
    { id: 15, name: '混合スポーツ' },  
    { id: 16, name: 'その他スポーツ' }
  ]

  include ActiveHash::Associations
  has_many :events
end