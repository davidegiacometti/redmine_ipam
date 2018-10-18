class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string    :ip_address
      t.string    :hostname
      t.string    :description
      t.timestamp :last_scan
      t.integer   :status
      t.integer   :network_id
      t.integer   :project_id
      t.integer   :author_id
    end
  end
end
