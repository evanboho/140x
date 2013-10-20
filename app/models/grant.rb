class Grant < ActiveRecord::Base
  belongs_to :granter, class_name: "Tweeter"
  belongs_to :grantee, class_name: "Tweeter"

  attr_accessor :grantee_screen_name
  validates_presence_of :grantee_id
  validates_presence_of :granter_id
  # validate :access_does_not_overlap

  before_validation :associate_screen_name_with_tweeter
  before_validation :set_default_date

  scope :current, -> { where("starts < ?", Time.now).where("ends > ? OR ends IS ?", Time.now, nil) }

    def associate_screen_name_with_tweeter
      return if grantee
      grantee = Tweeter.where("screen_name ilike ?", grantee_screen_name).first
      grantee ||= Tweeter.create(screen_name: grantee_screen_name)
      self.grantee = grantee
    end


  private
    def set_default_date
      self.starts ||= Time.now
    end

    def access_does_not_overlap
      grants = Grant.where(granter_id: granter_id, grantee_id: grantee_id).to_a
      ok = true
      if grants.present?
        new_starts = (grants.collect(&:starts) << self.starts).min
        new_ends = (grants.collect(&:ends) << self.ends).compact.max
        grant = grants.slice!(0)
        grant.update_attributes(starts: new_starts, ends: new_ends)
        grants.map { |g| g.destroy }
        errors.add(:starts, "You already gave access to that account.")
      end
    end

end
