# テーブル設計

## users テーブル

| Column       | Type   | Options                   |
| ------------ | ------ | ------------------------- |
| name         | string | null: false               |
| name_reading | string | null: false               |
| nickname     | string | null: false               |

### Association
- has_many :donations
 
## donations テーブル

| Column | Type         | Options                        |
| ------ | ------------ |------------------------------- |
| price  | integer      | null: false                    |
| user   | references   | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :address

## addresses テーブル

| Column        | Type          | Options                        |
| ------------- | ------------- | ------------------------------ |
| postal_code   | string        | null: false                    |
| prefecture    | string        | null: false                    |
| city          | string        | null: false                    |
| house_number  | string        | null: false                    |
| building_name | string        |                                |
| donation      | references    | null: false, foreign_key: true |

### Association
- belongs_to :purchase
- belongs_to :donation
- belongs_to_active_hash :prefecture