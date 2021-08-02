# Create a frequency table or image to calculate the precentage of every 1000 words in COCA I have learnt
import sqlite3 as sl
import pandas as pd
from db_Scraper_Youdao import get_words_unique
import matplotlib.pyplot as plt
import numpy as np
import time

# Parameter
up_bound = 20000
x_gap = 2000
text_x_gap = 1000

# Only fetch COCA < 20001 frequency words
con = sl.connect('words.db')
df_learn = pd.read_sql_query("SELECT COCA FROM WORDS_COCA WHERE COCA > 0 AND COCA < 20001", con)
df_learn_list = list(df_learn['COCA'])
df_learn_list_unique = get_words_unique(df_learn_list)
print(len(df_learn_list_unique))

# Create histogram
fig, ax = plt.subplots()
n, bins, patches = plt.hist(df_learn_list_unique, bins = 20, range = (0, 20000), density = False, edgecolor = "black")
n_int = [ int(x) for x in n]
print(n_int)

# Plot X axis 
x = np.arange(0, up_bound + 1, x_gap)
labels = [str(x) + 'k' for x in range(0, 21, 2)]
plt.xticks(x, labels)

# Plot the number of each bar
text_x = np.arange(text_x_gap/2, up_bound, text_x_gap)
for a, b in zip(text_x, n_int):
    ax.text(a, b + 0.5, b, ha = 'center', va = 'bottom')

# Plot total number I've learnt
total = sum(n_int)
ax.text(up_bound - text_x_gap, max(n_int) + 0.5, \
    'total: ' + str(total) + ' | ' + str(total / up_bound * 100) + '%', \
    ha = 'center', va = 'bottom', weight = 'bold', color = 'red')

# Maximize the figure
plt.get_current_fig_manager().window.showMaximized()
plt.show()

# Save to file with "date time".png file name
filename = time.strftime("%Y-%m-%d %H.%M.%S", time.localtime())
fig.savefig("progress_fig//" + filename + ".png", dpi = 500)

