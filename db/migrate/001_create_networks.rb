class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string    :ip_address
      t.string    :mask
      t.string    :description
      t.timestamp :last_scan
      t.integer   :project_id
      t.integer   :author_id
    end
  end
end
