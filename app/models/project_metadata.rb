# this class is not an activerecord, it refers to a mongo object
# interop with activerecord is a little tricky, we gotta be careful..

class ProjectMetadata
  include Mongoid::Document

  field :name
  field :project_id, type: Integer
  field :table, type: Hash, default: {}
  field :tracks, type: Array, default: []
  field :clips, type: Array, default: []

  # this ensures project_id is unique and present
  validates :project_id, uniqueness: true
  validates :project_id, presence: true

  def project
    Project.where(id: self.project_id).first
  end

end
