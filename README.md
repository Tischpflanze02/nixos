# nixos


## Copying the config

```bash
sudo cp nixos_config/configuration.nix /etc/nixos/
sudo cp nixos_config/poweroptimizaion.nix /etc/nixos/
```

## Adding Homemanger as Module to nix

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
```


## Building the conf 

```bash
sudo nixos-rebuild switch 
```

