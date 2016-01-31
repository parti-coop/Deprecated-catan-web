module Chociable
  extend ActiveSupport::Concern

  included do
    extend Enumerize
    enumerize :choice, in: [:agree, :disagree], predicates: true, scope: true

    scope :agree, -> { where(choice: 'agree') }
    scope :disagree, -> { where(choice: 'disagree') }
  end
end
