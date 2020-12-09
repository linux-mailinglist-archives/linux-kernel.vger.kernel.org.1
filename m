Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2062D4283
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbgLIM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgLIM5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:57:44 -0500
Date:   Wed, 9 Dec 2020 18:26:57 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607518622;
        bh=xF+fO7+hYfRN2rSz3MW9sd8zNSO6PkkKBsrTIxERP1Y=;
        h=From:To:Cc:Subject:From;
        b=qqaruSSnRyAbXrr2GtzPtM5ulQeGfRhxrIDiUQCrmBT60PVr8k6ItJYlbx3jrkvn2
         fwkMBhDzdB/F2I9k9dfXdbmCara4rGTRCXdq36BXuYJqNYYfh2KaCDI0EsvO8SqSC3
         KHHl9bCwwSuuvfhXrWzS2K5RLjJdQDE7v6pDKLl6pl0TSxYQxfY5khkiIFONulU7S6
         ztE5k3SVKmEtz3fSlu1U+Uu+3mFpvkyj+JNgTvTysKsWdEhWsAQSPpG7SrsyfOTdgI
         BG6NG3KaMOH1FFR0fGFoeQRcDr+T4yO3+r+LAADantXFi5dYJ/xlDEsDykIsDpMqhe
         1EyOkfMkxkzPw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL]: Generic phy updates for v5.11
Message-ID: <20201209125657.GJ8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Here is the pull request for phy susbsystem. All the changes are already
in linux-next, sorry for delayed request this time.

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-5.11

for you to fetch changes up to b097efba9580d1f7cbc80cda84e768983e3de541:

  drm/mediatek: avoid dereferencing a null hdmi_phy on an error message (20=
20-12-08 18:26:02 +0530)

----------------------------------------------------------------
phy-for-5.11

 - New phy drivers:
   - Mediatek MT7621 PCIe PHY (promoted from staging)
   - Ingenic USB phy driver supporting JZ4775 and X2000
   - Intel Keem Bay USB PHY driver
   - Marvell USB HSIC PHY driver supporting MMP3 SoC
   - AXG MIPI D-PHY driver

 - Updates:
   - Conversion to YAML binding for:
	- Broadcom SATA PHY
	- Cadence Sierra PHY bindings
	- STM32 USBC Phy
   - Support for Exynos5433 PCIe PHY
   - Support for Qualcomm SM8250 PCIe QMP PHY
   - Support for Exynos5420 USB2 phy
   - devm_platform_ioremap_resource conversion for bunch of drivers

----------------------------------------------------------------
Amelie Delaunay (3):
      phy: stm32: don't print an error on probe deferral
      phy: stm32: defer probe for reset controller
      dt-bindings: phy: phy-stm32-usbphyc: convert bindings to json-schema

Arnd Bergmann (1):
      phy: mediatek: allow compile-testing the hdmi phy

Chris Ruehl (4):
      phy: rockchip: set pulldown for strobe line in dts
      devicetree: phy: rockchip-emmc: pulldown property
      phy: rockchip-emmc: output tap delay dt property
      devicetree: phy: rockchip-emmc add output-tapdelay-select

Chunfeng Yun (17):
      phy: allwinner: convert to devm_platform_ioremap_resource(_byname)
      phy: amlogic: convert to devm_platform_ioremap_resource
      phy: broadcom: convert to devm_platform_ioremap_resource(_byname)
      phy: cadence: convert to devm_platform_ioremap_resource
      phy: freescale: convert to devm_platform_ioremap_resource
      phy: lantiq: convert to devm_platform_ioremap_resource
      phy: marvell: convert to devm_platform_ioremap_resource
      phy: phy-xgene: convert to devm_platform_ioremap_resource
      phy: phy-mtk-ufs: convert to devm_platform_ioremap_resource
      phy: qualcomm: convert to devm_platform_ioremap_resource(_byname)
      phy: phy-ralink-usb: convert to devm_platform_ioremap_resource
      phy: renesas: convert to devm_platform_ioremap_resource
      phy: rockchip: convert to devm_platform_ioremap_resource
      phy: samsung: convert to devm_platform_ioremap_resource
      phy: phy-stm32-usbphyc: convert to devm_platform_ioremap_resource
      phy: tegra: convert to devm_platform_ioremap_resource(_byname)
      phy: ti: convert to devm_platform_ioremap_resource(_byname)

Colin Ian King (1):
      drm/mediatek: avoid dereferencing a null hdmi_phy on an error message

Florian Fainelli (3):
      dt-bindings: phy: Allow defining the SATA AFE TX amplitude
      phy: phy-brcm-sata: Allow configuration SATA AFE TX amplitude
      dt-bindings: phy: Convert Broadcom SATA PHY to YAML

JC Kuo (1):
      phy: tegra: xusb: Fix usb_phy device driver field

Jaehoon Chung (1):
      phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433 PC=
Ie PHY

Jon Hunter (1):
      phy: tegra: Don't warn on probe deferral

Lubomir Rintel (3):
      dt-bindings: phy: Drop reset-gpios from marvell,mmp3-hsic-phy
      dt-bindings: phy: Allow BSD licensing of marvell,mmp3-hsic-phy.yaml
      phy: Add USB HSIC PHY driver for Marvell MMP3 SoC

Manivannan Sadhasivam (2):
      dt-bindings: phy: qcom,qmp: Add SM8250 PCIe PHY bindings
      phy: qcom-qmp: Add SM8250 PCIe QMP PHYs

Marek Szyprowski (2):
      phy: samsung: Add support for the Exynos5420 variant of the USB2 PHY
      phy: samsung: Merge Kconfig for Exynos5420 and Exynos5250

Neil Armstrong (7):
      dt-bindings: phy: add Amlogic AXG MIPI D-PHY bindings
      dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove reg attr=
ibute
      phy: amlogic: Add AXG MIPI D-PHY driver
      dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove phy cell=
 parameter
      phy: amlogic: phy-meson-axg-mipi-pcie-analog: add support for MIPI DS=
I analog
      phy: amlogic: meson-axg-mipi-pcie-analog: replace DSI_LANE definition=
s with BIT() macro
      phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up even in Host mode

Rafa=C5=82 Mi=C5=82ecki (1):
      phy: phy-bcm-ns-usb3: drop support for deprecated DT binding

Rikard Falkeborn (2):
      phy: fsl-imx8mq-usb: Constify imx8mp_usb_phy_ops
      phy: tegra: Constify static device_type structs

Robert Marko (1):
      MAINTAINERS: Add entry for Qualcomm IPQ4019 USB PHY

Sergio Paracuellos (6):
      dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
      phy: ralink: Add PHY driver for MT7621 PCIe PHY
      MAINTAINERS: add MT7621 PHY PCI maintainer
      staging: mt7621-pci-phy: remove driver from staging
      phy: ralink: phy-mt7621-pci: drop 'COMPILE_TEST' from Kconfig
      phy: ralink: phy-mt7621-pci: set correct name in MODULE_DEVICE_TABLE =
macro

Swapnil Jakhade (1):
      dt-bindings: phy: Add Cadence Sierra PHY bindings in YAML format

Tiezhu Yang (2):
      phy: mediatek: Make PHY_MTK_{XSPHY, TPHY} depend on HAS_IOMEM and OF_=
ADDRESS to fix build errors
      phy/rockchip: Make PHY_ROCKCHIP_INNO_HDMI depend on HAS_IOMEM to fix =
build error

Vinod Koul (4):
      phy: amlogic: Revert "phy: amlogic: Replace devm_reset_control_array_=
get()"
      phy: samsung: phy-exynos-pcie: fix typo 'tunning'
      phy: mediatek: statify mtk_hdmi_phy_driver
      phy: ingenic: depend on HAS_IOMEM

Wan Ahmad Zainie (2):
      dt-bindings: phy: Add Intel Keem Bay USB PHY bindings
      phy: intel: Add Keem Bay USB PHY support

Wang Li (1):
      phy: renesas: rcar-gen3-usb2: disable runtime pm in case of failure

Yangtao Li (1):
      phy: sun4i-usb: remove enable_pmu_unk1 from sun50i_h6_cfg

Yejune Deng (2):
      phy: amlogic: Replace devm_reset_control_array_get()
      phy: amlogic: replace devm_reset_control_array_get()

=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (3):
      USB: PHY: JZ4770: Remove unnecessary function calls.
      dt-bindings: USB: Add bindings for Ingenic JZ4775 and X2000.
      PHY: Ingenic: Add USB PHY driver using generic PHY framework.

 .../devicetree/bindings/clock/ingenic,cgu.yaml     |   2 +-
 .../bindings/phy/amlogic,axg-mipi-dphy.yaml        |  70 ++++
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml    |  21 +-
 .../devicetree/bindings/phy/brcm,sata-phy.yaml     | 148 ++++++++
 .../devicetree/bindings/phy/brcm-sata-phy.txt      |  58 ---
 .../ingenic,phy-usb.yaml}                          |   4 +-
 .../bindings/phy/intel,phy-keembay-usb.yaml        |  44 +++
 .../bindings/phy/marvell,mmp3-hsic-phy.yaml        |   9 +-
 .../bindings/phy}/mediatek,mt7621-pci-phy.yaml     |   2 +-
 .../devicetree/bindings/phy/phy-cadence-sierra.txt |  70 ----
 .../bindings/phy/phy-cadence-sierra.yaml           | 152 ++++++++
 .../devicetree/bindings/phy/phy-stm32-usbphyc.txt  |  73 ----
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml | 138 +++++++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   6 +
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   5 +
 .../devicetree/bindings/phy/samsung-phy.txt        |   1 +
 MAINTAINERS                                        |  14 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |   9 +-
 drivers/phy/allwinner/phy-sun50i-usb3.c            |   4 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c        |   4 +-
 drivers/phy/allwinner/phy-sun9i-usb.c              |   4 +-
 drivers/phy/amlogic/Kconfig                        |  13 +
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c      | 413 +++++++++++++++++=
++++
 .../phy/amlogic/phy-meson-axg-mipi-pcie-analog.c   | 203 ++++++----
 drivers/phy/amlogic/phy-meson-axg-pcie.c           |   6 +-
 drivers/phy/amlogic/phy-meson-g12a-usb2.c          |   4 +-
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     |   6 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           |   7 +-
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c         |   4 +-
 drivers/phy/broadcom/phy-bcm-kona-usb2.c           |   4 +-
 drivers/phy/broadcom/phy-bcm-ns-usb2.c             |   4 +-
 drivers/phy/broadcom/phy-bcm-ns-usb3.c             | 159 +-------
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c          |  13 +-
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             |   5 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c              |   4 +-
 drivers/phy/broadcom/phy-brcm-sata.c               |  40 +-
 drivers/phy/cadence/cdns-dphy.c                    |   4 +-
 drivers/phy/cadence/phy-cadence-salvo.c            |   4 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |   4 +-
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c     |   4 +-
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         |   6 +-
 drivers/phy/ingenic/Kconfig                        |  13 +
 drivers/phy/ingenic/Makefile                       |   2 +
 drivers/phy/ingenic/phy-ingenic-usb.c              | 412 +++++++++++++++++=
+++
 drivers/phy/intel/Kconfig                          |  12 +
 drivers/phy/intel/Makefile                         |   1 +
 drivers/phy/intel/phy-intel-keembay-usb.c          | 301 +++++++++++++++
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c        |   4 +-
 drivers/phy/marvell/Kconfig                        |  12 +
 drivers/phy/marvell/Makefile                       |   1 +
 drivers/phy/marvell/phy-armada375-usb2.c           |   4 +-
 drivers/phy/marvell/phy-berlin-usb.c               |   4 +-
 drivers/phy/marvell/phy-mmp3-hsic.c                |  82 ++++
 drivers/phy/marvell/phy-mmp3-usb.c                 |   4 +-
 drivers/phy/marvell/phy-mvebu-sata.c               |   4 +-
 drivers/phy/marvell/phy-pxa-28nm-hsic.c            |   4 +-
 drivers/phy/marvell/phy-pxa-28nm-usb2.c            |   4 +-
 drivers/phy/marvell/phy-pxa-usb.c                  |   4 +-
 drivers/phy/mediatek/Kconfig                       |  10 +-
 drivers/phy/mediatek/phy-mtk-hdmi.c                |   7 +-
 drivers/phy/mediatek/phy-mtk-ufs.c                 |   4 +-
 drivers/phy/phy-xgene.c                            |   4 +-
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c       |   4 +-
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c        |   4 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c       |   4 +-
 drivers/phy/qualcomm/phy-qcom-pcie2.c              |   5 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 281 +++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  18 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   4 +-
 drivers/phy/ralink/Kconfig                         |   8 +
 drivers/phy/ralink/Makefile                        |   1 +
 .../ralink/phy-mt7621-pci.c}                       | 117 +++---
 drivers/phy/ralink/phy-ralink-usb.c                |   4 +-
 drivers/phy/renesas/phy-rcar-gen2.c                |   4 +-
 drivers/phy/renesas/phy-rcar-gen3-pcie.c           |   4 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  10 +-
 drivers/phy/renesas/phy-rcar-gen3-usb3.c           |   4 +-
 drivers/phy/rockchip/Kconfig                       |   1 +
 drivers/phy/rockchip/phy-rockchip-emmc.c           |  29 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |   4 +-
 drivers/phy/samsung/phy-exynos-pcie.c              | 304 ++++++---------
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |   4 +-
 drivers/phy/samsung/phy-exynos5250-sata.c          |   5 +-
 drivers/phy/samsung/phy-exynos5250-usb2.c          |  48 ++-
 drivers/phy/samsung/phy-samsung-usb2.c             |   8 +-
 drivers/phy/samsung/phy-samsung-usb2.h             |   1 +
 drivers/phy/st/phy-stm32-usbphyc.c                 |  15 +-
 drivers/phy/tegra/phy-tegra194-p2u.c               |   4 +-
 drivers/phy/tegra/xusb.c                           |  12 +-
 drivers/phy/ti/phy-omap-control.c                  |  17 +-
 drivers/phy/ti/phy-omap-usb2.c                     |   4 +-
 drivers/phy/ti/phy-ti-pipe3.c                      |  15 +-
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/mt7621-pci-phy/Kconfig             |   8 -
 drivers/staging/mt7621-pci-phy/Makefile            |   2 -
 drivers/staging/mt7621-pci-phy/TODO                |   4 -
 drivers/usb/phy/phy-jz4770.c                       |   2 +-
 101 files changed, 2659 insertions(+), 944 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,axg-mipi-=
dphy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
 rename Documentation/devicetree/bindings/{usb/ingenic,jz4770-phy.yaml =3D>=
 phy/ingenic,phy-usb.yaml} (89%)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-keembay=
-usb.yaml
 rename {drivers/staging/mt7621-pci-phy =3D> Documentation/devicetree/bindi=
ngs/phy}/mediatek,mt7621-pci-phy.yaml (92%)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierr=
a.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierr=
a.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc=
=2Eyaml
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
 create mode 100644 drivers/phy/ingenic/Kconfig
 create mode 100644 drivers/phy/ingenic/Makefile
 create mode 100644 drivers/phy/ingenic/phy-ingenic-usb.c
 create mode 100644 drivers/phy/intel/phy-intel-keembay-usb.c
 create mode 100644 drivers/phy/marvell/phy-mmp3-hsic.c
 rename drivers/{staging/mt7621-pci-phy/pci-mt7621-phy.c =3D> phy/ralink/ph=
y-mt7621-pci.c} (75%)
 delete mode 100644 drivers/staging/mt7621-pci-phy/Kconfig
 delete mode 100644 drivers/staging/mt7621-pci-phy/Makefile
 delete mode 100644 drivers/staging/mt7621-pci-phy/TODO

Thanks
--=20
~Vinod

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl/QyZkACgkQfBQHDyUj
g0fIEhAArsaRpUzP5macBQrrek0+ItJwolHnxwquvhu66deUF9x+WdN4/6kqNmVl
9Jt7wSqg/IN33aqLnhyv76sJinApQcnCCvxJeVqa7/UyE4YpRhCfj6AmRe8yTV90
AurOTtHoriJxYxBHwUNtTg4Vp4ICN1bWsnsqkdoy7OGXKKWxHWl85Jx0tdh4Rad9
FbGe1VcoXDVX56QQ2x1LkjsEoXGPd8vTV/m3gHpKTyt2vm9uzf+3YCDwI066i/+R
fjRURDPDAqQ5DdWl4OpfwHTM1ssjxvpvLnM2dFz2/EQSkxjH4f09rz7x0+e17+72
pm2JUlzO2Gzrq38CyhtHEUD5y4PwRS9vB/5IMi4Jz1qF9Z/hYQ21raLDETCFMYRZ
D0af/XFAbd039nnwJVxS/JMs2b+shzQIewzf5Y6tdzakdttF44mbWKglMehmIxq3
A01IDhkHgtMD+mLvIr0Hej7Osu/O4srIrbennr8QpZGxBpTQm0fUg/IoeK4OxFwC
iRCHBtxI4ig3yzxVbhaHzliRHxhi4I+qzGm8oJgojPot2Ofd7HwUtmCVP5NjghV9
AVN2zU3Rnqx2xF5AH83+D3YjmX0DP3H6j6aWKMwY2fjY4QO7pJSjB8i+8g0SxGMr
0hNGDm28ANTikKGBQuI9KKhWsQa33+wwhcV5zLb3eLkJ09gEpQ0=
=1IfK
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
