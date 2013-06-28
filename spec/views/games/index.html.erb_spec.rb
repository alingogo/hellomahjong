require 'spec_helper'

describe "games/index" do
  before(:each) do
    assign(:games, [
      stub_model(Game,
        :meeting_id => 1,
        :table => "Table",
        :number => 2,
        :status => "Status"
      ),
      stub_model(Game,
        :meeting_id => 1,
        :table => "Table",
        :number => 2,
        :status => "Status"
      )
    ])
  end

  it "renders a list of games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Table".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
