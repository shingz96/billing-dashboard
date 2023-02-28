# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def ransackable_attributes(auth_object = nil)
      if allow_full_ransack_access?(auth_object)
        authorizable_ransackable_attributes
      else
        super
      end
    end

    def ransackable_associations(auth_object = nil)
      if allow_full_ransack_access?(auth_object)
        authorizable_ransackable_associations
      else
        super
      end
    end

    def allow_full_ransack_access?(auth_object)
      true # temporary allow now
    end
  end
end
