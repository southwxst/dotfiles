from .utils import *
from pathlib import Path

def export_dataset_for_research(did):
    addon = mw.addonManager.addonFromModule(__name__)
    user_files = Path(mw.addonManager.addonsFolder(addon)) / "user_files"
    user_files.mkdir(parents=True, exist_ok=True)
    log = mw.col.backend.export_dataset(min_entries=0, target_path=str(user_files / "dataset.revlog"))
    print(log)