FROM ubuntu:20.04

# これを入れておかないとtzdataのインストール時に止まる（プロンプトが出てる）
ENV DEBIAN_FRONTEND noninteractive

# パッケージインストール
RUN apt-get update && apt-get install -y \
    tzdata \
    vim \
    sudo \
    python3-pip \
    nodejs npm \
    language-pack-ja \
    && rm -rf /var/lib/apt/lists/*

# Jupyter Lab インストール
RUN pip3 install pandas matplotlib jupyterlab

# タイムゾーンを設定する環境変数
ENV TZ=Asia/Tokyo

# ポートの指定
EXPOSE 8888

# JupyterNotebookディレクトリ
WORKDIR /JupyterNotebook

# 設定ファイルの作成
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.notebook_dir = '/JupyterNotebook'" >> ~/.jupyter/jupyter_notebook_config.py

# JupyterLab の起動
CMD ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''"]
