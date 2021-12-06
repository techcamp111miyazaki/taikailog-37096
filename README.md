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
| order_number  | integer | null: false |
| player_name_1 | string  | null: false |
| belongs_1     | string  | null: false |
| score_1       | integer |             |
| player_name_2 | string  |             |
| belongs_2     | string  |             |
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


### Applicationについて

| 記述すること        | 備考                                                     |
| ----------------- | :------------------------------------------------------ |
| アプリケーション名   | 大会Log  |
| アプリケーション概要 | 離れた場所であっても、いつでも大会の情報を確認できる |
| URL               | https://taikailog-37096.herokuapp.com/ |
| テスト用アカウント   | * Email: admin1@admin1.com <br> * Pass: admin1 |
| 利用方法           | 1.トップページのヘッダーにあるボタンを選択し、アカウントでログイン <br> 2.New Event ボタンを選択し大会情報を投稿する <br> 3.一覧ページから投稿した情報を選択し、試合の情報入力を行う <br> 4.投稿した試合情報は一覧からいつでも確認できる|
| アプリケーションを作成した背景 | 学生時代の部活動を通じて、遠隔での試合情報の管理が可能になることで、選手・関係者の活動をより合理化できると考えた。逐次遠隔で試合の状況を確認できることで、待ち時間を推測することやアップを計画的に行えると考えた。そこで、デザインにシンプルさを求めた上で視覚的に試合の情報が認識できるアプリケーションを作成した |
| 洗い出した要件       | [要件を記載したシート](https://docs.google.com/spreadsheets/d/1ytgqzCArqGLReePKcvN3BYLK0GxPao0kVEVU4N3Hi9c/edit#gid=982722306) |
| Gif画像            | [![Image from Gyazo](https://i.gyazo.com/3549e02cf46718d42710f5f4d10eef81.gif)](https://gyazo.com/3549e02cf46718d42710f5f4d10eef81) |
| 実施予定の機能       | 一覧表示の非同期通信、お気に入り機能 |
| データベース設計     | [![Image from Gyazo](https://i.gyazo.com/9c9d07df80170bbb0ac0eddf16008b17.png)](https://gyazo.com/9c9d07df80170bbb0ac0eddf16008b17) |
| 画面遷移図          | [![Image from Gyazo](https://i.gyazo.com/178c1d1880ef02ce71948f9a971aaae0.png)](https://gyazo.com/178c1d1880ef02ce71948f9a971aaae0) |
| 開発環境            | ＊フロントエンド：HTML5,CSS/JavaScript<br> ＊バックエンド：Ruby(2.5.1),Ruby on Rails()<br> ＊インフラ：MySQL,heroku<br> ＊テスト：RSpec<br> ＊テキストエディタ：Visual Studio Code<br> ＊タスク管理：GitHubプロジェクトボード |