{  nixpkgs ? import <nixpkgs> {  } }:

with nixpkgs;
buildGoModule rec {
  pname = "irmago";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "privacybydesign";
    repo = "irmago";
    rev = "v${version}";
    sha256 = "sha256-Y+DUFOlgmyHloQwq0MTs/oabLf+8NHVElguoM9EVvmo=";
  };
  vendorSha256="sha256-9JZKl5hm3qtbYNwPFyDSzndhw6/Qr2DN/CY3eSNDMxU=";

  doCheck = false;
  meta = with lib; {
    description = "Secure and privacy-friendly authentication";
    homepage = https://irma.app/;
    license = licenses.mit;
    maintainers = with maintainers; [ irma.app ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
