Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCF1D9B79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgESPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 11:40:47 -0400
Received: from 8bytes.org ([81.169.241.247]:44002 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgESPkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:40:47 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7A101286; Tue, 19 May 2020 17:40:46 +0200 (CEST)
Date:   Tue, 19 May 2020 17:40:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.7-rc6
Message-ID: <20200519154039.GA27645@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc6

for you to fetch changes up to bd421264ed307dd296eab036851221b225071a32:

  iommu: Fix deferred domain attachment (2020-05-19 15:05:43 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.7-rc6

All related to the AMD IOMMU driver, including:

	- ACPI table parser fix to correctly read the UID of ACPI
	  devices.

	- ACPI UID device matching fix.

	- Fix deferred device attachment to a domain in kdump kernels
	  when the IOMMU driver uses the dma-iommu DMA-API
	  implementation.

----------------------------------------------------------------
Alexander Monakov (1):
      iommu/amd: Fix over-read of ACPI UID from IVRS table

Joerg Roedel (1):
      iommu: Fix deferred domain attachment

Raul E Rangel (1):
      iommu/amd: Fix get_acpihid_device_id()

 drivers/iommu/amd_iommu.c      |  3 ++-
 drivers/iommu/amd_iommu_init.c |  9 +++++----
 drivers/iommu/iommu.c          | 17 +++++++++++------
 3 files changed, 18 insertions(+), 11 deletions(-)

Please pull.

Thanks,

	Joerg

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl7D/fQACgkQK/BELZcB
GuPR5xAAiPtEmj0wQrMYkn7R6ukRjQiphX+jjjHJgRzQOm3MSpFVJ2YkKUkMJ7fI
VxrK2BlZO03nHPRJMG1qERl8DZQZ7TMK7BIlcKAbVDTRhYslaXqqp7NT1Ctt3XaF
AqCe6WRaOz+PJQGSV4lmYgOCX5N5qkpj4NBnVbNxOuAKnr4f6utpOxdG3qYW5Qzf
mjya7kuKZb5+ppPWoq2r38JXo3xfMbZvyj2MsWqfkrtYdaZsWJm0jdnjshrnX5ma
xfvP0JGl149wAqlO2EnJmOVkrWuZxHNVvPrJAVv1vyQdE4DEy4A6+WH2hVsJBFUs
PtTxTvyvQpTlwY4hE/ZeUiwq52CAAzMOaii5xYwZ1+Lb6IX16+fN3pUTBwD4Y8Ia
zIokGp1M8XcKxYLgVsnRfIWWD2HAmifbZOi/ZZc2BMOR7Skqbvq4s6D+pHYhfuoG
1VOMsWUImTrvEVv6y0UwfYxhbO5rKCfzUh/6JS53sGnZmbkBAUAh9ynTYg9mFrpz
wFfP6KG8XtxyQdL6MYes7haq75yS/0UtaEAHWE8oC5CbtPcI2TDhD3dUFEjETp1k
d/0ZfRZTsOPK4mIvQYqVNRt9FkpAJQ5MlsyxAY5ux9bPyK46reCnJXp3bBAllglj
KEdcJwN8LHS4UDzjf8rA0X9evdEKeifY6/P47Vih7AZs7vm3YPg=
=dLUK
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
