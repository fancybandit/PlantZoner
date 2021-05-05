require_relative '../../lib/slug'

class User < ApplicationRecord
    has_many :gardens, foreign_key: "owner_id"
    has_many :plants, through: :gardens
    has_many :growing_zones, through: :gardens

    has_secure_password
    validates :password, presence: true, length: {minimum: 6, too_short: "Passwords must be at least %{count} characters long"}

    validates :username, presence: :true, uniqueness: true, format: {with: /\A[a-zA-Z0-9\_]+\z/}, exclusion: {in: ["admin", "superadmin", "user"]}
    validates :email, presence: :true, uniqueness: :true, format: {with: /\A(?<username>[^@\s]+)@((?<domain_name>[-a-z0-9]+)\.(?<domain>[a-z]{2,}))\z/i}
    validates :slug, presence: true

    scope :most_gardens, -> {where("")}

    include Slug
    extend Slug
end