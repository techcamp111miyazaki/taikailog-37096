class Turn < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '第一回戦' },
    { id: 3, name: '第二回戦' },
    { id: 4, name: '第三回戦' },
    { id: 5, name: '第四回戦' },
    { id: 6, name: '第五回戦' },
    { id: 7, name: '第六回戦' },
    { id: 8, name: '第七回戦' },
    { id: 9, name: '第八回戦' },
    { id: 10, name: '第九回戦' },
    { id: 11, name: '第十回戦' },
    { id: 12, name: '準々決勝' },
    { id: 13, name: '準決勝' },
    { id: 14, name: '決勝' }
  ]

  include ActiveHash::Associations
  has_many :matches
end