mkdir source
cd source

IF EXIST "routing" (
    cd routing
    git pull origin master
) ELSE (
    git clone https://github.com/itinero/routing.git
    cd routing
    git checkout master
)
cd ..

IF EXIST "optimization" (
    cd optimization
    git pull origin master
) ELSE (
    git clone https://github.com/itinero/optimization.git
    cd optimization
    git checkout master
)
cd ..

IF EXIST "GTFS" (
    cd GTFS
    git pull origin develop
) ELSE (
    git clone https://github.com/itinero/GTFS.git
    cd GTFS
    git checkout develop
)
cd..

IF EXIST "core" (
    cd core
    git pull origin develop
) ELSE (
    git clone https://github.com/OsmSharp/core.git
    cd core
    git checkout develop
)
cd..

IF EXIST "openlr" (
    cd openlr
    git pull origin master
) ELSE (
    git clone https://github.com/itinero/openlr.git
    cd openlr
    git checkout master
)
cd ..
cd ..

docfx