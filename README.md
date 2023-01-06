# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | string | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column        | Type       | Options                            |
| ------------- | ---------- | ---------------------------------- |
| name          | string     | null: false                        |
| description   | text       | null: false                        |
| category      | references | null: false, foreign_key: true     |
| item_status   | references | null: false, foreign_key: true     |
| shipping_cost | references | null: false, foreign_key: true     |
| prefecture    | references | null: false, foreign_key: true     |
| shipping_date | references | null: false, foreign_key: true     |
| price         | string     | null: false                        |

### Association

- belongs_to :user
- has_one    :order

## orders テーブル

| Column | Type       | Options                        |
| -------| ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## Addresses テーブル

| Column       | Type       | Options                            |
| ------------ | ---------- | ---------------------------------- |
| postal_cord  | string     | null: false                        |
| prefecture   | references | null: false, foreign_key: true     |
| city         | string     | null: false                        |
| block        | string     | null: false                        |
| building     | string     | null: false                        |
| phone_number | string     | null: false                        |

### Association

- has_one    :order