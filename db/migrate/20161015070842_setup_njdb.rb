class SetupNjdb < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |u|
      u.string :name
      u.string :username
      u.string :email
      u.string :password_hash
      u.string :website
      u.string :description
    end

    create_table :projects do |p|
      p.string :name
    end


    create_table :songs do |s|
      s.integer :project_id
      s.string :name
      s.string :path
    end

    add_foreign_key :songs, :projects, column: :project_id


    create_table :clips do |c|
      c.string :path
      c.integer :user_id
      c.integer :project_id

    end
    add_foreign_key :clips, :users, column: :user_id
    add_foreign_key :clips, :projects, column: :project_id

  end
end
