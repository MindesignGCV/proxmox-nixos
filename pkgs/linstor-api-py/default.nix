{
  lib,
  python310,
  fetchFromGitHub,
  nix-update-script,
}:

python310.pkgs.buildPythonPackage rec {
  pname = "linstor-api-py";
  version = "1.27.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "LINBIT";
    repo = "linstor-api-py";
    rev = "v${version}";
    hash = "sha256-5DKwrylidnIA5OUVIPHkXAQoS/XM4YMN65WDBI3SJME=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    python310.pkgs.setuptools
    python310.pkgs.wheel
    python310.pkgs.distutils
  ];

  pythonImportsCheck = [ "linstor" ];

  passthru.updateScript = nix-update-script { extraArgs = [ "--flake" ]; };

  meta = with lib; {
    description = "LINSTOR Python API";
    homepage = "https://github.com/LINBIT/linstor-api-py";
    changelog = "https://github.com/LINBIT/linstor-api-py/blob/${src.rev}/CHANGELOG.md";
    license = [ ];
    maintainers = with maintainers; [
      camillemndn
      julienmalka
    ];
  };
}
