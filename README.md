# テーブル設計

## users テーブル

| Column           | Type   | Option      |
| ------------     | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| first_name       | string | null: false |
| family_name      | string | null: false |
| first_name_kana  | string | null: false |
| family_name_kana | string | null: false |
| birthday         | date   | null: false |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column       | Type       | Options                        |
| -----------  | ---------  | ------------------------------ |
| name         | string     | null: false                    |
| description  | text       | null: false                    |
| category_id  | integer    | null: false                    |
| condition_id | integer    | null: false                    |
| price        | integer    | null: false                    |
| postage_id   | integer    | null: false                    |
| region_id    | integer    | null: false                    |
| shipping_id  | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## address テーブル

| Column         | Type       | Options                        |
| -------------  | ---------- | ------------------------------ |
| zip_code       | string     | null: false                    |
| prefectures_id | integer    | null: false                    |
| city           | string     | null: false                    |
| street_number  | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

### Association

- belongs_to :order



