import random
import pandas as pd

def get_random_number():
    """Returns a random integer between 1 and 100."""
    return random.randint(1, 100) 

def get_random_series(size=10):
    """Returns a pandas Series of random numbers between 1 and 100."""
    numbers = [random.randint(1, 100) for _ in range(size)]
    return pd.Series(numbers) 

