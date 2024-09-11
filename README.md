# wg-setup-raspberry-pi

Execute with:

```bash
out="$(mktemp --suffix .sh)"
curl -sSL https://raw.githubusercontent.com/aleee-idk/wg-setup-raspberry-pi/main/setup.sh -o "$out" && sudo bash $out
rm $out
```
