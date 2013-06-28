require 'spec_helper'

describe "meetings/new" do
  before(:each) do
    assign(:meeting, stub_model(Meeting,
      :passwd => "MyString",
      :title => "MyString",
      :description => "MyString",
      :creator => "MyString"
    ).as_new_record)
  end

  it "renders new meeting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", meetings_path, "post" do
      assert_select "input#meeting_passwd[name=?]", "meeting[passwd]"
      assert_select "input#meeting_title[name=?]", "meeting[title]"
      assert_select "input#meeting_description[name=?]", "meeting[description]"
      assert_select "input#meeting_creator[name=?]", "meeting[creator]"
    end
  end
end
