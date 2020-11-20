Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE22BAC38
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgKTOvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgKTOvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:51:46 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F38D62224C;
        Fri, 20 Nov 2020 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605883905;
        bh=DVOSTqofBXjBb4+l//ZNmIGzjZCsdzjYuyDg2tXkbSg=;
        h=Date:From:To:Cc:Subject:From;
        b=01BCN47gBQw1atU1oo8GDd0bz3Kj0JRz09h/HcYqMXiSmJeG8ONIfMpuCyje2d35+
         A5vp1BVuVOVEtzswuquZ1t9vkxKfuOtl64fMbuZXs6KvPpVeNuC498Yd31rfy5m24F
         E8YZm+Lz3CQliymufsNLEiWoNZE1Yb22suh8wjV4=
Date:   Fri, 20 Nov 2020 20:21:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL]: Generic phy fixes for 5.10
Message-ID: <20201120145136.GK2925@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg

Please consider PULL to recive fixes for 5.10 for Generic phy.
All minor fixes to drivers, already in linux-next

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-5.10

for you to fetch changes up to fb89b2544b645527b3a359176999a416e65f5ada:

  phy: mediatek: fix spelling mistake in Kconfig "veriosn" -> "version" (20=
20-11-16 13:21:28 +0530)

----------------------------------------------------------------
phy: fixes for 5.10

Bunch of fixes for phy drivers:
*) USB phy incorrect clearing of bits
*) Tegra xusb dangling pointer
*) qcom-qmp null ptr initialization
*) cpcap-usb irq flags
*) intel kkembay kconfig depends
*) qualcomm OF dependency
*) mediatek typo

----------------------------------------------------------------
Al Cooper (1):
      phy: usb: Fix incorrect clearing of tca_drv_sel bit in SETUP reg for =
7211

Bryan O'Donoghue (2):
      phy: qualcomm: usb: Fix SuperSpeed PHY OF dependency
      phy: qualcomm: Fix 28 nm Hi-Speed USB PHY OF dependency

Colin Ian King (1):
      phy: mediatek: fix spelling mistake in Kconfig "veriosn" -> "version"

Geert Uytterhoeven (1):
      phy: intel: PHY_INTEL_KEEMBAY_EMMC should depend on ARCH_KEEMBAY

Marc Zyngier (1):
      phy: tegra: xusb: Fix dangling pointer on probe failure

Stephen Boyd (1):
      phy: qcom-qmp: Initialize another pointer to NULL

Zou Wei (1):
      phy: cpcap-usb: Use IRQF_ONESHOT

 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 5 -----
 drivers/phy/intel/Kconfig                         | 2 +-
 drivers/phy/mediatek/Kconfig                      | 2 +-
 drivers/phy/motorola/phy-cpcap-usb.c              | 3 ++-
 drivers/phy/qualcomm/Kconfig                      | 4 ++--
 drivers/phy/qualcomm/phy-qcom-qmp.c               | 2 +-
 drivers/phy/tegra/xusb.c                          | 1 +
 7 files changed, 8 insertions(+), 11 deletions(-)

Thanks
--=20
~Vinod

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl+31/gACgkQfBQHDyUj
g0d3QA/9EAXFCXfgcsBp+/D2AUS+44ILx3rJs9tqVMde4LuiMdC3wp2pgnK/+/57
34j36BGZG4oCzdyuJgkietTQdIQ5rf9m9Xq2R2zq/yKVgd68IBk8zVJBBDTI+sXi
NR0o2n8i8gz5bafjD+FBaIS21qJk4ObgQ1CAnhl4fJhHQRGICo7YHs/A63ko5sLl
uYUXili7gPLny+WmUnptyUSU2aLCxUiX1Bp9Pq+5BzpDq8y3EBpsbS1Jv3cJTZSU
T5O8pgGG4uIU9owioD8aUDHFc5EKUOaSzf5Wh4L8EfiNN9DS6B1Fs4ow4NlIAjmf
EfIiuUoTT584zw8jo+flEeYAElrrtgdJ+hcf26T+F9tuAlpZP6RmVT4tlhILv9Kh
HgP1nQxi9PpiKnAKQy4OPMET3hXSAASZ+kLAlEH/rKBLZusRMWtKLTe59E1bZ38R
DUUskcproTo4cJouenyWp9EIFgZ/1iBDJoyOhJrNCaRR0XCKutltx851eVClHHsq
UiVFDzR67oG4DaPjxpKJYHVygfiiSmQeVuy2NaDXvwvsmXvpI5CDwXD0uAhP1L0h
X3db6ks9ZRVm4Q3Mr9O7ecjFOErsfm8TsVPDMVEgZ0nZeiBefNZaZljx06NiY3a6
0DPEQF2BZ1nQtkuuzJQfpA8tHnWn7meto3qaory1hEa8y58arGo=
=ymmM
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
