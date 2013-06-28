require 'spec_helper'

describe "scores/show" do
  before(:each) do
    @score = assign(:score, stub_model(Score,
      :game_id => 1,
      :participant_id => 2,
      :points => 3,
      :direction => "Direction"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Direction/)
  end
end
