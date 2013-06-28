require 'spec_helper'

describe "games/edit" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :meeting_id => 1,
      :table => "MyString",
      :number => 1,
      :status => "MyString"
    ))
  end

  it "renders the edit game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", game_path(@game), "post" do
      assert_select "input#game_meeting_id[name=?]", "game[meeting_id]"
      assert_select "input#game_table[name=?]", "game[table]"
      assert_select "input#game_number[name=?]", "game[number]"
      assert_select "input#game_status[name=?]", "game[status]"
    end
  end
end
