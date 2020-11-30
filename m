Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C382C8B92
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbgK3Rop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:44:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47036 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK3Roo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:44:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AUHgwKd087139;
        Mon, 30 Nov 2020 11:42:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606758178;
        bh=ebyvGHgxYnsMErdJ7gl06ypcszQPPlEmdBFZ0QPGf0U=;
        h=Date:From:To:CC:Subject;
        b=EiABBD0jP87tzD9BLjSF7xJCPEH8/OQhsIvpGRcGijW0P53GLquyehIXvuRdeUEZl
         SGrDBPNixvZFUew7UJWoMLX14BLmsQhx3V4kP2hSd4+iig7jHTYcAtOka/LHIUnOhH
         wSUVkgnjudvmRn2H9BMEFDB93OlCQEXHdVA+UHMA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AUHgwmu084893
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 11:42:58 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 30
 Nov 2020 11:42:58 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 30 Nov 2020 11:42:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AUHgwIn011091;
        Mon, 30 Nov 2020 11:42:58 -0600
Date:   Mon, 30 Nov 2020 11:42:58 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <t-kristo@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] arm64: TI K3 DT updates for v5.11
Message-ID: <20201130174258.ljsiokkyr7x7tsbd@covenant>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lc77dsi6dcg2y3ab"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--lc77dsi6dcg2y3ab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull the following for TI K3 dts changes for v5.11 window.

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git tags/ti-k3=
-dt-for-v5.11

for you to fetch changes up to cd48ce86a4d0c1ffec86aa46a26da993c9af5f53:

  arm64: dts: ti: k3-j721e-common-proc-board: Add support for SD card UHS m=
odes (2020-11-30 07:12:54 -0600)

----------------------------------------------------------------
Devicetree changes for TI K3 platforms for v5.11 merge window:

- Standardized usage of "disabled" only in board.dts files, #interrupt-cell=
s warning fixups, node format error fixes

- J721E: R5F support, MMC/SD UHS mode added

- AM654: R5F support, dss marked coherent, drop unused dma-ring-reset-quirk=
 property

- J7200: ADC support, Mailbox, hwspinlock

----------------------------------------------------------------
Faiz Abbas (2):
      arm64: dts: ti: k3-j721e-main: Add output tap delay values
      arm64: dts: ti: k3-j721e-common-proc-board: Add support for SD card U=
HS modes

Grygorii Strashko (1):
      arm64: dts: ti: k3-am65: ringacc: drop ti, dma-ring-reset-quirk

Nishanth Menon (6):
      arm64: dts: ti: k3-am65*/j721e*: Fix unit address format error for ds=
s node
      arm64: dts: ti: k3-am65*: Cleanup disabled nodes at SoC dtsi level
      arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at SoC dtsi level
      arm64: dts: ti: am65/j721e: Fix up un-necessary status set to "okay" =
for crypto
      arm64: dts: ti: k3-am654-base-board: Fix up un-necessary status set t=
o "okay" for USB
      arm64: dts: ti: am65/j721e/j7200: Mark firmware used uart as "reserve=
d"

Peter Ujfalusi (2):
      arm64: dts: ti: k3-j7200-som-p0: main_i2c0 have an ioexpander on the =
SOM
      arm64: dts: ti: k3-j7200-common-proc-board: Correct the name of io ex=
pander on main_i2c1

Sekhar Nori (1):
      arm64: dts: ti: k3: squelch warning about lack of #interrupt-cells

Suman Anna (11):
      arm64: dts: ti: k3-am65-mcu: Add MCU domain R5F cluster node
      arm64: dts: ti: k3-am654-base-board: Add mailboxes to R5Fs
      arm64: dts: ti: k3-am654-base-board: Add DDR carveout memory nodes fo=
r R5Fs
      arm64: dts: ti: k3-am654-base-board: Reserve memory for IPC between R=
5F cores
      arm64: dts: ti: k3-j721e-mcu: Add MCU domain R5F cluster node
      arm64: dts: ti: k3-j721e-main: Add MAIN domain R5F cluster nodes
      arm64: dts: ti: k3-j721e-som-p0: Add mailboxes to R5Fs
      arm64: dts: ti: k3-j721e-som-p0: Add DDR carveout memory nodes for R5=
Fs
      arm64: dts: ti: k3-j7200-main: Add hwspinlock node
      arm64: dts: ti: k3-j7200-main: Add mailbox cluster nodes
      arm64: dts: ti: k3-j7200-som-p0: Add IPC sub-mailbox nodes

Tomi Valkeinen (1):
      arm64: dts: ti: k3-am65: mark dss as dma-coherent

Vignesh Raghavendra (1):
      arm64: dts: ti: k3-j7200-mcu-wakeup: Enable ADC support

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  13 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  43 ++++++-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |  71 +++++++++--
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     |  33 ++---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          | 114 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |  19 +++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  94 ++++++++++++++
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |  83 ++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          | 135 +++++++++++++++--=
----
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  42 ++++++-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        | 110 ++++++++++++++++-
 11 files changed, 682 insertions(+), 75 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--lc77dsi6dcg2y3ab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAl/FLxoACgkQ3bWEnRc2
JJ0dwQ/9E6A8kNv/FLxk0bcnYo56UgXVIdmiJu2H2jz0XnbfBMPUoZAYRsCTwqpQ
6qRAzv3lePH0hm0741TnocgPliPm9tAKcuJaw3y3poc7LKR77B8vL1H6tKnHXqxh
6/ZB6Pk+IN390PukCvoE1yfpevTmPRxn5FqKYKgVWPTSHdkEKSeRj1Ea2YVDRzL1
jH4UOVLaJ7OtQyTjWbRP1u/FxhZhKZ5eSb/pW36zx5dJXkybhJlzyb+yCDWylwrN
p8iRaZTnKswqVhu1b8VO/tknzNnUFGfM0n1ShMnKASpkIIpgKTfLEPIVz/VMvYLA
wXW+XrMUGLq/vj3fvl9uUV5yWA2tMeEUDSbxHsH1s3ArZt0HdCr6f2s9cTaPGv4M
QAN38Geh5xfzjWJupEeg9kGeB1ZG2y/spkx0Za/ZE2BnIAuKyEZpyNd24OiE86mc
Td414CUSdPOFpL/HcZ4udneo1qYT50Xx+5wxH4TOFyiJwsmWgZsa3mjhxgyDxB3D
p1DDymBJy1qT9+/jtH49ko0gw3ype7GivYUm8o8tk2F/qCgQAqMxY1/uoMrL69BE
qp9lOzhYXJK4A+tr2yDWb5L6usU3DVyQiw+8hfH84ljjxoPqvXuejNrpNKvZg/SW
zoeaStQs+10EUsk4A3IJVenS/u12oDQrs16QOOmJfiFZ1qN4xiE=
=hR4o
-----END PGP SIGNATURE-----

--lc77dsi6dcg2y3ab--
