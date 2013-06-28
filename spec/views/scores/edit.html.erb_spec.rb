require 'spec_helper'

describe "scores/edit" do
  before(:each) do
    @score = assign(:score, stub_model(Score,
      :game_id => 1,
      :participant_id => 1,
      :points => 1,
      :direction => "MyString"
    ))
  end

  it "renders the edit score form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", score_path(@score), "post" do
      assert_select "input#score_game_id[name=?]", "score[game_id]"
      assert_select "input#score_participant_id[name=?]", "score[participant_id]"
      assert_select "input#score_points[name=?]", "score[points]"
      assert_select "input#score_direction[name=?]", "score[direction]"
    end
  end
end
