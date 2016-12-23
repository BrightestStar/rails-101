class GroupRelationship < ApplicationRecord
  belong_to :group
  belong_to :user
end
