import sys
from datetime import datetime
from pathlib import Path


def main(p: str):
    Path(p).write_text(f"Current time: {datetime.now()}")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "slask.txt")
