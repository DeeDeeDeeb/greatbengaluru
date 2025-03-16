import importlib

packages = ["fastapi", "uvicorn", "torch", "torchvision", "pymongo", "pandas", "sklearn", "joblib"]

for pkg in packages:
    try:
        importlib.import_module(pkg)
        print(f"{pkg} ✅ Installed")
    except ImportError:
        print(f"{pkg} ❌ Not Installed")
