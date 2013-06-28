require 'spec_helper'

describe "meetings/show" do
  before(:each) do
    @meeting = assign(:meeting, stub_model(Meeting,
      :passwd => "Passwd",
      :title => "Title",
      :description => "Description",
      :creator => "Creator"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Passwd/)
    rendered.should match(/Title/)
    rendered.should match(/Description/)
    rendered.should match(/Creator/)
  end
end
