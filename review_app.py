from src.reviewer import Reviewer

if __name__ == '__main__':

    last_index = 4380

    # Init reviewer obj
    review_obj = Reviewer(last_index)

    review_obj.generate_daily_review()
    review_obj.generate_week_review()