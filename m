Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A832BACC3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgKTPFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbgKTPFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:05:22 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CEA22226;
        Fri, 20 Nov 2020 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605884721;
        bh=xosrCDLZZkcuUN8AwaezNyIm0NI3qb+9o6LpnIuVDtI=;
        h=Date:From:To:Cc:Subject:From;
        b=NFbm+mha/sFE3bkxLzqWdR7f4xQS8TfkMsayMfymz9Ab1Uzmw/O27+enPJkM4tR0w
         2AtWu+3yENDKBYmcW69/4b1ZxgTV2rXQCheQVa45siw7JMOueqhLPDxONNwIQxfprI
         0pszY3OPGUAQJerJJ4hsrefTl99Y8LZF0RbCAadU=
Date:   Fri, 20 Nov 2020 20:35:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.10-rc5
Message-ID: <20201120150512.GL2925@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus

Please consider pull to receive the dmaengine subsystem fixes for
v5.10-rc5

The includes a solitary core fixes and few driver fixes. All the patches
are in linux-next

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.10-rc5

for you to fetch changes up to 7e4be1290a38b3dd4a77cdf4565c9ffe7e620013:

  dmaengine: fix error codes in channel_register() (2020-11-18 17:51:51 +05=
30)

----------------------------------------------------------------
dmaengine fixes for v5.10-rc5

Core:
*) channel_register error handling

Driver fixes for:
*) idxd: wq config registers programming and mapping of portal size
*) ioatdma: unused fn removal
*) pl330: fix burst size
*) ti: pm fix on busy and -Wenum-conversion warns
*) xilinx: SG capability check, usage of xilinx_aximcdma_tx_segment,
readl_poll_timeout_atomic variant

----------------------------------------------------------------
Arnd Bergmann (1):
      dmaengine: ti: k3-udma: fix -Wenum-conversion warning

Dan Carpenter (1):
      dmaengine: fix error codes in channel_register()

Dave Jiang (2):
      dmaengine: idxd: fix wq config registers offset programming
      dmaengine: idxd: fix mapping of portal size

Lukas Bulwahn (1):
      dmaengine: ioatdma: remove unused function missed during dma_v2 remov=
al

Marc Ferland (1):
      dmaengine: xilinx_dma: use readl_poll_timeout_atomic variant

Matthew Murrian (2):
      dmaengine: xilinx_dma: Fix usage of xilinx_aximcdma_tx_segment
      dmaengine: xilinx_dma: Fix SG capability check for MCDMA

Sugar Zhang (1):
      dmaengine: pl330: _prep_dma_memcpy: Fix wrong burst size

Tony Lindgren (1):
      dmaengine: ti: omap-dma: Block PM if SDMA is busy to fix audio

 drivers/dma/dmaengine.c          | 17 +++++++++--------
 drivers/dma/idxd/device.c        | 31 +++++++++++++++----------------
 drivers/dma/idxd/idxd.h          |  3 ++-
 drivers/dma/idxd/init.c          |  5 +++++
 drivers/dma/idxd/registers.h     | 25 +++++++++++++++++++++++--
 drivers/dma/idxd/submit.c        |  2 +-
 drivers/dma/ioat/dca.c           | 10 ----------
 drivers/dma/pl330.c              |  2 +-
 drivers/dma/ti/k3-udma-private.c |  2 +-
 drivers/dma/ti/omap-dma.c        | 37 ++++++++++++++++++++++++-------------
 drivers/dma/xilinx/xilinx_dma.c  | 40 ++++++++++++++++++++++++++++++------=
----
 11 files changed, 111 insertions(+), 63 deletions(-)

Thanks
--=20
~Vinod

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl+32ygACgkQfBQHDyUj
g0c+VBAAtUKWTT9RrCa5XoSmddE6VjkajeGEkk9rGadIkDTIZtd8OGqMYFq1c0yP
WrsDFHgbA1UbFEk2qnpn3/weWI13NuryCy2JDAPYNj1Xb4Bdlup+KnSl31a7VbTx
ojiutL+Y2fhBPs1SqRnERdP3igwIYILGJubLixlgfOnSkcosZcCl4F/LT7Qm2iqZ
XLEkAEspZP2MGCYbIzF8sZKyvqjtIeVHeh5jvEHULwoiELbtbvUDLYpy2CifO/G9
J+OBF2j+0wiMxcaUrRhxE2+i88OmkjBsiWLOyW/bz7omu5FUkeVzLfikHJgNf3gy
1QRpOKyf1ocG2djfmzYTZSvTw4oRD4+fdweT7Q8tbTPrOBkayyNRlx6u3/bKCqDk
etFTVFdgt51bN1QBcdepj3aK5X8nA22bvQqRTX7BHx7omGPggi25XTwWN2USQBF4
9jgCSHLx494ME98gawLldxRPNr0dsRUqKv1cKOzlyqcG07ziDg0MQqFNpVxfhdPd
dEojlY8Y0pGAsTZA1ce2Ub5w18u7qrCZd4x9OcDHzB1IIucyNBybjaGQHeN297zA
XrtauH1Hb4+JKESSwZlZI3w1ahsJlX8OeEX0IvNWbgymF2HOgtGirAvyYNmOuaWq
Y3/6c1JOxtoIKB2XxeHRDmxApJORy2wMuEiLedgP4kAkdg7q3fo=
=4o4H
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
