Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C9328146C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387959AbgJBNqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:46:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53436 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgJBNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:46:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 092Dk0Wt123597;
        Fri, 2 Oct 2020 08:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601646360;
        bh=0NydwuapotJ0y2cBgY0RL7e1IflN1Ru/Qc8XITYlm+4=;
        h=Date:From:To:CC:Subject;
        b=U4RMF4UTrdKVltVUf0yXRcszLhJ3cGyS/UBbS7OlxLiSPd6joOLOF36g8y5b4ygMX
         duG88MD/38EOejdgx3EfE4bDg0Caybm8ixnRmLWmlI6Af0lGtL3Yg54xtyM09onXWn
         2l8JX9HJyt7Fuz8LDR1nFKNf5x5rYJkKKvqoQiIo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 092Dk09n053249
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 08:46:00 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 08:45:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 08:46:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 092DjxO0096205;
        Fri, 2 Oct 2020 08:45:59 -0500
Date:   Fri, 2 Oct 2020 08:45:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <t-kristo@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] arm64: TI K3 DT updates for v5.10 - part #2
Message-ID: <20201002134559.orvmgbns57qlyn3i@akan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imps7ep4na76fgmn"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--imps7ep4na76fgmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

Please pull the following part2 of the TI K3 DTS support since [1].
This also contains the PR [2] which provides the base for the J7200
USB support in this PR. Primary highlights in the part #2:
 - New K3 SoC: J7200 and related board J7200 Common processor board
 - Bunch of peripherals for J7200 (DMA, USB, MMC, Ethernet..)
 - GPIO hog node rename to abide by the updated yaml bindings.

The following changes since commit 66db854b1f62dbee48ec7373f149fa30e4b3dd4e:

  arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe instances =
(2020-09-22 08:19:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git tags/ti-k3=
-dt-for-v5.10-part2

for you to fetch changes up to bbcb0522ae0cea0f2561e7dad243f8a3d5ab5559:

  arm64: dts: ti: k3-j7200-common-proc-board: Add USB support (2020-09-30 0=
7:34:03 -0500)

----------------------------------------------------------------
Second and final device tree updates towards 5.10-rc1 for TI K3 platform.

----------------------------------------------------------------
Faiz Abbas (2):
      arm64: dts: ti: k3-j7200-main: Add support for MMC/SD controller nodes
      arm64: dts: ti: k3-j7200-common-proc-board: Add support for eMMC and =
SD card

Grygorii Strashko (3):
      arm64: dts: ti: k3-j7200-main: add main navss cpts node
      arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
      arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux =
and phy defs

Kishon Vijay Abraham I (1):
      arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane=
 function

Krzysztof Kozlowski (1):
      arm64: dts: ti: k3-j721e-common-proc-board: align GPIO hog names with=
 dtschema

Lokesh Vutla (5):
      arm64: dts: ti: Makefile: Use ARCH_K3 for building dtbs
      dt-bindings: arm: ti: Convert K3 board/soc bindings to DT schema
      dt-bindings: arm: ti: Add bindings for J7200 SoC
      arm64: dts: ti: Add support for J7200 SoC
      arm64: dts: ti: Add support for J7200 Common Processor Board

Nishanth Menon (1):
      Merge tag 'ti-k3-dt-fixes-for-v5.9' into ti-k3-dts-next

Peter Ujfalusi (1):
      arm64: dts: ti: k3-j7200: add DMA support

Roger Quadros (6):
      arm64: dts: ti: k3-j721e: Rename mux header and update macro names
      dt-bindings: ti-serdes-mux: Add defines for J7200 SoC
      arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
      arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
      arm64: dts: ti: k3-j7200-main: Add USB controller
      arm64: dts: ti: k3-j7200-common-proc-board: Add USB support

Vignesh Raghavendra (4):
      arm64: dts: ti: k3-j7200: Add I2C nodes
      arm64: dts: ti: k3-j7200-common-proc-board: Add I2C IO expanders
      arm64: dts: ti: k3-j7200-mcu-wakeup: Add HyperBus node
      arm64: dts: ti: k3-j7200-som-p0: Add HyperFlash node

 Documentation/devicetree/bindings/arm/ti/k3.txt    |  26 --
 Documentation/devicetree/bindings/arm/ti/k3.yaml   |  35 ++
 MAINTAINERS                                        |   2 +-
 arch/arm64/boot/dts/ti/Makefile                    |   8 +-
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     | 215 ++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          | 449 +++++++++++++++++=
++++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    | 273 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  65 +++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi               | 172 ++++++++
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |  15 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  13 +-
 include/dt-bindings/mux/mux-j721e-wiz.h            |  53 ---
 include/dt-bindings/mux/ti-serdes.h                |  93 +++++
 13 files changed, 1323 insertions(+), 96 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200.dtsi
 delete mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
 create mode 100644 include/dt-bindings/mux/ti-serdes.h

 [1] https://lore.kernel.org/linux-arm-kernel/20200922134722.2y5kqxu4lghbwp=
5u@akan/
 [2] https://lore.kernel.org/linux-arm-kernel/20200921125402.mtwypblhb45a6s=
sh@akan/

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--imps7ep4na76fgmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAl93LxEACgkQ3bWEnRc2
JJ0O/A/+I6FeT5Q5NK6OnDZs26SB7yOgi7sy5x50OCoZNTstbFkoOa6ewIeKgqbl
LpYf5HUk3B1p0PaRVSyF5bsWkvWdpPntw0t75XtAHh5mFO8AI/Un23eF7UMWpDbT
UJ/TIKBxTMy90vP1otiMLLmM+NDkSD0jPpIgsVf2bS8m1V/Xid25GFQ6TyniU660
5OTs1+YxxuQvNt2jinkQm8PzcDn9v1HypsHomd2g28AhyvV4PIlQdo80xBicvm6F
FfxS324DH3xK2ukWrOVeBF/Ev2Ga/aTRtiK0dJBsqxnku632ZWb3CLpKQk31oyRF
b4sgsuXWoEbe/HeJ7zQ/sVwBhynqw56ZMfTKL1UaiMICIa6gXIQh3Wdm0nctLg12
f1tvHP6FwGHJJRUPBH1+6SWYrJ0GOquSm6E/1ljDWLC8VR5wcF7fq+/hZ6RXbOzj
OMu2RdtbYuVSKH/esS8vKGMr5E3IZuiQWfMGXaTmQkKy9XmWQB+S6XdjrImbZMYI
DvToomTRepAOWSIMUORniPJjpymaUEGhr82XafQBi8DEpohVvd0SKkq+PP+gZwne
TNh8hlJ8+cRjRVYWieVsXBWFV0K26BED8ZC0kTLmxFyTHljyyeL4DdgsjT3QueZU
8nu/cUXsaOXAkoRzgDaDC5Azw4M1wqKIbcWgDk26vOP2HpyZmVU=
=QstV
-----END PGP SIGNATURE-----

--imps7ep4na76fgmn--
