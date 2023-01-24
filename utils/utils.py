import pandas as pd

class Convertor:

    @staticmethod
    def get_words_unique(words) -> list:
        seen = set()
        seen_add = seen.add
        return [x for x in words if not (x in seen or seen_add(x))]
    
    @staticmethod
    def get_word_with_double_single_quotes(word: str):
        return word.replace('\'', '\'\'')
    
class Printer:

    @staticmethod
    def print_single_column(df: pd.DataFrame, column_name) -> None:

        row_num, column_num = df.shape

        if row_num == 0:
            print('No rows in dataframe')
            return

        for i in range(row_num):
            print(df[column_name][i])
    
    @staticmethod
    def double_break_print(*values):

        print(*values, end = '\n\n')