module Slug
    def slugify
        self.username.gsub(/[^0-9A-Za-z ]/, '').downcase.split(' ').join('-')
    end

    def find_by_slug(slug)
        self.find_by(slug: slug)
    end
end