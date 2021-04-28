module Slug
    def slug
        self.username.gsub(/[^0-9A-Za-z ]/, '').downcase.split(' ').join('-')
    end

    def find_by_slug(slug)
        self.all.detect do |obj|
            obj.slug == slug
        end
    end
end