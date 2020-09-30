Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16A927E347
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgI3IF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgI3IF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:05:29 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 615432072E;
        Wed, 30 Sep 2020 08:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601453128;
        bh=7JYxs9JSU+BxuljUNkjSTE7tyNPi9bfc9U9063UfASs=;
        h=Date:From:To:Cc:Subject:From;
        b=1tq323Rfi4bfF5jkhFvFM3www8VuwlCCwtOEL6rGlNhu9BVfipz23YgAs7FSDf8/1
         lNK4uVkB1Ojn4kD4vgb3BFHRWe7dz3XyrifwR5RPXUaLFMTzvqs+8ZK2qe3glwFlYj
         OSMCVo3Sax9FkjMYbNtdzoZMUcuMw2eu3uQT2aMA=
Date:   Wed, 30 Sep 2020 09:05:23 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.10
Message-ID: <20200930080523.GA15805@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these arm-smmu updates for 5.10. Summary in the tag, but the
big thing here is the long-awaited SVM enablement from Jean-Philippe.
We're not quite done yet, but this pull extends the SMMUv3 driver so that
we're very close to being able to share page-tables directly with the CPU.

Other than that, there are a couple of things to note:

  1. My PGP subkeys expired. I've updated them here:

	https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/3E542FD9.asc

     and I've also mailed an updated copy for inclusion in the pgpkeys
     repository on kernel.org, but it hasn't landed yet:

	https://lore.kernel.org/keys/20200929222707.GA14916@willie-the-truck/T/#u

  2. The SVM enablement has a dependency on some ASID allocation rework
     in the arm64 tree, so I made a shared branch and pulled that in here
     too.

Please shout if you run into any problems.

Will

--->8

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to e2eae09939a89e0994f7965ba3c676a5eac8b4b0:

  iommu/qcom: add missing put_device() call in qcom_iommu_of_xlate() (2020-09-29 16:25:52 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.10

- Continued SVM enablement, where page-table is shared with CPU

- Groundwork to support integrated SMMU with Adreno GPU

- Allow disabling of MSI-based polling on the kernel command-line

- Minor driver fixes and cleanups (octal permissions, error messages, ...)

----------------------------------------------------------------
Barry Song (3):
      iommu/arm-smmu-v3: replace symbolic permissions by octal permissions for module parameter
      iommu/arm-smmu-v3: replace module_param_named by module_param for disable_bypass
      iommu/arm-smmu-v3: permit users to disable msi polling

Jean-Philippe Brucker (9):
      iommu/arm-smmu-v3: Fix endianness annotations
      arm64: mm: Pin down ASIDs for sharing mm with devices
      arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
      iommu/io-pgtable-arm: Move some definitions to a header
      iommu/arm-smmu-v3: Move definitions to a header
      iommu/arm-smmu-v3: Share process page tables
      iommu/arm-smmu-v3: Seize private ASID
      iommu/arm-smmu-v3: Check for SVA features
      iommu/arm-smmu-v3: Add SVA device feature

Jordan Crouse (3):
      iommu/arm-smmu: Pass io-pgtable config to implementation specific function
      iommu/arm-smmu: Add support for split pagetables
      iommu/arm-smmu: Prepare for the adreno-smmu implementation

Rob Clark (1):
      iommu/arm-smmu: Constify some helpers

Will Deacon (1):
      Merge branch 'for-next/svm' of git://git.kernel.org/.../arm64/linux into for-joerg/arm-smmu/updates

Yu Kuai (1):
      iommu/qcom: add missing put_device() call in qcom_iommu_of_xlate()

Zenghui Yu (1):
      iommu/arm-smmu-v3: Fix l1 stream table size in the error message

Zhou Wang (1):
      iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer

 MAINTAINERS                                     |   3 +-
 arch/arm64/include/asm/barrier.h                |   1 +
 arch/arm64/include/asm/io.h                     |   1 +
 arch/arm64/include/asm/mmu.h                    |   3 +
 arch/arm64/include/asm/mmu_context.h            |  11 +-
 arch/arm64/kernel/cpufeature.c                  |   1 +
 arch/arm64/mm/context.c                         | 105 ++-
 drivers/iommu/Kconfig                           |  10 +
 drivers/iommu/arm/arm-smmu-v3/Makefile          |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 248 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 843 +++++-------------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 723 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c      |   3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c           | 102 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h           |  84 ++-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c         |   8 +-
 drivers/iommu/io-pgtable-arm.c                  |  27 +-
 drivers/iommu/io-pgtable-arm.h                  |  30 +
 18 files changed, 1410 insertions(+), 798 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
 create mode 100644 drivers/iommu/io-pgtable-arm.h
