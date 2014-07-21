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

    click_link "Edit Tree"

    fill_in "Name", with: "The Really Great Banyan"
    fill_in "Species", with: "Banyana"
    fill_in "Country", with: "Indiana"
    fill_in "Image", with: "http://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Acharya_Jagadish_Chandra_Bose_Indian_Botanic_Garden_-_Howrah_2011-01-08_9728.JPG/800px-Acharya_Jagadish_Chandra_Bose_Indian_Botanic_Garden_-_Howrah_2011-01-08_9728.JPG"

    click_button "Update Tree"

    expect(page).to have_content "Tree updated"

    expect(page).to have_content "The Really Great Banyan"
    expect(page).to have_content "Banyana"
    expect(page).to have_content "Indiana"
    expect(page).to have_css "img[src='http://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Acharya_Jagadish_Chandra_Bose_Indian_Botanic_Garden_-_Howrah_2011-01-08_9728.JPG/800px-Acharya_Jagadish_Chandra_Bose_Indian_Botanic_Garden_-_Howrah_2011-01-08_9728.JPG']"
  end
end
