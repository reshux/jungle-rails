require 'rails_helper'

RSpec.feature "Visitor navigates from home page to product detail page", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel3.jpg'),
        quantity: 10,
        price: 64.99
        )
    end
  end

  scenario "They see product details" do
    # ACT
    visit root_path
    first(:link, "Details").click
    save_screenshot 'home_page.png'
    # DEBUG /
    expect(page).to have_css 'article.product-detail', count: 1
    save_screenshot 'product_detail.png'

  end

end 