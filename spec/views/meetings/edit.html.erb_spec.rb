require 'spec_helper'

describe "meetings/edit" do
  before(:each) do
    @meeting = assign(:meeting, stub_model(Meeting,
      :passwd => "MyString",
      :title => "MyString",
      :description => "MyString",
      :creator => "MyString"
    ))
  end

  it "renders the edit meeting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", meeting_path(@meeting), "post" do
      assert_select "input#meeting_passwd[name=?]", "meeting[passwd]"
      assert_select "input#meeting_title[name=?]", "meeting[title]"
      assert_select "input#meeting_description[name=?]", "meeting[description]"
      assert_select "input#meeting_creator[name=?]", "meeting[creator]"
    end
  end
end
