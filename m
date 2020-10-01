Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0C9280735
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgJASuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJASug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:50:36 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90013C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:50:36 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 76EA02C3; Thu,  1 Oct 2020 20:50:31 +0200 (CEST)
Date:   Thu, 1 Oct 2020 20:50:30 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.9-rc7
Message-ID: <20201001185024.GA3327@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc7

for you to fetch changes up to 1a3f2fd7fc4e8f24510830e265de2ffb8e3300d2:

  iommu/vt-d: Fix lockdep splat in iommu_flush_dev_iotlb() (2020-10-01 14:54:17 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.9-rc7

Including:

	- Fix a device reference counting bug in the Exynos IOMMU
	  driver.

	- Lockdep fix for the Intel VT-d driver.

	- Fix a bug in the AMD IOMMU driver which caused corruption of
	  the IVRS ACPI table and caused IOMMU driver initialization
	  failures in kdump kernels.

----------------------------------------------------------------
Adrian Huang (1):
      iommu/amd: Fix the overwritten field in IVMD header

Lu Baolu (1):
      iommu/vt-d: Fix lockdep splat in iommu_flush_dev_iotlb()

Yu Kuai (1):
      iommu/exynos: add missing put_device() call in exynos_iommu_of_xlate()

 drivers/iommu/amd/init.c     | 56 ++++++++------------------------------------
 drivers/iommu/exynos-iommu.c |  8 +++++--
 drivers/iommu/intel/iommu.c  |  4 ++--
 3 files changed, 18 insertions(+), 50 deletions(-)

Please pull.

Thanks,

	Joerg

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl92JPAACgkQK/BELZcB
GuMIhg/9GctD/xz7BHZMIkJKRrc71epdmDSh6+5ruSv3V/dzW1EU17Pv0IWjeOdF
dOpKUZzCCYYM6ra+4QHQ2CChHSWREj1kFKnilRV4E3DGXRY51lJCzIMjSOU4Prv1
frgx+3h1sVkigLjP9s+xXM9LsM72FO8p7eW+Bylr4s4lES4TX7V5uIiVdIY0900j
EtE7MeFK1cu/oONqVaNT5Wrqx6OaCH4DuPoOiyc/FhHQB/VVWckoto8Hbh2VxtTV
gWwzD++XyM8Vz+TkcxG0caIYNeplDmknIIVN9zqqprYrbsy8CO5hByNMGXjJmITd
HDIPuB64Ev8EeY2iWO5xQeBMXkP2Tf373Jqu34q8fe/Wfn8m97/1hYvFuJAEZqhv
+jvDvdYnaeUPnLNKfgK/vGIsJlW+JQjtJhQbfkCSP6flzPhsSxF6QF7ckkfuiX+c
vIiMLifggcT94ZLCl9/KAbx/axCBAvgmxvN+Cp3KD021frNMLLMuC9VmcgFYfixU
GS2akMdxWphS2d0rOjWm4S3H9RxO5+rPRRCQ+yzm/PtWCec0961kWyu66NEMc0W1
bTxcWV3HnSHKut8qbg/EAeFBAoWcpgMZig8AhyacKDQT52s9YTGK3iCRoBythFr3
Hu21BUfjspw/7bcvm8772AhS3fHKFyyGijAcAguFLlfTwf/IDO4=
=ChUR
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
