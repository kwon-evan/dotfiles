from typing import Any
from typing import Dict
from typing import List

import torch


def main():
    print(torch.cuda.is_available())
    print(torch.version.cuda)

if __name__ == "__main__":
    main()
