class RenameTypeToCategory < ActiveRecord::Migration
	def change
		rename_column :linestudies, :type, :category
	end
end
