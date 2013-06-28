require 'spec_helper'

describe "scores/new" do
  before(:each) do
    assign(:score, stub_model(Score,
      :game_id => 1,
      :participant_id => 1,
      :points => 1,
      :direction => "MyString"
    ).as_new_record)
  end

  it "renders new score form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", scores_path, "post" do
      assert_select "input#score_game_id[name=?]", "score[game_id]"
      assert_select "input#score_participant_id[name=?]", "score[participant_id]"
      assert_select "input#score_points[name=?]", "score[points]"
      assert_select "input#score_direction[name=?]", "score[direction]"
    end
  end
end
