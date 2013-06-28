require 'spec_helper'

describe "games/new" do
  before(:each) do
    assign(:game, stub_model(Game,
      :meeting_id => 1,
      :table => "MyString",
      :number => 1,
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", games_path, "post" do
      assert_select "input#game_meeting_id[name=?]", "game[meeting_id]"
      assert_select "input#game_table[name=?]", "game[table]"
      assert_select "input#game_number[name=?]", "game[number]"
      assert_select "input#game_status[name=?]", "game[status]"
    end
  end
end
