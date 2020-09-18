Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6621C270090
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIRPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:11:01 -0400
Received: from 8bytes.org ([81.169.241.247]:45352 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRPK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:10:59 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 43459A8D; Fri, 18 Sep 2020 17:10:58 +0200 (CEST)
Date:   Fri, 18 Sep 2020 17:10:56 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.9-rc5
Message-ID: <20200918151051.GA31007@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc5

for you to fetch changes up to e97685abd5d711c885053d4949178f7ab9acbaef:

  iommu/amd: Restore IRTE.RemapEn bit for amd_iommu_activate_guest_mode (2020-09-18 11:17:19 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.9-rc5

Two fixes for the AMD IOMMU driver:

	- Fix a potential NULL-ptr dereference found by smatch

	- Fix interrupt remapping when a device is assigned to a guest
	  and AVIC is enabled.

----------------------------------------------------------------
Joao Martins (1):
      iommu/amd: Fix potential @entry null deref

Suravee Suthikulpanit (1):
      iommu/amd: Restore IRTE.RemapEn bit for amd_iommu_activate_guest_mode

 drivers/iommu/amd/iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl9kzfYACgkQK/BELZcB
GuPpIg//av7xkX3DUvOd7ZJf+Jd7q25MYp1V2h89/PvfkPPy/X05tJDt4N/MFzT8
qFi05Yl7kocTf7RhH5odvsaBF5x2DoF/7mmjJjBAesoJIye0BL2jugajiIyEOz8N
7cLItdClfs/cFjM9Qwux1NdsXnWThNywSpZRPpx279GGJZxwvV4B98MYOo/j1IY7
F41HWi3AeD/x1lnR3NuflnYv8TaTm7cZubzmimC9uOujbB1asBrIx1qVeqL3WP9K
QeXj8UeGaZFDWaYfRM+8RPP2fnqHQu6IyE0SuzyA2BsEh5qz59L0QUJ5vjauQt0N
IauNpKF8Yq04tHfnRyWnnbUgshM7WkTb+87i5ZVVf/EsXw8SCKKmfYLob/Ubb6mU
NI/a1F06IGFrMwvhMYE+GiHEP7JM7/g5/x1TmCj8XFXQhRpnMopoLNdLVjt8O64G
hStvr9OmM8y7ED//vUMdPAHnQKZ+CfXaG1TY5fJR8wIjTPMCow12S/6VG+klmJ26
XCrgoc0A1GCyxQKSOd4oJajcxW0/LBf7heUM7BjnHguEpDqEjNClYpU7FtiraR2Y
75SW5aIeIsx9WDR88pTRvBtu1IJ9pmXran0D1umsCPhQS4ULP/94APbLXmN8rObk
RACcOeWjDc+YDMj3YH9TS6O/8Y6VW+s08Mwnl1hDxrQpvzUfiLA=
=2y0U
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
