HOCKEY_DIR="Hockey"
MOVIES_DIR="Movies"
VF_DIR="violent-flow"
RLVS_DIR="RLVS"
RWF_DIR="RWF-2000"
BUS_VIOLENCE_DIR="bus-violence"
# BOSS DATASET !!!!!!

HOCKEY_URL="https://academictorrents.com/download/38d9ed996a5a75a039b84cf8a137be794e7cee89.torrent"
MOVIES_URL="https://academictorrents.com/download/70e0794e2292fc051a13f05ea6f5b6c16f3d3635.torrent"
VF_URL="FROM GOOGLE DRIVE"
RLVS_URL="https://drive.google.com/uc?id=1zw-elBkWVaGN1qKxXeKZsau_8iep9wl1"
RWF_URL="https://drive.google.com/uc?id=1xNXdpqJ7-Jd2aWI1InHh2-Zfob8hYUuk"


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