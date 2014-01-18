require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

# doc.at_css("dddefault").text

mech = Mechanize.new

form_variables = {'term_in' => '201401', 'sel_camp' => 'UAAALL', 'course_type' => 'A'}
test = { "term_in" => "dummy", "sel_subj" => "dummy", "sel_day" => "dummy", "sel_schd" => "dummy", "sel_insm" => "dummy", "sel_camp" => "dummy", "sel_levl" => "dummy", "sel_sess" => "dummy", "sel_instr" => "dummy", "sel_ptrm" => "dummy", "sel_attr" => "dummy", "sel_meet" => "dummy", "sel_pace" => "dummy", "sel_method" => "dummy", "search_type" => "QUICK", "sel_title" => "", "begin_hh" => "0", "begin_mi" => "0", "begin_ap" => "a", "end_hh" => "0", "end_mi" => "0", "end_ap" => "a", "btn_sel" => "", "term_in" => "201401", "sel_camp" => "UAAALL", "sel_open_search" => "", "course_type" => "A", "sel_subj" => "%", "sel_crse" => "", "begin_ap" => "x", "end_ap" => "y"}

mech.get('http://www.uaa.alaska.edu/') do |page|
  #Click 'Class Schedule'
  search = mech.click(page.link_with(:text => /Class Schedule/))
  # searchform = search.form('SearchForm')
  # pp searchform.field_with(:id => 'term_input_id').options[0].click
  # pp searchform.checkbox_with(:id => 'camp_id19').check
  # pp searchform.checkbox_with(:id => 'subj_id1').check
  search
  results = mech.post('https://uaonline.alaska.edu/banprod/owa/bwck2sch.p_get_crse_unsec', test)
  puts 'success'
end
