#!/usr/bin/env python3
# Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.

from .build import DATASET_REGISTRY, build_dataset  # noqa
from .hockey import Hockey
from .movies import Movies
from .vf import Vf
from .rwf2000 import Rwf2000
from .bus import Bus

# try:
#     from .ptv_datasets import Ptvcharades, Ptvkinetics, Ptvssv2  # noqa
# except Exception:
#     print("Please update your PyTorchVideo to latest master")
