
import matplotlib.pyplot as plt
import numpy as np

def temporal_adjustment(t, T=100):
    """Temporal adjustment according to Reisch

    Args:
        t (float): year of calculated temperoral adjustment
        T (int, optional): period of consideration. Defaults to 100.

    Returns:
        float : Temporal adjustment factor
    """
    return 2 - np.exp((np.log(2)/T)*t)

def temporal_adjustment_probable(t, p=1, T=100):
    """Temporal adjustment according to Reisch

    Args:
        t (float): year of calculated temperoral adjustment
        p (float): probability of usage. Defaults to 1.
        T (int, optional): period of consideration. Defaults to 100.

    Returns:
        float : Temporal adjustment factor
    """
    return 2 - np.exp((np.log(2)/T)*t)*p