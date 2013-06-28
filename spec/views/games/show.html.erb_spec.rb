require 'spec_helper'

describe "games/show" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :meeting_id => 1,
      :table => "Table",
      :number => 2,
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Table/)
    rendered.should match(/2/)
    rendered.should match(/Status/)
  end
end
