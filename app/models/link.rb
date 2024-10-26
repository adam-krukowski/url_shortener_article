class Link < ApplicationRecord
  validates :url, presence: true, format: URI::regexp(%w[http https])
  validates :slug, uniqueness: true, length: { within: 3..255 }
  validates :url, length: { within: 3..255 }

  before_validation :generate_slug

  def generate_slug
    self.slug = SecureRandom.uuid[0..5] if slug.blank?
  end

  def short
    Rails.application.routes.url_helpers.short_url(slug: slug)
  end

  def self.shorten(url, slug = '')
    link = find_by(url: url, slug: slug) || new(url: url, slug: slug)
    return link.short if link.save

    shorten(url, slug + SecureRandom.uuid[0..2])
  end
end
