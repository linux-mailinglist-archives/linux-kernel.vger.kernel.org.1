Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3589B22EBAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgG0MFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 08:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgG0MFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:05:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B457C20663;
        Mon, 27 Jul 2020 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595851515;
        bh=r1kUcZmdouTSseteZGhdHYEGdV/gZ5NwF+sWDuAMOnM=;
        h=Date:From:To:Cc:Subject:From;
        b=fgIlfaG2lMAUS1E0ldkFwcqu4K50rN68s8Msg5/hB+gWmiciFrohRD/NLtRt3NCc3
         tCuDaxsfmzeQjRZZT+g590lyN64EnXni4Xq/qlXx+gqX/AwXxBI7/GM4AOBv/veD5P
         O8dZGa64VIxZ2Ud/V0iVkF7i58hLlBx/oHDMxP58=
Date:   Mon, 27 Jul 2020 13:05:11 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Move driver files into their own subdir
Message-ID: <20200727120510.GA20662@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

As requested in [1], here is a second Arm SMMU pull request for 5.9, moving
the driver files into their own subdirectory to avoid cluttering
drivers/iommu/.

Cheers,

Will

[1] https://lore.kernel.org/r/20200722133323.GG27672@8bytes.org

--->8

The following changes since commit aa7ec73297df57a86308fee78d2bf86e22ea0bae:

  iommu/arm-smmu: Add global/context fault implementation hooks (2020-07-20 09:30:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to e86d1aa8b60f7ea18d36f50296d7d20eb2852e7e:

  iommu/arm-smmu: Move Arm SMMU drivers into their own subdirectory (2020-07-27 12:53:10 +0100)

----------------------------------------------------------------
More Arm SMMU updates for 5.9

- Move Arm SMMU driver files into their own subdirectory

----------------------------------------------------------------
Will Deacon (1):
      iommu/arm-smmu: Move Arm SMMU drivers into their own subdirectory

 MAINTAINERS                                        | 4 ++--
 drivers/iommu/Makefile                             | 5 +----
 drivers/iommu/arm/Makefile                         | 2 ++
 drivers/iommu/arm/arm-smmu-v3/Makefile             | 2 ++
 drivers/iommu/{ => arm/arm-smmu-v3}/arm-smmu-v3.c  | 0
 drivers/iommu/arm/arm-smmu/Makefile                | 4 ++++
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-impl.c   | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-nvidia.c | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-qcom.c   | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu.c        | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu.h        | 0
 drivers/iommu/{ => arm/arm-smmu}/qcom_iommu.c      | 0
 12 files changed, 11 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/arm/Makefile
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/Makefile
 rename drivers/iommu/{ => arm/arm-smmu-v3}/arm-smmu-v3.c (100%)
 create mode 100644 drivers/iommu/arm/arm-smmu/Makefile
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-impl.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-nvidia.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-qcom.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu.h (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/qcom_iommu.c (100%)
