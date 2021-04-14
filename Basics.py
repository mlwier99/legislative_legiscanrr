
import pandas
from pandas.io.json import json_normalize
import json


with open('/home/michelle/Dropbox/RA Work/Spring 2020, TP/text/random_example.json', 'r') as read_file:    
    data = json.load(read_file)
    
data = json_normalize(data)


print(data)

df = data 

data.to_csv('/home/michelle/Dropbox/RA Work/Spring 2020, TP/text/random_example.json')

