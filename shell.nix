{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    buildInputs = [ pkgs.go   pkgs.postgresql   pkgs.mailhog];

    src = pkgs.fetchFromGitHub {
       owner = "privacybydesign";
       repo = "irmago";
       rev = "0c153a97d013162688e77f104c65bd246b5d5323";
       sha256 = "sha256-Y+DUFOlgmyHloQwq0MTs/oabLf+8NHVElguoM9EVvmo=";
     };

     shellHook = ''
       export PGHOST=./postgres
       export PGDATA=$PGHOST/data
       export PGDATABASE=postgres
       export PGLOG=$PGHOST/postgres.log
            
       if pg_ctl status 
       then 
       pg_ctl stop
       fi

       if [ ! -d $PGDATA ]; then
       initdb -U postgres --auth=trust --no-locale --encoding=UTF8
       fi
              
       pg_ctl -D $PGDATA -l $PGLOG -o "-k /tmp" -o "-F -p 5432" start
              
       if  pg_ctl status
       then
       createuser -h localhost -s postgres

       psql -U postgres -h localhost -c 'CREATE database test'
       psql -U postgres -h localhost -c "CREATE USER testuser with encrypted password 'testpassword'"
       psql -U postgres -h localhost -c 'grant all privileges on database test to testuser'
       fi
       '';

  }
