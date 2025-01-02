# Instalação

## NixOS (VMWare)

Após ter instalado o NixOS no VMWare Fusion Pro, clone o repositório:
```
git clone https://github.com/nicolas-rezende/nix-config ~/.nix-config
```
Descriptografe os arquivos sensíveis:
```
transcrypt -c aes-256-cbc -p "$PASSWORD"
```
> É possível que não seja possível escrever a senha diretamente no comando (exemplo: layout do teclado errado e não permite escrever aspas duplas). Nesse caso, omita a opção `-p` e siga os prompts.
> Defina que NÃO quer gerar uma senha nova e digite a senha.
Garanta que a configuração de hardware detectada na instalação para garantir que tudo irá funcionar corretamente:
```
cp /etc/nixos/hardware-configuration.nix ~/.nix-config/hosts/${NIX_HOST}/hardware-configuration.nix
```
> Exemplo:
> ```
> cp /etc/nixos/hardware-configuration.nix ~/.nix-config/hosts/nixos-vmware/hardware-configuration.nix
> ```
Adicione ao repositório para que o arquivo seja lido pelo `nixos-rebuild`:
```
git add .
```
Gere uma nova geração:
```
sudo nixos-rebuild switch --flake .#${NIX_HOST}
```
> Exemplo:
> ```
> sudo nixos-rebuild switch --flake .#nixos-vmware
> ```
Reinicie o computador para que todas as configurações sejam aplicadas:
```
sudo reboot
```
Se as alterações de hardware forem permanentes (não é uma vm de teste), então faça um commit das mudanças:
```
git commit -m "update hardware configuration"
```
