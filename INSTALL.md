# Installation

## Requirements
- Python >= 3.8
- Numpy
- GCC >= 4.9
- PyTorch >= 1.3 and [torchvision](https://github.com/pytorch/vision/) that matches the PyTorch installation.
- PyTorchVideo: `pip install "git+https://github.com/facebookresearch/pytorchvideo.git"`
- [fvcore](https://github.com/facebookresearch/fvcore/): `pip install 'git+https://github.com/facebookresearch/fvcore'`
- simplejson: `pip install simplejson`
- ffmpeg: `conda install ffmpeg=4.2`
- PyYaml: (will be installed along with fvcore)
- tqdm: (will be installed along with fvcore)
- iopath: `pip install -U iopath` or `conda install -c iopath iopath`
- psutil: `pip install psutil`
- OpenCV: `pip install opencv-python`
- tensorboard: `conda install tensorboard`. Use conda install to have the necessary requirements instead of the pip command included in the official repo.
- scikit-learn: ̣̣̣̣̣̣̣̣̣̣̣̣̣̣̣̣̣̣̣`pip install scikit-learn` (sklearn is not supported anymore)
- moviepy: (optional, for visualizing video on tensorboard) `conda install -c conda-forge moviepy` or `pip install moviepy`
- FairScale: `pip install 'git+https://github.com/facebookresearch/fairscale'`
- cython: `pip install cython`
- [Detectron2](https://github.com/facebookresearch/detectron2):

```
    pip install -U 'git+https://github.com/facebookresearch/fvcore.git' 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'
    git clone https://github.com/facebookresearch/detectron2 detectron2_repo
    pip install -e detectron2_repo
    # You can find more details at https://github.com/facebookresearch/detectron2/blob/master/INSTALL.md
```

## PySlowFast

Clone the PySlowFast Video Understanding repository.
```
git clone https://github.com/facebookresearch/slowfast
```

Add this repository to $PYTHONPATH.
```
export PYTHONPATH=/path/to/SlowFast/slowfast:$PYTHONPATH
```

## Build PySlowFast

After having the above dependencies, run:
```
git clone https://github.com/facebookresearch/slowfast
cd SlowFast
python setup.py build develop
```

Now the installation is finished, run the pipeline with:
```
python tools/run_net.py --cfg configs/Kinetics/C2D_8x8_R50.yaml NUM_GPUS 1 TRAIN.BATCH_SIZE 8 SOLVER.BASE_LR 0.0125 DATA.PATH_TO_DATA_DIR path_to_your_data_folder
```