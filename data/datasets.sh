HOCKEY_DIR="Hockey"
MOVIES_DIR="Movies"
VF_DIR="VF"
RWF_DIR="RWF2000"
BUS_VIOLENCE_DIR="Bus"

HOCKEY_URL="https://academictorrents.com/download/38d9ed996a5a75a039b84cf8a137be794e7cee89.torrent"
MOVIES_URL="https://academictorrents.com/download/70e0794e2292fc051a13f05ea6f5b6c16f3d3635.torrent"
VF_URL="https://drive.google.com/uc?id=1c3LOwnKwMW_tngX0IRWSiDEGrwOMTm2o"
RWF_URL="https://drive.google.com/uc?id=1M9RHroGjB2pTJRrKzmVNgUSTy6J1Iiku"


# HOCKEY-FIGHTS DATASET
if [[ ! -d "${HOCKEY_DIR}" ]]; then
    echo "Downloading and extracting: hockey fights"
    aria2c --seed-time=0 "${HOCKEY_URL}"
	unzip -qq HockeyFights.zip -d "${HOCKEY_DIR}" && rm HockeyFights.zip && rm *.torrent
	mkdir ${HOCKEY_DIR}/Fight && mkdir ${HOCKEY_DIR}/NoFight
	mv ${HOCKEY_DIR}/fi* ${HOCKEY_DIR}/Fight && mv ${HOCKEY_DIR}/no* ${HOCKEY_DIR}/NoFight
fi

# VIOLENCE IN MOVIES DATASET
if [[ ! -d "${MOVIES_DIR}" ]]; then
    echo "Downloading and extracting: violence in movies"
    aria2c --seed-time=0 "${MOVIES_URL}"	
    unrar x Peliculas.rar -idq && rm Peliculas.rar && rm *.torrent
	mv Peliculas "${MOVIES_DIR}" 	
fi

# VIOLENT-FLOW DATASET
if [[ ! -d "${VF_DIR}" ]]; then
    echo "Downloading and extracting: violent-flow"
    gdown "${VF_URL}"
    unzip -qq violent-flow.zip -d "${VF_DIR}" && rm violent-flow.zip
fi

# REAL-LIFE VIOLENCE SITUATIONS DATASET
if [[ ! -d "${RLVS_DIR}" ]]; then
    echo "Downloading and extracting: real-life violence situations"
    gdown "${RLVS_URL}"
    unzip -qq real-life-violence.zip -d "${RLVS_DIR}" && rm real-life-violence.zip
fi

# RWF-2000 DATASET
if [[ ! -d "${RWF_DIR}" ]]; then
    echo "Downloading and extracting: RWF-2000"
    gdown "${RWF_URL}"
    unzip -qq RWF-2000.zip -d "${RWF_DIR}" && rm RWF-2000.zip
fi

# SURVEILLANCE CAMERA FIGHT DATASET
if [[ ! -d "${SCF_DIR}" ]]; then
    echo "Downloading and extracting: surveillance camera fight"
    gdown "${SCF_URL}"
    unzip surveillance-camera-fight.zip && rm surveillance-camera-fight.zip
fi

# BUS-VIOLENCE DATASET
if [[ ! -d "${BUS_VIOLENCE_DIR}" ]]; then
    echo "Downloading and extracting: bus-violence"
    zenodo_get 10.5281/zenodo.7044203       # zenodo DOI
    unzip bus-violence.zip -d "${BUS_VIOLENCE_DIR}"  && rm bus-violence.zip && rm md5sums.txt
fi