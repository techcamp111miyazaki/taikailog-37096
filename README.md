# README

## userテーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| name               | string  | null: false               |
| email              | string  | null: false unique: true  |
| encrypted_password | string  | null: false               |
| admin              | boolean | default: false            |

### Association
- has_many :events
- has_many :matches
- has_many :favorites

## eventテーブル
| Column        | Type    | Options     |
| ------------- | ------- | ----------- |
| event_title   | string  | null: false |
| place         | string  | null: false |
| prefecture_id | integer | null: false |
| date          | date    | null: false |
| category_id   | integer | null: false |

### Association
- belongs_to :user
- has_many :matches

## matchテーブル
| Column        | Type    | Options     |
| ------------- | ------- | ----------- |
| turn_id       | integer | null: false |
| field_id      | integer | null: false | 
| player_name_1 | string  | null: false |
| belongs_1     | string  | null: false |
| score_1       | integer |             |
| player_name_2 | string  | null: false |
| belongs_2     | string  | null: false |
| score_2       | integer |             |
| log           | text    |             |

### Association
- belongs_to :user
- belongs_to :event
- has_many :favorites

## favoriteテーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| event  | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :match