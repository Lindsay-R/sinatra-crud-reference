feature "Trees CRUD" do
  scenario "A user can create, update and delete a tree" do
    visit "/"

    click_link "New Tree"

    fill_in "Name", with: "The Great Banyan"
    fill_in "Species", with: "Banyan"
    fill_in "Country", with: "India"
    fill_in "Image", with: "http://en.wikipedia.org/wiki/List_of_trees#mediaviewer/File:Great_banyan_tree_kol.jpg"

    click_button "Create Tree"

    expect(page).to have_content "Tree created"

    expect(page).to have_content "The Great Banyan"
    expect(page).to have_content "India"
    expect(page).to have_css "img[src='http://en.wikipedia.org/wiki/List_of_trees#mediaviewer/File:Great_banyan_tree_kol.jpg']"
  end
end
