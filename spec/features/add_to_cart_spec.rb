require 'rails_helper'

RSpec.feature "Visitor adds item to cart", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel2.jpg'),
        quantity: 10,
        price: 64.99
        )
    end
  end

  scenario "cart counter changes to 1" do
    # ACT
    visit root_path
    save_screenshot 'home_page_before_add.png'
    first(:button, "Add").click
    # DEBUG /
    expect(page).to have_text 'My Cart (1)'
    save_screenshot 'home_page_after_add.png'

  end

end 