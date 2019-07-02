# Custom RancherOS

google-authenticator-libpamを組み込んだRancherOSの作成

## 準備

カスタマイズしたいバージョンのRancherOSのレポジトリをダウンロード

```bash
git clone https://github.com/rancher/os.git -b v1.5.2
git clone https://github.com/rancher/os-base.git -b v2018.02.11-1
git clone https://github.com/rancher/os-packer.git
```

## ビルド

### ISO image

ビルド環境を起動してビルドを行います、Docker for Macで起動するLinux Kernelのバージョンは、やや古いため、新しいカーネルを利用しているLinuxディストリビューションをVagrantで起動して、そちらでビルドの実施をします。

```bash
vagrant up
vagrant ssh

make build-os-base
# os-base/dist/ 以下を確認

make release-os-base
```

### Image for cloud service

```bash
# OSを作成する時？にregistryへのアクセスでloginしてないとダウンロードできない？
docker login

make build-os
# os/dist/ 以下を確認
```

### Image for VirtualBox/VagrantBox

```bash
packer build -force packer.json 
```

https://www.packer.io/docs/builders/virtualbox-ovf.html#boot-command


## Reference

### BR2 External tree

- https://qiita.com/pu_ri/items/8cdef8f7bb79a2ea0863
- https://buildroot.org/downloads/manual/manual.html#outside-br-custom
- https://www.glamenv-septzen.net/view/953
- https://monoist.atmarkit.co.jp/mn/articles/0807/02/news135.html

### Cloud-Conf

- https://rancher.com/docs/os/v1.x/en/installation/configuration/
- https://cloudinit.readthedocs.io/en/latest/index.html
- https://qiita.com/aoya6i/items/cf02c62e5f402fc4a835
