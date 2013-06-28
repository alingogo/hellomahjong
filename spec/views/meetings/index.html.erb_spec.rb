require 'spec_helper'

describe "meetings/index" do
  before(:each) do
    assign(:meetings, [
      stub_model(Meeting,
        :passwd => "Passwd",
        :title => "Title",
        :description => "Description",
        :creator => "Creator"
      ),
      stub_model(Meeting,
        :passwd => "Passwd",
        :title => "Title",
        :description => "Description",
        :creator => "Creator"
      )
    ])
  end

  it "renders a list of meetings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Passwd".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Creator".to_s, :count => 2
  end
end
