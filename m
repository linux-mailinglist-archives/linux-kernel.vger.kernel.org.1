Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994882DEDB0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 08:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLSHUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 02:20:25 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:33794 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgLSHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 02:20:25 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 636C820117A;
        Sat, 19 Dec 2020 07:19:42 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id E48FE20AFE; Sat, 19 Dec 2020 08:18:38 +0100 (CET)
Date:   Sat, 19 Dec 2020 08:18:38 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] pcmcia updates for v5.11
Message-ID: <X92pTkP2CWpp/RyQ@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AxR4wce5dVZGYAq"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AxR4wce5dVZGYAq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

The following changes since commit b3298500b23f0b53a8d81e0d5ad98a29db71f4f0:

  Merge tag 'for-5.10/dm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm (2020-12-04 13:28:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

for you to fetch changes up to 70d3a462fc244b0580268cc8e6c47ae4463db68a:

  pcmcia: omap: Fix error return code in omap_cf_probe() (2020-12-05 09:59:13 +0100)


Besides a few PCMCIA odd fixes, the NEC VRC4173 CARDU driver is
removed, as it has not compiled in ages.


Thanks,
	Dominik


----------------------------------------------------------------
Christophe JAILLET (1):
      pcmcia/electra_cf: Fix some return values in 'electra_cf_probe()' in case of error

Jason Yan (1):
      pcmcia: db1xxx_ss: remove unneeded semicolon

Sebastian Andrzej Siewior (1):
      pcmcia: Remove NEC VRC4173 CARDU

Wang ShaoBo (1):
      pcmcia: omap: Fix error return code in omap_cf_probe()

 drivers/pcmcia/Kconfig         |   4 -
 drivers/pcmcia/Makefile        |   1 -
 drivers/pcmcia/db1xxx_ss.c     |   2 +-
 drivers/pcmcia/electra_cf.c    |   2 +
 drivers/pcmcia/omap_cf.c       |   8 +-
 drivers/pcmcia/vrc4173_cardu.c | 591 -----------------------------------------
 drivers/pcmcia/vrc4173_cardu.h | 247 -----------------
 7 files changed, 9 insertions(+), 846 deletions(-)
 delete mode 100644 drivers/pcmcia/vrc4173_cardu.c
 delete mode 100644 drivers/pcmcia/vrc4173_cardu.h

--7AxR4wce5dVZGYAq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAl/dqU4ACgkQmpdgiUyN
ow0YbQ/9E0ha7t1r4VTmPkgvtJU6XPhY7/P6Qn5R8iFV9VDt+eM5oJroW3pDHogt
NyIvdpEWr8N6fUVYqy0CeTFZedRd/ixzmlyLwWjeiQ9qTdkpCNQrj5DAeBs4p6Rj
5gwLkWGYnDLtkFT6tFz8pbBSPa+el1pDtqZ355SrhKTdqxbxbfwOS1uRuGc6CGeT
bM1aBfmlRcn8VEsQH0KG29QUoTMvC5sFVkTRl5xfbe7F4f+PamIptFiYvRToOfpi
mJMPyiPt9f1PbMb/WzEkSxMpYffgkEKATrjxnUfjEq/LLH951jqU+nr755NXnqm3
YJmsOKvt6Odi/ADlBdU4Nulz0EWg7zdP/6h/3sqHSbvYOzyx7i7r13MU4TCajmgI
+bKNsH3Rz+Vm66KdsHrhV0f6kD0NHz7cUrjIr6csJ/LxwToFDxgBaySuY7RWUll1
eNP1u2n5m4unkGBEAzRRdwcrzrrSp07NXdKfLYFFknjg7t27/KOJcp6mW/2Dxr5L
njgUoqVIm0NKmaa/aTloeaFrfGHjLPX06dGQ+2Dr1fD0+0bGWzIQBMUywsO0K/aT
Q2klgiXaKwa6ZwsMmFIezyBfETC47eLSr8Lu+VeRfrCUzw5OiIBKtPAM8mqe8IGV
hBlGHPTN237Rxrsllj3o9oUSpYB7lJRhyThwqVlPt14ksahnkvU=
=//Tm
-----END PGP SIGNATURE-----

--7AxR4wce5dVZGYAq--
