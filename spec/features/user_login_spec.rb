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

    @user = User.create!({first_name: "Tom", last_name: "Cabbage", email:"tomcabbage@gmail.com", password: "carrotsucks", password_confirmation: "carrotsucks"})
  end



  scenario "They see product details" do
    # ACT
    visit root_path
    first(:link, "Login").click
    expect(page).to have_button 'Login'
    save_screenshot 'login_page_rendered.png'
    # DEBUG /
    fill_in 'email', with: 'tomcabbage@gmail.com'
    fill_in 'password', with: 'carrotsucks'
    save_screenshot 'login_page_rendered_filled_in.png'
    click_button 'Login'
    expect(page).to have_css 'article.product', count: 10
    expect(page).to have_text 'Tom'
    expect(page).to have_text 'Logout'
    save_screenshot 'login_redirect_home.png'
  end

end 