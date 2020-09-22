Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3406274373
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIVNri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:47:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59672 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVNri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:47:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08MDlNAS052939;
        Tue, 22 Sep 2020 08:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600782443;
        bh=fAyQZ7elzBl6I1cjgQaG39fhlMZO3dkZE9iUXTvmgfY=;
        h=Date:From:To:CC:Subject;
        b=nKggUnn5gXIYlojYovbvybfmxUP6uSq8VcfyaBhIb3XAupSL77Lp8gaBRR5B2KSot
         xryXq1Rp52izPLVK+IvXqz8/DziD8icUi+9oURzQfzOBFKhXi0j8AlZF7E1cIUCUVE
         tLUwgtXI/Ee23q2GmjLMVKO6Nyhw2KazlHmMxqq4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08MDlNho030940
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 08:47:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Sep 2020 08:47:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Sep 2020 08:47:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08MDlMG8111593;
        Tue, 22 Sep 2020 08:47:22 -0500
Date:   Tue, 22 Sep 2020 08:47:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <t-kristo@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>,
        Suman Anna <s-anna@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham Israel Vijayponraj <kishon@ti.com>
Subject: [GIT PULL] arm64: TI K3 DT updates for v5.10
Message-ID: <20200922134722.2y5kqxu4lghbwp5u@akan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6xxoxz5j6hkbmwm"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--t6xxoxz5j6hkbmwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull the following for 5.10 cycle (had to base on 5.9-rc3 due to
a bad dependency):
	- dts fixups for dtbs_check and W=3D2 build of dtbs, node names.
	- am654 adds crypto nodes and an erratum workaround for PCIe(down to Gen2)
	- j721e adds C66, C71 DSP and PCIe nodes

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git tags/ti-k3=
-dt-for-v5.10

for you to fetch changes up to 66db854b1f62dbee48ec7373f149fa30e4b3dd4e:

  arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe instances =
(2020-09-22 08:19:47 -0500)

----------------------------------------------------------------
Device tree updates towards 5.10-rc1 for TI K3 platform.

----------------------------------------------------------------
Keerthy (2):
      arm64: dts: ti: k3-am6: Add crypto accelarator node
      arm64: dts: ti: k3-j721e-main: Add crypto accelerator node

Kishon Vijay Abraham I (2):
      arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
      arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe instan=
ces

Nishanth Menon (8):
      arm64: dts: ti: k3-j721e: Use lower case hexadecimal
      arm64: dts: ti: k3-am65-main: Use lower case hexadecimal
      arm64: dts: ti: k3-am65*: Use generic gpio for node names
      arm64: dts: ti: k3-am65*: Use generic clock for syscon clock names
      arm64: dts: ti: k3-*: Use generic pinctrl for node names
      arm64: dts: ti: k3-am65-base-board Use generic camera for node name i=
nstead of ov5640
      arm64: dts: ti: k3-am65-wakeup: Use generic temperature-sensor for no=
de name
      arm64: dts: ti: k3-*: Fix up node_name_chars_strict warnings

Sekhar Nori (1):
      arm64: dts: ti: k3-am65: restrict PCIe to Gen2 speed

Suman Anna (10):
      arm64: dts: ti: k3-am65: Fix interconnect node names
      arm64: dts: ti: k3-j721e: Fix interconnect node names
      arm64: dts: ti: k3-j721e-som-p0: Move mailbox nodes from board dts fi=
le
      arm64: dts: ti: k3-j721e-main: Add C66x DSP nodes
      arm64: dts: ti: k3-j721e-som-p0: Add mailboxes to C66x DSPs
      arm64: dts: ti: k3-j721e-som-p0: Add DDR carveout memory nodes for C6=
6 DSPs
      arm64: dts: ti: k3-j721e-main: Add C71x DSP node
      arm64: dts: ti: k3-j721e-som-p0: Add mailboxes to C71x DSP
      arm64: dts: ti: k3-j721e-som-p0: Add DDR carveout memory nodes for C7=
1x DSP
      arm64: dts: ti: k3-j721e-som-p0: Reserve memory for IPC between RTOS =
cores

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  52 +++-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |   4 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |   6 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi                |   6 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |  18 +-
 .../boot/dts/ti/k3-am654-industrial-thermal.dtsi   |  12 +-
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     | 191 ++++++-------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          | 301 +++++++++++++++++=
+++-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |   4 +-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        | 155 ++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi               |  11 +-
 11 files changed, 608 insertions(+), 152 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--t6xxoxz5j6hkbmwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAl9qAGMACgkQ3bWEnRc2
JJ0q+g//feLgMlV0jxEVB5zA5jDdsxbU0DEjeIn33jzXTE4zHlX2G1GtjYV/vq2l
MMUpgqJ+5U4O3HsEP0K/H1v0idXZwyTYHz3+otPgai/teXCYvXzvKwNvAytEllD0
5DOL0J2YAmmkgPLqDu5f1Zxj63uKoLfaLoF1yM3pyKpmRYrtNYm2OcLka5+9KpqZ
2gHxDN6gvUmA4JxL+p9aHYXJ57QPGdeXwCwhyxaT/on5XMd7up6d0RU3dVGf2pq1
8lFzvxlOB5Sr66DDqF3uwU+Ps1WJ026kueLFfPyrphKh8DdCR1eh3mGL1k1sgNUS
4SCHFwIP8OwZ1ldCIionGt1yfUouHhTMZhwVkUWgOJw70X+WJ2T7m7FY3Yy2/G0W
tEd/7IUzjg7ssZWoRLeswQIoKVOsP0sNfKDr3vd4CGEOCL2+WJVcUybECoL9/PGX
fD4MS3/3pQLNLmX0W5zHzSFJoi3048YYuDb1n69HBM8RdS9jgF6WhBWYAZxAeHYH
RXFGdyjD2SCAkiQdOQZ1t9gpquX8prbw/FmymTayZLVlE2DYmb0Q3qs53DLyozxk
0WvfEb1aXT9Cni2LaYWBJwXk8CygopPLPlctz3roRMUY/V+2TYjy5aPIO5c0P5f2
sUGcA/PpGRixFWC8a0CsrKjjWK/lTfY+S1hIz82MkH8nz/Y8H5o=
=yXKB
-----END PGP SIGNATURE-----

--t6xxoxz5j6hkbmwm--
