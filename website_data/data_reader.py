import urllib2

def text_data_from_website(url,open_tag,close_tag):
    response = urllib2.urlopen(url)
    html = response.read()

    data_tags = html.split(open_tag)[1:]
    data = []

    for data_tag in data_tags:
        data.append(data_tag.split(close_tag)[0])

    return data

url = "http://www.playbill.com/productions?venue-type=broadway"
open_tag = "<div class=\"pb-pl-tile-title\">"
close_tag = "</div>"
titles = text_data_from_website(url,open_tag,close_tag)
for title in titles:
    print(title)