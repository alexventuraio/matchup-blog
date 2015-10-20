class Article < ActiveRecord::Base
    include AASM

    belongs_to :user
    has_many :comments
    has_many :has_categories, dependent: :destroy # 'dependent' para que se eliminen en cascada los registros en has_categories
    has_many :categories, through: :has_categories

    validates :title, presence: true, uniqueness: true
    validates :body, presence: true, length: { minimum: 20}
    before_create :set_visits_count
    # before_save :method
    # before_validation :method
    after_create :save_categories
    # after_create :send_mail
    # after_save :method
    # after_save :method on: :create

    has_attached_file :cover, styles: { medium: "1280x720", thumb: "800x600" }
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

    # Metodo de clase para filtrar los articulos publicados
    # Podemos utilizar cualquiera de las dos formas
    scope :publicados, -> { where(state: "published") }
    # def self.publicados
    #     Article.where(state:"published")
    # end
    scope :ultimos, -> { order("created_at DESC") }


    # Custom Setter
    def categories=(value)
        @categories = value
    end

    def update_visits_count
        self.update(visits_count: self.visits_count + 1)
    end

    aasm column: "state" do
        state :in_draft, initial: true
        state :published

        event :publish do
            transitions from: :in_draft, to: :published
        end

        event :unpublish do
            transitions from: :published, to: :in_draft
        end
    end

    private

    def set_visits_count
        self.visits_count = 0
    end

    def save_categories
        unless @categories.nil?
            @categories.each do |category_id|
                HasCategory.create(category_id: category_id, article_id: self.id)
            end
        end
    end

    def send_mail
         ArticleMailer.new_article(self).deliver_later
    end
end
