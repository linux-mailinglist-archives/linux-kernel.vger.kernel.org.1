Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD02A9962
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgKFQXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:23:11 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14C3C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:23:11 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AAB4B3D3; Fri,  6 Nov 2020 17:23:09 +0100 (CET)
Date:   Fri, 6 Nov 2020 17:23:08 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.10-rc2
Message-ID: <20201106162302.GA3084@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.10-rc2

for you to fetch changes up to 4dd6ce478003525df8618750d30f0b90380047a7:

  iommu: Fix a check in iommu_check_bind_data() (2020-11-03 14:55:51 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.10-rc2

Including:

	- Fix a NULL-ptr dereference in the Intel VT-d driver

	- Two fixes for Intel SVM support

	- Increase IRQ remapping table size in the AMD IOMMU driver. The
	  old number of 128 turned out to be too low for some recent
	  devices.

	- Fix a mask check in generic IOMMU code

----------------------------------------------------------------
Dan Carpenter (1):
      iommu: Fix a check in iommu_check_bind_data()

Liu Yi L (1):
      iommu/vt-d: Fix sid not set issue in intel_svm_bind_gpasid()

Liu, Yi L (1):
      iommu/vt-d: Fix a bug for PDP check in prq_event_thread

Lu Baolu (1):
      iommu/vt-d: Fix kernel NULL pointer dereference in find_domain()

Suravee Suthikulpanit (1):
      iommu/amd: Increase interrupt remapping table limit to 512 entries

 drivers/iommu/amd/amd_iommu_types.h | 6 +++++-
 drivers/iommu/intel/iommu.c         | 3 +++
 drivers/iommu/intel/svm.c           | 8 +++++++-
 drivers/iommu/iommu.c               | 2 +-
 4 files changed, 16 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl+leGYACgkQK/BELZcB
GuMk+g/8D/ZGF3MByeEcWyYydC+51XpLLS+g9uf9tSFIXJUhCJYfCN4m8RMP4I2h
IErgzsuLKMI6Jbn6qziYk+7VBRmUFKQsQ74vg+WgQkrhjn9dAFm+pE/ffRnF//fp
NAZe/Q310ovw4TohUaZhBrQWtRIu47zSw9sc1zbvvU2yeOfQFCuiCA3YxaLprU4/
Mi/Wc3RVJCTs7zbcmMg1V3bkuER+cOOkvZgIW38vcHBh4ykoSmuovGQT/uOHEege
9dYUv4Kalpl0d2fiwQhKgTE9Vlfm0FAofAl4JVkbCIylIP9kvVHyk6ys/ZQ0A1fg
pFke9xLLE8ihj/nI7I4mL6D43/mKEVQkkInHpX8ApVT0pX7tQsQ8oG/18kHsbMUo
V9rOoliSfqjAMhL8G+UyAJ7gyFHosEdZQ39irmEIsPYDgqETNyqCQZlh+DMg41+2
CjtRq3lGTK/63M1fmOAGhXhQh/XmJGyX89NXdN1A/miFloRyG9W+4Z6XDWU4+Kt+
dmBgEf/gL565J3jca/vNEXmqw3tx5h+1SA3KDHIvziKEHz1XsGrz8pLYVf7AOxMb
RLDIbTnHJUotpyrmy8M8+TNmXIQp9060fxMSzg4KP8/LJFuV9XkJqaoAhtSQbUlS
63b2OU7c/k/TsOynKcqL2uTlp4ie7HH3ZXSPmOyaSBjs/26ogkc=
=gPl6
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
