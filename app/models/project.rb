class Project < ApplicationRecord
  has_one :song

  after_save :init_metadata


  # todo add more default fields here
  def init_metadata
    ProjectMetadata.create(project_id: self.id)
  end

  def project_metadata
    ProjectMetadata.where(project_id: self.id).first
  end
end
