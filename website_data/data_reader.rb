require 'open-uri'
require 'csv'
require 'byebug'

def text_data_from_website(url,open_tag,close_tag)
    html = open(url, &:read)
    data_tags = html.split(open_tag)[1..-1]
    data = []
    
    data_tags.each do |data_tag|
        data << data_tag.split(close_tag)[0].strip
    end
    data
end

def save_to_csv(data)
    time_stamp = Time.now.getutc
    csv_name = "titles" + time_stamp.to_s + ".csv"

    CSV.open csv_name, "w" do |csv|
        data.each do |title|
            csv << [title]
        end
    end
end

def find_new(new_csv,old_csv)
    old_titles =  {}
    new_titles = {}
    new_appearances = []

    CSV.foreach(old_csv) {|row| old_titles[row[0]] = true}
    CSV.foreach(new_csv) {|row| new_titles[row[0]] = true}

    new_titles.each_key do |title|
        new_appearances << title unless old_titles[title] == true
    end

    new_appearances
end



def main
    url = "http://www.playbill.com/productions?venue-type=broadway"
    open_tag = "<div class=\"pb-pl-tile-title\">"
    close_tag = "</div>"
    titles =  text_data_from_website(url,open_tag,close_tag)
    save_to_csv(titles)
    print find_new("titles.csv","existing_titles.csv")
    #reconfigure line 50 to take as arguments the CSV files actually being generated
end

main

