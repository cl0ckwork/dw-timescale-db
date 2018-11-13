# DATA-WAREHOUSING TIMESCALE-DB

See their api [here](https://docs.timescale.com/v1.0/api)

## Getting Started
1. clone the repo to you machine, then `cd` into the repo `cd dw-timescale-db`
2. start the environment for anaconda `conda env create -f environment.yml -n anaconda37`
3. activate env `conda activate anaconda37` or `source activate anaconda37`
4. install add-on for jupyter `conda install nb_conda` (for the [Conda](https://github.com/Anaconda-Platform/nb_conda) tab in jupyter notebook.)
5. install [docker](https://docs.docker.com/install/)
6. start the docker container `docker-compose up --remove-orphans`
7. use python to connect to the database and do work. (see `main.py` OR `db-connection.ipynb`)

## Using Jupyter Notebook
1. `conda install nb_conda` (if not already done)
2. activate env, `source activate anaconda37`
3. run the notebook via terminal to make the environment the default `jupyter notebook`
4. use the Conda tab to change environment to `anaconda37` if its not set.
5. write your code (see `db-connection.ipynb` example).

