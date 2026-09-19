import pandas as pd

# 1. Read the 3 files into Python
nykaa = pd.read_csv('nykaa_campaign_data.csv')
purplle = pd.read_csv('purplle_campaign_data.csv')
tira = pd.read_csv('tira_campaign_data.csv')

# 2. Add a new 'Brand' column to each file so we know who is who!
nykaa['Brand'] = 'Nykaa'
purplle['Brand'] = 'Purplle'
tira['Brand'] = 'Tira'

# 3. Glue the 3 files together into one big Master File
master_data = pd.concat([nykaa, purplle, tira])

# 4. Clean the data: Replace any blank, missing spaces with the number 0
master_data = master_data.fillna(0)

# 5. Save our new Master File so we can use it in SQL next
master_data.to_csv('Master_Marketing_Data.csv', index=False)
print("Success! Your files are combined and cleaned!")