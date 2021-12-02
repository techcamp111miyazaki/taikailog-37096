class Field < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '第一試合場' },
    { id: 3, name: '第二試合場' },
    { id: 4, name: '第三試合場' },
    { id: 5, name: '第四試合場' },
    { id: 6, name: '第五試合場' },
    { id: 7, name: '第六試合場' },
    { id: 8, name: '第七試合場' },
    { id: 9, name: '第八試合場' },
    { id: 10, name: '第九試合場' },
    { id: 11, name: '第十試合場' },
    { id: 12, name: '第十一試合場' },
    { id: 13, name: '第十二試合場' },
    { id: 14, name: '第十三試合場' }
  ]

  include ActiveHash::Associations
  has_many :matches
end