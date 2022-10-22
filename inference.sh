#!/bin/bash
cd /opt/ml/processing/input/
pip install click requests tqdm pyspng ninja imageio-ffmpeg==0.4.3
tar -xzvf /opt/ml/processing/model/model.tar.gz -C .
cp /opt/ml/processing/data/test.png .
python3 projector.py --network model.pkl --target test.png --outdir /opt/ml/processing/output/test