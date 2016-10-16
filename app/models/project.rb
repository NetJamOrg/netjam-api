class Project < ApplicationRecord
  has_one :song

  before_save :init_metadata


  # todo add more default fields here
  def init_metadata
    ProjectMetadata.create(project_id: self.id)
  end

  def project_metadata
    ProjectMetadata.where(project_id: self.id)
  end
end
