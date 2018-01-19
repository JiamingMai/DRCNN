Usage:

1. Place the "DRCNN" folder into "($Caffe_Dir)/examples/"

2. Open MATLAB and direct to ($Caffe_Dir)/example/DRCNN, run 
"generate_train.m" and "generate_test.m" to generate training and test data.

3. To train our DRCNN, run
./build/tools/caffe train --solver examples/DRCNN_train/DRCNN_solver.prototxt

4. After training, you can extract parameters from the caffe model and save them in the format that can be used in our test package (SRCNN_v1). To do this, you need to install mat-caffe first, then open MATLAB and direct to ($Caffe_Dir) and run "saveFilters.m". The "($Caffe_Dir)/examples/DRCNN/x3.mat" will be there for you.

5. In order to continue to train the network, you can use the following command: 
./build/tools/caffe train --solver examples/DRCNN_train/DRCNN_solver.prototxt --snapshot=examples/DRCNN_train/DRCNN_iter_10000.solverstate

