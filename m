Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A585292AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgJSPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgJSPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:44:26 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB9C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:44:26 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8F2554C3; Mon, 19 Oct 2020 17:44:24 +0200 (CEST)
Date:   Mon, 19 Oct 2020 17:44:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux since iommu-updates-v5.10
Message-ID: <20201019154418.GA25261@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 7e3c3883c381aeda903778d7e99fc4cd523be610:

  Merge branches 'arm/allwinner', 'arm/mediatek', 'arm/renesas', 'arm/tegra', 'arm/qcom', 'arm/smmu', 'ppc/pamu', 'x86/amd', 'x86/vt-d' and 'core' into next (2020-10-07 11:51:59 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.10

for you to fetch changes up to 9def3b1a07c41e21c68a0eb353e3e569fdd1d2b1:

  iommu/vt-d: Don't dereference iommu_device if IOMMU_API is not built (2020-10-19 14:16:02 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v5.10:

	- Fix a build regression with !CONFIG_IOMMU_API

----------------------------------------------------------------
Bartosz Golaszewski (1):
      iommu/vt-d: Don't dereference iommu_device if IOMMU_API is not built

 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl+NtFIACgkQK/BELZcB
GuN+1g/5AQencd67ugSp9xsZdB7mnHk0zO/8tfyxx0PWsX1/QrWbs8vVs8xzHGhA
1WbLXLzTJwlbJWy0+np26U3/B6Y3AhP3ugBmdu5UMC87Zeyi3aXNhMCaLoTAkCnu
KKiTCMQDXY1E7T8ocUExgBtCO8M3NAlWCAgBHDMcI9SAeYbsIpGT/lVyloGPEoMk
tyGJNKa5msxUhXPiDps3UgPrMgBy0ghDwcr2ErURXOQZdL7wa+fWPPkTaF5KSzS7
+ASBNwALqOECQe6bmOhQ9OGiVlvgA3RkLl7Ep4DdcaUGc6nAseYsFD4LLDEnWAPe
Uvhjyrbs9iyhCRxVG77s+fyyPt0ppEis/gIqjD0mbh1NvGRJc//davvB2FtR/fiA
JcrAb9zj6QjOYcaCtRUQUjALe5hXe0N32vHygNwDapQdg80d4W2nL95vFbDg1s8t
EGFWVoCfD4oc2hQIG/AOpzlaR/g6Mlg+guaaC7wZtn103yVtJMphTYoiwdcrSJYx
EtWWSAq02L4+lyHp3h2tUW4MMEeUggtC5B+F7WbkA7M6mh0y1oNCm9DfK5RVbn6i
aJTaCEwg/wgwnk+AiUttO+DoNXR8EZPPc0isnMdIOj2EYTtOwNi9JkTRFZ+eFvAN
LlcqpmOkJ3RpvRjFO5K8qrnEfHPjs7xAHSYSUSq8DjNMFX6WfdA=
=FsUY
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
