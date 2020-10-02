Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5909D281026
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbgJBJyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgJBJyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:54:18 -0400
Received: from localhost (unknown [122.167.37.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8AC4206DD;
        Fri,  2 Oct 2020 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601632456;
        bh=a5N01qmJLaBksjo8zWNrY4dly6fbHauhlM4ZjF+ZUq4=;
        h=Date:From:To:Cc:Subject:From;
        b=E4AmGCO1EGGa9y6DGjZmh+H8QmNxqD5OWOqxynGtR5oNnQgIpfq1i1fXgTtQBt9zx
         iVeQhg9apvlLTJaoUU/SM3vP96ndkNv836AYi1w0c729OkJ8Byg5F2K4AP+9Qt7URZ
         TUqtLG+amESIKV5e+8Uwin6KkiaSzHoHFnEsdosQ=
Date:   Fri, 2 Oct 2020 15:24:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic PHY updates for v5.10
Message-ID: <20201002095412.GZ2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive updates for Generic phy susbsystem. Bunch of new
drivers and device support and a new core API this time.

The following changes since commit ad7a7acaedcf45071c822b6c983f9c1e084041c9:

  phy: omap-usb2-phy: disable PHY charger detect (2020-08-31 14:30:59 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-5.10

for you to fetch changes up to 60f5a24c11f7fa0c8c74018cfd4c25a3f432fdaf:

  phy: qcom-qmp: initialize the pointer to NULL (2020-10-01 13:06:40 +0530)

----------------------------------------------------------------
phy for 5.9

 - Core:
   - New PHY attribute for max_link_rate

 - New phy drivers:
   - Rockchip dphy driver moved from staging
   - Socionext UniPhier AHCI PHY driver
   - Intel LGM SoC USB phy
   - Intel Keem Bay eMMC PHY driver

 - Updates:
   - Support for imx8mp usb phy
   - Support for DP Phy and USB3+DP combo phy in QMP driver
   - Support for Qualcomm sc7180 DP phy
   - Support for cadence torrent PCIe and USB single linke and multilink
     configurations along with USB, SGMII/QSGMII configurations

----------------------------------------------------------------
Anand Moon (1):
      phy: samsung: Use readl_poll_timeout function

Chunfeng Yun (6):
      phy: phy-bcm-ns-usb3: convert to readl_poll_timeout_atomic()
      phy: phy-bcm-ns2-usbdrd: convert to readl_poll_timeout_atomic()
      phy: phy-bcm-sr-usb: convert to readl_poll_timeout_atomic()
      phy: phy-qcom-apq8064-sata: convert to readl_relaxed_poll_timeout()
      phy: phy-pxa-28nm-hsic: convert to readl_poll_timeout()
      phy: phy-pxa-28nm-usb2: convert to readl_poll_timeout()

Ezequiel Garcia (1):
      phy: Move phy-rockchip-dphy-rx0 out of staging

Grygorii Strashko (3):
      phy: ti: gmii-sel: move phy init in separate function
      phy: ti: gmii-sel: use features mask during init
      phy: ti: gmii-sel: retrieve ports number and base offset from dt

Kunihiko Hayashi (2):
      dt-bindings: phy: Add UniPhier AHCI PHY description
      phy: socionext: Add UniPhier AHCI PHY driver support

Li Jun (2):
      dt-bindings: phy-imx8mq-usb: add compatible string for imx8mp usb phy
      phy: freescale: imx8mq-usb: add support for imx8mp usb phy

Ramuthevar Vadivel Murugan (2):
      dt-bindings: phy: Add USB PHY support for Intel LGM SoC
      phy: Add USB3 PHY support for Intel LGM SoC

Randy Dunlap (1):
      phy: fix USB_LGM_PHY warning & build errors

Rikard Falkeborn (11):
      phy: cadence: salvo: Constify cdns_salvo_phy_ops
      phy: fsl-imx8mq-usb: Constify imx8mq_usb_phy_ops
      phy: hisilicon; Constify hi3660_phy_ops
      phy: lantiq: rcu-usb2: Constify ltq_rcu_usb2_phy_ops
      phy: lantiq: vrx200-pcie: Constify ltq_vrx200_pcie_phy_ops
      phy: ralink-usb: Constify ralink_usb_phy_ops
      phy: samsung-ufs: Constify samsung_ufs_phy_ops
      phy: qcom-ipq4019-usb: Constify static phy_ops structs
      phy: cadence: Sierra: Constify static structs
      phy: cadence: salvo: Constify cdns_nxp_sequence_pair
      phy: cadence: torrent: Constify regmap_config structs

Roger Quadros (2):
      phy: omap-usb2-phy: fix coding style issues
      dt-binding: phy: convert ti,omap-usb2 to YAML

Sekhar Nori (3):
      phy: ti: am654: simplify regfield handling
      phy: ti: am654: simplify return handling
      phy: ti: am654: update PCIe serdes config

Stephen Boyd (8):
      dt-bindings: phy: qcom,qmp-usb3-dp: Add DP phy information
      phy: qcom-qmp: Move phy mode into struct qmp_phy
      phy: qcom-qmp: Remove 'initialized' in favor of 'init_count'
      phy: qcom-qmp: Move 'serdes' and 'cfg' into 'struct qcom_phy'
      phy: qcom-qmp: Get dp_com I/O resource by index
      phy: qcom-qmp: Use devm_platform_ioremap_resource() to simplify
      phy: qcom-qmp: Add support for DP in USB3+DP combo phy
      phy: qcom-qmp: Add support for sc7180 DP phy

Swapnil Jakhade (22):
      phy: Add new PHY attribute max_link_rate
      phy: cadence-torrent: Set Torrent PHY attributes
      phy: cadence-torrent: Use of_device_get_match_data() to get driver da=
ta
      phy: cadence-torrent: Use devm_platform_ioremap_resource() to get reg=
 addresses
      phy: cadence-torrent: Enable support for multiple subnodes
      phy: cadence-torrent: Add separate regmap functions for torrent and DP
      phy: cadence-torrent: Check total lane count for all subnodes is with=
in limit
      dt-bindings: phy: cadence-torrent: Add binding to specify SSC mode
      dt-bindings: phy: cadence-torrent: Update Torrent PHY bindings for ge=
neric use
      phy: cadence-torrent: Add single link PCIe support
      phy: cadence-torrent: Check cmn_ready assertion during PHY power on
      phy: cadence-torrent: Add PHY APB reset support
      dt-bindings: phy: Add PHY_TYPE_QSGMII definition
      phy: cadence-torrent: Add support for PHY multilink configuration
      phy: cadence-torrent: Update PHY reset for multilink configuration
      phy: cadence-torrent: Add clk changes for multilink configuration
      phy: cadence-torrent: Add PHY link configuration sequences for single=
 link
      phy: cadence-torrent: Configure PHY_PLL_CFG as part of link_cmn_vals
      phy: cadence-torrent: Add single link SGMII/QSGMII register sequences
      phy: cadence-torrent: Add single link USB register sequences
      phy: cadence-torrent: Add PCIe + USB multilink configuration
      phy: cadence-torrent: Add USB + SGMII/QSGMII multilink configuration

Tomasz Figa (1):
      phy: rockchip-dphy-rx0: Include linux/delay.h

Tomi Valkeinen (2):
      dt-bindings: phy: cdns,torrent-phy: add reset-names
      dt-bindings: phy: ti,phy-j721e-wiz: fix bindings for torrent phy

Vinod Koul (3):
      Merge branch 'fixes' into next
      Merge branch 'topic/phy_attrs' into next
      phy: qcom-qmp: initialize the pointer to NULL

Wan Ahmad Zainie (3):
      phy: intel: Rename phy-intel to phy-intel-lgm
      dt-bindings: phy: intel: Add Keem Bay eMMC PHY bindings
      phy: intel: Add Keem Bay eMMC PHY support

YueHaibing (1):
      phy: ti: j721e-wiz: Remove duplicate include

 .../devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt |    2 +-
 .../bindings/phy/intel,lgm-emmc-phy.yaml           |   17 +-
 .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml |   58 +
 .../bindings/phy/phy-cadence-torrent.yaml          |   96 +-
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |   95 +-
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |   76 +
 .../devicetree/bindings/phy/ti,omap-usb2.yaml      |   74 +
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |   13 +-
 Documentation/devicetree/bindings/phy/ti-phy.txt   |   37 -
 drivers/phy/Kconfig                                |   11 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/broadcom/phy-bcm-ns-usb3.c             |   22 +-
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c          |   13 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c              |   19 +-
 drivers/phy/cadence/phy-cadence-salvo.c            |    8 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |   24 +-
 drivers/phy/cadence/phy-cadence-torrent.c          | 2119 ++++++++++++++++=
+++-
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         |   79 +-
 drivers/phy/hisilicon/phy-hi3660-usb3.c            |    2 +-
 drivers/phy/intel/Kconfig                          |   22 +-
 drivers/phy/intel/Makefile                         |    5 +-
 drivers/phy/intel/phy-intel-keembay-emmc.c         |  307 +++
 .../{phy-intel-combo.c =3D> phy-intel-lgm-combo.c}   |    0
 .../{phy-intel-emmc.c =3D> phy-intel-lgm-emmc.c}     |    0
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           |    2 +-
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c        |    2 +-
 drivers/phy/marvell/phy-pxa-28nm-hsic.c            |   40 +-
 drivers/phy/marvell/phy-pxa-28nm-usb2.c            |   33 +-
 drivers/phy/phy-lgm-usb.c                          |  284 +++
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c       |   21 +-
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c        |    4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 1053 ++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   80 +
 drivers/phy/ralink/phy-ralink-usb.c                |    2 +-
 drivers/phy/rockchip/Kconfig                       |   12 +
 drivers/phy/rockchip/Makefile                      |    1 +
 .../rockchip}/phy-rockchip-dphy-rx0.c              |    1 +
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |   39 +-
 drivers/phy/samsung/phy-samsung-ufs.c              |    2 +-
 drivers/phy/socionext/Kconfig                      |   10 +
 drivers/phy/socionext/Makefile                     |    1 +
 drivers/phy/socionext/phy-uniphier-ahci.c          |  321 +++
 drivers/phy/ti/phy-am654-serdes.c                  |  325 +--
 drivers/phy/ti/phy-gmii-sel.c                      |  159 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |    1 -
 drivers/phy/ti/phy-omap-usb2.c                     |   36 +-
 drivers/staging/media/Kconfig                      |    2 -
 drivers/staging/media/Makefile                     |    1 -
 .../staging/media/phy-rockchip-dphy-rx0/Kconfig    |   13 -
 .../staging/media/phy-rockchip-dphy-rx0/Makefile   |    2 -
 drivers/staging/media/phy-rockchip-dphy-rx0/TODO   |    6 -
 include/dt-bindings/phy/phy-cadence-torrent.h      |   13 +
 include/dt-bindings/phy/phy.h                      |    1 +
 include/linux/phy/phy.h                            |    2 +
 54 files changed, 4858 insertions(+), 711 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphie=
r-ahci-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
 create mode 100644 drivers/phy/intel/phy-intel-keembay-emmc.c
 rename drivers/phy/intel/{phy-intel-combo.c =3D> phy-intel-lgm-combo.c} (1=
00%)
 rename drivers/phy/intel/{phy-intel-emmc.c =3D> phy-intel-lgm-emmc.c} (100=
%)
 create mode 100644 drivers/phy/phy-lgm-usb.c
 rename drivers/{staging/media/phy-rockchip-dphy-rx0 =3D> phy/rockchip}/phy=
-rockchip-dphy-rx0.c (99%)
 create mode 100644 drivers/phy/socionext/phy-uniphier-ahci.c
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/Makefile
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/TODO
 create mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h

Thanks
--=20
~Vinod

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl92+MMACgkQfBQHDyUj
g0cY+RAAxeDiAmGq1acH+ZqYN1Vznn9XhJivByQlfA5eshYnYiZtuzbsL1pwHFCe
cv63xMV4coKAHnZquDEKSCI4yoKbBA3ZaciurMXCKoYdD5DslQ0cgPLwjoxZvCTs
wj6jUB0m1nIrYYK++hNxyOgbzJtzdkuNYf9+YUmTTHHyybWQQDwtNcad0YyW5gDH
7mJt0bfDydG1c5FZcLCRo30L6Q9AHDUD/rzHgbJzSjyhEvseOZdU3mej0LVlQfoJ
jCKAql8lEgyg0R5VfrCAtNVXrgzOI+WlpQ5zufE2westzncQHCnJlDOWBEgeaFoS
I1IErDFq7KqtCE5THgbIMlil5URthucD2e894CSulofzLxhDXmtfzUBdPk5nYmIQ
NLhcQg0tu8l/HbNDxSWLeqcXKFQMVP5mAI/ETGZA0UWFuQi3HLkIJrvuFzGyob0f
em9x7naDqiRCBP4I+M5gujzwepYuEKI5RAKEg7+ZArJTcw3SOHzc+aeqew/5Y7f4
sMUxxF27AGxwcTkoMklEzdMp8UHr/hRxsRG6XbucZ7XOWFxSBR4KnS1TuFMe5y1w
H0BbVdXNpByxqco6eTRx7uS43bzCGwZ7NRnyD9WLzHaXHzAa3FWZUB9LCPCt98sb
VDijwJoV6atB+Ka6n8gXOWYlHfM86tI72ZCRZOgUoBnvVe048mc=
=3VQ3
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
