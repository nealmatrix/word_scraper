import argparse

from src.reviewer import Reviewer

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--index", default = 4000, help = "first index of the review", type = int)

    args = parser.parse_args()
    index = args.index

    # Init reviewer obj
    review_obj = Reviewer(index)

    # Daily review
    y_or_n = input('Generate daily review?, Y or N?\n')

    if y_or_n.upper() == 'Y':
        review_obj.generate_daily_review()

    # Week review
    y_or_n = input('Generate week review?, Y or N?\n')

    if y_or_n.upper() == 'Y':
        review_obj.generate_week_review()