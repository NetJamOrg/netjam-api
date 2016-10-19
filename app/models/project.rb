class Project < ApplicationRecord
  has_one :song

  belongs_to :user, foreign_key: :owner_id

  after_save :init_metadata
  after_destroy :destroy_metadata

  # todo add more default fields here
  def init_metadata
    ProjectMetadata.create(project_id: self.id)
  end

  def destroy_metadata
    ProjectMetadata.find_by(project_id: self.id).destroy
  end

  def project_metadata
    ProjectMetadata.find_by(project_id: self.id)
  end
end
