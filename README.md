# wg-setup-raspberry-pi

Execute with installation of wireguard with:

```bash
out="$(mktemp --suffix .sh)"
curl -sSL https://raw.githubusercontent.com/aleee-idk/wg-setup-raspberry-pi/main/setup.sh -o "$out" && sudo bash $out
rm $out
```

Start and restart the connection with:

```bash
sudo wg-quick down wg0
sudo wg-quick up wg0
```
