require 'spec_helper'

describe "scores/index" do
  before(:each) do
    assign(:scores, [
      stub_model(Score,
        :game_id => 1,
        :participant_id => 2,
        :points => 3,
        :direction => "Direction"
      ),
      stub_model(Score,
        :game_id => 1,
        :participant_id => 2,
        :points => 3,
        :direction => "Direction"
      )
    ])
  end

  it "renders a list of scores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Direction".to_s, :count => 2
  end
end
