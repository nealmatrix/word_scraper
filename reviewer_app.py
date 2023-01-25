from src.reviewer import Reviewer

if __name__ == '__main__':

    last_index = 4380

    # Init reviewer obj
    review_obj = Reviewer(last_index)

    # Daily review
    y_or_n = input('Generate daily review?, Y or N?\n')

    if y_or_n.upper() == 'Y':
        review_obj.generate_daily_review()

    # Week review
    y_or_n = input('Generate week review?, Y or N?\n')

    if y_or_n.upper() == 'Y':
        review_obj.generate_week_review()