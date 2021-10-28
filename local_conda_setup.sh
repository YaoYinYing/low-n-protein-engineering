echo "channels:
  - defaults
  - https://*****:******@conda.graylab.jhu.edu
  - conda-forge
show_channel_urls: true
default_channels:
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/main
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/r
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.bfsu.edu.cn/anaconda/cloud
  msys2: https://mirrors.bfsu.edu.cn/anaconda/cloud
  bioconda: https://mirrors.bfsu.edu.cn/anaconda/cloud
  menpo: https://mirrors.bfsu.edu.cn/anaconda/cloud
  pytorch: https://mirrors.bfsu.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.bfsu.edu.cn/anaconda/cloud
report_errors: false

pkgs_dirs:
  - $HOME/.conda/pkgs" > $HOME/.condarc

conda_env=low-n-p450
conda create -y -n $conda_env
conda activate $conda_env
conda install -y jupyter

# set pypi repo to mirrors managed by BFSU
pip install pip -U
pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple

pip install tqdm
pip install jax-unirep
pip install biopython
pip install awscli
pip install optuna
pip install seaborn
pip install python-Levenshtein
pip install feather-format
# fix error like: "Permission denied: '/usr/share/jupyter/nbconvert/templates/conf.json'"
pip install nbconvert==5.6.1

conda install -y -c conda-forge openmm==7.5.1 cudnn==8.2.1.32 cudatoolkit==11.4.2 pdbfixer==1.7
conda install -y -c bioconda hmmer==3.3.2 hhsuite==3.3.0 kalign2==2.04
pip install --upgrade jax jaxlib==0.1.72+cuda111 -f https://storage.googleapis.com/jax-releases/jax_releases.html

git clone https://github.com/YaoYinYing/low-n-protein-engineering
cd low-n-protein-engineering
rm jupyter.log; nohup jupyter notebook --port 8899 --ip 0.0.0.0 >> jupyter.log &